HA$PBExportHeader$w_recibo.srw
forward
global type w_recibo from window
end type
type cb_5 from commandbutton within w_recibo
end type
type cb_4 from commandbutton within w_recibo
end type
type cb_3 from commandbutton within w_recibo
end type
type cb_2 from commandbutton within w_recibo
end type
type cbx_1 from checkbox within w_recibo
end type
type pb_1 from picturebutton within w_recibo
end type
type cb_1 from commandbutton within w_recibo
end type
type dw_detalle from u_dw within w_recibo
end type
type dw_cabeza from u_dw within w_recibo
end type
type rr_1 from roundrectangle within w_recibo
end type
end forward

global type w_recibo from window
integer width = 2405
integer height = 1872
boolean titlebar = true
string title = "Recibos"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
cb_5 cb_5
cb_4 cb_4
cb_3 cb_3
cb_2 cb_2
cbx_1 cbx_1
pb_1 pb_1
cb_1 cb_1
dw_detalle dw_detalle
dw_cabeza dw_cabeza
rr_1 rr_1
end type
global w_recibo w_recibo

forward prototypes
public function long wf_signum ()
public function integer wf_nuevo ()
public function string wf_cargar_deuda ()
public function integer wf_cobro ()
public function integer wf_actualizar_ctacte (integer fila)
end prototypes

public function long wf_signum ();long ll_num

SELECT max(id_recibo) +1 
INTO :ll_num
FROM recibos;
if sqlca.sqlcode = -1 then
	MessageBox('Error DB','Error al intentar obtener el n$$HEX1$$fa00$$ENDHEX$$mero de contrato')
	return -1
end if

if isnull(ll_num) then ll_num = 1

return ll_num
end function

public function integer wf_nuevo ();long ll_num

dw_cabeza.reset()
dw_cabeza.insertrow(0)

ll_num = wf_signum()
if ll_num = -1 then return -1

dw_cabeza.object.id_recibo[1] = ll_num
dw_cabeza.object.fe_recibo[1] = gdt_fe_sistema

dw_detalle.reset()

pb_1.enabled = true

return 1
end function

public function string wf_cargar_deuda ();long ll_serie,ll_num,ll_cuota, ll_contrato, ll_clie, li_row
dec ldec_cuota,	ldec_pagado, ldec_saldo
datetime ldt_venc
string ls_letra

ll_clie = dw_cabeza.object.id_cliente[1]

DECLARE cursor_deuda CURSOR FOR 
	SELECT cuenta_corriente.id_letra,   
         cuenta_corriente.id_serie,   
         cuenta_corriente.id_numero,   
         cuenta_corriente.id_cuota,   
         cuenta_corriente.id_contrato,   
         cuenta_corriente.pr_cuota,   
         cuenta_corriente.pr_pagado,   
         cuenta_corriente.pr_saldo,   
         cuenta_corriente.fe_vencimiento  
    FROM cuenta_corriente 
	WHERE id_cliente = :ll_clie AND
			 pr_saldo > 0;
if sqlca.sqlcode = -1 then return sqlca.sqlerrtext

OPEN cursor_deuda;
if sqlca.sqlcode = -1 then return sqlca.sqlerrtext

FETCH cursor_deuda INTO :ls_letra,	:ll_serie,	:ll_num,	:ll_cuota,  :ll_contrato,	
								:ldec_cuota,	:ldec_pagado, :ldec_saldo, :ldt_venc;
if sqlca.sqlcode = -1 then return sqlca.sqlerrtext

do while sqlca.sqlcode = 0
	
	li_row = dw_detalle.insertrow(0)
	
	 dw_detalle.object.id_letra[li_row] = ls_letra
	 dw_detalle.object.id_serie[li_row] =    ll_serie
	 dw_detalle.object.id_numero[li_row] =    ll_num
	 dw_detalle.object.id_cuota[li_row] =  ll_cuota
