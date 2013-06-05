HA$PBExportHeader$sisgestion.sra
$PBExportComments$Generated Application Object
forward
global type sisgestion from application
end type
global n_tr sqlca
global dynamicdescriptionarea sqlda
global dynamicstagingarea sqlsa
global error error
global message message
end forward

global variables
n_cst_appmanager gnv_app

datetime gdt_fe_sistema
end variables 

global type sisgestion from application
string appname = "sisgestion"
string displayname = "InmoSIS"
end type
global sisgestion sisgestion

on sisgestion.create
appname="sisgestion"
message=create message
sqlca=create n_tr
sqlda=create dynamicdescriptionarea
sqlsa=create dynamicstagingarea
error=create error
end on

on sisgestion.destroy
destroy(sqlca)
destroy(sqlda)
destroy(sqlsa)
destroy(error)
destroy(message)
end on

event open;
IF Handle(This, TRUE) > 0 THEN
	MessageBox("Applicaci$$HEX1$$f300$$ENDHEX$$n ya est$$HEX2$$e1002000$$ENDHEX$$Activa",  &
	Upper(This.AppName) + " ya est$$HEX2$$e1002000$$ENDHEX$$activa."  &
	+ " Ud. No puede iniciar la aplicaci$$HEX1$$f300$$ENDHEX$$n otra vez.")
	HALT CLOSE
ELSE
	gnv_app = CREATE n_cst_sismanager
	if gnv_app.event pfc_logon('', '') = -1 then return
	gnv_app.event pfc_open(commandline)	
END IF
end event

event idle;// DESCONECTAR LA BASE
// Y VOLVER A CONECTAR

Integer   li_return, veces

//disconnect using sqlca;

for veces = 1 to 3
	li_return = gnv_app.of_LogonDlg( ) 

	IF li_return = 1 THEN   
//		this.SetMicroHelp("Login exitoso") 
		return
	elseIF li_return = 0 THEN  
//		// el usuario cancela
//		this.Event pfc_Exit( )
		Halt Close  
	ELSEif  li_return = -1 then
		MessageBox("Login", "Login incorrecto")  
		if veces = 3 then
			Halt Close  
		end if
	END IF
next
end event

event systemerror;ROLLBACK;
gnv_app.Event pfc_SystemError()
end event

