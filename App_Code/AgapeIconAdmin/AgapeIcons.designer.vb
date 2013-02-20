﻿'------------------------------------------------------------------------------
' <auto-generated>
'     This code was generated by a tool.
'     Runtime Version:4.0.30319.17929
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

Namespace AgapeIconAdmin
	
	<Global.System.Data.Linq.Mapping.DatabaseAttribute(Name:="AgapeConnect")>  _
	Partial Public Class AgapeIconsDataContext
		Inherits System.Data.Linq.DataContext
		
		Private Shared mappingSource As System.Data.Linq.Mapping.MappingSource = New AttributeMappingSource()
		
    #Region "Extensibility Method Definitions"
    Partial Private Sub OnCreated()
    End Sub
    Partial Private Sub InsertFile(instance As File)
    End Sub
    Partial Private Sub UpdateFile(instance As File)
    End Sub
    Partial Private Sub DeleteFile(instance As File)
    End Sub
    Partial Private Sub InsertAgape_Skin_AgapeIcon(instance As Agape_Skin_AgapeIcon)
    End Sub
    Partial Private Sub UpdateAgape_Skin_AgapeIcon(instance As Agape_Skin_AgapeIcon)
    End Sub
    Partial Private Sub DeleteAgape_Skin_AgapeIcon(instance As Agape_Skin_AgapeIcon)
    End Sub
    Partial Private Sub InsertAgape_Skin_IconSetting(instance As Agape_Skin_IconSetting)
    End Sub
    Partial Private Sub UpdateAgape_Skin_IconSetting(instance As Agape_Skin_IconSetting)
    End Sub
    Partial Private Sub DeleteAgape_Skin_IconSetting(instance As Agape_Skin_IconSetting)
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
		
		Public ReadOnly Property Files() As System.Data.Linq.Table(Of File)
			Get
				Return Me.GetTable(Of File)
			End Get
		End Property
		
		Public ReadOnly Property Agape_Skin_AgapeIcons() As System.Data.Linq.Table(Of Agape_Skin_AgapeIcon)
			Get
				Return Me.GetTable(Of Agape_Skin_AgapeIcon)
			End Get
		End Property
		
		Public ReadOnly Property Agape_Skin_IconSettings() As System.Data.Linq.Table(Of Agape_Skin_IconSetting)
			Get
				Return Me.GetTable(Of Agape_Skin_IconSetting)
			End Get
		End Property
	End Class
	
	<Global.System.Data.Linq.Mapping.TableAttribute(Name:="dbo.Files")>  _
	Partial Public Class File
		Implements System.ComponentModel.INotifyPropertyChanging, System.ComponentModel.INotifyPropertyChanged
		
		Private Shared emptyChangingEventArgs As PropertyChangingEventArgs = New PropertyChangingEventArgs(String.Empty)
		
		Private _FileId As Integer
		
		Private _PortalId As System.Nullable(Of Integer)
		
		Private _FileName As String
		
		Private _Extension As String
		
		Private _Size As Integer
		
		Private _Width As System.Nullable(Of Integer)
		
		Private _Height As System.Nullable(Of Integer)
		
		Private _ContentType As String
		
		Private _Folder As String
		
		Private _FolderID As Integer
		
		Private _Content As System.Data.Linq.Binary
		
    #Region "Extensibility Method Definitions"
    Partial Private Sub OnLoaded()
    End Sub
    Partial Private Sub OnValidate(action As System.Data.Linq.ChangeAction)
    End Sub
    Partial Private Sub OnCreated()
    End Sub
    Partial Private Sub OnFileIdChanging(value As Integer)
    End Sub
    Partial Private Sub OnFileIdChanged()
    End Sub
    Partial Private Sub OnPortalIdChanging(value As System.Nullable(Of Integer))
    End Sub
    Partial Private Sub OnPortalIdChanged()
    End Sub
    Partial Private Sub OnFileNameChanging(value As String)
    End Sub
    Partial Private Sub OnFileNameChanged()
    End Sub
    Partial Private Sub OnExtensionChanging(value As String)
    End Sub
    Partial Private Sub OnExtensionChanged()
    End Sub
    Partial Private Sub OnSizeChanging(value As Integer)
    End Sub
    Partial Private Sub OnSizeChanged()
    End Sub
    Partial Private Sub OnWidthChanging(value As System.Nullable(Of Integer))
    End Sub
    Partial Private Sub OnWidthChanged()
    End Sub
    Partial Private Sub OnHeightChanging(value As System.Nullable(Of Integer))
    End Sub
    Partial Private Sub OnHeightChanged()
    End Sub
    Partial Private Sub OnContentTypeChanging(value As String)
    End Sub
    Partial Private Sub OnContentTypeChanged()
    End Sub
    Partial Private Sub OnFolderChanging(value As String)
    End Sub
    Partial Private Sub OnFolderChanged()
    End Sub
    Partial Private Sub OnFolderIDChanging(value As Integer)
    End Sub
    Partial Private Sub OnFolderIDChanged()
    End Sub
    Partial Private Sub OnContentChanging(value As System.Data.Linq.Binary)
    End Sub
    Partial Private Sub OnContentChanged()
    End Sub
    #End Region
		
		Public Sub New()
			MyBase.New
			OnCreated
		End Sub
		
		<Global.System.Data.Linq.Mapping.ColumnAttribute(Storage:="_FileId", AutoSync:=AutoSync.OnInsert, DbType:="Int NOT NULL IDENTITY", IsPrimaryKey:=true, IsDbGenerated:=true)>  _
		Public Property FileId() As Integer
			Get
				Return Me._FileId
			End Get
			Set
				If ((Me._FileId = value)  _
							= false) Then
					Me.OnFileIdChanging(value)
					Me.SendPropertyChanging
					Me._FileId = value
					Me.SendPropertyChanged("FileId")
					Me.OnFileIdChanged
				End If
			End Set
		End Property
		
		<Global.System.Data.Linq.Mapping.ColumnAttribute(Storage:="_PortalId", DbType:="Int")>  _
		Public Property PortalId() As System.Nullable(Of Integer)
			Get
				Return Me._PortalId
			End Get
			Set
				If (Me._PortalId.Equals(value) = false) Then
					Me.OnPortalIdChanging(value)
					Me.SendPropertyChanging
					Me._PortalId = value
					Me.SendPropertyChanged("PortalId")
					Me.OnPortalIdChanged
				End If
			End Set
		End Property
		
		<Global.System.Data.Linq.Mapping.ColumnAttribute(Storage:="_FileName", DbType:="NVarChar(100) NOT NULL", CanBeNull:=false)>  _
		Public Property FileName() As String
			Get
				Return Me._FileName
			End Get
			Set
				If (String.Equals(Me._FileName, value) = false) Then
					Me.OnFileNameChanging(value)
					Me.SendPropertyChanging
					Me._FileName = value
					Me.SendPropertyChanged("FileName")
					Me.OnFileNameChanged
				End If
			End Set
		End Property
		
		<Global.System.Data.Linq.Mapping.ColumnAttribute(Storage:="_Extension", DbType:="NVarChar(100) NOT NULL", CanBeNull:=false)>  _
		Public Property Extension() As String
			Get
				Return Me._Extension
			End Get
			Set
				If (String.Equals(Me._Extension, value) = false) Then
					Me.OnExtensionChanging(value)
					Me.SendPropertyChanging
					Me._Extension = value
					Me.SendPropertyChanged("Extension")
					Me.OnExtensionChanged
				End If
			End Set
		End Property
		
		<Global.System.Data.Linq.Mapping.ColumnAttribute(Storage:="_Size", DbType:="Int NOT NULL")>  _
		Public Property Size() As Integer
			Get
				Return Me._Size
			End Get
			Set
				If ((Me._Size = value)  _
							= false) Then
					Me.OnSizeChanging(value)
					Me.SendPropertyChanging
					Me._Size = value
					Me.SendPropertyChanged("Size")
					Me.OnSizeChanged
				End If
			End Set
		End Property
		
		<Global.System.Data.Linq.Mapping.ColumnAttribute(Storage:="_Width", DbType:="Int")>  _
		Public Property Width() As System.Nullable(Of Integer)
			Get
				Return Me._Width
			End Get
			Set
				If (Me._Width.Equals(value) = false) Then
					Me.OnWidthChanging(value)
					Me.SendPropertyChanging
					Me._Width = value
					Me.SendPropertyChanged("Width")
					Me.OnWidthChanged
				End If
			End Set
		End Property
		
		<Global.System.Data.Linq.Mapping.ColumnAttribute(Storage:="_Height", DbType:="Int")>  _
		Public Property Height() As System.Nullable(Of Integer)
			Get
				Return Me._Height
			End Get
			Set
				If (Me._Height.Equals(value) = false) Then
					Me.OnHeightChanging(value)
					Me.SendPropertyChanging
					Me._Height = value
					Me.SendPropertyChanged("Height")
					Me.OnHeightChanged
				End If
			End Set
		End Property
		
		<Global.System.Data.Linq.Mapping.ColumnAttribute(Storage:="_ContentType", DbType:="NVarChar(200) NOT NULL", CanBeNull:=false)>  _
		Public Property ContentType() As String
			Get
				Return Me._ContentType
			End Get
			Set
				If (String.Equals(Me._ContentType, value) = false) Then
					Me.OnContentTypeChanging(value)
					Me.SendPropertyChanging
					Me._ContentType = value
					Me.SendPropertyChanged("ContentType")
					Me.OnContentTypeChanged
				End If
			End Set
		End Property
		
		<Global.System.Data.Linq.Mapping.ColumnAttribute(Storage:="_Folder", DbType:="NVarChar(200)")>  _
		Public Property Folder() As String
			Get
				Return Me._Folder
			End Get
			Set
				If (String.Equals(Me._Folder, value) = false) Then
					Me.OnFolderChanging(value)
					Me.SendPropertyChanging
					Me._Folder = value
					Me.SendPropertyChanged("Folder")
					Me.OnFolderChanged
				End If
			End Set
		End Property
		
		<Global.System.Data.Linq.Mapping.ColumnAttribute(Storage:="_FolderID", DbType:="Int NOT NULL")>  _
		Public Property FolderID() As Integer
			Get
				Return Me._FolderID
			End Get
			Set
				If ((Me._FolderID = value)  _
							= false) Then
					Me.OnFolderIDChanging(value)
					Me.SendPropertyChanging
					Me._FolderID = value
					Me.SendPropertyChanged("FolderID")
					Me.OnFolderIDChanged
				End If
			End Set
		End Property
		
		<Global.System.Data.Linq.Mapping.ColumnAttribute(Storage:="_Content", DbType:="Image", CanBeNull:=true, UpdateCheck:=UpdateCheck.Never)>  _
		Public Property Content() As System.Data.Linq.Binary
			Get
				Return Me._Content
			End Get
			Set
				If (Object.Equals(Me._Content, value) = false) Then
					Me.OnContentChanging(value)
					Me.SendPropertyChanging
					Me._Content = value
					Me.SendPropertyChanged("Content")
					Me.OnContentChanged
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
	
	<Global.System.Data.Linq.Mapping.TableAttribute(Name:="dbo.Agape_Skin_AgapeIcons")>  _
	Partial Public Class Agape_Skin_AgapeIcon
		Implements System.ComponentModel.INotifyPropertyChanging, System.ComponentModel.INotifyPropertyChanged
		
		Private Shared emptyChangingEventArgs As PropertyChangingEventArgs = New PropertyChangingEventArgs(String.Empty)
		
		Private _AgapeIconid As Long
		
		Private _IconFile As System.Nullable(Of Integer)
		
		Private _LinkType As String
		
		Private _LinkLoc As String
		
		Private _PortalId As System.Nullable(Of Integer)
		
		Private _ViewOrder As System.Nullable(Of Integer)
		
		Private _HovrIconFile As System.Nullable(Of Integer)
		
		Private _Title As String
		
    #Region "Extensibility Method Definitions"
    Partial Private Sub OnLoaded()
    End Sub
    Partial Private Sub OnValidate(action As System.Data.Linq.ChangeAction)
    End Sub
    Partial Private Sub OnCreated()
    End Sub
    Partial Private Sub OnAgapeIconidChanging(value As Long)
    End Sub
    Partial Private Sub OnAgapeIconidChanged()
    End Sub
    Partial Private Sub OnIconFileChanging(value As System.Nullable(Of Integer))
    End Sub
    Partial Private Sub OnIconFileChanged()
    End Sub
    Partial Private Sub OnLinkTypeChanging(value As String)
    End Sub
    Partial Private Sub OnLinkTypeChanged()
    End Sub
    Partial Private Sub OnLinkLocChanging(value As String)
    End Sub
    Partial Private Sub OnLinkLocChanged()
    End Sub
    Partial Private Sub OnPortalIdChanging(value As System.Nullable(Of Integer))
    End Sub
    Partial Private Sub OnPortalIdChanged()
    End Sub
    Partial Private Sub OnViewOrderChanging(value As System.Nullable(Of Integer))
    End Sub
    Partial Private Sub OnViewOrderChanged()
    End Sub
    Partial Private Sub OnHovrIconFileChanging(value As System.Nullable(Of Integer))
    End Sub
    Partial Private Sub OnHovrIconFileChanged()
    End Sub
    Partial Private Sub OnTitleChanging(value As String)
    End Sub
    Partial Private Sub OnTitleChanged()
    End Sub
    #End Region
		
		Public Sub New()
			MyBase.New
			OnCreated
		End Sub
		
		<Global.System.Data.Linq.Mapping.ColumnAttribute(Storage:="_AgapeIconid", AutoSync:=AutoSync.OnInsert, DbType:="BigInt NOT NULL IDENTITY", IsPrimaryKey:=true, IsDbGenerated:=true)>  _
		Public Property AgapeIconid() As Long
			Get
				Return Me._AgapeIconid
			End Get
			Set
				If ((Me._AgapeIconid = value)  _
							= false) Then
					Me.OnAgapeIconidChanging(value)
					Me.SendPropertyChanging
					Me._AgapeIconid = value
					Me.SendPropertyChanged("AgapeIconid")
					Me.OnAgapeIconidChanged
				End If
			End Set
		End Property
		
		<Global.System.Data.Linq.Mapping.ColumnAttribute(Storage:="_IconFile", DbType:="Int")>  _
		Public Property IconFile() As System.Nullable(Of Integer)
			Get
				Return Me._IconFile
			End Get
			Set
				If (Me._IconFile.Equals(value) = false) Then
					Me.OnIconFileChanging(value)
					Me.SendPropertyChanging
					Me._IconFile = value
					Me.SendPropertyChanged("IconFile")
					Me.OnIconFileChanged
				End If
			End Set
		End Property
		
		<Global.System.Data.Linq.Mapping.ColumnAttribute(Storage:="_LinkType", DbType:="VarChar(12)")>  _
		Public Property LinkType() As String
			Get
				Return Me._LinkType
			End Get
			Set
				If (String.Equals(Me._LinkType, value) = false) Then
					Me.OnLinkTypeChanging(value)
					Me.SendPropertyChanging
					Me._LinkType = value
					Me.SendPropertyChanged("LinkType")
					Me.OnLinkTypeChanged
				End If
			End Set
		End Property
		
		<Global.System.Data.Linq.Mapping.ColumnAttribute(Storage:="_LinkLoc", DbType:="VarChar(120)")>  _
		Public Property LinkLoc() As String
			Get
				Return Me._LinkLoc
			End Get
			Set
				If (String.Equals(Me._LinkLoc, value) = false) Then
					Me.OnLinkLocChanging(value)
					Me.SendPropertyChanging
					Me._LinkLoc = value
					Me.SendPropertyChanged("LinkLoc")
					Me.OnLinkLocChanged
				End If
			End Set
		End Property
		
		<Global.System.Data.Linq.Mapping.ColumnAttribute(Storage:="_PortalId", DbType:="Int")>  _
		Public Property PortalId() As System.Nullable(Of Integer)
			Get
				Return Me._PortalId
			End Get
			Set
				If (Me._PortalId.Equals(value) = false) Then
					Me.OnPortalIdChanging(value)
					Me.SendPropertyChanging
					Me._PortalId = value
					Me.SendPropertyChanged("PortalId")
					Me.OnPortalIdChanged
				End If
			End Set
		End Property
		
		<Global.System.Data.Linq.Mapping.ColumnAttribute(Storage:="_ViewOrder", DbType:="Int")>  _
		Public Property ViewOrder() As System.Nullable(Of Integer)
			Get
				Return Me._ViewOrder
			End Get
			Set
				If (Me._ViewOrder.Equals(value) = false) Then
					Me.OnViewOrderChanging(value)
					Me.SendPropertyChanging
					Me._ViewOrder = value
					Me.SendPropertyChanged("ViewOrder")
					Me.OnViewOrderChanged
				End If
			End Set
		End Property
		
		<Global.System.Data.Linq.Mapping.ColumnAttribute(Storage:="_HovrIconFile", DbType:="Int")>  _
		Public Property HovrIconFile() As System.Nullable(Of Integer)
			Get
				Return Me._HovrIconFile
			End Get
			Set
				If (Me._HovrIconFile.Equals(value) = false) Then
					Me.OnHovrIconFileChanging(value)
					Me.SendPropertyChanging
					Me._HovrIconFile = value
					Me.SendPropertyChanged("HovrIconFile")
					Me.OnHovrIconFileChanged
				End If
			End Set
		End Property
		
		<Global.System.Data.Linq.Mapping.ColumnAttribute(Storage:="_Title", DbType:="NVarChar(50)")>  _
		Public Property Title() As String
			Get
				Return Me._Title
			End Get
			Set
				If (String.Equals(Me._Title, value) = false) Then
					Me.OnTitleChanging(value)
					Me.SendPropertyChanging
					Me._Title = value
					Me.SendPropertyChanged("Title")
					Me.OnTitleChanged
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
	
	<Global.System.Data.Linq.Mapping.TableAttribute(Name:="dbo.Agape_Skin_IconSettings")>  _
	Partial Public Class Agape_Skin_IconSetting
		Implements System.ComponentModel.INotifyPropertyChanging, System.ComponentModel.INotifyPropertyChanged
		
		Private Shared emptyChangingEventArgs As PropertyChangingEventArgs = New PropertyChangingEventArgs(String.Empty)
		
		Private _AgapeSkinSettings As Long
		
		Private _PortalId As System.Nullable(Of Integer)
		
		Private _IconHeight As System.Nullable(Of Integer)
		
		Private _ShowTitles As System.Nullable(Of Boolean)
		
		Private _Padding As Short
		
    #Region "Extensibility Method Definitions"
    Partial Private Sub OnLoaded()
    End Sub
    Partial Private Sub OnValidate(action As System.Data.Linq.ChangeAction)
    End Sub
    Partial Private Sub OnCreated()
    End Sub
    Partial Private Sub OnAgapeSkinSettingsChanging(value As Long)
    End Sub
    Partial Private Sub OnAgapeSkinSettingsChanged()
    End Sub
    Partial Private Sub OnPortalIdChanging(value As System.Nullable(Of Integer))
    End Sub
    Partial Private Sub OnPortalIdChanged()
    End Sub
    Partial Private Sub OnIconHeightChanging(value As System.Nullable(Of Integer))
    End Sub
    Partial Private Sub OnIconHeightChanged()
    End Sub
    Partial Private Sub OnShowTitlesChanging(value As System.Nullable(Of Boolean))
    End Sub
    Partial Private Sub OnShowTitlesChanged()
    End Sub
    Partial Private Sub OnPaddingChanging(value As Short)
    End Sub
    Partial Private Sub OnPaddingChanged()
    End Sub
    #End Region
		
		Public Sub New()
			MyBase.New
			OnCreated
		End Sub
		
		<Global.System.Data.Linq.Mapping.ColumnAttribute(Storage:="_AgapeSkinSettings", AutoSync:=AutoSync.OnInsert, DbType:="BigInt NOT NULL IDENTITY", IsPrimaryKey:=true, IsDbGenerated:=true)>  _
		Public Property AgapeSkinSettings() As Long
			Get
				Return Me._AgapeSkinSettings
			End Get
			Set
				If ((Me._AgapeSkinSettings = value)  _
							= false) Then
					Me.OnAgapeSkinSettingsChanging(value)
					Me.SendPropertyChanging
					Me._AgapeSkinSettings = value
					Me.SendPropertyChanged("AgapeSkinSettings")
					Me.OnAgapeSkinSettingsChanged
				End If
			End Set
		End Property
		
		<Global.System.Data.Linq.Mapping.ColumnAttribute(Storage:="_PortalId", DbType:="Int")>  _
		Public Property PortalId() As System.Nullable(Of Integer)
			Get
				Return Me._PortalId
			End Get
			Set
				If (Me._PortalId.Equals(value) = false) Then
					Me.OnPortalIdChanging(value)
					Me.SendPropertyChanging
					Me._PortalId = value
					Me.SendPropertyChanged("PortalId")
					Me.OnPortalIdChanged
				End If
			End Set
		End Property
		
		<Global.System.Data.Linq.Mapping.ColumnAttribute(Storage:="_IconHeight", DbType:="Int")>  _
		Public Property IconHeight() As System.Nullable(Of Integer)
			Get
				Return Me._IconHeight
			End Get
			Set
				If (Me._IconHeight.Equals(value) = false) Then
					Me.OnIconHeightChanging(value)
					Me.SendPropertyChanging
					Me._IconHeight = value
					Me.SendPropertyChanged("IconHeight")
					Me.OnIconHeightChanged
				End If
			End Set
		End Property
		
		<Global.System.Data.Linq.Mapping.ColumnAttribute(Storage:="_ShowTitles", DbType:="Bit")>  _
		Public Property ShowTitles() As System.Nullable(Of Boolean)
			Get
				Return Me._ShowTitles
			End Get
			Set
				If (Me._ShowTitles.Equals(value) = false) Then
					Me.OnShowTitlesChanging(value)
					Me.SendPropertyChanging
					Me._ShowTitles = value
					Me.SendPropertyChanged("ShowTitles")
					Me.OnShowTitlesChanged
				End If
			End Set
		End Property
		
		<Global.System.Data.Linq.Mapping.ColumnAttribute(Storage:="_Padding", DbType:="SmallInt NOT NULL")>  _
		Public Property Padding() As Short
			Get
				Return Me._Padding
			End Get
			Set
				If ((Me._Padding = value)  _
							= false) Then
					Me.OnPaddingChanging(value)
					Me.SendPropertyChanging
					Me._Padding = value
					Me.SendPropertyChanged("Padding")
					Me.OnPaddingChanged
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
