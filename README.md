# Trabajo practico integrador

Este es mi trabajo practico integrador de la materia de Taller de produccion en Ruby 2022.

## Configuracion del proyecto

- Ruby version: 3.1.2
- Rails version: 7.0.4
- Database: PostgresSQL

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
- Pundit: Quize usarlo para el control de acceso con las policies pero tuve problemas con active admin. Asi que el control lo hice en los controllers

## Informacion adicional

### Roles

Tenemos dos clases de roles de empleados.

- Staff que es un empleado comun.
- Admin que es un empleado administrador.

### Idioma

La gran mayoria del codigo esta escrito en ingles, por la costumbre y facilidad de lectura. De igual manera utilizo I18n para la traduccion de los textos.

### Modelos

- Branch Offices: Sucursales de la empresa.
  - name: `string` requerido
  - address: `string` requerido
  - phone: `string` requerido
- Users: Clientes de la empresa.
  - username: `string` requerido y unico
  - email: `string` requerido y unico
  - password: `string` requerido
- Admin Users: Empleados de la empresa.
  - roles: admin y/o staff
  - username: `string` requerido y unico
  - password: `string` requerido
  - email: `string` requerido y unico
  - branch_office_id: `sucursal` requerida solo para rol staff
- Opening Hours: Horarios de apertura de las sucursales.
  - day: `int` 1…7 requerido, 1 = lunes
  - opens: `hour` requerido
  - closes: `hour` requerido
- Role: Roles de los empleados.

<aside>
💡 Aclaracion: los empleados y clientes pueden iniciar con su nombre de usuario o email

</aside>

### Permisos de los empleados y clientes en el sistema

- Administrador

  1. Perfil
     - Modificar los datos de su perfil de usuario
     - Modificar su contraseña
  2. Clientes
     - Modificar un cliente
     - Ver un cliente
     - Eliminar un cliente
     - Ver clientes
  3. Sucursales
     - Modificar un sucursal
     - Ver una sucursal
     - Eliminar una sucursal, no debe tener turnos asignados
     - Ver sucursales
     - Agregar una sucursal
  4. Turnos
     - Ver un turno
     - Ver turnos de cualquier sucursal
  5. Horarios
     - Modificar un horario
     - Ver un horario
     - Eliminar una horario
     - Ver horarios
     - Crear un horario
  6. Empleados
     - Modificar un empleado
     - Ver un empleado
     - Eliminar una empleado
     - Ver empleados
     - Crear empleados

- Personal bancario

  1. Perfil
     - Modificar los datos de su perfil de usuario
     - Modificar su contraseña
  2. Clientes
     - Ver un cliente
     - Ver clientes
  3. Sucursales
     - Ver una sucursal
     - Ver sucursales
  4. Turnos de su sucursal
     - Modificar un turno
     - Ver un turno
     - Eliminar una turno
     - Ver turnos
  5. Horarios
     - Ver un horario
     - Ver horarios
  6. Empleados
     - No pueden hacer nada

- Cliente

  1. Registro
     - Registrarme en el sistema
  2. Perfil (solo autenticado)
     - Modificar los datos de su perfil de usuario
     - Modificar su contraseña
  3. Sucursales
     - Ver sucursales
     - Ver datos
  4. Turnos
     - Ver mis turnos (solo autenticado)
     - Ver un turno (solo autenticado)
     - Modificar un turno ( solo autenticado y si no esta completado)
     - Eliminar un turno ( solo autenticado y si no esta completado)
     - Sacar un turno (no se puede el mismo dias sacar mas de uno en la misma sucursal)
