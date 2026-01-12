
# DotNet Crud Web Api Example

 A RESTful Web API using ASP.NET Core in .NET 8.0 alongside Entity Framework Core. 
 
 This project demonstrates a simple CRUD (Create, Read, Update, Delete) operation on movies, utilizing a SQLite database to persist data.

## Prerequisites

Before you begin, ensure you have the following installed:
- .NET 8.0 SDK
- Entity Framework Core CLI

You can install the EF Core CLI tool globally using:

```bash
dotnet tool install --global dotnet-ef
```

## Getting Started

To get a local copy up and running follow these simple steps:

1. **Clone the repository**

   ```bash
   git clone https:/github.com/Scribbio/DotNet-8-Crud-Web-API-Example.git
   ```

2. **Navigate to the project directory**

   ```bash
   cd DotNetCrudWebApi
   ```

3. **Install necessary packages**

   Make sure all the required NuGet packages are restored:

   ```bash
   dotnet restore
   ```

4. **Run Migrations**

   Apply the database migrations to set up your database schema:

   ```bash
   dotnet ef database update
   ```

   If your EF Core context and migrations are in a different project, specify the projects as follows:

   ```bash
   dotnet ef database update --project YourEFCoreProject --startup-project YourStartupProject
   ```

## Usage

Start the API locally by running:

```bash
dotnet run
```

Your API will be available at `http://localhost:5000` by default.

### API Endpoints

The following endpoints are available:

- `GET /api/Movies`: Retrieves a list of all movies.
- `GET /api/Movies/{id}`: Retrieves a specific movie by its ID.
- `POST /api/Movies`: Adds a new movie.
- `PUT /api/Movies/{id}`: Updates an existing movie.
- `DELETE /api/Movies/{id}`: Deletes a specific movie.

## License

Distributed under the MIT License. See `LICENSE` for more information.

------------------------------------------------------------------------------------------

### Run the application
Use Docker Compose to build and start the application. This command will compile the code, create the Docker image, and start the container.

```bash
docker-compose up --build
```

### Access the API
Once the container is running, you can access the Swagger UI to test the endpoints:

```bash
http://localhost:8080/swagger
```

### Database (SQLite)

The application uses SQLite. A data folder will be created in your project root automatically. This folder is mapped to the container, ensuring that your data persists even if you stop the container.

### Stopping the application

To stop the application, press Ctrl+C in the terminal, or run:

```bash
docker-compose down
```

### Video Report

Link on video-report related to this work: https://youtu.be/oaJIemjqQmw

------------------------------------------------------------------------------------------
