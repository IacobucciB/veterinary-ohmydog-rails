# Veterinaria Oh My Dog

Proyecto colaborativo que realicé con dos colegas universitarios: un completo Sistema de Citas Veterinarias desarrollado utilizando el framework Ruby on Rails. Esta aplicación web sirve como una plataforma fácil de usar que facilita diversas funcionalidades dentro del ámbito veterinario.

### Pasos para ejecutar la aplicación

1. Instalación de Ruby y Rails  
Asegúrate de tener Ruby y Rails instalados en tu sistema.

2. Clonar el repositorio  
```
git clone https://github.com/IacobucciB/veterinary-ohmydog-rails.git
```

3. Instalación de dependencias  
Accede al directorio del proyecto y ejecuta el siguiente comando para instalar las gemas y dependencias necesarias:
```
bundle install
```

4. Configuración de la base de datos  
Asegúrate de tener PostgreSQL instalado en tu sistema. Luego, configura la base de datos ejecutando los siguientes comandos. Estos comandos crearán la base de datos, ejecutarán todas las migraciones pendientes y sembrarán datos de ejemplo en la base de datos.
```
rails db:create
rails db:migrate
rails db:seed
```

5. Ejecución del servidor  
Una vez configurada la base de datos, puedes iniciar el servidor de desarrollo ejecutando el siguiente comando. Esto iniciará el servidor local en http://localhost:3000, donde podrás acceder a la aplicación en tu navegador web.
```
rails server
```

### Características Clave

+ Programación de Citas:  
El sistema permite a los dueños de mascotas programar citas de manera conveniente con profesionales veterinarios. La interfaz de usuario intuitiva garantiza un proceso de reserva sin inconvenientes, mejorando la experiencia general del usuario.

+ Registro de Mascotas:  
Los dueños de mascotas pueden registrar a sus animales en la plataforma, proporcionando detalles esenciales como historial médico, raza y registros de vacunación. Esta función ayuda a mantener una base de datos integral de pacientes

+ Autenticación y Autorización de Usuarios:  
Para garantizar la seguridad de los datos y la privacidad, la aplicación incorpora mecanismos robustos de autenticación y autorización de usuarios. Se definen niveles de acceso para gestionar eficazmente los diferentes roles dentro del sistema.

+ Tablero Interactivo:  
El tablero proporciona a los usuarios una vista centralizada de las citas próximas, actividades recientes e información esencial relacionada con las mascotas. Esta característica agiliza la navegación y mejora la participación del usuario.

+ Recordatorios Automatizados:  
Para mejorar la asistencia a las citas, el sistema incluye un sistema automatizado de recordatorios. Los usuarios reciben notificaciones oportunas sobre las citas próximas, contribuyendo a un servicio veterinario más organizado y eficiente.