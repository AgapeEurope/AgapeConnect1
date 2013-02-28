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
            Session(TransactionIdPropertyName) = TransactionId

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


                ' Affichage de la réponse
                Dim respStr As StringBuilder = New StringBuilder()

                respStr.AppendLine("<h4>R&eacute;ponse manuelle du serveur SIPS</h4><br /><hr><br />")
                respStr.AppendLine("merchant_id = " & theResp.getValue("merchant_id") + "<br />")
                respStr.AppendLine("merchant_country = " & theResp.getValue("merchant_country") + "<br />")
                respStr.AppendLine("amount = " & theResp.getValue("amount") + "<br />")
                respStr.AppendLine("transaction_id = " & theResp.getValue("transaction_id") + "<br />")
                respStr.AppendLine("transmission_date = " & theResp.getValue("transmission_date") + "<br />")
                respStr.AppendLine("payment_means = " & theResp.getValue("payment_means") + "<br />")
                respStr.AppendLine("payment_time = " & theResp.getValue("payment_time") + "<br />")
                respStr.AppendLine("payment_date = " & theResp.getValue("payment_date") + "<br />")
                respStr.AppendLine("response_code = " & theResp.getValue("response_code") + "<br />")
                respStr.AppendLine("payment_certificate = " & theResp.getValue("payment_certificate") + "<br />")
                respStr.AppendLine("authorisation_id = " & theResp.getValue("authorisation_id") + "<br />")
                respStr.AppendLine("currency_code = " & theResp.getValue("currency_code") + "<br />")
                respStr.AppendLine("card_number = " & theResp.getValue("card_number") + "<br />")
                respStr.AppendLine("cvv_flag = " & theResp.getValue("cvv_flag") + "<br />")
                respStr.AppendLine("cvv_response_code = " & theResp.getValue("cvv_response_code") + "<br />")
                respStr.AppendLine("bank_response_code = " & theResp.getValue("bank_response_code") + "<br />")
                respStr.AppendLine("complementary_code = " & theResp.getValue("complementary_code") + "<br />")
                respStr.AppendLine("complementary_info = " & theResp.getValue("complementary_info") + "<br />")
                respStr.AppendLine("return_context = " & theResp.getValue("return_context") + "<br />")
                respStr.AppendLine("caddie = " & theResp.getValue("caddie") + "<br />")
                respStr.AppendLine("receipt_complement = " & theResp.getValue("receipt_complement") + "<br />")
                respStr.AppendLine("merchant_language = " & theResp.getValue("merchant_language") + "<br />")
                respStr.AppendLine("language = " & theResp.getValue("language") + "<br />")
                respStr.AppendLine("customer_id = " & theResp.getValue("customer_id") + "<br />")
                respStr.AppendLine("order_id = " & theResp.getValue("order_id") + "<br />")
                respStr.AppendLine("customer_email = " & theResp.getValue("customer_email") + "<br />")
                respStr.AppendLine("customer_ip_address = " & theResp.getValue("customer_ip_address") + "<br />")
                respStr.AppendLine("capture_day = " & theResp.getValue("capture_day") + "<br />")
                respStr.AppendLine("capture_mode = " & theResp.getValue("capture_mode") + "<br />")
                respStr.AppendLine("data = " & theResp.getValue("data") + "<br />")
                respStr.AppendLine("order_validity = " & theResp.getValue("order_validity") + "<br />")
                respStr.AppendLine("transaction_condition = " & theResp.getValue("transaction_condition") + "<br />")
                respStr.AppendLine("statement_reference = " & theResp.getValue("statement_reference") + "<br />")
                respStr.AppendLine("card_validity = " & theResp.getValue("card_validity") + "<br />")
                respStr.AppendLine("score_color = " & theResp.getValue("score_color") + "<br />")
                respStr.AppendLine("score_info = " & theResp.getValue("score_info") + "<br />")
                respStr.AppendLine("score_value = " & theResp.getValue("score_value") + "<br />")
                respStr.AppendLine("score_threshold = " & theResp.getValue("score_threshold") + "<br />")
                respStr.AppendLine("score_profile = " & theResp.getValue("score_profile") + "<br />")
                respStr.AppendLine("threed_ls_code = " & theResp.getValue("threed_ls_code") + "<br />")
                respStr.AppendLine("threed_relegation_code = " & theResp.getValue("threed_relegation_code") + "<br />")

                LitPageContent.Text = respStr.ToString
                LitPageContent.Visible = True


            Catch e As Exception

                LitPageContent.Text = "Error = " & e.GetType().FullName & e.Message

            End Try
        End Sub

    End Class
End Namespace
