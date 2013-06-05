HA$PBExportHeader$w_contrato.srw
forward
global type w_contrato from window
end type
type cb_6 from commandbutton within w_contrato
end type
type cb_5 from commandbutton within w_contrato
end type
type cb_4 from commandbutton within w_contrato
end type
type cb_3 from commandbutton within w_contrato
end type
type cb_grabar from commandbutton within w_contrato
end type
type cb_cerrar from commandbutton within w_contrato
end type
type st_3 from statictext within w_contrato
end type
type st_2 from statictext within w_contrato
end type
type st_1 from statictext within w_contrato
end type
type cb_2 from commandbutton within w_contrato
end type
type em_monto from editmask within w_contrato
end type
type em_fecha from editmask within w_contrato
end type
type em_cuotas from editmask within w_contrato
end type
type cbx_1 from checkbox within w_contrato
end type
type cb_1 from commandbutton within w_contrato
end type
type dw_cuotas from datawindow within w_contrato
end type
type dw_contrato from datawindow within w_contrato
end type
type gb_1 from groupbox within w_contrato
end type
type gb_2 from groupbox within w_contrato
end type
type rr_1 from roundrectangle within w_contrato
end type
end forward

global type w_contrato from window
integer width = 2807
integer height = 2668
boolean titlebar = true
string title = "Registrar Contrato"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
cb_6 cb_6
cb_5 cb_5
cb_4 cb_4
cb_3 cb_3
cb_grabar cb_grabar
cb_cerrar cb_cerrar
st_3 st_3
st_2 st_2
st_1 st_1
cb_2 cb_2
em_monto em_monto
em_fecha em_fecha
em_cuotas em_cuotas
cbx_1 cbx_1
cb_1 cb_1
dw_cuotas dw_cuotas
dw_contrato dw_contrato
gb_1 gb_1
gb_2 gb_2
rr_1 rr_1
end type
global w_contrato w_contrato

forward prototypes
public function date wf_agregar_meses (date ad_fecha, integer ai_meses)
public function integer wf_nuevo ()
public function long wf_signum ()
public subroutine wf_buscar_inmueble (long al_id)
public function integer wf_control_vencimiento (date ad_fecha)
public function integer wf_alquilar_inmueble ()
end prototypes

public function date wf_agregar_meses (date ad_fecha, integer ai_meses);int li_dias, li_mes, li_anio

li_dias = day(ad_fecha)
li_mes = month(ad_fecha)
li_anio = year(ad_fecha)

li_mes = li_mes + ai_meses
if li_mes > 12 then
	li_anio = li_anio + int(li_mes/12)
	li_mes = Mod(li_mes, 12)
end if
if li_mes = 2 AND li_dias > 28 then li_dias = 28

return date(li_anio, li_mes, li_dias)
end function

public function integer wf_nuevo ();long ll_num

dw_contrato.reset()
dw_contrato.insertrow(0)

ll_num = wf_signum()
if ll_num = -1 then return -1

dw_contrato.object.id_contrato[1] = ll_num
dw_contrato.object.fe_contrato[1] = gdt_fe_sistema

dw_cuotas.reset()

em_fecha.text = string(gdt_fe_sistema)
em_cuotas.text = '1'
em_monto.text = '$ 0'

return 1
end function

public function long wf_signum ();long ll_num

SELECT max(id_contrato) 
INTO :ll_num
FROM contratos;
if sqlca.sqlcode = -1 then
	MessageBox('Error DB','Error al intentar obtener el n$$HEX1$$fa00$$ENDHEX$$mero de contrato')
	return -1
end if

if isnull(ll_num) then ll_num = 1

return ll_num
end function

public subroutine wf_buscar_inmueble (long al_id);long ll_cliente

SELECT id_cliente
INTO :ll_cliente
FROM inmuebles
WHERE id_inmueble = :al_id;
if sqlca.sqlcode = 100 or sqlca.sqlcode = -1 then
	MessageBox('Nuevo Contrato', 'Ocurri$$HEX2$$f3002000$$ENDHEX$$un Error. Intente nuevamente.', exclamation!)
	setnull(al_id)
	setnull(ll_cliente)
