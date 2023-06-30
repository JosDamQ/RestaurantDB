Drop database  if exists DBTonysKinal2018163;
Create database DBTonysKinal2018163;

Use DBTonysKinal2018163;

/*Josue Damian Garcia Quiñonez 
2018163
IN5AM
CREACION: 7/02/2022
ULTIMA MODIFICACION: 16/02/2022
TALLER*/


Create table Empresas(
	codigoEmpresa INT NOT NULL Auto_increment,
    nombreEmpresa varchar(150) not null,
    direccion varchar(150) not null,
    telefono varchar(10) not null,
    primary key PK_codigoEmpresa(codigoEmpresa)
);

Create table Productos(
	codigoProducto Int auto_increment not null,
    nombreProducto varchar(150) not null,
    cantidad int not null,
    primary key PK_codigoProducto(codigoProducto)
);

Create table TipoPlato(
	codigoTipoPlato int auto_increment not null,
    descripcionTipo varchar(100),
    primary key PK_codigoTipoPlato(codigoTipoPlato)
);

Create table TipoEmpleado(
	codigoTipoEmpleado int auto_increment not null,
    descripcion varchar(100),
    primary key PK_codigoTipoEmpleado(codigoTipoEmpleado)
);

Create table Presupuesto(
	codigoPresupuesto int auto_increment not null,
    fechaSolicitud date not null,
    cantidadPresupuesto decimal(10,2) not null,
    codigoEmpresa int not null,
    primary key PK_codigoPresupuesto(codigoPresupuesto),
    constraint FK_Presupuesto_Empresas foreign key (codigoEmpresa)
		references Empresas(codigoEmpresa)
);

Create table Servicios(
	codigoServicio int auto_increment not null,
    fechaServivio date not null,
    tipoServicio varchar(100) not null,
    horaServicio time not null,
    lugarServicio varchar(100) not null,
    telefonoContacto varchar(10) not null,
    codigoEmpresa int not null,
    primary key PK_codigoServicio(codigoServicio),
    constraint FK_Sercvicios_Empresas foreign key (codigoEmpresa)
		references Empresas(codigoEmpresa)
);

Create table Empleados(
	codigoEmpleado int auto_increment not null,
    numeroEmpleado int not null,
    apellidosEmpleado varchar(150) not null,
    nombresEmpleado varchar(150) not null,
    direccionEmpleaso varchar(150) not null,
    telefonoContacto varchar(10) not null,
    gradoCocinero varchar(50),
    codigoTipoEmpleado int not null,
    primary key PK_codigoEmpleado(codigoEmpleado),
    constraint FK_Empleados_TipoEmpleado foreign key(codigoTipoEmpleado)
		references TipoEmpleado(codigoTipoEmpleado)
);

Create table Platos(
	codigoPlato int auto_increment not null,
	cantidad int not null,
    nombrePlato varchar(50) not null,
	descripcionPlato varchar(150) not null,
    precioPlato decimal(10,2) not null,
    codigoTipoPlato int not null,
    primary key PK_codigoPlato(codigoPlato),
    constraint FK_Platos_TipoPlato foreign key(codigoTipoPlato)
		references TipoPlato(codigoTipoPlato)
);

Create table Servicios_Has_Platos(
	codigoServiciosHasPlatos int auto_increment not null,
    serviciosCodigoServicio int not null,
    platosCodigoPlato int not null,
    primary key PK_codigoServiciosHasPlatos(codigoServiciosHasPlatos),
    constraint FK_Servicios_Has_Platos_Servicios foreign key(serviciosCodigoServicio)
		references Servicios(codigoServicio),
	constraint FK_Servicios_Has_Platos_Platos foreign key(platosCodigoPlato)
		references Platos(codigoPlato)
);

Create table Productos_Has_Platos(
	codigoProductosHasPlatos int auto_increment not null,
    productosCodigoProducto int not null,
    platosCodigoPlato int not null,
    primary key PK_codigoProductosHasPlatos(codigoProductosHasPlatos),
    constraint FK_Productos_Has_Platos_Productos foreign key(productosCodigoProducto)
		references Productos(codigoProducto),
	constraint FK_Productos_Has_Platos_Platos foreign key(platosCodigoPlato)
		references Platos(codigoPlato)
);

