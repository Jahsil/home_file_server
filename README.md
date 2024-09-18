# Home File Server

A **Laravel-based** backend application that serves files for download. The application is containerized using **Docker** and utilizes **Nginx** as a reverse proxy to forward requests to **PHP-FPM** for handling. This setup efficiently manages and serves files, making it a simple, self-hosted file server for your personal or home network.

## Features

-   Download files through a REST API.
-   Serves static files via Laravel.
-   Containerized using Docker for easy deployment.
-   Nginx reverse proxy setup for efficient handling of requests.
-   PHP-FPM for improved performance with PHP.

## Requirements

Before you begin, ensure you have the following:

-   **Docker** and **Docker Compose** installed.
-   A basic understanding of Docker containers and networking.

## Setup and Installation

### 1. Clone the Repository

```bash
git clone https://github.com/your-username/home-file-server.git
cd home-file-server
```

### 2. Environment Setup

Copy the .env.example to .env:

```bash
cp .env.example .env
```

Edit the .env file to configure the database and other settings. For example, if using SQLite:

```bash
DB_CONNECTION=sqlite
DB_DATABASE=/var/www/html/database/database.sqlite

```

### 3. Build and Run the Containers

Build and run the Docker containers:

```bash
docker build -t home-file-server .
docker run -d \
  --name laravel-app \
  -v $(pwd):/var/www/html \
  home-file-server
```

Now run the Nginx container to proxy requests to Laravel:

```bash
docker run -d \
  --name nginx \
  -p 80:80 \
  --link laravel-app:app \
  -v $(pwd)/nginx.conf:/etc/nginx/nginx.conf \
  nginx:latest
```

### 4. Migrate the Database

Once the Laravel container is running, run the database migrations to create the necessary tables:

```bash
docker exec -it laravel-app php artisan migrate
```

### 5. File Storage Permissions

Ensure the correct file permissions for the storage and bootstrap/cache directories:

```bash
docker exec -it laravel-app bash
chmod -R 777 storage
chmod -R 777 bootstrap/cache
```

### 6. Access the Application

Your Laravel application should now be running and accessible at http://localhost.

You can upload files to the /storage directory and serve them for download via API routes.

## Nginx Configuration

The following is a sample Nginx configuration (nginx.conf) used to proxy requests to PHP-FPM in the Laravel container:

```bash
server {
    listen 80;
    server_name localhost;

    root /var/www/html/public;
    index index.php index.html;

    location / {
        try_files $uri $uri/ /index.php?$query_string;
    }

    location ~ \.php$ {
        fastcgi_pass app:9000;
        fastcgi_index index.php;
        fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
        include fastcgi_params;
    }
}
```

Make sure this file is placed in the root of your project.

## API Endpoints

List all Files
To see all the files available, send a GET request to:

```bash
GET /files
```

Download a File
To download a file, send a GET request to:

```bash
GET /files/{filename}
```

Example:

````bash
curl -O http://localhost/api/files/sample.txt
```bash
````

## Contributing

Feel free to open issues or submit pull requests for improvements. Contributions are always welcome!

## License

This project is licensed under the MIT License. See the LICENSE file for more details.

```bash
This is fully formatted for GitHub, with headers (`#`), code blocks, and sections as you requested!
```
