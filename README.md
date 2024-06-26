# Aplicación celular de viajes turísticos (MOCHI GO)
Esta aplicación se basa en microservicios, los cuales se basa en mejorar la experiencia de un turista en cualquier parte del mundo donde desee viajar, este aplicativo va a contener:

1. Servicio de autentificación de usuario
2. Servicio de notificaciones por pushNotifications (Celular)
3. Servicio de notificaciones por email
4. Servicio de compras
5. Servicio de traducción

Los cuales se podrán ver desde varias aplicaciones, principalmente este proyecto como esta pensado para turistas se va a hacer en un aplicativo móvil, el cual se realizara en el framework de Flutter con Dart.

Los servicios dependiendo de donde se llame, mayormente se van a hacer con dos tipos de lenguaje, los cuales van a ser con el backend de Python y JavaScript, con su respectivo framework, los cuales son Node.js y si se necesita algún guardado de datos o autentificaciones de usuario se usara Django o Flask para enviar algún servicio que necesite consumo o realizar comando que necesite de comprobaciones o servicio externo que no necesite algún tipo de guardado de datos.

# Nota
Al momento se esta tratando con las aplicaciones como Django, Node.js y Flask, entonces estas notas serán para poder realizar todas las ejecuciones de los códigos:

- Django
```
> python manage.py runserver <numero de puerto>
```
Esta linea de comandos servirá para ejecutar he iniciar el microservicio de python en Django, donde el `<numero de puerto>` llega a ser mayormente estos: `8000, 8001, 8002, etc`
- Node.js
```
> node app.js
```
Esta linea va a ejecutar siempre el microservicio que este realizado con JavaScript donde no hay que olvidar que tenemos las variables de entorno llamadas `.env` estas se encuentran retiradas del github por el `.gitignore` entonces hay que crear uno de esos en la base del proyecto y poner el puerto el cual se van a registrar de la siguiente forma `PORT=8000` por dar un ejemplo

- Flask
```
python app.py
```
Esta linea hará que se ejecute la aplicación en flask, donde se podrá guardar la información de forma básica sin usuarios distribuyendo la información en distintas tablas de bases de datos, o sino solo para llamar los datos que necesite.

- Puertos que se estan usando en los microservicios
```
> 8000
> 8001
> 8002
```

## Servicios y sus componentes
### Desde el mas importante al menos importante
#### Servicio de autentificación de usuario
Este es el servicio principal de nuestro aplicativo, ya que se encargara de autenticar los usuarios que se están registrando en la aplicación, y están ingresando a la misma, este servicio se lo realizara a partir del Framework de Django, ya que este puede hacer que rápidamente un servicio de creación y autentificación de usuario de manera sencilla y rápida, los campos que pertenecerán al usuario van a ser:

id  | password       | last_login | is_superuser | username | first_name | last_name | email | is_staff | is_active | date_joined |
--- | ---------------|-------------| ------- | ---------- | ----------- | ---------- | ----- | -------- | --------- | ----------- |
int | String (128)   | timestamp | boolean | String (150) | String (150) | String (150) | String (254) | boolean | boolean | timestamp |
FK  | Necesario | auto completado | auto completado | necesario | No necesario | No necesario | Necesario | auto completado | auto completado | auto completado |

*Cosas a saber antes de crear un super usuario*

En el `.gitignore` se encuentra ignorando la base de datos que es `db.sqlite3` entonces al momento de realizar cualquier intento de crear un usuario o alguna acción que implique algo de base de datos, se necesitara poner los siguientes comandos:

> python manage.py makemigrations <br>
> python manage.py migrate

Esto ayudara a la creación de la base de datos y todos los componentes que se necesiten en la carpeta de `authuser`.

El servicio contara con un usuario que se llama "superuser" el cual se crea mediante lineas de comando, donde se dejara aquí como crear el super usuario:

```
> python manage.py createsuperuser
```

Después de poner la linea se deberá ingresar la siguiente información: 

```
> username: "Usuario que puede contener _, @, +, ., -" <br>
> email: "email valido con @ y ." <br>
> password: "Clave la cual después va a ser encriptada" <br>
> confirm password: "Clave identidad a la contraseña anterior"
```

Al realizar eso se podrá ingresar usando la siguiente ruta `<Nombre del dominio>\admin` o `http:\\127.0.0.1:8000\admin`:`http:\\10.0.2.2:8000\admin` y le pedirá un usuario y la contraseña que se creo anteriormente.

*Rutas de rediciones de API Users*

Las rutas de rediciones de el api con Django para autenticar a un usuario se llega a ser la principal:
- `/users/`
- `/users/login/`
- `/users/logout/`

Y la documentación si es que se necesita sobre la api, llega a estar en la ruta:
- `/users/swagger/`
- `/users/redoc/`