Create table Servicios_Has_Empleados(
	codigoServiciosHasEmpleados int auto_increment not null,
    serviciosCodigoservicio int not null,
    empleadosCodigoEmpleado int not null,
    fechaEvento date not null,
    horaEvento time not null,
    lugarEvento varchar(150) not null,
    primary key PK_codigoServiciosHasEmpleados(codigoServiciosHasEmpleados),
    constraint FK_Servicios_Has_Empleados_Servicios foreign key(serviciosCodigoservicio)
		references Servicios(codigoServicio),
	constraint FK_Servicios_Has_Empleados_Empleados foreign key(empleadosCodigoEmpleado)
		references Empleados(codigoEmpleado)
);

-- Procedimientos Almacenados--------------------------------------------------------------
-- Entidad Empresas------------------------------------------------------------------------
-- Agregar---------------------------------------------------------------------------------
/*''*/
Delimiter //
create procedure sp_AgregarEmpresa(in nombreEmpresa varchar(150), in direccion varchar(150), in telefono varchar(10))
	Begin
		insert into Empresas(nombreEmpresa, direccion, telefono)
        values(nombreEmpresa, direccion, telefono);
    End // 
Delimiter ;
Call sp_agregarEmpresa('Burger King','zona 9', '34661234');
Call sp_agregarEmpresa('Wendy´s','zona 11', '33321234');
-- Mostar------------------------------------------------------------------------------------
Delimiter //
create procedure sp_MostrarEmpresas()
	Begin 
		Select E.codigoEmpresa,
               E.nombreEmpresa,
               E.direccion,
               E.telefono 
               from Empresas as E;
    End //
Delimiter ;
Call sp_mostrarEmpresas;
-- Buscar----------------------------------------------------------------------------------
Delimiter //
create procedure sp_BuscarEmpresa(in codEmpresa int)
	Begin
		Select E.codigoEmpresa,
               E.nombreEmpresa,
               E.direccion,
               E.telefono 
               from Empresas as E where codigoEmpresa = codEmpresa;
    End //
Delimiter ;
Call sp_BuscarEmpresa(1);
-- Eliminar------------------------------------------------------------------------------------
Delimiter //
create procedure sp_EliminarEmpresa(in codEmpresa int)
	Begin
		Delete from Empresas 
			where codigoEmpresa = codEmpresa;
    End //
Delimiter ;
Call sp_EliminarEmpresa(2);
-- Actualizar---------------------------------------------------------------------------------
Delimiter //
create procedure sp_EditarEmpresa(in codEmpresa int, in nomEmpresa varchar(150), in direcc varchar(150), in tel varchar(10))
	Begin
		Update Empresas as E
			set E.nombreEmpresa = nomEmpresa,
				E.direccion = direcc,
                E.telefono = tel
		    where codigoEmpresa = codEmpresa;
    End //
Delimiter ;
Call sp_EditarEmpresa(1,'Carls JR','Zona 21','12345678');
-- Entidad Productos-------------------------------------------------------------------
-- Agregar----------------------------------------------------------------------------
Delimiter //
create procedure sp_AgregarProducto(in nomProducto varchar(150), in cant int)
	Begin
		Insert into Productos(nombreProducto, cantidad)
        values(nomProducto, cant);
    End //
Delimiter ;
Call sp_AgregarProducto('Hamburguesa',23);
Call sp_AgregarProducto('Papas fritas',45);
-- Mostar---------------------------------------------------------------------------------
Delimiter //
create procedure sp_MostrarProductos()
	Begin
		Select P.codigoProducto,
               P.nombreProducto,
               P.cantidad
		from Productos as P;
    End //
Delimiter ;
Call sp_MostrarProductos();
-- Buscar-----------------------------------------------------------------------------------
Delimiter //
create procedure sp_BuscarProducto(in codProducto int)
	Begin
		Select P.codigoProducto,
               P.nombreProducto,
               P.cantidad
		from Productos as P where codigoProducto = codProducto;
    End //
