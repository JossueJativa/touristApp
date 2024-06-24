# Aplicación celular de viajes turísticos
Esta aplicación se basa en microservicios, los cuales se basa en mejorar la experiencia de un turista en cualquier parte del mundo donde desee viajar, este aplicativo va a contener:

1. Servicio de autentificación de usuario
2. Servicio de notificaciones
3. Servicio de telefonía y comunicación
4. Servicio de salud
5. Servicio de eventos
6. Servicio de mapas
7. Servicio de movilidad
8. Servicio de traducción
9. Servicio de calendario

Los cuales se podrán ver desde varias aplicaciones, principalmente este proyecto como esta pensado para turistas se va a hacer en un aplicativo móvil, el cual se realizara en el framework de Flutter con Dart.

Los servicios dependiendo de donde se llame, mayormente se van a hacer con dos tipos de lenguaje, los cuales van a ser con el backend de Python y JavaScript, con su respectivo framework, los cuales son Node.js y si se necesita algún guardado de datos o autentificaciones de usuario se usara Django, o sino se usara la librería de Flask - Python para enviar algún servicio que necesite consumo o realizar comando que necesite de comprobaciones o servicio externo que no necesite algún tipo de guardado de datos.

## Servicios y sus componentes
### Desde el mas importante al menos importante
* Servicio de autentificación de usuario
Este es el servicio principal de nuestro aplicativo, ya que se encargara de autenticar los usuarios que se están registrando en la aplicación, y están ingresando a la misma, este servicio se lo realizara a partir del Framework de Django, ya que este puede hacer que rápidamente un servicio de creación y autentificación de usuario de manera sencilla y rápida, los campos que pertenecerán al usuario van a ser:

id  | password       | last_login | is_superuser | username | first_name | last_name | email | is_staff | is_active | date_joined |
--- | ---------------|-------------| ------- | ---------- | ----------- | ---------- | ----- | -------- | --------- | ----------- |
int | String (128)   | timestamp | boolean | String (150) | String (150) | String (150) | String (254) | boolean | boolean | timestamp |
FK  | Necesario | auto completado | auto completado | necesario | No necesario | No necesario | Necesario | auto completado | auto completado | auto completado |

### Cosas a saber antes de crear un super usuario
En el `.gitignore` se encuentra ignorando la base de datos que es `db.sqlite3` entonces al momento de realizar cualquier intento de crear un usuario o alguna acción que implique algo de base de datos, se necesitara poner los siguientes comandos:

> python manage.py makemigrations <br>
> python manage.py migrate

Esto ayudara a la creación de la base de datos y todos los componentes que se necesiten en la carpeta de `authuser`.

El servicio contara con un usuario que se llama "superuser" el cual se crea mediante lineas de comando, donde se dejara aquí como crear el super usuario:

> python manage.py createsuperuser

Después de poner la linea se deberá ingresar la siguiente información: 

> username: "Usuario que puede contener _, @, +, ., -" <br>
> email: "email valido con @ y ." <br>
> password: "Clave la cual después va a ser encriptada" <br>
> confirm password: "Clave identidad a la contraseña anterior"

Al realizar eso se podrá ingresar usando la siguiente ruta `<Nombre del dominio>\admin` y le pedirá un usuario y la contraseña que se creo anteriormente.

### Rutas de rediciones de API Users
Las rutas de rediciones de el api con Django para autenticar a un usuario se llega a ser la principal:
- `/users/`
- `/users/login/`
- `/users/logout/`

Y la documentación si es que se necesita sobre la api, llega a estar en la ruta:
- `/users/swagger/`
- `/users/redoc/`