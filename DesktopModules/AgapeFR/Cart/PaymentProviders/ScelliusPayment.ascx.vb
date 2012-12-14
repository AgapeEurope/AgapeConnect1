Imports ApiPayment
Imports ApiPayment.Web
Imports ApiPayment.Common


Namespace DotNetNuke.Modules.AgapeFR.Cart.Payment
    Partial Class ScelliusPayment
        Inherits GenericPaymentProvider

#Region "Constants"

        'merchant_id param used to call scellius API
        '   011223344551111 => Certificat de test
        '   077576340200044 => Certificat réel Agapé France (pour l'utiliser, enlever "aspx" pour "F_CTYPE" dans "pathfile"
        Dim MerchantId As String = "011223344551111"

        'Relative path to Scellius pathfile
        Dim Pathfile As String = "/payment/Scellius/param/pathfile"

        'Relative path to Scellius autoresponse page
        Dim IPNPage As String = "payment/Scellius/IPN.aspx"

        'Type of call: Request or Response
        Const CallTypeRequest As String = "Request"
        Const CallTypeResponse As String = "Response"

#End Region


        Public Overrides Sub Initialize()

            'Call the right API method (request or response)
            Select Case CallType
                Case CallTypeResponse : ResponseMethod()
                Case Else : RequestMethod()
            End Select

        End Sub

        Protected Sub RequestMethod()
            Try

                ' /* Initialisation du chemin du fichier pathfile
                Dim api As ApiPayment.Web.SIPSApiWeb = New SIPSApiWeb(Server.MapPath(Pathfile))


                ' Initialisation de l'objet d'appel
                Dim theCall As SIPSDataObject = CType(New SIPSCallParm(), SIPSDataObject)

                '**************************** Parametres obligatoires*************************
                ' ex : merchant_id = 011223344551111
                theCall.setValue("merchant_id", MerchantId)

                ' ex : merchant_country = fr
                'theCall.setValue("merchant_country", "fr")

                'Affectation du montant de la transaction dans la plus petite unite monetaire du pays
                ' ex : 123,00 Euros ==> 12300 (currency_code = 978)
                theCall.setValue("amount", Amount * 100)

                ' Affectation du code monetaire ISO 4217 pour la transaction
                ' ex : Euro ==> 978
                'theCall.setValue("currency_code", "978")

                ' Identifiant de transaction
                ' ex : transaction_id = 123456 (genere automatiquement si non renseigne)
                ' /!\ Si on utilise un TransactionId par Cart, on ne peut pas retenter le paiement d'un Cart.
                ' theCall.setValue("transaction_id", TransactionId)
                '******************************************************************************

                ' Affectation d'un numero identifiant pour la transaction
                ' Attention aux reserves sur l'affectation automatique
                ' cf Guide du developpeur

                ' Valorisation des autres donnees de la transaction facultatives, a completer au besoin
                ' Les valeurs proposees ne sont que des exemples
                ' Les champs et leur utilisation sont expliques dans le Dictionnaire des donnees

                Dim urlRoot As String = Request.Url.Scheme & "://" & Request.Url.Authority & Request.ApplicationPath
                Dim responseURL As String = ReturnURL & "?" & CallTypeParamKey & "=" & CallTypeResponse

                theCall.setValue("normal_return_url", responseURL)
                theCall.setValue("cancel_return_url", responseURL)
                theCall.setValue("automatic_response_url", urlRoot & IPNPage)
                ' theCall.setValue("language","fr")
                ' theCall.setValue("payment_means","CB,2,VISA,2,MASTERCARD,2")
                ' theCall.setValue("header_flag", "no")
                ' theCall.setValue("capture_day", "4")
                ' theCall.setValue("capture_mode","")
                ' theCall.setValue("bgcolor","")
                ' theCall.setValue("block_align","")
                ' theCall.setValue("block_order","")
                ' theCall.setValue("textcolor","")
                ' theCall.setValue("receipt_complement","")
                ' theCall.setValue("caddie","mon caddie")
                ' theCall.setValue("customer_id","")
                ' theCall.setValue("customer_email","")
                ' theCall.setValue("data","")
                ' theCall.setValue("return_context","")
                ' theCall.setValue("target","")
                theCall.setValue("order_id", OrderId)
                ' theCall.setValue("customer_title","")
                ' theCall.setValue("customer_name","")
                ' theCall.setValue("customer_firstname","")
                ' theCall.setValue("customer_birthdate","")
                ' theCall.setValue("customer_phone","")
                ' theCall.setValue("customer_mobile_phone","")
                ' theCall.setValue("customer_ip_address","")
                ' theCall.setValue("customer_nationality_country","")
                ' theCall.setValue("customer_birth_zipcode","")
                ' theCall.setValue("customer_birth_city","")
                ' theCall.setValue("home_city","")
                ' theCall.setValue("home_streetnumber","")
                ' theCall.setValue("home_street","")
                ' theCall.setValue("home_zipcode","")

                ' Les valeurs suivantes ne sont utilisables qu'en pre-production
                ' Elles necessitent l'installation de vos logos et templates sur
                ' le serveur de paiement


                ' theCall.setValue("normal_return_logo","")
                ' theCall.setValue("cancel_return_logo","")
                ' theCall.setValue("submit_logo","")
                ' theCall.setValue("logo_id","")
                ' theCall.setValue("logo_id2","")
                ' theCall.setValue("advert","")
                ' theCall.setValue("background_id","")
                ' theCall.setValue("templatefile","mon_template")


                ' Insertion de la commande dans votre base de donnees
                ' avec le status "en cours"
                ' ...

                ' Appel de l'api SIPS payment et affichage de la réponse
                'DAVID: Payment - See http://www.ksfinternational.com/BlogArticle.aspx?aid=2454362239080082422 to avoid nested form problem
                LitPageContent.Text = "<form></form><br/>" & api.sipsPaymentCallFunc(theCall)

                'api.sipsPaymentCallFunc(theCall)
                'LitPageContent.Text = "<form>test</form><br/><FORM METHOD=POST ACTION=""https://scellius.lapostefinance.fr/cgis-payment-scellius/prod/callpayment"" TARGET=""_top"">" & vbLf & "<INPUT TYPE=HIDDEN NAME=DATA VALUE=""2020353738603028502c2360552d5340532d2360522c2360532e2360502c2328512e3048502c5330502c2324573d26354d3c2651413d26353f3c562d453b2651493d372c2a2c232c562c2360512e242d5c222b2539293454244c333425333524353230542532316048502d2324502c2360582c4360502e2360542c432c2a2c2360512c2360502d2560562c33342a2c2328592c2360502c4639525c224360522e2360502c2329463c4048502c2340502c2360532e333c585c224360512e2360502c2338502c2360502c23602a2c2360552c2360502d4360542e333c532d4048512c2334502c2328543054284c2c42513632352d212b23284c333425333524353230542532315c2250525c224360502c5360502c232c562c23602a2c2324562c2360502c552d33336048502c2338502c2324542c4360512c4324512c4340512d5360522c33442a2c2360592c2360502c4639525c224360502c2360502c23313f3d265d505c224360502c4360502c3334502d533c552d5338532d2360522c2360502d23302a2c2324532c2324512c4641543d27605a2b525d4c3b562d413b26414f3c57305a2c3340592d433c4f33365d4e3c26254e3a3635522b573141384645442b5328532d525d433d26504f305625523d2521413e3655453b47304f3b3645442b5338522d5c225d4c383659473d36254739325d463c42552634425d24393639413d3651542b4625533c27405f3056254c3b2531593c26345d344635533c265d4e3c56342a2c232c512c2360542e2641543d27605a2b525d4c3b562d413b26414f3c57305a2c3340592d433c4f3c2625593b36354e3d5c225d333856354c3b2645553c525d293424584e38372d503e6048502c3324502c3324523a2731543c23484f2b56514f3856254c3a265d533d2348512e2344562d525d2d3b565950383659493937284f3d2625423a36304f2c432c572b562d543b5c225d2338372954342625593b36354e3d5c225d4d3a36304f2d4328542b5651413b463d5538363d452b5639522b3439322b543145394625553b27304e38372d503e235d233836514c352745503933553239372d503b5659533930488352c779b1bf25f7""><br />" & vbLf & "<div align=center>" & vbLf & "Vous utilisez le formulaire s&#233;curis&#233; standard SSL, choisissez une carte ci-dessous <img border=0 src=""/payment/Scellius/logo/CLEF.gif"" alt=""""> :" & vbLf & "<br /><br />" & vbLf & "</div>" & vbLf & "<div align=center>" & vbLf & "<input type=image name=CB src=""/payment/Scellius/logo/CB.gif"" alt=""CB"">" & vbLf & "<img src=""/payment/Scellius/logo/INTERVAL.gif"" alt="" "">" & vbLf & "<input type=image name=VISA src=""/payment/Scellius/logo/VISA.gif"" alt=""VISA"">" & vbLf & "<img src=""/payment/Scellius/logo/INTERVAL.gif"" alt="" "">" & vbLf & "<input type=image name=MASTERCARD src=""/payment/Scellius/logo/MASTERCARD.gif"" alt=""MASTERCARD"">" & vbLf & "<br /><br />" & vbLf & "</div>" & vbLf & "</FORM>"


            Catch e As Exception

                LitPageContent.Text = "Error = " & e.GetType().FullName & e.Message

            End Try
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


            Catch e As Exception

                LitPageContent.Text = "Error = " & e.GetType().FullName & e.Message

            End Try
        End Sub

    End Class
End Namespace