Delimiter ;
Call sp_BuscarProducto(1);
-- Eliminar---------------------------------------------------------------------------------
Delimiter //
create procedure sp_EliminarProducto(in codProducto int)
	Begin
		delete 
        from Productos where codigoProducto = codProducto;
    End //
Delimiter ;
Call sp_EliminarProducto(2);
-- Actualizar---------------------------------------------------------------------------
Delimiter //
create procedure sp_ActualizarProducto(in codProducto int, nomProducto varchar(150), in cant int)
	Begin
		Update Productos as P
        set P.nombreProducto = nomProducto,
            P.cantidad = cant
        where codigoProducto = codProducto;    
    End //
Delimiter ;
Call sp_ActualizarProducto(1,'Pizza de queso',65);
-- Entidad Tipo Plato-----------------------------------------------------------
-- Agregar---------------------------------------------------------------------
Delimiter //
Create procedure sp_AgregarTipoPlato(in descripTipoPlato varchar(100))
	Begin
		Insert into TipoPlato(descripcionTipo)
        values(descripTipoPlato);
    End //
Delimiter ;
Call sp_AgregarTipoPlato('Entrada');
Call sp_AgregarTipoPlato('Postre');
-- Mostrar---------------------------------------------------------------------------
Delimiter //
Create procedure sp_MostrarTipoPlato()
	Begin
		Select TP.codigoTipoPlato,
               TP.descripcionTipo
        from TipoPlato as TP;       
    End //
Delimiter ;
Call sp_MostrarTipoPlato();
-- Buscar---------------------------------------------------------------------------
Delimiter //
Create procedure sp_BuscarTipoPlato(in codTipoPlato int)
	Begin
		Select TP.codigoTipoPlato,
               TP.descripcionTipo
        from TipoPlato as TP where TP.codigoTipoPlato = codTipoPlato;       
    End //
Delimiter ;
Call sp_BuscarTipoPlato(1);
-- Eliminar----------------------------------------------------------------------
Delimiter //
Create procedure sp_EliminarTipoPlato(in codTipoPlato int)
	Begin
		delete 
        from TipoPlato as TP where TP.codigoTipoPlato = codTipoPlato;
    End //
Delimiter ;
Call sp_EliminarTipoPlato(2);
-- Editar-----------------------------------------------------------------------------
Delimiter //
Create procedure sp_EditarTipoPlato(in codTipoPlato int, in descripTipoPlato varchar(100))
	Begin
		Update TipoPlato as TP
			set TP.descripcionTipo = descripTipoPlato
        where TP.codigoTipoPlato = codTipoPlato;    
    End //
Delimiter ;
Call sp_EditarTipoPlato(1,'Bebida');
-- Entidad TipoEmpleado--------------------------------------------------------------------------
-- Agregar--------------------------------------------------------------------------------------
Delimiter //
Create procedure sp_AgregarTipoEmpleado(in descrip varchar(100))
	Begin
		Insert into TipoEmpleado(descripcion)
        values(descrip);
    End //
Delimiter ;
Call sp_AgregarTipoEmpleado('Repartidor');
Call sp_AgregarTipoEmpleado('Mesero');
-- Mostrar---------------------------------------------------------------------------------------
Delimiter //
Create procedure sp_MostrarTipoEmpleado()
	Begin
		Select TE.codigoTipoEmpleado,
               TE.descripcion
        from TipoEmpleado as TE;       
    End //
Delimiter ;
Call sp_MostrarTipoEmpleado();
-- Buscar----------------------------------------------------------------------------------------
Delimiter //
Create procedure sp_BuscarTipoEmpleado(in codTipoEmpleado int)
	Begin
		Select TE.codigoTipoEmpleado,
			   TE.descripcion
        from TipoEmpleado as TE where TE.codigoTipoEmpleado = codTipoEmpleado;       
    End //
Delimiter ;
Call sp_BuscarTipoEmpleado(1);
-- Eliminar-------------------------------------------------------------------------------------------
Delimiter //
Create procedure sp_EliminarTipoEmpleado(in codTipoEmpleado int)
	Begin
		delete 
        From TipoEmpleado as TE where TE.codigoTipoEmpleado = codTipoEmpleado;
    End //
