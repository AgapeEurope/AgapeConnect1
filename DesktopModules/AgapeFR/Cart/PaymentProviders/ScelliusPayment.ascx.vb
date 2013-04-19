Imports ApiPayment
Imports ApiPayment.Web
Imports ApiPayment.Common


Namespace DotNetNuke.Modules.AgapeFR.Cart.Payment
    Partial Class ScelliusPayment
        Inherits GenericPaymentProvider

#Region "Properties and constants"

        'Relative path to Scellius pathfile
        Dim Pathfile As String = "/payment/Scellius/param/pathfile"

#End Region

        Protected Sub Page_Init(sender As Object, e As System.EventArgs) Handles Me.Init

            ' Init translation resource file
            AgapeTranslation.InitLocalResourceFile(Me)

        End Sub
        Public Overrides Sub Initialize()

            'Call the right API method (request or response)
            Select Case CallType
                Case CallTypeResponse : ResponseMethod()
                Case Else : RequestMethod()
            End Select

        End Sub

        Protected Sub RequestMethod()

            'Init session variables with values to be passed to the iFrame
            Session(ReturnURLPropertyName) = PaymentReturnURL
            Session(AmountPropertyName) = Amount
            Session(OrderIdPropertyName) = OrderId

            'Display the iFrame where Scellius API call will be processed
            IfrScelliusCall.Visible = True
        End Sub

        ' traitement de la reponse manuelle
        Protected Sub ResponseMethod()
            Try

                ' Initialisation du chemin du fichier pathfile
                Dim api As ApiPayment.Web.SIPSApiWeb = New SIPSApiWeb(Server.MapPath(Pathfile))


                ' Initialisation de l'objet reponse
                Dim theResp As SIPSDataObject = CType(New SIPSResponseParm(), SIPSDataObject)

                ' Recuperation de la variable cryptee postee
                Dim cypheredtxt As String = Request.Params.Get("DATA")

                ' Decryptage de la reponse
                theResp = api.sipsPaymentResponseFunc(cypheredtxt)

                ' Affichage de la réponse dans les logs
                Dim respStr As StringBuilder = New StringBuilder()
                respStr.AppendLine("Réponse manuelle du serveur SIPS")
                respStr.AppendLine("merchant_id = " & theResp.getValue("merchant_id"))
                respStr.AppendLine("merchant_country = " & theResp.getValue("merchant_country"))
                respStr.AppendLine("amount = " & theResp.getValue("amount"))
                respStr.AppendLine("transaction_id = " & theResp.getValue("transaction_id"))
                respStr.AppendLine("transmission_date = " & theResp.getValue("transmission_date"))
                respStr.AppendLine("payment_means = " & theResp.getValue("payment_means"))
                respStr.AppendLine("payment_time = " & theResp.getValue("payment_time"))
                respStr.AppendLine("payment_date = " & theResp.getValue("payment_date"))
                respStr.AppendLine("response_code = " & theResp.getValue("response_code"))
                respStr.AppendLine("payment_certificate = " & theResp.getValue("payment_certificate"))
                respStr.AppendLine("authorisation_id = " & theResp.getValue("authorisation_id"))
                respStr.AppendLine("currency_code = " & theResp.getValue("currency_code"))
                respStr.AppendLine("card_number = " & theResp.getValue("card_number"))
                respStr.AppendLine("cvv_flag = " & theResp.getValue("cvv_flag"))
                respStr.AppendLine("cvv_response_code = " & theResp.getValue("cvv_response_code"))
                respStr.AppendLine("bank_response_code = " & theResp.getValue("bank_response_code"))
                respStr.AppendLine("complementary_code = " & theResp.getValue("complementary_code"))
                respStr.AppendLine("complementary_info = " & theResp.getValue("complementary_info"))
                respStr.AppendLine("return_context = " & theResp.getValue("return_context"))
                respStr.AppendLine("caddie = " & theResp.getValue("caddie"))
                respStr.AppendLine("receipt_complement = " & theResp.getValue("receipt_complement"))
                respStr.AppendLine("merchant_language = " & theResp.getValue("merchant_language"))
                respStr.AppendLine("language = " & theResp.getValue("language"))
                respStr.AppendLine("customer_id = " & theResp.getValue("customer_id"))
                respStr.AppendLine("order_id = " & theResp.getValue("order_id"))
                respStr.AppendLine("customer_email = " & theResp.getValue("customer_email"))
                respStr.AppendLine("customer_ip_address = " & theResp.getValue("customer_ip_address"))
                respStr.AppendLine("capture_day = " & theResp.getValue("capture_day"))
                respStr.AppendLine("capture_mode = " & theResp.getValue("capture_mode"))
                respStr.AppendLine("data = " & theResp.getValue("data"))
                respStr.AppendLine("order_validity = " & theResp.getValue("order_validity"))
                respStr.AppendLine("transaction_condition = " & theResp.getValue("transaction_condition"))
                respStr.AppendLine("statement_reference = " & theResp.getValue("statement_reference"))
                respStr.AppendLine("card_validity = " & theResp.getValue("card_validity"))
                respStr.AppendLine("score_color = " & theResp.getValue("score_color"))
                respStr.AppendLine("score_info = " & theResp.getValue("score_info"))
                respStr.AppendLine("score_value = " & theResp.getValue("score_value"))
                respStr.AppendLine("score_threshold = " & theResp.getValue("score_threshold"))
                respStr.AppendLine("score_profile = " & theResp.getValue("score_profile"))
                respStr.AppendLine("threed_ls_code = " & theResp.getValue("threed_ls_code"))
                respStr.AppendLine("threed_relegation_code = " & theResp.getValue("threed_relegation_code"))
                AgapeLogger.Info(-1, respStr.ToString)

                Dim OrderId As Integer = CInt(theResp.getValue("order_id"))
                Dim responseCode As String = theResp.getValue("response_code") '17 = Customer Cancelled,  00 = OK, 05 = Paiement refusé, Other = Error

                If responseCode = "00" Then ' Payment was OK
                    'Show only panel for successfull payment
                    IfrScelliusCall.Visible = False
                    divPaymentCanceled.Visible = False
                    divPaymentSuccessful.Visible = True
                Else ' Customer Cancelled or error
                    'Copy the current cart
                    Dim newCartId = CartFunctions.CopyCart(OrderId, False)
                    Session("TheCartID") = newCartId

                    'Show only panel with different options buttons after cancelled payment or error
                    IfrScelliusCall.Visible = False
                    divPaymentCanceled.Visible = True
                    divPaymentSuccessful.Visible = False

                End If

            Catch e As Exception

                AgapeLogger.Error(-1, "Error = " & e.GetType().FullName & e.Message)

            End Try
        End Sub

        Protected Sub BtnEmptyCart_Click(sender As Object, e As EventArgs) Handles BtnEmptyCart.Click

            ' Empty the cart
            CartFunctions.EmptyCart(TheCartID)

            'Redirect to Cart main page
            Dim mc As New DotNetNuke.Entities.Modules.ModuleController
            Dim x = mc.GetModuleByDefinition(PortalId, "frCart")
            If Not x Is Nothing Then
                If Not x.TabID = Nothing Then
                    Response.Redirect(NavigateURL(x.TabID))
                End If
            End If
        End Sub


        Protected Sub BtnModifyCart_Click(sender As Object, e As EventArgs) Handles BtnModifyCart.Click

            ' Redirect to Cart main page
            Dim mc As New DotNetNuke.Entities.Modules.ModuleController
            Dim x = mc.GetModuleByDefinition(PortalId, "frCart")
            If Not x Is Nothing Then
                If Not x.TabID = Nothing Then
                    Response.Redirect(NavigateURL(x.TabID))
                End If
            End If

        End Sub

        Protected Sub BtnPayAgain_Click(sender As Object, e As EventArgs) Handles BtnPayAgain.Click

            'Redirect to CartPayment via Cart main page
            Dim mc As New DotNetNuke.Entities.Modules.ModuleController
            Dim x = mc.GetModuleByDefinition(PortalId, "frCart")
            If Not x Is Nothing Then
                If Not x.TabID = Nothing Then
                    Response.Redirect(NavigateURL(x.TabID) & "?skip=CartPayment")
                End If
            End If

        End Sub
    End Class
End Namespace