end if

dw_contrato.object.id_inmueble[1] = al_id
dw_contrato.object.id_locador[1] = ll_cliente
end subroutine

public function integer wf_control_vencimiento (date ad_fecha);
if ad_fecha < date(gdt_fe_sistema) then
	MessageBox('Carga de cuotas', 'La fecha de vencimiento no puede ser anterior a la actual', exclamation!)
	return -1
end if
if date(dw_contrato.object.fe_vencimiento[1]) < ad_fecha then
	MessageBox('Carga de cuotas', 'La fecha de vencimiento no puede ser posterior a la fecha '+&
											'de vencimiento del contrato', exclamation!)
	return -1
end if
end function

public function integer wf_alquilar_inmueble ();long ll_in

ll_in = dw_contrato.object.id_inmueble[1]

UPDATE inmuebles
SET sn_alquilado = 'S'
WHERE id_inmueble = :ll_in;
if sqlca.sqlcode = -1 then 
	MessageBox('Contrato Grabaci$$HEX1$$f300$$ENDHEX$$n', 'Error al intentar actualizar el estado del inmueble.~n'+sqlca.sqlerrtext)
	return -1
end if

return 1
end function

on w_contrato.create
this.cb_6=create cb_6
this.cb_5=create cb_5
this.cb_4=create cb_4
this.cb_3=create cb_3
this.cb_grabar=create cb_grabar
this.cb_cerrar=create cb_cerrar
this.st_3=create st_3
this.st_2=create st_2
this.st_1=create st_1
this.cb_2=create cb_2
this.em_monto=create em_monto
this.em_fecha=create em_fecha
this.em_cuotas=create em_cuotas
this.cbx_1=create cbx_1
this.cb_1=create cb_1
this.dw_cuotas=create dw_cuotas
this.dw_contrato=create dw_contrato
this.gb_1=create gb_1
this.gb_2=create gb_2
this.rr_1=create rr_1
this.Control[]={this.cb_6,&
this.cb_5,&
this.cb_4,&
this.cb_3,&
this.cb_grabar,&
this.cb_cerrar,&
this.st_3,&
this.st_2,&
this.st_1,&
this.cb_2,&
this.em_monto,&
this.em_fecha,&
this.em_cuotas,&
this.cbx_1,&
this.cb_1,&
this.dw_cuotas,&
this.dw_contrato,&
this.gb_1,&
this.gb_2,&
this.rr_1}
end on

on w_contrato.destroy
destroy(this.cb_6)
destroy(this.cb_5)
destroy(this.cb_4)
destroy(this.cb_3)
destroy(this.cb_grabar)
destroy(this.cb_cerrar)
destroy(this.st_3)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.cb_2)
destroy(this.em_monto)
destroy(this.em_fecha)
destroy(this.em_cuotas)
destroy(this.cbx_1)
destroy(this.cb_1)
destroy(this.dw_cuotas)
destroy(this.dw_contrato)
destroy(this.gb_1)
destroy(this.gb_2)
destroy(this.rr_1)
end on

event open;
dw_contrato.settransobject(sqlca)
dw_contrato.insertrow(0)
dw_cuotas.settransobject(sqlca)

wf_nuevo()
end event

type cb_6 from commandbutton within w_contrato
integer x = 946
integer y = 660
integer width = 110
integer height = 104
integer taborder = 50
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "..."
end type

event clicked;s_cliente lstr_cliente

open(w_abm_clientes)

lstr_cliente = message.powerobjectparm

if lstr_cliente.id = -1 then
else
	dw_contrato.object.id_garante[1] = lstr_cliente.id
end if
end event

type cb_5 from commandbutton within w_contrato
integer x = 946
integer y = 524
integer width = 110
integer height = 104
integer taborder = 40
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "..."
end type