Delimiter ;
Call sp_EliminarTipoEmpleado(2);
-- Editar-------------------------------------------------------------------------------------------
Delimiter //
Create procedure sp_EditarTipoEmpleado(in codTipoEmpleado int, in descrip varchar(100))
	Begin
		Update TipoEmpleado as TE
			set TE.descripcion = descrip
        where TE.codigoTipoEmpleado = codTipoEmpleado;    
    End //
Delimiter ;
Call sp_EditarTipoEmpleado(1,'Cocinero');
-- Entidad Presupuesto---------------------------------------------------------------------------------
-- Agregar--------------------------------------------------------------------------------------------
Delimiter //
Create procedure sp_AgregarPresupuesto(in fechaSolicitud date, in cantidadPresupuesto decimal(10,2), in codigoEmpresa int)
	Begin
		Insert into Presupuesto(fechaSolicitud,cantidadPresupuesto,codigoEmpresa)
        values(fechaSolicitud,cantidadPresupuesto,codigoEmpresa);
    End //
Delimiter ;
Call sp_AgregarPresupuesto('2022-03-24',593.54,1);
Call sp_AgregarPresupuesto('2022-04-22',595.54,1);
-- Mostrar----------------------------------------------------------------------------------------------
Delimiter //
Create procedure sp_MostarPresupuesto()
	Begin
		Select P.codigoPresupuesto,
               P.fechaSolicitud,
               P.cantidadPresupuesto,
               P.codigoEmpresa
        from Presupuesto as P;       
    End //
Delimiter ;
Call sp_MostarPresupuesto();
-- Buscar--------------------------------------------------------------------------------------------------
Delimiter //
Create procedure sp_BuscarPresupuesto(in codPresupuesto int)
	Begin
		Select P.codigoPresupuesto,
               P.fechaSolicitud,
               P.cantidadPresupuesto,
               P.codigoEmpresa
         from Presupuesto as P where P.codigoPresupuesto = codPresupuesto;      
    End //
Delimiter ;
Call sp_BuscarPresupuesto(1);
-- Eliminar----------------------------------------------------------------------------------------------------
Delimiter // 
Create procedure sp_EliminarPresupuesto(in codPresupuesto int)
	Begin
		Delete 
        from Presupuesto as P where P.codigoPresupuesto = codPresupuesto;
    End //
Delimiter ;
Call sp_EliminarPresupuesto(2);
-- Editar-------------------------------------------------------------------------------
Delimiter //
Create procedure sp_EditarPresupuesto(in codPresupuesto int, in feSolicitud date, in cantiPresupuesto decimal(10,2),in codEmpresa int)
	Begin
		Update Presupuesto as P
			set P.fechaSolicitud = feSolicitud,
                P.cantidadPresupuesto = cantiPresupuesto,
                P.codigoEmpresa = codEmpresa
         where P.codigoPresupuesto = codPresupuesto;       
    End //
Delimiter ;
Call sp_EditarPresupuesto(1,'2020-1-1',300.12,1);
-- Entidad Servicios--------------------------------------------------------------------------------------------------
-- Agregar-------------------------------------------------------------------------------------------------------------
Delimiter //
Create procedure sp_AgregarServicio(in fechaServivio date,in tipoServicio varchar(100),in horaServicio time,
	in lugarServicio varchar(100), in telefonoContacto varchar(10), in codigoEmpresa int) 
		Begin
			Insert into Servicios(fechaServivio,tipoServicio,horaServicio,lugarServicio,telefonoContacto,codigoEmpresa)
            Values(fechaServivio,tipoServicio,horaServicio,lugarServicio,telefonoContacto,codigoEmpresa);
        End //
Delimiter ;
Call sp_AgregarServicio('2020-6-26','Entrega a domicilio','14:30','Tienda Zona 9', '23553366',1);
Call sp_AgregarServicio('2022-7-6','Recoger en tiendas','17:50','Tienda Zona 8', '23455686',1);
-- Mostrar----------------------------------------------------------------------------------------------------------------
Delimiter //
Create procedure sp_MostrarServicios()
	Begin
		Select S.codigoServicio,
               S.fechaServivio,
               S.tipoServicio,
               S.horaServicio,
               S.lugarServicio,
               S.telefonoContacto,
               S.codigoEmpresa
         from Servicios as S;      
    End //
