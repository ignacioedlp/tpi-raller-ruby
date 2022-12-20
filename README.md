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
  4. Turnos (solo autenticado)
     - Ver mis turnos
     - Ver un turno
     - Modificar un turno (si no esta completado)
     - Eliminar un turno (si no esta completado)
     - Sacar un turno (no se puede el mismo dias sacar mas de uno en la misma sucursal)
     
### Aclaraciones
1. No se aclaro en el enunciado pero en cuanto a la eliminacion de un horario, quizas una opcion es cancelar o eliminar los turnos para ese dia. (No lo hice porque no lo aclararon).
2. Las sucursales solo se pueden eliminar si no tiene turnos pendientes. En el caso de que se pueda, los turnos completados no tendran una sucursal asignada. Lo hice de esa manera para no perder el historial de turnos.
3. Puede haber lugares donde la traduccion no este hecha. 
4. Como no especificaban que acciones tenian los admin con los turnos, lo que hice es mostrar los turnos de todas las sucursales (para el caso de que sea un admin y no un staff), pero solamente las acciones de ver todos y los detalles de cada uno. Luego las acciones de eliminar, modificar no las puede hacer.
5. Hice que puedan tener mas de un rol, porque me parecia mas logico de si a futuro, se necesitara de tener multiples roles y no uno solo.
6. En cuanto a la modificacion de un cliente o empleado, la contraseña la hice de manera que con solo el campo contraseña se modifique, no puse la verificacion ni ingresar a la contraseña actual. Igualmente si quieren cambiar su contraseña un cliente o empleado lo puede hacer el mismo.

### NOTAS DE LA RE ENTREGA
- [x]  Los seeds no terminan de cargar por un error de validación en los turnos.
    
    Solucion los turnos se los tiene que crear
    
- [x]  Los errores de validación al intentar sacar un turno obligan a comenzar de cero, y no se indican qué errores se encuentran. Tal como hablamos en el coloquio, para estas situaciones se suele volver a renderizar la vista anterior y así mostrar los errores en el formulario de carga junto con el valor que el usuario cargó para que pueda corregirlo sin tener que completar todo de nuevo.
    
    Los errores ahora se muestran, pero los datos no logro devolverlos, creo que es porque si o si al renderizar se crea un shift nuevo.
    
- [x]  Validaciones como las de Shift#comment_and_admin_user_are_present_if_completed se pueden expresar directamente con validadores de Rails:validates :comment, :admin_user, presence: true, if: :completed?
    La validación de unicidad de horarios por día y sucursal no es correcta. Desde el CRUD de Horarios de atención puedo modificar un día de atención y repetir el día     (una vez creado).
    
    OpeningHour#day_is_unique es una reescritura del uniqueness validator: validates :day, uniqueness: { scope: :branch_office_id }.
    
    Corregido.
    
- [x]  La forma de gestionar los horarios de atención no es lo más amigable. Hubiera sido más claro que se gestionen directamente desde el CRUD de una sucursal. (No es necesario arreglar esto para la reentrega, aunque sería una linda mejora)
    
    -
    
- [x]  Al modificar un horario, se carga la página con el día incorrecto (siempre está seteado a Lunes, aunque esté modificando el horario para otro día de la semana).
    
    Arreglado ahora se muestra el dia correcto
    
- [x]  No encuentro cómo atender un turno, si es la modificación del turno no me parece adecuada porque muestra campos de más y me obliga a marcar manualmente como completado así como también cargarme como que fui yo quien lo atendió. Esto sí debe corregirse.
    
    Ahora se tiene la opcion de atender, el editar no existe mas, al guardar el turno se asigna como completado y el operador con la sesion iniciada, una vez completado el turno no se puede volver a hacer. Solo ver la informacion del turno.

