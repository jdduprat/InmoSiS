HA$PBExportHeader$w_cobro.srw
forward
global type w_cobro from w_response
end type
type cb_1 from commandbutton within w_cobro
end type
type dw_1 from datawindow within w_cobro
end type
type rr_1 from roundrectangle within w_cobro
end type
end forward

global type w_cobro from w_response
integer width = 1550
integer height = 1076
string title = "Forma de Pago"
boolean center = true
cb_1 cb_1
dw_1 dw_1
rr_1 rr_1
end type
global w_cobro w_cobro

forward prototypes
public function integer wf_signum ()
end prototypes

public function integer wf_signum ();long ll_mov

SELECT MAX(id_movimiento) +1
INTO :ll_mov
FROM caja_movimientos;
if sqlca.sqlcode = -1 then 
	rollback;
	MessageBox('Error DB','Ha ocurrido un error al consultar en la base de datos. '+sqlca.sqlerrtext)
	return -1
end if

if isnull(ll_mov) then ll_mov = 1

return ll_mov
end function

on w_cobro.create
int iCurrent
call super::create
this.cb_1=create cb_1
this.dw_1=create dw_1
this.rr_1=create rr_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_1
this.Control[iCurrent+2]=this.dw_1
this.Control[iCurrent+3]=this.rr_1
end on

on w_cobro.destroy
call super::destroy
destroy(this.cb_1)
destroy(this.dw_1)
destroy(this.rr_1)
end on

event open;call super::open;
s_movimiento lstr_mov

lstr_mov = message.powerobjectparm

dw_1.settransobject(sqlca)
dw_1.insertrow(0)

dw_1.object.id_letra[1] = lstr_mov.letra
dw_1.object.id_serie[1] = lstr_mov.serie
dw_1.object.id_recibo[1] = lstr_mov.numero
dw_1.object.fe_movimiento[1] = gdt_fe_sistema
dw_1.object.ti_aplica_caja[1] = lstr_mov.ti_aplica_caja
dw_1.object.pr_Total[1] =  lstr_mov.total

dw_1.object.id_valor[1] = 1

dw_1.accepttext( )
end event

type cb_1 from commandbutton within w_cobro
integer x = 928
integer y = 828
integer width = 402
integer height = 112
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "&Aceptar"
boolean default = true
end type

event clicked;long ll_num
string ls_error

if dw_1.object.pr_total[1] = 0 then 
	MessageBox('Error', 'No se puede grabar un recibo igual a 0')
	return 
end if

ll_num = wf_signum()
if ll_num = -1 then return 

dw_1.object.id_movimiento[1] = ll_num
dw_1.object.fe_registro[1] = f_fecha_Servidor()

if dw_1.update( ) = -1 then
	ls_error = sqlca.sqlerrtext
	rollback;
	MessageBox('Cobro', 'Error al intentar grabar los datos. Intente Nuevamente~n'+ls_error)
	ll_num = -1
end if

closewithreturn(parent, string(ll_num))
end event

type dw_1 from datawindow within w_cobro
integer x = 41
integer y = 36
integer width = 1454
integer height = 740
integer taborder = 10
string title = "none"
string dataobject = "d_cobro"
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

type rr_1 from roundrectangle within w_cobro
long linecolor = 8421504
integer linethickness = 4
long fillcolor = 67108864
integer x = 41
integer y = 804
integer width = 1454
integer height = 168
integer cornerheight = 40
integer cornerwidth = 46
end type

