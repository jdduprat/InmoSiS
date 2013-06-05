HA$PBExportHeader$w_consulta_movimientos.srw
forward
global type w_consulta_movimientos from window
end type
type cbx_1 from checkbox within w_consulta_movimientos
end type
type em_hasta from editmask within w_consulta_movimientos
end type
type st_2 from statictext within w_consulta_movimientos
end type
type st_1 from statictext within w_consulta_movimientos
end type
type em_desde from editmask within w_consulta_movimientos
end type
type pb_2 from picturebutton within w_consulta_movimientos
end type
type pb_1 from picturebutton within w_consulta_movimientos
end type
type cb_2 from commandbutton within w_consulta_movimientos
end type
type cb_1 from commandbutton within w_consulta_movimientos
end type
type dw_1 from datawindow within w_consulta_movimientos
end type
type rr_1 from roundrectangle within w_consulta_movimientos
end type
end forward

global type w_consulta_movimientos from window
integer width = 3630
integer height = 2284
boolean titlebar = true
string title = "Consulta movimientos de Caja"
string menuname = "m_menucaja"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
cbx_1 cbx_1
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
global w_consulta_movimientos w_consulta_movimientos

on w_consulta_movimientos.create
if this.MenuName = "m_menucaja" then this.MenuID = create m_menucaja
this.cbx_1=create cbx_1
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
this.Control[]={this.cbx_1,&
this.em_hasta,&
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

on w_consulta_movimientos.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.cbx_1)
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

ld_fesistema = date(gdt_fe_sistema)

li_mes = month(ld_fesistema)
li_anio = year(ld_fesistema)

em_Desde.text = '01/' + string(li_mes) + '/' + string(li_anio)
em_hasta.text = string(ld_fesistema)

dw_1.retrieve( date(em_desde.text), date(em_hasta.text))
end event

type cbx_1 from checkbox within w_consulta_movimientos
integer x = 105
integer y = 1960
integer width = 320
integer height = 80
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "Listado"
end type

event clicked;
if checked then
	dw_1.dataobject = 'd_consulta_movimientos'
else
	dw_1.dataobject = 'd_movimientos_crostab'
end if

dw_1.settransobject( sqlca)
cb_2.event clicked( )
end event

type em_hasta from editmask within w_consulta_movimientos
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

type st_2 from statictext within w_consulta_movimientos
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

type st_1 from statictext within w_consulta_movimientos
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

type em_desde from editmask within w_consulta_movimientos
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

type pb_2 from picturebutton within w_consulta_movimientos
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

event clicked;string camino,archivo
int li_result

setpointer(hourglass!)
// ... Init docname
// ... GetFileOpenName or any other method

if GetFileSaveName ( 'Nombre de Archivo', camino, archivo,'xls') = -1 then
MessageBox("Error", "error", Exclamation!)
return
end if

if dw_1.SaveAs(camino, HTMLTable!, True) = -1 then
MessageBox("Error", "Imposible de Exportar los datos", Exclamation!)
return
end if

// Convert HTML file to Excel native format
OLEObject excel
excel = CREATE OLEObject
li_result = excel.ConnectToNewObject("excel.application")
IF li_result <> 0 THEN
DESTROY excel
MessageBox("OLE Error", "No puede conectarse a Excel " &
+ "C$$HEX1$$f300$$ENDHEX$$digo: " &
+ String(li_result))
SetPointer(Arrow!)
RETURN 
END IF

excel.application.DisplayAlerts = FALSE
excel.workbooks.open(camino)
excel.visible=true
excel.application.workbooks(1).saveas(camino, 39)

setpointer(arrow!)
DESTROY excel
end event

type pb_1 from picturebutton within w_consulta_movimientos
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

type cb_2 from commandbutton within w_consulta_movimientos
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

type cb_1 from commandbutton within w_consulta_movimientos
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

type dw_1 from datawindow within w_consulta_movimientos
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

event constructor;settransobject(sqlca)
end event

type rr_1 from roundrectangle within w_consulta_movimientos
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