Delimiter ;
Call sp_MostrarServicios();
-- Buscar-------------------------------------------------------------------------------------------------------------------
Delimiter //
Create procedure sp_BuscarServicio(in codServicio int)
	Begin
		Select S.codigoServicio,
               S.fechaServivio,
               S.tipoServicio,
               S.horaServicio,
               S.lugarServicio,
               S.telefonoContacto,
               S.codigoEmpresa
         from Servicios as S where S.codigoServicio = codServicio;      
    End //
Delimiter ;
Call sp_BuscarServicio(1);
-- Eliminar----------------------------------------------------------------------------------------------------------------------
Delimiter //
Create procedure sp_EliminarServicio(in codServicio int)
	Begin
		Delete 
        from Servicios as S where S.codigoServicio = codServicio;
    End //
Delimiter ;
Call sp_EliminarServicio(2);
-- Actualizar--------------------------------------------------------------------------------------------
Delimiter //
Create procedure sp_EditarServicio(in codServicio int, in feServivio date, in tiServicio varchar(100), in hoServicio time,
	in luServicio varchar(100), in telefono varchar(10), in codEmpresa int)
		Begin
			Update Servicios as S
				set S.fechaServivio = feServivio,
					S.tipoServicio = tiServicio,
                    S.horaServicio = hoServicio,
                    S.lugarServicio = luServicio,
                    S.telefonoContacto = telefono,
                    S.codigoEmpresa = codEmpresa
            where S.codigoServicio = codServicio;        
        End //
Delimiter ;
Call sp_EditarServicio(1,'2021-4-23','En restaurante', '11:34', 'Restaurante zona 2', '23232323',1);
-- Entidad Empleados------------------------------------------------------------------------------------
-- Agregar--------------------------------------------------------------------------------------------------
Delimiter //
Create procedure sp_AgregarEmpleado(in numeroEmpleado int, in apellidosEmpleado varchar(150),in nombresEmpleado varchar(150),
	in direccionEmpleaso varchar(150),in telefonoContacto varchar(10),in gradoCocinero varchar(50),in codigoTipoEmpleado int)
		Begin
			Insert into Empleados(numeroEmpleado,apellidosEmpleado,nombresEmpleado,direccionEmpleaso,telefonoContacto,gradoCocinero,codigoTipoEmpleado)
            values(numeroEmpleado,apellidosEmpleado,nombresEmpleado,direccionEmpleaso,telefonoContacto,gradoCocinero,codigoTipoEmpleado);
        End //
Delimiter ;
Call sp_AgregarEmpleado(1,'García','Damian','zona 3','12354675','Cocinero Experto',1);
Call sp_AgregarEmpleado(2,'Lopez','Cristian','zona 5','21784675','Cocinero Mediano',1);
-- Mostrar------------------------------------------------------------------------------------------------------
Delimiter //
Create procedure sp_MostrarEmpleados()
	Begin
		Select E.codigoEmpleado,
               E.numeroEmpleado,
               E.apellidosEmpleado,
               E.nombresEmpleado,
               E.direccionEmpleaso,
               E.telefonoContacto,
               E.gradoCocinero,
               E.codigoTipoEmpleado
        from Empleados as E;       
    End //
Delimiter ;
Call sp_MostrarEmpleados();
-- Buscar--------------------------------------------------------------------------------------------------------
Delimiter //
Create procedure sp_BuscarEmpleado(in codEmpleado int)
	Begin
		Select E.codigoEmpleado,
               E.numeroEmpleado,
               E.apellidosEmpleado,
               E.nombresEmpleado,
               E.direccionEmpleaso,
               E.telefonoContacto,
               E.gradoCocinero,
               E.codigoTipoEmpleado
        from Empleados as E where codEmpleado = E.codigoEmpleado;
    End //
