HA$PBExportHeader$w_inmueble_detalle.srw
forward
global type w_inmueble_detalle from window
end type
type cb_2 from commandbutton within w_inmueble_detalle
end type
type cb_1 from commandbutton within w_inmueble_detalle
end type
type dw_1 from datawindow within w_inmueble_detalle
end type
type rr_1 from roundrectangle within w_inmueble_detalle
end type
end forward

global type w_inmueble_detalle from window
integer width = 2167
integer height = 1396
boolean titlebar = true
string title = "Nuevo Inmueble"
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
global w_inmueble_detalle w_inmueble_detalle

type variables
uo_dwc_localidades iuo_localidades
end variables

forward prototypes
public subroutine wf_iniciar_localidad ()
end prototypes

public subroutine wf_iniciar_localidad ();
iuo_localidades = create uo_dwc_localidades

iuo_localidades.of_set_dw(dw_1)
iuo_localidades.of_init()
iuo_localidades.of_cargar_localidad_empresa( )
end subroutine

event open;long ll_inmueble

ll_inmueble = long(message.stringparm)

dw_1.settransobject(sqlca)

wf_iniciar_localidad()
	
if ll_inmueble > 0 then 
	dw_1.retrieve( ll_inmueble )
	
else	
	
	dw_1.insertrow(0)
	
	SELECT max(id_inmueble) + 1
	INTO :ll_inmueble
	FROM inmuebles;
	if sqlca.sqlcode = -1 then
		MessageBox('Nuevo Inmueble','Error al intentar obtener n$$HEX1$$fa00$$ENDHEX$$mero de la base de datos~n'+sqlca.sqlerrtext)
		close(this)
	end if
	
	if isnull(ll_inmueble) then ll_inmueble = 1
	
	dw_1.object.id_inmueble[1] = ll_inmueble
	
end if
end event

on w_inmueble_detalle.create
this.cb_2=create cb_2
this.cb_1=create cb_1
this.dw_1=create dw_1
this.rr_1=create rr_1
this.Control[]={this.cb_2,&
this.cb_1,&
this.dw_1,&
this.rr_1}
end on

on w_inmueble_detalle.destroy
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.dw_1)
destroy(this.rr_1)
end on

event close;destroy iuo_localidades
end event

type cb_2 from commandbutton within w_inmueble_detalle
integer x = 969
integer y = 1152
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

type cb_1 from commandbutton within w_inmueble_detalle
integer x = 1550
integer y = 1152
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

type dw_1 from datawindow within w_inmueble_detalle
integer x = 27
integer y = 32
integer width = 2002
integer height = 1076
integer taborder = 10
string title = "none"
string dataobject = "d_inmueble_detalle"
boolean border = false
end type

event itemchanged;choose case getcolumnname()
	case 'id_provincia'
		iuo_localidades.of_set_provincia(long(data))
		
	case 'id_departamento'
		iuo_localidades.of_set_departamento(long(data))
		
	case 'id_localidad'
		iuo_localidades.of_set_localidad(long(data))
		
end choose
end event

type rr_1 from roundrectangle within w_inmueble_detalle
long linecolor = 12632256
integer linethickness = 4
long fillcolor = 67108864
integer x = 18
integer y = 1124
integer width = 2107
integer height = 168
integer cornerheight = 40
integer cornerwidth = 46
end type

