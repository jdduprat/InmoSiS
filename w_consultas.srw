HA$PBExportHeader$w_consultas.srw
forward
global type w_consultas from window
end type
type em_hasta from editmask within w_consultas
end type
type st_2 from statictext within w_consultas
end type
type st_1 from statictext within w_consultas
end type
type em_desde from editmask within w_consultas
end type
type pb_2 from picturebutton within w_consultas
end type
type pb_1 from picturebutton within w_consultas
end type
type cb_2 from commandbutton within w_consultas
end type
type cb_1 from commandbutton within w_consultas
end type
type dw_1 from datawindow within w_consultas
end type
type rr_1 from roundrectangle within w_consultas
end type
end forward

global type w_consultas from window
integer width = 3630
integer height = 2208
boolean titlebar = true
string title = "Consulta movimientos de Caja"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
em_hasta em_hasta
st_2 st_2
st_1 st_1
em_desde em_desde
pb_2 pb_2
pb_1 pb_1
cb_2 cb_2
cb_1 cb_1
dw_1 dw_1
rr_1 rr_1
end type
global w_consultas w_consultas

on w_consultas.create
this.em_hasta=create em_hasta
this.st_2=create st_2
this.st_1=create st_1
this.em_desde=create em_desde
this.pb_2=create pb_2
this.pb_1=create pb_1
this.cb_2=create cb_2
this.cb_1=create cb_1
this.dw_1=create dw_1
this.rr_1=create rr_1
this.Control[]={this.em_hasta,&
this.st_2,&
this.st_1,&
this.em_desde,&
this.pb_2,&
this.pb_1,&
this.cb_2,&
this.cb_1,&
this.dw_1,&
this.rr_1}
end on

on w_consultas.destroy
destroy(this.em_hasta)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.em_desde)
destroy(this.pb_2)
destroy(this.pb_1)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.dw_1)
destroy(this.rr_1)
end on

event open;int li_mes, li_anio
date ld_fesistema
string ls_parm

ls_parm = message.stringparm

dw_1.dataobject = ls_parm
dw_1.settransobject(sqlca)

ld_fesistema = date(gdt_fe_sistema)

li_mes = month(ld_fesistema)
li_anio = year(ld_fesistema)

em_Desde.text = '01/' + string(li_mes) + '/' + string(li_anio)
em_hasta.text = string(ld_fesistema)

dw_1.retrieve( date(em_desde.text), date(em_hasta.text))
end event

type em_hasta from editmask within w_consultas
integer x = 1362
integer y = 1956
integer width = 425
integer height = 96
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "none"
alignment alignment = center!
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = datemask!
string mask = "dd/mm/yyyy"
boolean dropdowncalendar = true
end type

type st_2 from statictext within w_consultas
integer x = 1298
integer y = 1968
integer width = 78
integer height = 64
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "a"
boolean focusrectangle = false
end type

type st_1 from statictext within w_consultas
integer x = 503
integer y = 1972
integer width = 320
integer height = 64
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "Per$$HEX1$$ed00$$ENDHEX$$odo: de"
boolean focusrectangle = false
end type

type em_desde from editmask within w_consultas
integer x = 841
integer y = 1956
integer width = 425
integer height = 96
integer taborder = 60
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "none"
alignment alignment = center!
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = datemask!
string mask = "dd/mm/yyyy"
boolean dropdowncalendar = true
end type

type pb_2 from picturebutton within w_consultas
integer x = 2798
integer y = 1952
integer width = 128
integer height = 108
integer taborder = 50
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string picturename = "EditDataGrid!"
alignment htextalign = left!
string powertiptext = "Excel"
end type

event clicked;
dw_1.SaveAs("", Excel!, true)
end event

type pb_1 from picturebutton within w_consultas
integer x = 2642
integer y = 1952
integer width = 128
integer height = 108
integer taborder = 40
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string picturename = "Print!"
alignment htextalign = left!
string powertiptext = "Imprimir"
end type

event clicked;
dw_1.print()
end event

type cb_2 from commandbutton within w_consultas
integer x = 1847
integer y = 1944
integer width = 402
integer height = 112
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "&Mostrar"
end type

event clicked;

dw_1.retrieve( date(em_desde.text), date(em_hasta.text))

end event

type cb_1 from commandbutton within w_consultas
integer x = 2994
integer y = 1948
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

event clicked;close(parent)
end event

type dw_1 from datawindow within w_consultas
integer x = 23
integer y = 16
integer width = 3529
integer height = 1880
integer taborder = 10
string title = "none"
string dataobject = "d_movimientos_crostab"
boolean hscrollbar = true
boolean vscrollbar = true
boolean resizable = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type rr_1 from roundrectangle within w_consultas
long linecolor = 12632256
integer linethickness = 4
long fillcolor = 67108864
integer x = 32
integer y = 1920
integer width = 3525
integer height = 168
integer cornerheight = 40
integer cornerwidth = 46
end type