event clicked;s_cliente lstr_cliente

open(w_abm_clientes)

lstr_cliente = message.powerobjectparm

if lstr_cliente.id = -1 then 
else
	dw_contrato.object.id_locatario[1] = lstr_cliente.id
end if
end event

type cb_4 from commandbutton within w_contrato
integer x = 151
integer y = 2424
integer width = 402
integer height = 112
integer taborder = 160
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "&Nuevo"
end type

event clicked;
wf_nuevo()
end event

type cb_3 from commandbutton within w_contrato
integer x = 686
integer y = 1568
integer width = 402
integer height = 112
integer taborder = 100
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "<< &Borrar"
end type

event clicked;int i, filas

filas = dw_cuotas.rowcount( )
for i = filas to 1 step -1
	if dw_cuotas.object.sn[i] = 'S' then 
		dw_cuotas.deleterow(0)
	end if
next

for i = 1 to dw_cuotas.rowcount( )
	dw_cuotas.object.id_cuota[i] = i
next
end event

type cb_grabar from commandbutton within w_contrato
integer x = 1536
integer y = 2424
integer width = 402
integer height = 112
integer taborder = 140
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "&Grabar"
end type

event clicked;int i
datetime ldt_fe_registro
long ll_num
string ls_Error

ldt_fe_registro = f_fecha_servidor()

ll_num = wf_signum() 

dw_contrato.object.fe_registro[1] = ldt_fe_registro
dw_contrato.object.id_contrato[1] = ll_num

if wf_alquilar_inmueble() = -1 then return 

for i = 1 to dw_cuotas.rowcount()
	dw_cuotas.object.id_letra[i] =  'CT'
	dw_cuotas.object.id_serie[i] =  1
	dw_cuotas.object.id_numero[i] =  ll_num
next

if dw_contrato.update() = -1 then
	ls_Error = sqlca.sqlerrtext
	rollback;
	MessageBox('Error DB', 'Error al intentar grabar el contrato.~n'+ls_Error)
	return 
end if 

if dw_cuotas.update() = -1 then
	ls_Error = sqlca.sqlerrtext
	rollback;
	MessageBox('Error DB', 'Error al intentar grabar las cuotas en ctacte.~n'+ls_Error)
	return 
end if 

commit;

wf_nuevo()
end event

type cb_cerrar from commandbutton within w_contrato
integer x = 2222
integer y = 2424
integer width = 402
integer height = 112
integer taborder = 150
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

type st_3 from statictext within w_contrato
integer x = 654
integer y = 1160
integer width = 197
integer height = 64
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "Monto:"
boolean focusrectangle = false
end type

type st_2 from statictext within w_contrato
integer x = 229
integer y = 1160
integer width = 288
integer height = 64
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "1er Venc.:"
boolean focusrectangle = false
end type

type st_1 from statictext within w_contrato
integer x = 32
integer y = 1160
integer width = 174
integer height = 64
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "Cant.:"
boolean focusrectangle = false
end type

type cb_2 from commandbutton within w_contrato
integer x = 686
integer y = 1396
integer width = 407
integer height = 112
integer taborder = 90
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "&Agregar >>"
end type

event clicked;int li_nu_cuota, li_ca_cuotas, li_row, i
date ld_primer_fecha, ld_fecha
dec ldec_monto
long ll_clie

//if datetime(em_fecha.text) > gdt_fe_sistema then return
if em_fecha.text = '00/00/0000' then return

li_ca_cuotas = integer(em_cuotas.text)
ld_primer_fecha = date(em_fecha.text)
ldec_monto = dec(mid(em_monto.text,2))

if ldec_monto = 0 then 
	MessageBox('Carga de cuotas', 'Debe ingresar un monto de cuota mayor a 0')
	return
end if

ll_clie = dw_contrato.object.id_locatario[1]

