
Imports ApiPayment
Imports ApiPayment.Web
Imports ApiPayment.Common


Namespace DotNetNuke.Modules.AgapeFR.Cart.Payment
    Partial Class ScelliusPaymentFrame
        Inherits System.Web.UI.Page

#Region "Properties and constants"

        'merchant_id param used to call scellius API
        '   014141675911111 => Certificat de test Scellius
        '   011223344551111 => Certificat de test SIPS
        '   077576340200044 => Certificat réel Agapé France (pour l'utiliser, enlever "aspx" pour "F_CTYPE" dans "pathfile")
        Dim MerchantId As String = "014141675911111"

        'Relative path to Scellius pathfile
        Dim Pathfile As String = "/payment/Scellius/param/pathfile"

        'Relative path to Scellius autoresponse page
        Dim IPNPage As String = "payment/Scellius/IPN.aspx"

        'URL to return to after processing the payment
        ReadOnly Property PaymentReturnURL() As String
            Get
                Return Session(GenericPaymentProvider.ReturnURLPropertyName)
            End Get
        End Property

        'Amount to pay for
        ReadOnly Property Amount() As String
            Get
                Return Session(GenericPaymentProvider.AmountPropertyName)
            End Get
        End Property

        'The order ID
        ReadOnly Property OrderId() As String
            Get
                Return Session(GenericPaymentProvider.OrderIdPropertyName)
            End Get
        End Property

#End Region


        Protected Sub Page_Load(sender As Object, e As EventArgs) Handles Me.Load

            'Call the request API method
            RequestMethod()

        End Sub

        Protected Sub RequestMethod()
            Try

                ' /* Initialisation du chemin du fichier pathfile
                Dim api As SIPSApiWeb = New SIPSApiWeb(Server.MapPath(Pathfile))


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
                ' Généré automatiquement si non renseigné
                'theCall.setValue("transaction_id", SIPSApiWeb.getTransactionId())
                '******************************************************************************

                ' Affectation d'un numero identifiant pour la transaction
                ' Attention aux reserves sur l'affectation automatique
                ' cf Guide du developpeur

                ' Valorisation des autres donnees de la transaction facultatives, a completer au besoin
                ' Les valeurs proposees ne sont que des exemples
                ' Les champs et leur utilisation sont expliques dans le Dictionnaire des donnees

                Dim urlRoot As String = Request.Url.Scheme & "://" & Request.Url.Authority & Request.ApplicationPath
                Dim responseURL As String = PaymentReturnURL
                Dim callTypeParam = GenericPaymentProvider.CallTypeParamKey & "=" & GenericPaymentProvider.CallTypeResponse
                If responseURL.Contains("?") Then
                    responseURL &= "&" & callTypeParam
                Else
                    responseURL &= "?" & callTypeParam
                End If

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
                theCall.setValue("target", "_top")
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
                ' DAVID: Cart - Modifier le statut de la commande en BD

                ' Appel de l'api SIPS payment et affichage de la réponse
                LitPageContent.Text = api.sipsPaymentCallFunc(theCall)

            Catch e As Exception

                LitPageContent.Text = "Error = " & e.GetType().FullName & e.Message

            Finally

                'Clear session variables
                Session(GenericPaymentProvider.ReturnURLPropertyName) = PaymentReturnURL
                Session(GenericPaymentProvider.AmountPropertyName) = Amount
                Session(GenericPaymentProvider.OrderIdPropertyName) = OrderId

            End Try
        End Sub

    End Class
End Namespace
