terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0"
    }
  }
}

# Docker provider (Windows Docker Desktop connects through a named pipe)
provider "docker" {
  host = "npipe:////./pipe/docker_engine"
}

# Pull the nginx image
resource "docker_image" "nginx" {
  name         = "nginx:latest"
  keep_locally = false
}

# Create a container from that image (depends on the image above)
resource "docker_container" "nginx" {
  name  = "terraform-nginx"
  image = docker_image.nginx.image_id

  ports {
    internal = 80
    external = 8085
  }
}

output "container_name" {
  value = docker_container.nginx.name
}

output "app_url" {
  value = "http://localhost:8085"
}