for i = 1 to li_ca_cuotas
	li_row = dw_cuotas.insertrow(0)

	ld_fecha = wf_agregar_meses(ld_primer_fecha, i -1) 
	if wf_control_vencimiento(ld_fecha) = -1 then return
	
	dw_cuotas.object.id_cuota[li_row] = li_row
	dw_cuotas.object.fe_vencimiento[li_row] = ld_fecha
	dw_cuotas.object.pr_cuota[li_row] = ldec_monto
	dw_cuotas.object.pr_saldo[li_row] = ldec_monto
	dw_cuotas.object.id_Cliente[li_row] = ll_clie
	
next

ld_fecha = date(dw_cuotas.object.fe_vencimiento[dw_cuotas.rowcount()])
ld_fecha = wf_agregar_meses(ld_fecha, 1)

em_fecha.text = string(ld_fecha, 'dd/mm/yyyy')
end event

type em_monto from editmask within w_contrato
integer x = 699
integer y = 1232
integer width = 398
integer height = 108
integer taborder = 80
integer textsize = -11
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
string text = "$ 0"
alignment alignment = right!
borderstyle borderstyle = stylelowered!
string mask = "[currency]"
boolean autoskip = true
end type

event getfocus;this.selecttext( 1, len(this.text))
end event

type em_fecha from editmask within w_contrato
integer x = 229
integer y = 1232
integer width = 457
integer height = 108
integer taborder = 70
integer textsize = -11
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
string text = "none"
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = datemask!
string mask = "dd/mm/yyyy"
boolean dropdowncalendar = true
end type

type em_cuotas from editmask within w_contrato
integer x = 41
integer y = 1232
integer width = 174
integer height = 108
integer taborder = 60
integer textsize = -11
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
string text = "1"
alignment alignment = center!
borderstyle borderstyle = stylelowered!
string mask = "#####"
end type

type cbx_1 from checkbox within w_contrato
integer x = 1202
integer y = 1252
integer width = 82
integer height = 80
integer taborder = 110
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
end type

event clicked;string ls
int i

ls = 'N'
if checked then ls = 'S'

for i = 1 to dw_cuotas.Rowcount()
	dw_cuotas.object.sn[i] = ls
next


end event

type cb_1 from commandbutton within w_contrato
integer x = 951
integer y = 256
integer width = 110
integer height = 104
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "..."
end type

event clicked;long ll_inmueble, ll_cliente
s_abm lstr_abm

open(w_abm_inmuebles)

lstr_abm = message.powerobjectparm

ll_inmueble = lstr_abm.id

wf_buscar_inmueble(ll_inmueble)

end event

type dw_cuotas from datawindow within w_contrato
integer x = 1189
integer y = 1232
integer width = 1518
integer height = 1088
integer taborder = 120
string dataobject = "d_cuotas"
boolean vscrollbar = true
boolean border = false
boolean livescroll = true
end type

event itemchanged;date ldt

if dwo.name = 'fe_vencimiento' then
	if wf_control_vencimiento(date(data)) = -1 then
		setnull(ldt)
		dw_cuotas.object.fe_vencimiento[row] = ldt
	end if
end if
end event

type dw_contrato from datawindow within w_contrato
integer x = 169
integer y = 32
integer width = 2395
integer height = 1056
integer taborder = 10
string title = "none"
string dataobject = "d_contrato"
boolean border = false
end type

event itemchanged;

choose case dwo.name
	case 'id_inmueble'
		wf_buscar_inmueble(long(data))
end choose

end event

type gb_1 from groupbox within w_contrato
integer x = 1115
integer y = 1164
integer width = 1646
integer height = 1208
integer taborder = 130
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "Cuotas"
end type

type gb_2 from groupbox within w_contrato
integer x = 37
integer width = 2734
integer height = 1124
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "Datos"
end type

type rr_1 from roundrectangle within w_contrato
long linecolor = 12632256
integer linethickness = 4
long fillcolor = 67108864
integer x = 37
integer y = 2396
integer width = 2715
integer height = 168
integer cornerheight = 40
integer cornerwidth = 46
end type

