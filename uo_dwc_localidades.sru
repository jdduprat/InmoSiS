HA$PBExportHeader$uo_dwc_localidades.sru
forward
global type uo_dwc_localidades from nonvisualobject
end type
end forward

global type uo_dwc_localidades from nonvisualobject
end type
global uo_dwc_localidades uo_dwc_localidades

type variables
private:

datawindow idw_data
datawindowchild idwc_loc, idwc_dep, idwc_prov
end variables

forward prototypes
public subroutine of_set_dw (datawindow adw)
public function integer of_cargar_localidad_empresa ()
public subroutine of_set_localidad (long al_loc)
public subroutine of_set_departamento (long al_dep)
public subroutine of_set_provincia (long al_prov)
public subroutine of_init ()
end prototypes

public subroutine of_set_dw (datawindow adw);idw_data = adw
end subroutine

public function integer of_cargar_localidad_empresa ();long ll_localidad, ll_departamento, ll_provincia

SELECT id_localidad, departamento_id, provincia_id
INTO :ll_localidad, :ll_departamento, :ll_provincia
FROM empresas, localidades, departamentos
WHERE sn_activa = 'S' AND
			empresas.id_localidad = localidades.id AND
			localidades.departamento_id = departamentos.id; 
if sqlca.sqlcode = -1 then
	MessageBox('Error DB','Error al intentar de base de datos~n'+sqlca.sqlerrtext)
	return -1
end if

this.of_set_provincia( ll_provincia )
this.of_set_departamento( ll_departamento )
this.of_set_localidad( ll_localidad )

end function

public subroutine of_set_localidad (long al_loc);
if isnull(al_loc) or al_loc = 0 then
	idwc_loc.insertrow(0)
else
	idw_data.object.id_localidad[idw_data.getrow()] = al_loc
end if
end subroutine

public subroutine of_set_departamento (long al_dep);
if isnull(al_dep) or al_dep = 0 then
	idwc_dep.insertrow(0)
else
	idw_data.object.id_departamento[idw_data.getrow()] = al_dep
	idwc_loc.retrieve(al_dep)
end if
end subroutine

public subroutine of_set_provincia (long al_prov);
if isnull(al_prov) or al_prov = 0 then
	idwc_prov.retrieve()
	idwc_dep.reset( )
	idwc_loc.reset( )
else
	idw_data.object.id_provincia[idw_data.getrow()] = al_prov
	idwc_dep.retrieve(al_prov)
end if
end subroutine

public subroutine of_init ();
idw_data.getchild( 'id_localidad', idwc_loc)
idw_data.getchild( 'id_departamento', idwc_dep)
idw_data.getchild( 'id_provincia', idwc_prov)

idwc_loc.settransobject(SQLCA)
idwc_dep.settransobject(SQLCA)
idwc_prov.settransobject(SQLCA)
end subroutine

on uo_dwc_localidades.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_dwc_localidades.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

