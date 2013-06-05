HA$PBExportHeader$w_abm_valores.srw
forward
global type w_abm_valores from window
end type
type cb_4 from commandbutton within w_abm_valores
end type
type cb_3 from commandbutton within w_abm_valores
end type
type cb_2 from commandbutton within w_abm_valores
end type
type cb_1 from commandbutton within w_abm_valores
end type
type rr_1 from roundrectangle within w_abm_valores
end type
type dw_1 from datawindow within w_abm_valores
end type
end forward

global type w_abm_valores from window
integer width = 2135
integer height = 1520
boolean titlebar = true
string title = "Valores de Caja"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 67108864
string icon = "DosEdit5!"
boolean center = true
cb_4 cb_4
cb_3 cb_3
cb_2 cb_2
cb_1 cb_1
rr_1 rr_1
dw_1 dw_1
end type
global w_abm_valores w_abm_valores

type variables

constant string ORIGEN_MOV = '2' 
constant string ORIGEN_ABM = '1'

private string is_origen


end variables

on w_abm_valores.create
this.cb_4=create cb_4
this.cb_3=create cb_3
this.cb_2=create cb_2
this.cb_1=create cb_1
this.rr_1=create rr_1
this.dw_1=create dw_1
this.Control[]={this.cb_4,&
this.cb_3,&
this.cb_2,&
this.cb_1,&
this.rr_1,&
this.dw_1}
end on

on w_abm_valores.destroy
destroy(this.cb_4)
destroy(this.cb_3)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.rr_1)
destroy(this.dw_1)
end on

event open;
is_origen = message.stringparm

dw_1.retrieve()
end event

type cb_4 from commandbutton within w_abm_valores
integer x = 1568
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

type cb_3 from commandbutton within w_abm_valores
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

dw_1.accepttext( )

for i = 1 to dw_1.rowcount( )
	if isnull(dw_1.object.de_valor[i]) then 
		MessageBox('Error de datos', 'Debe ingresar la descripci$$HEX1$$f300$$ENDHEX$$n de valor. Fila: '+string(i))
		return
	end if
next

if 	dw_1.update() = -1 then
	rollback;
	MessageBox('ABM Valores', 'Error al intentar grabar los datos')
else
	commit;
	MessageBox('ABM Valores', 'Los datos se grabaron correctamente')
end if

end event

type cb_2 from commandbutton within w_abm_valores
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

if dw_1.rowcount( ) = 0 then return

row = dw_1.getrow()

li_res = MessageBox('ABM Valores', '$$HEX1$$bf00$$ENDHEX$$Desea borrar el valor ' + string(dw_1.object.id_valor[row]) + '?',  question!, yesno!)

if li_Res = 1 then dw_1.deleterow(row)

end event

type cb_1 from commandbutton within w_abm_valores
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

dw_1.accepttext( )

if dw_1.rowcount() = 0 then 
	ll_idmov = 1
else
	if isnull(dw_1.object.de_valor[dw_1.rowcount()]) then return
	
	ll_idmov = dw_1.object.id[1] + 1	
end if

li_row = dw_1.insertrow(0)

dw_1.object.id_valor[li_row] = ll_idmov
dw_1.setfocus( )

dw_1.scrolltorow(li_row)
dw_1.setcolumn( 'de_valor')
end event

type rr_1 from roundrectangle within w_abm_valores
long linecolor = 12632256
integer linethickness = 4
long fillcolor = 67108864
integer y = 1248
integer width = 2085
integer height = 168
integer cornerheight = 40
integer cornerwidth = 46
end type

type dw_1 from datawindow within w_abm_valores
integer x = 27
integer y = 4
integer width = 2071
integer height = 1228
integer taborder = 10
string title = "none"
string dataobject = "d_valores"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;settransobject(sqlca)
end event

event doubleclicked;string ls_return

if row = 0 then return

if is_origen = ORIGEN_MOV then 
	
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

