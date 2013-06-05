HA$PBExportHeader$w_abm_tipomovimiento.srw
forward
global type w_abm_tipomovimiento from window
end type
type cb_4 from commandbutton within w_abm_tipomovimiento
end type
type cb_3 from commandbutton within w_abm_tipomovimiento
end type
type cb_2 from commandbutton within w_abm_tipomovimiento
end type
type cb_1 from commandbutton within w_abm_tipomovimiento
end type
type dw_1 from datawindow within w_abm_tipomovimiento
end type
type rr_1 from roundrectangle within w_abm_tipomovimiento
end type
end forward

global type w_abm_tipomovimiento from window
integer width = 2213
integer height = 1520
boolean titlebar = true
string title = "Tipos de Movimiento de Caja"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 67108864
string icon = "DosEdit5!"
boolean center = true
cb_4 cb_4
cb_3 cb_3
cb_2 cb_2
cb_1 cb_1
dw_1 dw_1
rr_1 rr_1
end type
global w_abm_tipomovimiento w_abm_tipomovimiento

type variables

constant string ORIGEN_MOV = '2' 
constant string ORIGEN_ABM_MOV = '1'
constant string ORIGEN_INM = '3'
constant string ORIGEN_ABM_INM = '4'

private:

string is_origen
string DW_TIPO_CAJA = 'd_tipos_movimientos'
string DW_TIPO_INMUEBLE = 'd_tipos_inmuebles'
end variables

on w_abm_tipomovimiento.create
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

on w_abm_tipomovimiento.destroy
destroy(this.cb_4)
destroy(this.cb_3)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.dw_1)
destroy(this.rr_1)
end on

event open;
is_origen = message.stringparm

choose case is_origen
	CASE ORIGEN_MOV, ORIGEN_ABM_MOV
		dw_1.dataobject = DW_TIPO_CAJA
		
	CASE ORIGEN_INM, ORIGEN_ABM_INM
		dw_1.dataobject = DW_TIPO_INMUEBLE
		
end choose

dw_1.SETTRAnsobject(SQLCA)
dw_1.retrieve()


end event

type cb_4 from commandbutton within w_abm_tipomovimiento
integer x = 1641
integer y = 1276
integer width = 402
integer height = 112
integer taborder = 50
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "&Cerrar"
boolean cancel = true
end type

event clicked;close(parent)
end event

type cb_3 from commandbutton within w_abm_tipomovimiento
integer x = 1106
integer y = 1276
integer width = 402
integer height = 112
integer taborder = 40
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "&Grabar"
boolean default = true
end type

event clicked;int i

dw_1.accepttext()

for i = 1 to dw_1.rowcount( )
	if isnull(dw_1.object.de_tipo[i])	 then 
		MessageBox('Error de datos', 'Debe ingresar el tipo de valor. Fila: '+string(i))
		return
	end if
next

if dw_1.update() = -1 then
	rollback;
	MessageBox('ABM Tipos', 'Error al intentar grabar los datos')
else
	commit;
	MessageBox('ABM Tipos', 'Los datos se grabaron correctamente')
end if
end event

type cb_2 from commandbutton within w_abm_tipomovimiento
integer x = 635
integer y = 1276
integer width = 402
integer height = 112
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "&Borrar"
end type

event clicked;int row, li_res

if dw_1.rowcount() = 0 then return

row = dw_1.getrow()

li_res = MessageBox('ABM Tipos', '$$HEX1$$bf00$$ENDHEX$$Desea borrar el tipo ' + string(dw_1.object.id_tipo[row]) + '?',  question!, yesno!)

if li_Res = 1 then dw_1.deleterow(row)
end event

type cb_1 from commandbutton within w_abm_tipomovimiento
integer x = 165
integer y = 1276
integer width = 402
integer height = 112
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "&Insertar"
end type

event clicked;long ll_idmov
int li_row

if dw_1.rowcount() = 0 then
	ll_idmov = 1
else
	if isnull(dw_1.object.de_tipo[dw_1.rowcount()]) then return
	
	ll_idmov = dw_1.object.id[1] + 1
end if
	
li_row = dw_1.insertrow(0)

dw_1.object.id_Tipo[li_row] = ll_idmov
dw_1.setfocus( )

dw_1.scrolltorow(li_row)
dw_1.setcolumn( 'de_tipo')
end event

type dw_1 from datawindow within w_abm_tipomovimiento
integer x = 27
integer y = 4
integer width = 2149
integer height = 1228
integer taborder = 10
string title = "none"
string dataobject = "d_tipos_movimientos"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;settransobject(sqlca)
end event

event doubleclicked;string ls_return

if row = 0 then return

if is_origen = ORIGEN_MOV OR is_origen = ORIGEN_INM then 
	
	ls_return = string(dw_1.object.id_tipo[row])
	
	CloseWithReturn ( parent, ls_return )
	
end if

end event

event itemerror;
//if dwo.name = 'De_tipo' then
	messageBox('Atenci$$HEX1$$f300$$ENDHEX$$n', 'Debe ingresar un valor')
	return 1
//end if


end event

type rr_1 from roundrectangle within w_abm_tipomovimiento
long linecolor = 12632256
integer linethickness = 4
long fillcolor = 67108864
integer x = 27
integer y = 1248
integer width = 2139
integer height = 168
integer cornerheight = 40
integer cornerwidth = 46
end type