//	 dw_detalle.object.id_contrato[li_row] = ll_contrato
	 dw_detalle.object.pr_cuota[li_row] = ldec_cuota
	 dw_detalle.object.pr_pagado[li_row] = ldec_pagado
	 dw_detalle.object.pr_saldo[li_row] = ldec_saldo
	// dw_detalle.object.fe_vencimiento[li_row] = ldt_venc
	
	FETCH cursor_deuda INTO :ls_letra,	:ll_serie,	:ll_num,	:ll_cuota,  :ll_contrato,	
								:ldec_cuota,	:ldec_pagado, :ldec_saldo, :ldt_venc;
		if sqlca.sqlcode = -1 then return sqlca.sqlerrtext
loop

CLOSE cursor_deuda;
if sqlca.sqlcode = -1 then return sqlca.sqlerrtext

return ''
end function

public function integer wf_cobro ();s_movimiento lstr_mov
string ls_Respuesta

lstr_mov.letra = dw_cabeza.object.id_letra[1]
lstr_mov.serie = dw_cabeza.object.id_serie[1]
lstr_mov.numero = dw_cabeza.object.id_recibo[1]
lstr_mov.ti_aplica_caja = 1
lstr_mov.total = dw_cabeza.object.pr_Total[1]

openwithparm(w_cobro, lstr_mov)

ls_respuesta = message.stringparm

if ls_Respuesta = '-1' OR ls_Respuesta = '' then return -1

return 1
end function

public function integer wf_actualizar_ctacte (integer fila);long ll_serie, ll_num, ll_cuota
string ls_letra
dec ldec_pago

ls_letra = dw_detalle.object.id_letra[fila] 
ll_serie = dw_detalle.object.id_serie[fila] 
ll_num = dw_detalle.object.id_numero[fila] 
ll_cuota = dw_detalle.object.id_cuota[fila] 
ldec_pago = dw_detalle.object.pr_pago[fila] 
	 
UPDATE cuenta_corriente
SET pr_pagado = pr_pagado + :ldec_pago,
		pr_saldo = pr_saldo - :ldec_pago
WHERE id_letra = :ls_letra AND 
		id_serie = :ll_serie AND
		id_numero = :ll_num AND
		id_cuota = :ll_cuota ;
if sqlca.sqlcode = -1 then
	rollback;
	MessageBox('Recibos', 'Error al tratar de actualizar ala ctacte~n'+sqlca.sqlerrtext)
	return -1
end if

return 1 
end function

on w_recibo.create
this.cb_5=create cb_5
this.cb_4=create cb_4
this.cb_3=create cb_3
this.cb_2=create cb_2
this.cbx_1=create cbx_1
this.pb_1=create pb_1
this.cb_1=create cb_1
this.dw_detalle=create dw_detalle
this.dw_cabeza=create dw_cabeza
this.rr_1=create rr_1
this.Control[]={this.cb_5,&
this.cb_4,&
this.cb_3,&
this.cb_2,&
this.cbx_1,&
this.pb_1,&
this.cb_1,&
this.dw_detalle,&
this.dw_cabeza,&
this.rr_1}
end on

on w_recibo.destroy
destroy(this.cb_5)
destroy(this.cb_4)
destroy(this.cb_3)
destroy(this.cb_2)
destroy(this.cbx_1)
destroy(this.pb_1)
destroy(this.cb_1)
destroy(this.dw_detalle)
destroy(this.dw_cabeza)
destroy(this.rr_1)
end on

event open;
dw_cabeza.settransobject(sqlca)
dw_cabeza.insertrow(0)
dw_detalle.settransobject(sqlca)

wf_nuevo()
end event

type cb_5 from commandbutton within w_recibo
integer x = 704
integer y = 1632
integer width = 434
integer height = 112
integer taborder = 70
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Borrar No Sel"
end type

event clicked;int i 

dw_detalle.accepttext( )

for i = dw_detalle.rowcount( ) to 1 step -1
	if dw_detalle.object.sn[i] = 'N' then dw_detalle.deleterow(i)
next

if dw_detalle.rowcount( ) = 0 then pb_1.enabled = true
end event

type cb_4 from commandbutton within w_recibo
integer x = 165
integer y = 1632
integer width = 402
integer height = 112
integer taborder = 60
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

type cb_3 from commandbutton within w_recibo
integer x = 1266
integer y = 1632
integer width = 402
integer height = 112
integer taborder = 50
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

