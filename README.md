# MongoDb

## Available Languages

- [English](README.md)
- [Español](README_es.md)

## Description

This project creates a MongoDB Docker container and imports a bunch of data at creation using a Docker Compose file and a Dockerfile.

## Prerequisites

Before you begin, ensure that you have the following installed on your system:

- Docker
- Docker Compose

## Getting Started

1. Clone the repository to your local machine.
2. Navigate to the project directory.
3. Open a terminal window and run the following command:

   ```bash
   docker-compose up -- build
   ```

   This will start the MongoDB container and import the data into it. You should see logs in your terminal showing the progress of the import process.

4. Once the import process is complete, you can access the MongoDB container using the following command:

   ```bash
   docker-compose exec mongodb mongo -u root -p example
   ```

   This will open the MongoDB shell and log in using the root user and example password.

5. To create a new user in the database, run the following commands in the MongoDB shell:

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

   This will create a new user with the username `microstrategy`, password `password`, and `readWrite` role for the `mflix` database. You can use this user to connect to the MongoDB database from MicroStrategy.

6. To stop the container, use the following command:

   ```bash
   docker-compose down
   ```

## Docker Compose Configuration

The `docker-compose.yml` file contains the configuration for the MongoDB container and the mongo-seed service that imports the data. Here's an explanation of the different sections:

- **mongodb**: This service uses the `mongo:6.0.5` image and sets up a volume to persist the database data. It also exposes port 27017 and sets up environment variables for the root username, password, and database name.
- **mongo_seed**: This service builds a Docker image from the `Dockerfile` in the current directory, copies the `mongo-seed` directory into the container, and runs the `import.sh` script.
- **mongo-express**: This service uses the `mongo-express` image to provide a web-based interface for managing the MongoDB database.

## Dockerfile Configuration

The `Dockerfile` is used to build the `mongo-seed` image. Here's an explanation of the different sections:

- **FROM**: This specifies the base image to use, which is `mongo:6.0.5`.
- **WORKDIR**: This sets the working directory to `/mongo-seed`.
- **COPY**: This copies the contents of the `mongo-seed` directory into the container.
- **RUN**: This runs the `chmod +x import.sh` command to make the `import.sh` script executable.
- **CMD**: This sets the default command to run when the container starts, which is to run the `import.sh` script.

## Connecting to MongoDB in a MicroStrategy dossier

To connect to the MongoDB database from a dossier in MicroStrategy, follow these steps:

1. Open MicroStrategy Workstation and click `Create Local Dossier`.
2. In the `DATASETS` panel, select `Add New Data` > `New Data` and select `MongoDB` as the data source type.
3. Add a new `DATA SOURCE`.
4. In the "Connection" window, enter the following information:

   - Host: the IP address of the MongoDB container, for example, `localhost`.
   - Port: the port on which MongoDB is running, default is `27017`.
   - Authentication: select "Username and password" and enter the credentials of the `microstrategy` user we created earlier in step 5 of the previous section.
   - Database: enter `mflix` as the database name.

5. Select the available tables and click `Finish`.
6. You can now start working with MongoDB data in MicroStrategy.
