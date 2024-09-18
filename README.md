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
