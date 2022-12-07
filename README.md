# README

# Trabajo practico integrador

Este es mi trabajo practico integrador de la materia de Taller de produccion en Ruby 2022.

## Configuracion del proyecto

- Ruby version: 3.1.2
- Rails version: 7.0.4
- Database: Postgres

Para comenzar a usar el proyecto, debes seguir los siguientes pasos:

## Instalar las dependencias

```bash
$ bundle install
```

## Iniciar la DB

Si necesitas modificar alguna variable de entorno, puedes hacerlo en el archivo .env

```bash
$ rails db:setup
```

## Iniciar el servidor

```bash
$ rails s
```

## Gemas utilizadas

- Devise: Para la autenticacion de clientes y empleados
- Bootstrap: Para el diseño de la pagina publica
- Rolify: Para la gestion de roles de empleados
- Active Admin: Para la gestion del sistema
- Draper: Para la decoracion de modelos
- standard: Para el formateo de codigo

## Informacion adicional

### Roles

Tenemos dos clases de roles de empleados.

- Staff que es un empleado comun.
- Admin que es un empleado administrador.

### Idioma

La gran mayoria del codigo esta escrito en ingles, por la costumbre y facilidad de lectura. De igual manera utilizo I18n para la traduccion de los textos.

### Modelos

- Branch Offices: Sucursales de la empresa.
- Users: Clientes de la empresa.
- Admin Users: Empleados de la empresa.
- Opening Hours: Horarios de apertura de las sucursales.
- Role: Roles de los empleados.

<aside>
💡 Aclaracion: los empleados y clientes pueden iniciar con su nombre de usuario o email

</aside>

### Permisos de los empleados y clientes en el sistema

Administrador

1. Clientes
    - [ ]  Modificar un cliente
    - [ ]  Ver un cliente
    - [ ]  Eliminar un cliente
    - [ ]  Ver clientes
2. Sucursales
    - [ ]  Modificar un sucursal
    - [ ]  Ver una sucursal
    - [ ]  Eliminar una sucursal
    - [ ]  Ver sucursales
3. Turnos
    - [ ]  Modificar un turno de cualquier sucursal
    - [ ]  Ver un turno
    - [ ]  Eliminar una turno
    - [ ]  Ver turnos de cualquier sucursal
4. Horarios
    - [ ]  Modificar un horario
    - [ ]  Ver un horario
    - [ ]  Eliminar una horario
    - [ ]  Ver horarios
5. Empleados
    - [ ]  Modificar un empleado
    - [ ]  Ver una empleado
    - [ ]  Eliminar una empleado
    - [ ]  Ver empleados
    - [ ]  Modificar sus propios datos

Empleado

1. Clientes
    - [ ]  Modificar un cliente
    - [ ]  Ver un cliente
    - [ ]  Eliminar un cliente
    - [ ]  Ver clientes
2. Sucursales
    - [ ]  Modificar un sucursal
    - [ ]  Ver una sucursal
    - [ ]  Eliminar una sucursal
    - [ ]  Ver sucursales
3. Turnos
    - [ ]  Modificar un turno su sucursal
    - [ ]  Ver un turno
    - [ ]  Eliminar una turno
    - [ ]  Ver turnos de su sucursal
4. Horarios
    - [ ]  Modificar un horario
    - [ ]  Ver un horario
    - [ ]  Eliminar una horario
    - [ ]  Ver horarios
5. Empleados
    - [ ]  Modificar un empleado
    - [ ]  Ver una empleado
    - [ ]  Eliminar una empleado
    - [ ]  Ver empleados
    - [ ]  Modificar sus propios datos

Cliente

1. Clientes
    - [ ]  Modificar sus propios datos (solo autenticado)
2. Sucursales
    - [ ]  Ver sucursales
    - [ ]  Ver datos
3. Turnos
    - [ ]  Ver mis turnos  (solo autenticado)
    - [ ]  Ver un turno  (solo autenticado)
    - [ ]  Modificar un turno ( solo autenticado y si no esta completado)
    - [ ]  Eliminar un turno ( solo autenticado y si no esta completado)
