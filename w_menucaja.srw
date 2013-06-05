HA$PBExportHeader$w_menucaja.srw
forward
global type w_menucaja from window
end type
type mdi_1 from mdiclient within w_menucaja
end type
type p_1 from picture within w_menucaja
end type
end forward

global type w_menucaja from window
integer width = 3909
integer height = 2628
boolean titlebar = true
string menuname = "m_menucaja"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
windowtype windowtype = mdi!
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
mdi_1 mdi_1
p_1 p_1
end type
global w_menucaja w_menucaja

on w_menucaja.create
if this.MenuName = "m_menucaja" then this.MenuID = create m_menucaja
this.mdi_1=create mdi_1
this.p_1=create p_1
this.Control[]={this.mdi_1,&
this.p_1}
end on

on w_menucaja.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.mdi_1)
destroy(this.p_1)
end on

event resize;
p_1.height = height - 300
p_1.width = width - 150
end event

event open;string ls_empresa

select de_empresa
into :ls_empresa
from empresas
where sn_activa = 'S';

title = ls_empresa
end event

type mdi_1 from mdiclient within w_menucaja
long BackColor=268435456
end type

type p_1 from picture within w_menucaja
integer x = 41
integer y = 36
integer width = 2697
integer height = 1280
string picturename = "fondo.jpg"
boolean focusrectangle = false
end type

