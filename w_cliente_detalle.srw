HA$PBExportHeader$w_cliente_detalle.srw
forward
global type w_cliente_detalle from window
end type
type cb_2 from commandbutton within w_cliente_detalle
end type
type cb_1 from commandbutton within w_cliente_detalle
end type
type dw_1 from datawindow within w_cliente_detalle
end type
type rr_1 from roundrectangle within w_cliente_detalle
end type
end forward

global type w_cliente_detalle from window
integer width = 1943
integer height = 1324
boolean titlebar = true
string title = "Nuevo Cliente"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
cb_2 cb_2
cb_1 cb_1
dw_1 dw_1
rr_1 rr_1
end type
global w_cliente_detalle w_cliente_detalle

type variables

uo_dwc_localidades iuo_localidades
end variables

forward prototypes
public subroutine wf_iniciar_localidad ()
public subroutine wf_agregar_cliente ()
end prototypes

public subroutine wf_iniciar_localidad ();
iuo_localidades = create uo_dwc_localidades

iuo_localidades.of_set_dw(dw_1)
iuo_localidades.of_init()

iuo_localidades.of_cargar_localidad_empresa( )
end subroutine

public subroutine wf_agregar_cliente ();long ll_cli

dw_1.insertrow(0)

SELECT max(id_cliente) + 1
INTO :ll_cli
FROM clientes;
if sqlca.sqlcode = -1 then
	MessageBox('Error DB','Error al intentar de base de datos~n'+sqlca.sqlerrtext)
	close(this)
end if

if isnull(ll_cli) then ll_cli = 1

dw_1.object.id_cliente[1] = ll_cli
end subroutine

event open;long ll_cli

ll_cli = long(message.stringparm)

dw_1.settransobject(sqlca)

wf_iniciar_localidad()
if ll_cli > 0 then 
	dw_1.retrieve( ll_cli )	
	//wf_iniciar_localidad(1)
else	
	//wf_iniciar_localidad(0)
	wf_agregar_cliente()
end if
end event

on w_cliente_detalle.create
this.cb_2=create cb_2
this.cb_1=create cb_1
this.dw_1=create dw_1
this.rr_1=create rr_1
this.Control[]={this.cb_2,&
this.cb_1,&
this.dw_1,&
this.rr_1}
end on

on w_cliente_detalle.destroy
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.dw_1)
destroy(this.rr_1)
end on

event close;
destroy iuo_localidades
end event

type cb_2 from commandbutton within w_cliente_detalle
integer x = 768
integer y = 1084
integer width = 402
integer height = 112
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "&Grabar"
end type

event clicked;
if dw_1.update() = -1 then
	rollback;
	MessageBox('Error','Error al intentar grabar los datos. ~nIntente nuevamente')
end if

commit;

close(parent)
end event

type cb_1 from commandbutton within w_cliente_detalle
integer x = 1353
integer y = 1084
integer width = 402
integer height = 112
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "&Cerrar"
boolean cancel = true
end type

event clicked;
dw_1.reset()

close(parent)
end event

type dw_1 from datawindow within w_cliente_detalle
integer x = 46
integer y = 32
integer width = 1819
integer height = 1024
integer taborder = 10
string title = "none"
string dataobject = "d_cliente_detalle"
boolean border = false
end type

event itemchanged;
choose case getcolumnname()
	case 'id_provincia'
		iuo_localidades.of_set_provincia(long(data))
		
	case 'id_departamento'
		iuo_localidades.of_set_departamento(long(data))
		
	case 'id_localidad'
		iuo_localidades.of_set_localidad(long(data))
		
end choose

end event

type rr_1 from roundrectangle within w_cliente_detalle
long linecolor = 12632256
integer linethickness = 4
long fillcolor = 67108864
integer x = 27
integer y = 1056
integer width = 1879
integer height = 168
integer cornerheight = 40
integer cornerwidth = 46
end type