Delimiter ;
Call sp_BuscarEmpleado(1);
-- Eliminar--------------------------------------------------------------------------------------------------------
Delimiter //
Create procedure sp_EliminarEmpleado(in codEmpleado int)
	Begin
		Delete 
			from Empleados as E where E.codigoEmpleado = codEmpleado;
    End //
Delimiter ;
Call sp_EliminarEmpleado(2);
-- Actualizar----------------------------------------------------------------------------------------------------------
Delimiter //
Create procedure sp_EditarEmpleado(in codEmpleado int, in numEmpleado int,in apeEmpleado varchar(150),in nomEmpleado varchar(150),
	in direEmpleado varchar(150),in telEmpleado varchar(10),in graEmpleado varchar(50),in codTipoEmpleado int)
		Begin
			Update Empleados as E
				set E.numeroEmpleado = numEmpleado,
                    E.apellidosEmpleado = apeEmpleado,
                    E.nombresEmpleado = nomEmpleado,
                    E.direccionEmpleaso = direEmpleado,
                    E.telefonoContacto = telEmpleado,
                    E.gradoCocinero = graEmpleado,
                    E.codigoTipoEmpleado = codTipoEmpleado
                 where E.codigoEmpleado = codEmpleado;   
        End //
Delimiter ;
Call sp_EditarEmpleado(1,4,'Pedro','Damian','zona 3','12354675','Cocinero Novato',1);
-- Entidad Platos-----------------------------------------------------------------------------------------------
-- Agregar----------------------------------------------------------------------------------------------------
Delimiter //
Create procedure sp_AgregarPlato(in cantidad int,in nombrePlato varchar(50),in descripcionPlato varchar(150),in precioPlato decimal(10,2),
	in codigoTipoPlato int)
		Begin
			Insert into Platos(cantidad,nombrePlato,descripcionPlato,precioPlato,codigoTipoPlato)
            values(cantidad,nombrePlato,descripcionPlato,precioPlato,codigoTipoPlato);
        End //
Delimiter ;
Call sp_AgregarPlato(43,'Pizza','Deliciosa pizza de queso',30.66,1);
Call sp_AgregarPlato(564,'Helado de fresa','Delicioso helado de fresa',33.66,1);
-- Mostrar----------------------------------------------------------------------------------------------------
Delimiter //
Create procedure sp_MostrarPlatos()
	Begin
		Select P.codigoPlato,
               P.cantidad,
               P.nombrePlato,
               P.descripcionPlato,
               P.precioPlato,
               P.codigoTipoPlato
          from Platos as P;     
    End //
Delimiter ;
Call sp_MostrarPlatos();
-- Buscar---------------------------------------------------------------------------------------------------
Delimiter //
Create procedure sp_BuscarPlato(in codPlato int)
	Begin
		Select P.codigoPlato,
               P.cantidad,
               P.nombrePlato,
               P.descripcionPlato,
               P.precioPlato,
               P.codigoTipoPlato
          from Platos as P where P.codigoPlato = codPlato;     
    End //
Delimiter ;
Call sp_BuscarPlato(1);
-- Eliminar--------------------------------------------------------------------------------------------------------
Delimiter //
Create procedure sp_EliminarPlato(in codPlato int)
	Begin
		delete
			from Platos as P where P.codigoPlato = codPlato;
    End //
Delimiter ;
Call sp_EliminarPlato(2);
-- Editar-------------------------------------------------------------------------------------------------------
Delimiter //
Create procedure sp_EditarPlato(in codPlato int,in cant int,in nomPlato varchar(50),in desPlato varchar(150),in precPlato decimal(10,2),
	in codTipoPlato int)
		Begin
			Update Platos as P
				set P.cantidad = cant,
                    P.nombrePlato = nomPlato,
                    P.descripcionPlato = desPlato,
                    P.precioPlato = precPlato,
                    P.codigoTipoPlato = codTipoPlato
              where P.codigoPlato = codPlato;      
        End //
Delimiter ;
Call sp_EditarPlato(1,43,'Hamburguesa','Deliciosa hambuerguesa vegana',30.66,1);
-- Entidad ServiciosHasPlatos-------------------------------------------------------------------------------------
-- Agregar----------------------------------------------------------------------------------------------------------
Delimiter //
Create procedure sp_AgregarServicioHasPlato(in serviciosCodigoServicio int, platosCodigoPlato int)
	Begin
		Insert into Servicios_Has_Platos(serviciosCodigoServicio,platosCodigoPlato)
        values(serviciosCodigoServicio,platosCodigoPlato);
    End //
