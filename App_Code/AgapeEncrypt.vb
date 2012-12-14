Imports Microsoft.VisualBasic
Imports System
Imports System.Security.Cryptography
Imports System.IO
Imports System.Text
Imports StaffBroker
Namespace AgapeEncryption


    Public Class AgapeEncrypt


        Public Shared Function Decrypt(ByVal val As String) As String
            'Change these values in your own implementation

            Dim sk = StaffBrokerFunctions.GetSetting("EntropyKey", 0).Split(",")
            Dim SharedKey As Byte() = New Byte(sk.Count - 1) {}
            Dim i As Integer = 0
            For Each row In sk
                If row.Length > 0 Then
                    SharedKey(i) = CByte(row)

                    i += 1
                End If
            Next

            Dim sv = StaffBrokerFunctions.GetSetting("EntropyVector", 0).Split(",")
            Dim SharedVector As Byte() = New Byte(sv.Count - 1) {}
            i = 0
            For Each row In sv
                If row.Length > 0 Then
                    SharedVector(i) = CByte(row)

                    i += 1
                End If
            Next








            Dim tdes As New TripleDESCryptoServiceProvider()
            Dim toDecrypt As Byte() = Convert.FromBase64String(val)
            Dim ms As New MemoryStream()
            Dim cs As New CryptoStream(ms, tdes.CreateDecryptor(SharedKey, sharedvector), CryptoStreamMode.Write)
            cs.Write(toDecrypt, 0, toDecrypt.Length)
            cs.FlushFinalBlock()
            Return Encoding.UTF8.GetString(ms.ToArray())
        End Function

        Public Shared Function Encrypt(ByVal val As String) As String
           Dim sk = StaffBrokerFunctions.GetSetting("EntropyKey", 0).Split(",")
            Dim SharedKey As Byte() = New Byte(sk.Count - 1) {}
            Dim i As Integer = 0
            For Each row In sk
                If row.Length > 0 Then
                    SharedKey(i) = CByte(row)

                    i += 1
                End If
            Next

            Dim sv = StaffBrokerFunctions.GetSetting("EntropyVector", 0).Split(",")
            Dim SharedVector As Byte() = New Byte(sv.Count - 1) {}
            i = 0
            For Each row In sv
                If row.Length > 0 Then
                    SharedVector(i) = CByte(row)

                    i += 1
                End If
            Next



            Dim tdes As New TripleDESCryptoServiceProvider()
            Dim toEncrypt As Byte() = Encoding.UTF8.GetBytes(val)
            Dim ms As New MemoryStream()
            Dim cs As New CryptoStream(ms, tdes.CreateEncryptor(SharedKey, sharedvector), CryptoStreamMode.Write)

            cs.Write(toEncrypt, 0, toEncrypt.Length)
            cs.FlushFinalBlock()
            Return Convert.ToBase64String(ms.ToArray())
        End Function
    End Class



End Namespace