#### Servicio de notificaciones al usuario
Este componente se encontrara realizado con Node.js, ya que al momento se cuenta con una buena forma de mandar notificaciones con un sistema de Google, que es el Firebase Cloud Messaging (FCM), se llega a hacer en node para poder guardar en un archivo externo el ID del usuario el cual tiene la aplicación instalada y el código del aplicativo para enviar la notificación.

La característica principal de este servicio es que va a tener una base de datos NoSQL el cual tendrá el siguiente formato:

```
{
    user_id: <int>,
    code_phone: <string>
}
```
Esto va a satisfacer la necesidad de tener los códigos de los celulares, y poder enviar mensajes mediante un end-point el cual va a recibir el mensaje que se quiere enviar, y dependiendo si tiene una lista de ID's de usuarios o no, se va a enviar a todas las personas que estén registradas en la aplicación de turismo.

*Rutas de redirection de API*

La ruta principal de redirección se va a ser de otro microservicio, la cual llega a tener como `http:\\<Nombre del dominio>` o `http:\\127.0.0.1:8001`:`http:\\10.0.2.2:8001`

Las rutas principales para el guardado de datos para las notificaciones en la parte del aplicativo móvil se realizaran en los siguientes end points:

- `/api/save`
- `/api/get/:user_id`
- `/api/get`
- `/api/send-notification`

Donde cada uno va a solicitar información especifica sobre que se necesitara enviar como:

`/sabe`: Pide el user_id y el code_phone <br>
`/get/:user_id`: Pide el id del usuario en la ruta <br>
`/send-notification`: Pide el user_id, title y message <br>

Para correr el aplicativo de node hay que redirigirse a la carpeta de notificaciones y poner los siguientes comandos

```
> node init
> node app.js
```

Con el ultimo ya corre el servidor y debería salir lo siguiente en la consola de comandos:

```
Server running on port 8080
```

#### Servicio de compras del usuario
Este servicio se centrara en obtener información de compras que se realizaran en el aplicativo de MOCHI GO, el cual se realizara con respecto a un carrito de compras con los artículos que se quisiera comprar, este se va a basar en servicio de:

- Creación de la categoría de producto a seleccionar
    | Nombre de categoria |
    | --- |
    | String(150) |
- Creación de productos con respecto a su categoría
    | Nombre de producto | Descripción | Precio | Image | categoria id |
    | --- | --- | --- | --- | --- |
    | String(150) | String(150) | float | String(150) | PK |
- Creación de facturación con respecto a los datos que se tiene del usuario como:
    | Usuario id | email de usuario | primer nombre | Segundo nombre | Ubicación | Date | Phone |
    | ----------------- | ---------------- | ---------| ----| ------ | ---- | ---- |
    | int | String(150) | String(150) | String(150) | String(50) | Date | String(10) |
- Creación de productos comprados como:
    | Nombre del producto | Precio unitario | Cantidad |
    | --- | ---- | ---- | 
    | String(150) | float | int |

Al ver que es un servicio que necesita de base de datos relacional para realizar las facturas de forma dinámica, se llegara a usar una base de datos, se usara Flask como forma de API para la creación de la factura de la data que se va a necesitar guardar de compras.

*Cosas antes de ejecutar el programa*

Al tratarse de un aplicativo en Flask, no se necesitaran muchas dependencias, pero si llega a haber un `.gitignore` para no subir en el github la base de datos que se va a crear al momento de ejecutar la aplicación.

*Rutas de redirection de API*

Para las rutas con este aplicativo de Flask se va a usar los siguientes enlaces: `http://<nombre de dominio>\` o `http://127.0.0.1:8002`:`http://10.0.2.2:8002` para poder conectarse al api que nos trae Flask, las rutas van a ser las siguientes:

- `/categories`
- `/products`
- `/products/<int:product_id>`
- `/bill-details`
- `/bills`

los cuales cada uno tiene su método CRUD, el cual funcionara para realizar cualquier acción que se necesite para crear la facturación correspondiente y de esa forma podremos encontrar de forma rápida la información necesaria para mandar al front-end mucho más rápido y más efectivo.

Para cada categoría que se esta mencionando para end-points del api se van a necesitar algunos parámetros en el body, los cuales son:

- categories
```
{
    "name": "Algún nombre de una categoría"
}
```
- products
```
{
    "category_id": Int de categoría,
    "description": "Descripción del producto",
    "image": "link de imagen",
    "name": "Nombre del producto",
    "price": Precio en double
},
```
- bill
```
{
    'total': total de la compra realizada,
    'user_id': int del usuario que compre,
    'first_name': Primer nombre del usuario,
    'last_name': Segundo nombre del usuario,
    'email': Email del usuario,
    'location': Donde vive el usuario,
    'phone': Celular del usuario
}
```
- bill-details
```
{
    'bill_id': Id de la cabecera a la cual va asociada,
    'product_id': Id del producto que compro
    'quantity': Cantidad del producto que compro
}
```