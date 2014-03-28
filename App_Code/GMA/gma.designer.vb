﻿'------------------------------------------------------------------------------
' <auto-generated>
'     This code was generated by a tool.
'     Runtime Version:4.0.30319.34011
'
'     Changes to this file may cause incorrect behavior and will be lost if
'     the code is regenerated.
' </auto-generated>
'------------------------------------------------------------------------------

Option Strict On
Option Explicit On

Imports System
Imports System.Collections.Generic
Imports System.ComponentModel
Imports System.Data
Imports System.Data.Linq
Imports System.Data.Linq.Mapping
Imports System.Linq
Imports System.Linq.Expressions
Imports System.Reflection

Namespace GMA
	
	<Global.System.Data.Linq.Mapping.DatabaseAttribute(Name:="AgapeConnect")>  _
	Partial Public Class gmaDataContext
		Inherits System.Data.Linq.DataContext
		
		Private Shared mappingSource As System.Data.Linq.Mapping.MappingSource = New AttributeMappingSource()
		
    #Region "Extensibility Method Definitions"
    Partial Private Sub OnCreated()
    End Sub
    Partial Private Sub Insertgma_Server(instance As gma_Server)
    End Sub
    Partial Private Sub Updategma_Server(instance As gma_Server)
    End Sub
    Partial Private Sub Deletegma_Server(instance As gma_Server)
    End Sub
    #End Region
		
		Public Sub New()
			MyBase.New(Global.System.Configuration.ConfigurationManager.ConnectionStrings("SiteSqlServer").ConnectionString, mappingSource)
			OnCreated
		End Sub
		
		Public Sub New(ByVal connection As String)
			MyBase.New(connection, mappingSource)
			OnCreated
		End Sub
		
		Public Sub New(ByVal connection As System.Data.IDbConnection)
			MyBase.New(connection, mappingSource)
			OnCreated
		End Sub
		
		Public Sub New(ByVal connection As String, ByVal mappingSource As System.Data.Linq.Mapping.MappingSource)
			MyBase.New(connection, mappingSource)
			OnCreated
		End Sub
		
		Public Sub New(ByVal connection As System.Data.IDbConnection, ByVal mappingSource As System.Data.Linq.Mapping.MappingSource)
			MyBase.New(connection, mappingSource)
			OnCreated
		End Sub
		
		Public ReadOnly Property gma_Servers() As System.Data.Linq.Table(Of gma_Server)
			Get
				Return Me.GetTable(Of gma_Server)
			End Get
		End Property
	End Class
	
	<Global.System.Data.Linq.Mapping.TableAttribute(Name:="dbo.gma_Servers")>  _
	Partial Public Class gma_Server
		Implements System.ComponentModel.INotifyPropertyChanging, System.ComponentModel.INotifyPropertyChanged
		
		Private Shared emptyChangingEventArgs As PropertyChangingEventArgs = New PropertyChangingEventArgs(String.Empty)
		
		Private _gmaServerId As Integer
		
		Private _displayName As String
		
		Private _rootUrl As String
		
		Private _serviceURL As String
		
		Private _addedByUser As System.Nullable(Of Integer)
		
    #Region "Extensibility Method Definitions"
    Partial Private Sub OnLoaded()
    End Sub
    Partial Private Sub OnValidate(action As System.Data.Linq.ChangeAction)
    End Sub
    Partial Private Sub OnCreated()
    End Sub
    Partial Private Sub OngmaServerIdChanging(value As Integer)
    End Sub
    Partial Private Sub OngmaServerIdChanged()
    End Sub
    Partial Private Sub OndisplayNameChanging(value As String)
    End Sub
    Partial Private Sub OndisplayNameChanged()
    End Sub
    Partial Private Sub OnrootUrlChanging(value As String)
    End Sub
    Partial Private Sub OnrootUrlChanged()
    End Sub
    Partial Private Sub OnserviceUrlChanging(value As String)
    End Sub
    Partial Private Sub OnserviceUrlChanged()
    End Sub
    Partial Private Sub OnaddedByUserChanging(value As System.Nullable(Of Integer))
    End Sub
    Partial Private Sub OnaddedByUserChanged()
    End Sub
    #End Region
		
		Public Sub New()
			MyBase.New
			OnCreated
		End Sub
		
		<Global.System.Data.Linq.Mapping.ColumnAttribute(Storage:="_gmaServerId", AutoSync:=AutoSync.OnInsert, DbType:="Int NOT NULL IDENTITY", IsPrimaryKey:=true, IsDbGenerated:=true)>  _
		Public Property gmaServerId() As Integer
			Get
				Return Me._gmaServerId
			End Get
			Set
				If ((Me._gmaServerId = value)  _
							= false) Then
					Me.OngmaServerIdChanging(value)
					Me.SendPropertyChanging
					Me._gmaServerId = value
					Me.SendPropertyChanged("gmaServerId")
					Me.OngmaServerIdChanged
				End If
			End Set
		End Property
		
		<Global.System.Data.Linq.Mapping.ColumnAttribute(Storage:="_displayName", DbType:="NVarChar(200) NOT NULL", CanBeNull:=false)>  _
		Public Property displayName() As String
			Get
				Return Me._displayName
			End Get
			Set
				If (String.Equals(Me._displayName, value) = false) Then
					Me.OndisplayNameChanging(value)
					Me.SendPropertyChanging
					Me._displayName = value
					Me.SendPropertyChanged("displayName")
					Me.OndisplayNameChanged
				End If
			End Set
		End Property
		
		<Global.System.Data.Linq.Mapping.ColumnAttribute(Storage:="_rootUrl", DbType:="NVarChar(400) NOT NULL", CanBeNull:=false)>  _
		Public Property rootUrl() As String
			Get
				Return Me._rootUrl
			End Get
			Set
				If (String.Equals(Me._rootUrl, value) = false) Then
					Me.OnrootUrlChanging(value)
					Me.SendPropertyChanging
					Me._rootUrl = value
					Me.SendPropertyChanged("rootUrl")
					Me.OnrootUrlChanged
				End If
			End Set
		End Property
		
		<Global.System.Data.Linq.Mapping.ColumnAttribute(Storage:="_serviceURL", DbType:="NVarChar(400)")>  _
		Public Property serviceUrl() As String
			Get
				Return Me._serviceURL
			End Get
			Set
				If (String.Equals(Me._serviceURL, value) = false) Then
					Me.OnserviceUrlChanging(value)
					Me.SendPropertyChanging
					Me._serviceURL = value
					Me.SendPropertyChanged("serviceUrl")
					Me.OnserviceUrlChanged
				End If
			End Set
		End Property
		
		<Global.System.Data.Linq.Mapping.ColumnAttribute(Storage:="_addedByUser", DbType:="Int")>  _
		Public Property addedByUser() As System.Nullable(Of Integer)
			Get
				Return Me._addedByUser
			End Get
			Set
				If (Me._addedByUser.Equals(value) = false) Then
					Me.OnaddedByUserChanging(value)
					Me.SendPropertyChanging
					Me._addedByUser = value
					Me.SendPropertyChanged("addedByUser")
					Me.OnaddedByUserChanged
				End If
			End Set
		End Property
		
		Public Event PropertyChanging As PropertyChangingEventHandler Implements System.ComponentModel.INotifyPropertyChanging.PropertyChanging
		
		Public Event PropertyChanged As PropertyChangedEventHandler Implements System.ComponentModel.INotifyPropertyChanged.PropertyChanged
		
		Protected Overridable Sub SendPropertyChanging()
			If ((Me.PropertyChangingEvent Is Nothing)  _
						= false) Then
				RaiseEvent PropertyChanging(Me, emptyChangingEventArgs)
			End If
		End Sub
		
		Protected Overridable Sub SendPropertyChanged(ByVal propertyName As [String])
			If ((Me.PropertyChangedEvent Is Nothing)  _
						= false) Then
				RaiseEvent PropertyChanged(Me, New PropertyChangedEventArgs(propertyName))
			End If
		End Sub
	End Class
End Namespace
