HA$PBExportHeader$w_ingreso_egreso_caja.srw
forward
global type w_ingreso_egreso_caja from window
end type
type cb_4 from commandbutton within w_ingreso_egreso_caja
end type
type cb_3 from commandbutton within w_ingreso_egreso_caja
end type
type cb_2 from commandbutton within w_ingreso_egreso_caja
end type
type cb_1 from commandbutton within w_ingreso_egreso_caja
end type
type dw_1 from datawindow within w_ingreso_egreso_caja
end type
type rr_1 from roundrectangle within w_ingreso_egreso_caja
end type
end forward

global type w_ingreso_egreso_caja from window
integer width = 2126
integer height = 1444
boolean titlebar = true
boolean controlmenu = true
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
windowanimationstyle openanimation = centeranimation!
cb_4 cb_4
cb_3 cb_3
cb_2 cb_2
cb_1 cb_1
dw_1 dw_1
rr_1 rr_1
end type
global w_ingreso_egreso_caja w_ingreso_egreso_caja

type variables

datawindowchild idwc_tipos_movimiento
end variables

forward prototypes
public function integer wf_nuevo_movimiento ()
public function integer wf_signum (integer etapa)
public subroutine wf_settiaplica (integer row)
end prototypes

public function integer wf_nuevo_movimiento ();int row

row = dw_1.insertrow(0)

dw_1.object.fe_movimiento[row] = gdt_fe_sistema
dw_1.object.id_movimiento[row] = wf_signum(1)

return 1
end function

public function integer wf_signum (integer etapa);long ll_mov

CHOOSE CASE etapa
	CASE 1
		SELECT MAX(id_movimiento) +1
		INTO :ll_mov
		FROM caja_movimientos;
		if sqlca.sqlcode = -1 then 
			ll_mov = -1
			MessageBox('Error DB','Ha ocurrido un error al consultar la base de datos. '+sqlca.sqlerrtext)
		end if
		
	CASE 2
//		UPDATE caja_movimientos
//		SET id_movimiento = {MAX(id_movimiento)} + 1
//		;
//		if sqlca.sqlcode = -1 then 
//			rollback;
//			MessageBox('Error DB','Ha ocurrido un error al intentar grabar en la base de datos. '+sqlca.sqlerrtext)
//			return -1
//		end if
		
		SELECT MAX(id_movimiento) +1
		INTO :ll_mov
		FROM caja_movimientos;
		if sqlca.sqlcode = -1 then 
			rollback;
			MessageBox('Error DB','Ha ocurrido un error al consultar en la base de datos. '+sqlca.sqlerrtext)
			return -1
		end if
		
END CHOOSE
		
return ll_mov
end function

public subroutine wf_settiaplica (integer row);int li_tiaplica

li_tiaplica = idwc_tipos_movimiento.getitemnumber( idwc_tipos_movimiento.getrow(), 'ti_aplica_caja')
dw_1.object.ti_aplica_caja[row] = li_tiaplica
end subroutine

on w_ingreso_egreso_caja.create
this.cb_4=create cb_4
this.cb_3=create cb_3
this.cb_2=create cb_2
this.cb_1=create cb_1
this.dw_1=create dw_1
this.rr_1=create rr_1
this.Control[]={this.cb_4,&
this.cb_3,&
this.cb_2,&
this.cb_1,&
this.dw_1,&
this.rr_1}
end on

on w_ingreso_egreso_caja.destroy
destroy(this.cb_4)
destroy(this.cb_3)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.dw_1)
destroy(this.rr_1)
end on

event open;
wf_nuevo_movimiento()

dw_1.getchild( 'id_tipo', idwc_tipos_movimiento) 
idwc_tipos_movimiento.settransobject(sqlca)
idwc_tipos_movimiento.retrieve( )
end event

type cb_4 from commandbutton within w_ingreso_egreso_caja
integer x = 1554
integer y = 260
integer width = 110
integer height = 104
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "..."
end type

event clicked;string ls_tipo

openwithparm(w_abm_tipomovimiento, w_abm_tipomovimiento.ORIGEN_MOV)

ls_tipo = message.stringparm

dw_1.object.id_tipo[1] = long(ls_tipo)
wf_settiaplica(1)
end event

type cb_3 from commandbutton within w_ingreso_egreso_caja
integer x = 462
integer y = 1196
integer width = 402
integer height = 112
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "&Nuevo"
end type

event clicked;
if MessageBox('Nuevo Recibo', 'Si contin$$HEX1$$fa00$$ENDHEX$$a perder$$HEX2$$e1002000$$ENDHEX$$los cambios realizados. '+&
					'~n$$HEX1$$bf00$$ENDHEX$$Desea continuar?', question!, yesno!) = 2 then return

dw_1.reset()
wf_nuevo_movimiento()

end event

type cb_2 from commandbutton within w_ingreso_egreso_caja
integer x = 1541
integer y = 1196
integer width = 402
integer height = 112
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "&Cerrar"
end type

event clicked;close(parent)
end event

type cb_1 from commandbutton within w_ingreso_egreso_caja
integer x = 928
integer y = 1196
integer width = 402
integer height = 112
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "&Grabar"
end type

event clicked;long ll_num
string ls_Error

dw_1.accepttext()

if isnull(dw_1.object.fe_movimiento[1]) then
	MessageBox('Atenci$$HEX1$$f300$$ENDHEX$$n','Debe ingresar la fecha de movimiento', exclamation!)
	return
end if

if isnull(dw_1.object.id_tipo[1]) then
	MessageBox('Atenci$$HEX1$$f300$$ENDHEX$$n','Debe seleccionar el movimiento', exclamation!)
	return
end if

if isnull(dw_1.object.id_valor[1]) then
	MessageBox('Atenci$$HEX1$$f300$$ENDHEX$$n','Debe ingresar los valores del movimiento', exclamation!)
	return
end if

if isnull(dw_1.object.pr_total[1]) then
	MessageBox('Atenci$$HEX1$$f300$$ENDHEX$$n','Debe ingresar el importe del movimiento', exclamation!)
	return
end if

ll_num = wf_signum(2)
if ll_num = -1 then return

dw_1.object.id_movimiento[1] = ll_num
dw_1.object.fe_registro[1] = f_fecha_servidor()

if dw_1.update() = -1 then
	ls_Error = sqlca.sqlerrtext
	rollback;
	MessageBox('Error DB','Ocurri$$HEX2$$f3002000$$ENDHEX$$un error al intentar grabar el movimiento. Intente nuevamente~n'+ls_Error, exclamation!)
	return
end if

commit;

dw_1.reset()
wf_nuevo_movimiento()
end event

type dw_1 from datawindow within w_ingreso_egreso_caja
integer x = 32
integer y = 32
integer width = 2025
integer height = 1108
integer taborder = 10
string title = "none"
string dataobject = "d_ingreso_egreso_caja"
boolean border = false
boolean livescroll = true
end type

event constructor;this.settransobject(sqlca)
end event

event itemchanged;

CHOOSE CASE dwo.name
	
	CASE 'id_tipo'
	
		wf_settiaplica(row)
	
		
END CHOOSE
end event

type rr_1 from roundrectangle within w_ingreso_egreso_caja
long linecolor = 12632256
integer linethickness = 4
long fillcolor = 67108864
integer x = 32
integer y = 1168
integer width = 2034
integer height = 168
integer cornerheight = 40
integer cornerwidth = 46
end type