Delimiter ;
Call sp_AgregarServicioHasPlato(1,1);
Call sp_AgregarServicioHasPlato(1,1);
-- Mostrar--------------------------------------------------------------------------------------------------------------
Delimiter //
Create procedure sp_MostrarServiciosHasPlatos()
	Begin
		Select SP.codigoServiciosHasPlatos,
               SP.serviciosCodigoServicio,
               SP.platosCodigoPlato
         from Servicios_Has_Platos as SP;      
    End //
Delimiter ;
Call sp_MostrarServiciosHasPlatos();
-- Buscar------------------------------------------------------------------------------------------------------------------
Delimiter //
Create procedure sp_BuscarServicioHasPlato(in codServiciosHasPlatos int)
	Begin
		Select SP.codigoServiciosHasPlatos,
               SP.serviciosCodigoServicio,
               SP.platosCodigoPlato
         from Servicios_Has_Platos as SP where SP.codigoServiciosHasPlatos = codServiciosHasPlatos; 
    End //
Delimiter ;
Call sp_BuscarServicioHasPlato(1);
-- Eliminar------------------------------------------------------------------------------------------------------------
Delimiter //
Create procedure sp_EliminarServiciosHasPlatos(in codServiciosHasPlatos int)
	Begin
		Delete 
			from Servicios_Has_Platos as SP where SP.codigoServiciosHasPlatos = codServiciosHasPlatos;
    End //
Delimiter ;
Call sp_EliminarServiciosHasPlatos(2);
-- Editar--------------------------------------------------------------------------------------------------------------
Delimiter //
Create procedure sp_EditarServiciosHasPlatos(in codServiciosHasPlatos int, in serviciosCodServicio int,in platosCodPlato int)
	Begin
		Update Servicios_Has_Platos as SP
			set SP.serviciosCodigoServicio = serviciosCodServicio,
                SP.platosCodigoPlato = serviciosCodServicio
             where SP.codigoServiciosHasPlatos = codServiciosHasPlatos;   
    End //
Delimiter ;
Call sp_EditarServiciosHasPlatos(2,2,2);
-- Entidad ProductosHasPlatos-----------------------------------------------------------------------------------------
-- Agregar----------------------------------------------------------------------------------------------------------
Delimiter //
Create procedure sp_AgregarProductosHasPlatos(in productosCodigoProducto int, in platosCodigoPlato int)
	Begin 
		Insert into Productos_Has_Platos(productosCodigoProducto,platosCodigoPlato)
        values(productosCodigoProducto,platosCodigoPlato );
    End //
Delimiter ;
Call sp_AgregarProductosHasPlatos(1,1);
-- Mostrar--------------------------------------------------------------------------------------------------------------
Delimiter //
Create procedure sp_MostrarProductosHasPlatos()
	Begin
		Select PP.codigoProductosHasPlatos,
               PP.productosCodigoProducto,
               PP.platosCodigoPlato
        from Productos_Has_Platos as PP;       
    End //
Delimiter ;
Call sp_MostrarProductosHasPlatos();
-- Buscar------------------------------------------------------------------------------------------------------------------
Delimiter //
Create procedure sp_BuscarProductosHasPlatos(in codProductosHasPlatos int)
	Begin
		Select PP.codigoProductosHasPlatos,
               PP.productosCodigoProducto,
               PP.platosCodigoPlato
        from Productos_Has_Platos as PP where PP.codigoProductosHasPlatos = codProductosHasPlatos;  
    End //
Delimiter ;
Call sp_BuscarProductosHasPlatos(1);
-- Eliminar------------------------------------------------------------------------------------------------------------
Delimiter //
Create procedure sp_EliminarProductosHasPlatos(in codProductosHasPlatos int)
	Begin
		Delete 
			from Productos_Has_Platos as PP where PP.codigoProductosHasPlatos = codProductosHasPlatos;
    End //
