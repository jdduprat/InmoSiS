HA$PBExportHeader$w_abm_inmuebles.srw
forward
global type w_abm_inmuebles from window
end type
type em_busqueda from editmask within w_abm_inmuebles
end type
type st_columna from statictext within w_abm_inmuebles
end type
type cb_modificar from commandbutton within w_abm_inmuebles
end type
type cb_2 from commandbutton within w_abm_inmuebles
end type
type cb_1 from commandbutton within w_abm_inmuebles
end type
type gb_1 from groupbox within w_abm_inmuebles
end type
type rr_1 from roundrectangle within w_abm_inmuebles
end type
type dw_1 from u_dw within w_abm_inmuebles
end type
end forward

global type w_abm_inmuebles from window
integer width = 4091
integer height = 2256
boolean titlebar = true
string title = "Inmuebles"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
em_busqueda em_busqueda
st_columna st_columna
cb_modificar cb_modificar
cb_2 cb_2
cb_1 cb_1
gb_1 gb_1
rr_1 rr_1
dw_1 dw_1
end type
global w_abm_inmuebles w_abm_inmuebles

type variables
integer ii_origen
end variables

on w_abm_inmuebles.create
this.em_busqueda=create em_busqueda
this.st_columna=create st_columna
this.cb_modificar=create cb_modificar
this.cb_2=create cb_2
this.cb_1=create cb_1
this.gb_1=create gb_1
this.rr_1=create rr_1
this.dw_1=create dw_1
this.Control[]={this.em_busqueda,&
this.st_columna,&
this.cb_modificar,&
this.cb_2,&
this.cb_1,&
this.gb_1,&
this.rr_1,&
this.dw_1}
end on

on w_abm_inmuebles.destroy
destroy(this.em_busqueda)
destroy(this.st_columna)
destroy(this.cb_modificar)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.gb_1)
destroy(this.rr_1)
destroy(this.dw_1)
end on

event open;
ii_origen = integer(message.stringparm)

dw_1.of_setsort(true)
dw_1.of_setrowselect(true)
dw_1.inv_rowselect.of_setstyle(dw_1.inv_rowselect.single)

dw_1.of_settransobject(sqlca)
dw_1.of_retrieve()
end event

type em_busqueda from editmask within w_abm_inmuebles
integer x = 507
integer y = 84
integer width = 1467
integer height = 100
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
string text = "none"
borderstyle borderstyle = stylelowered!
string mask = "#####"
end type

type st_columna from statictext within w_abm_inmuebles
integer x = 82
integer y = 100
integer width = 402
integer height = 64
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "ID:"
alignment alignment = right!
boolean focusrectangle = false
end type

type cb_modificar from commandbutton within w_abm_inmuebles
integer x = 1861
integer y = 2008
integer width = 402
integer height = 112
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "&Modificar"
end type

event clicked;long ll_inmueble

if dw_1.getrow() = 0 then return 0

ll_inmueble = dw_1.object.id_inmueble[dw_1.getrow()]

openwithparm(w_inmueble_detalle, string(ll_inmueble))

dw_1.of_retrieve()
end event

type cb_2 from commandbutton within w_abm_inmuebles
integer x = 1179
integer y = 2008
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
open(w_inmueble_detalle)

dw_1.of_retrieve()
end event

type cb_1 from commandbutton within w_abm_inmuebles
integer x = 3470
integer y = 2008
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
end type

event clicked;s_abm str_inmueble

str_inmueble.id = -1
closewithreturn(parent, str_inmueble)
end event

type gb_1 from groupbox within w_abm_inmuebles
integer x = 37
integer y = 16
integer width = 3991
integer height = 196
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "Buscar"
end type

type rr_1 from roundrectangle within w_abm_inmuebles
long linecolor = 12632256
integer linethickness = 4
long fillcolor = 67108864
integer x = 41
integer y = 1980
integer width = 4000
integer height = 168
integer cornerheight = 40
integer cornerwidth = 46
end type

type dw_1 from u_dw within w_abm_inmuebles
integer x = 37
integer y = 220
integer width = 3995
integer height = 1744
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_inmuebles"
boolean hscrollbar = true
end type

event doubleclicked;call super::doubleclicked;
if row = 0 then return

if ii_origen = 1 then
	cb_modificar.event clicked()
else
	s_abm str_inmueble
	
	str_inmueble.id = dw_1.object.id_inmueble[row]
	closewithreturn(parent, str_inmueble)
	
end if
end event

event clicked;call super::clicked;string ls_columna

if row = 0 and ypos < 17 then

	ls_columna = dwo.text
	st_columna.text = ls_columna + ': '
	
	if mid(dwo.name, 1, 3) = 'de_' then
		em_busqueda.setmask( stringmask!, '')
	else
		em_busqueda.setmask( numericmask!, '######')
	end if
	
end if


end event

event pfc_retrieve;call super::pfc_retrieve;return retrieve()
end event

