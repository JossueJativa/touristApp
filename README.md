# Aplicación celular de viajes turísticos
Esta aplicación se basa en microservicios, los cuales se basa en mejorar la experiencia de un turista en cualquier parte del mundo donde desee viajar, este aplicativo va a contener:

* Servicio de notificaciones
* Servicio de telefonía y comunicación
* Servicio de salud
* Servicio de eventos
* Servicio de mapas
* Servicio de movilidad
* Servicio de traducción
* Servicio de calendario

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