Delimiter ;
Call sp_EliminarProductosHasPlatos (1);
-- Editar--------------------------------------------------------------------------------------------------------------
Delimiter //
Create procedure sp_EditarProductosHasPlatos(in codProductosHasPlatos int, in productosCodProducto int, in platosCodPlato int)
	Begin
		Update Productos_Has_Platos as PP
			set PP.productosCodigoProducto = productosCodProducto,
                PP.platosCodigoPlato = platosCodPlato
        where PP.codigoProductosHasPlatos =  codProductosHasPlatos;       
    End //
Delimiter ;
Call sp_EditarProductosHasPlatos(2,1,1);
-- Entidad ServiciosHasEmpleados---------------------------------------------------------------------------------
-- Agregar----------------------------------------------------------------------------------------------------------
Delimiter //
Create procedure sp_AgregarServicioHasEmpleado(in serviciosCodigoservicio int, in empleadosCodigoEmpleado int, in fechaEvento date,
	in horaEvento time, in lugarEvento varchar(150))
		Begin
			Insert into Servicios_Has_Empleados(serviciosCodigoservicio,empleadosCodigoEmpleado,fechaEvento,horaEvento,lugarEvento)
            values(serviciosCodigoservicio,empleadosCodigoEmpleado,fechaEvento,horaEvento,lugarEvento);
        End //
Delimiter ;
Call sp_AgregarServicioHasEmpleado(1,1,'2022-04-21','11:30','Plaza Restaurante MAX');
Call sp_AgregarServicioHasEmpleado(1,1,'2022-07-12', '13:34','Plaza zona 3');
-- Mostrar--------------------------------------------------------------------------------------------------------------
Delimiter //
Create procedure sp_MostrarServiciosHasEmpleados()
	Begin
		Select SE.codigoServiciosHasEmpleados,
			   SE.serviciosCodigoservicio,
               SE.empleadosCodigoEmpleado,
               SE.fechaEvento,
               SE.horaEvento,
               SE.lugarEvento
          from Servicios_Has_Empleados as SE;     
    End //
Delimiter ;
Call sp_MostrarServiciosHasEmpleados();
-- Buscar------------------------------------------------------------------------------------------------------------------
Delimiter //
Create procedure sp_BuscarServiciosHasEmpleados(in codServiciosHasEmpleados int)
	Begin 
		Select SE.codigoServiciosHasEmpleados,
			   SE.serviciosCodigoservicio,
               SE.empleadosCodigoEmpleado,
               SE.fechaEvento,
               SE.horaEvento,
               SE.lugarEvento
          from Servicios_Has_Empleados as SE where SE.codigoServiciosHasEmpleados = codServiciosHasEmpleados;     
    End //
Delimiter ;
Call sp_BuscarServiciosHasEmpleados(1);
-- Eliminar------------------------------------------------------------------------------------------------------------
Delimiter //
Create procedure sp_EliminarServiciosHasEmpleados(in codServiciosHasEmpleados int)
	Begin 
		Delete 
			from Servicios_Has_Empleados as SE where SE.codigoServiciosHasEmpleados = codServiciosHasEmpleados;
    End //
Delimiter ;
Call sp_EliminarServiciosHasEmpleados(1);
-- Editar--------------------------------------------------------------------------------------------------------------
Delimiter //
Create procedure sp_EditarcodServiciosHasEmpleados(in codServiciosHasEmpleados int, in serviciosCodservicio int, in serviciosCodEmpleado int,
	in feEvento date, in horEvento time, in luEvento varchar(150))
		Begin 
			Update Servicios_Has_Empleados as SE
				set SE.serviciosCodigoservicio = serviciosCodservicio,
					SE.empleadosCodigoEmpleado = serviciosCodEmpleado,
                    SE.fechaEvento = feEvento,
                    SE.horaEvento = horEvento,
                    SE.lugarEvento = luEvento
            where SE.codigoServiciosHasEmpleados = codServiciosHasEmpleados;        
        End //
Delimiter ;
Call sp_EditarcodServiciosHasEmpleados(1,1,1,'2022-07-12', '13:34','Plaza zona 7');