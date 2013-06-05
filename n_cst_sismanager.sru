HA$PBExportHeader$n_cst_sismanager.sru
forward
global type n_cst_sismanager from n_cst_appmanager
end type
end forward

global type n_cst_sismanager from n_cst_appmanager
end type
global n_cst_sismanager n_cst_sismanager

on n_cst_sismanager.create
call super::create
end on

on n_cst_sismanager.destroy
call super::destroy
end on

event pfc_open;call super::pfc_open;
datetime ldt_fe_Server

SELECT fe_sistema
INTO :gdt_fe_sistema
FROM empresas
WHERE sn_Activa = 'S';

ldt_fe_Server = datetime(date(f_fecha_Servidor()))

if gdt_fe_sistema <> ldt_fe_Server then
	UPDATE empresas
	SET fe_sistema = :ldt_fe_Server
	WHERE sn_Activa = 'S';	
	
	gdt_fe_sistema = ldt_fe_Server
end if

open (w_menucaja)
end event

event pfc_logon;call super::pfc_logon;long   li_return,ll_return   
String   ls_inifile, ls_userid, ls_password 

//// Conecci$$HEX1$$f300$$ENDHEX$$n a la Base del Sistema de Seguridad
//itr_security = CREATE n_tr 
//itr_security.of_Init(gnv_app.of_GetAppINIFile(), "Security")
//// Verificaci$$HEX1$$f300$$ENDHEX$$n de la conecci$$HEX1$$f300$$ENDHEX$$n
//if itr_security.of_Connect( ) = -1 then
//	messagebox('Conexi$$HEX1$$f300$$ENDHEX$$n a BD Seguridad', 'Error de conexi$$HEX1$$f300$$ENDHEX$$n.', Information!)
////	Return -1  
//END IF
//// inicializa los par$$HEX1$$e100$$ENDHEX$$metros de seguridad en el sistema de seguridad
//li_return = gnv_app.inv_security.of_InitSecurity(itr_security,"siscom",as_userid,"Default")
//if li_return < 0 then
//	MessageBox('Error', 'No se pudo iniciar la Seguridad. Error N$$HEX2$$b0002000$$ENDHEX$$' + string(li_return))
//	return -1
//end if
////li_return = gnv_app.inv_security.of_InitSecurity(itr_security, "siscom", &
////            gnv_app.of_GetUserID( ), "Default")
////li_return = gnv_app.inv_security.of_InitSecurity(itr_security, "siscom", &
////            sqlca.logid, "Default")
//
// Verifica si hay conecci$$HEX1$$f300$$ENDHEX$$n con la Base de Datos AGUIAR

this.of_splash(2)

if sqlca.of_IsConnected( ) THEN     
   if sqlca.logid = as_userid and sqlca.logpass = as_password then
		return 1
	end if
end if

// lee los par$$HEX1$$e100$$ENDHEX$$metros de conecci$$HEX1$$f300$$ENDHEX$$n del Archivo INI
ls_inifile = gnv_app.of_GetAppIniFile()
if SQLCA.of_Init(ls_inifile,"Database") = -1 THEN  
   	MessageBox("Base de Datos", "Error initializando desde " + ls_inifile)   
	Return -1  
end if  

// as_userid and as_password are arguments  
// to the pfc_Logon event  
//SQLCA.of_SetUser(as_userid, as_password)  

IF NOT sqlca.of_IsConnected( ) THEN     
	//	ll_return = itr_security.of_Connect( )     
	//	IF ll_return <> 0 THEN        
	//		MessageBox("Connect", "Connect error")     
	//	END IF  
	sqlca.LogID = as_userid
	sqlca.LogPass = as_password

	IF SQLCA.of_Connect() = -1 THEN     
		Return -1  
	ELSE     
		Return 1  
	END IF

else

	// 1ero. Se desconecta y vuelve a conectarse
	ll_return = sqlca.of_Disconnect( )

	MessageBox("Desconecci$$HEX1$$f300$$ENDHEX$$n de la Base de Datos", "La transacci$$HEX1$$f300$$ENDHEX$$n Actual se perder$$HEX2$$e1002000$$ENDHEX$$!!!")
	
	IF ll_return <> 0 THEN  MessageBox("Disconnect", "Disconnect error")
	
	sqlca.LogID = as_userid
	sqlca.LogPass = as_password

	IF SQLCA.of_Connect() = -1 THEN     
		Return -1  
	ELSE     
		Return 1  
	END IF

end if

end event

event constructor;call super::constructor;this.of_SetAppIniFile ("sisgestion.ini")  
//this.of_SetHelpFile   ("c:\pathname\pfc\tutorial\pfctutor.hlp")  
//this.of_SetLogo       ("jesica.jpg")  

this.of_SetCopyright("2013 ISI Duprat David")  
this.of_SetVersion("Sistema de Gesti$$HEX1$$f300$$ENDHEX$$n Empresarial - Versi$$HEX1$$f300$$ENDHEX$$n 1.0~n~n~n                Iniciando aplicaci$$HEX1$$f300$$ENDHEX$$n...") 
this.of_SetMicroHelp(TRUE)
THIS.of_SetDWCache(TRUE)
//THIS.of_SetDebug(TRUE)
//this.of_SetError(TRUE)
//this.of_SetSecurity(TRUE)
end event