dw_cabeza.accepttext( )
dw_detalle.accepttext( )

if dw_detalle.object.ctotal[dw_detalle.rowcount( )] = 0 then 
	MessageBox('Error', 'No se puede grabar un recibo igual a 0')
	return 
end if

ldt_fe_registro = f_fecha_servidor()

ll_num = wf_signum() 
if ll_num = -1 then return 

dw_cabeza.object.fe_registro[1] = ldt_fe_registro
dw_cabeza.object.id_Recibo[1] = ll_num
dw_cabeza.object.pr_total[1] = dw_detalle.object.ctotal[dw_detalle.rowcount( )]

// Borro las filas que no est$$HEX1$$e100$$ENDHEX$$n seleccionadas
for i = dw_detalle.rowcount( ) to 1 step -1
	if dw_detalle.object.sn[i] = 'N' then dw_detalle.deleterow(i)
next
// Asigno el numero de reciubos al detalle
for i = 1 to dw_detalle.rowcount()
	dw_detalle.object.id_recibo[i] =  ll_num
	if wf_actualizar_ctacte(i) = -1 then return
next

if dw_cabeza.update() = -1 then
	ls_Error = sqlca.sqlerrtext
	rollback;
	MessageBox('Error DB', 'Error al intentar grabar el recibo.~n'+ls_Error)
	return 
end if 

if dw_detalle.update() = -1 then
	ls_Error = sqlca.sqlerrtext
	rollback;
	MessageBox('Error DB', 'Error al intentar grabar el detalle del recibo.~n'+ls_Error)
	return 
end if 

if wf_cobro() = -1 then 
	rollback;
	return
end if

commit;

wf_nuevo()


end event

type cb_2 from commandbutton within w_recibo
integer x = 1829
integer y = 1632
integer width = 402
integer height = 112
integer taborder = 80
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

type cbx_1 from checkbox within w_recibo
integer x = 55
integer y = 484
integer width = 78
integer height = 80
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
boolean lefttext = true
end type

event clicked;int i
string ls

ls = 'N'
if checked then ls = 'S'

for i = 1 to dw_detalle.rowcount()
	
	dw_detalle.object.sn[i] = ls
	dw_detalle.object.pr_pago[i] = dw_detalle.object.pr_saldo[i]
	
next
end event

type pb_1 from picturebutton within w_recibo
integer x = 2103
integer y = 200
integer width = 114
integer height = 104
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string picturename = "EditDataFreeform!"
alignment htextalign = left!
string powertiptext = "Traer Deuda"
end type

event clicked;
wf_cargar_deuda()

this.enabled = false

dw_detalle.setrow(1)
end event

type cb_1 from commandbutton within w_recibo
integer x = 736
integer y = 204
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

if not isvalid(lstr_cliente) then return
if lstr_cliente.id = -1 then setnull(lstr_cliente.id)

dw_cabeza.object.id_cliente[1] = lstr_cliente.id
end event

type dw_detalle from u_dw within w_recibo
integer x = 37
integer y = 468
integer width = 2313
integer height = 1108
integer taborder = 10
string dataobject = "d_recibo_detalle"
end type

event itemchanged;call super::itemchanged;dec ldec_saldo

choose case dwo.name
		
	case 'sn'
		this.object.pr_pago[row] = this.object.pr_saldo[row]
		
	case 'pr_pago'
		ldec_saldo = this.object.pr_saldo[row]
		if dec(data) > ldec_saldo then
			MessageBox('Recibos', 'El pago ingresado supera al saldo de la cuota')
			setitem(row, 'pr_pago', ldec_saldo)
			return 1
		end if
		
end choose

end event

type dw_cabeza from u_dw within w_recibo
integer x = 41
integer y = 24
integer width = 2309
integer height = 428
integer taborder = 20
string dataobject = "d_recibo_cabeza"
boolean vscrollbar = false
borderstyle borderstyle = styleraised!
end type

type rr_1 from roundrectangle within w_recibo
long linecolor = 12632256
integer linethickness = 4
long fillcolor = 67108864
integer x = 41
integer y = 1604
integer width = 2309
integer height = 168
integer cornerheight = 40
integer cornerwidth = 46
end type

