# MongoDb

## Lenguas disponibles

- [Inglés](README.md)
- [Español](README_es.md)

## Descripción

Este proyecto crea un contenedor de MongoDB Docker e importa un montón de datos en la creación utilizando un archivo Docker Compose y un Dockerfile.

## Requisitos previos

Antes de comenzar, asegúrese de tener instalados los siguientes elementos en su sistema:

- Docker
- Docker Compose

## Empezando

1. Clone el repositorio en su máquina local.
2. Navegue hasta el directorio del proyecto.
3. Abra una ventana de terminal y ejecute el siguiente comando:

   ```bash
   docker-compose up -- build
   ```

   Esto iniciará el contenedor MongoDB e importará los datos en él. Debería ver registros en su terminal que muestren el progreso del proceso de importación.

4. Una vez que se complete el proceso de importación, puede acceder al contenedor MongoDB usando el siguiente comando:

   ```bash
   docker-compose exec mongodb mongo -u root -p example
   ```

   Esto abrirá la consola de MongoDB e iniciará sesión usando el usuario root y la contraseña example.

5. Para crear un nuevo usuario en la base de datos, ejecuta los siguientes comandos en la consola de MongoDB:

   ```js
   use mflix

   db.createUser({
       user: 'microstrategy',
       pwd: 'password',
       roles: [
           {
               role: 'readWrite',
               db: 'mflix',
           },
       ],
   });
   ```

   Esto creará un nuevo usuario con el nombre de usuario `microstrategy`, la contraseña `password` y el rol de `readWrite` para la base de datos `mflix`. Se puede usar este usuario para conectarte a la base de datos de MongoDB desde MicroStrategy.

6. Para detener el contenedor, use el siguiente comando:

   ```bash
   docker-compose down
   ```

## Configuración de Docker Compose

El archivo `docker-compose.yml` contiene la configuración del contenedor MongoDB y el servicio `mongo-seed` que importa los datos. Aquí hay una explicación de las diferentes secciones:

- **mongodb**: Este servicio utiliza la imagen `mongo:6.0.5` y configura un volumen para persistir los datos de la base de datos. También expone el puerto 27017 y configura variables de entorno para el nombre de usuario root, contraseña y nombre de la base de datos.
- **mongo_seed**: Este servicio crea una imagen de Docker a partir del `Dockerfile` en el directorio actual, copia el directorio `mongo-seed` en el contenedor y ejecuta el script `import.sh`.
- **mongo-express**: Este servicio utiliza la imagen `mongo-express` para proporcionar una interfaz web para administrar la base de datos MongoDB.

## Configuración de Dockerfile

El `Dockerfile` se utiliza para crear la imagen `mongo-seed`. Aquí hay una explicación de las diferentes secciones:

- **FROM**: Esto especifica la imagen base que se utilizará, que es `mongo:6.0.5`.
- **WORKDIR**: Esto establece el directorio de trabajo en `/mongo-seed`.
- **COPY**: Esto copia el contenido del directorio `mongo-seed` en el contenedor.
- **RUN**: Esto ejecuta el comando `chmod +x import.sh` para hacer que el script `import.sh` sea ejecutable.
- **CMD**: Esto establece el comando predeterminado que se ejecutará cuando se inicie el contenedor, que es ejecutar el script `import.sh`.

## Conexión a MongoDB en un dossier en MicroStrategy

Para conectarse a la base de datos de MongoDB desde un dossier en MicroStrategy, siga estos pasos:

1. Abre MicroStrategy Workstation y haz clic en `Create Local Dossier`
2. En el panel de `DATASETS`, selecciona "Add New Data" > "New Data" y selecciona "MongoDB" como el tipo de fuente de datos.
3. Agregue un nuevo `DATA SOURCE`
4. En la ventana "Connection", introduzca la siguiente información:

   - Host: la dirección IP del contenedor de MongoDB, por ejemplo, `localhost`.
   - Port: el puerto en el que está ejecutándose MongoDB, por defecto es `27017`.
   - Authentication: seleccione "Username and password" e introduzca las credenciales del usuario `microstrategy` que creamos anteriormente en el paso 5 de la sección anterior.
   - Database: introduzca `mflix` como nombre de la base de datos.
5. Seleccione las tablas disponibres y de clic en `Finish`.
6. Ahora puedes comenzar a trabajar con los datos de MongoDB en  MicroStrategy.
