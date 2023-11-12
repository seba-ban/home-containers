resource "docker_image" "nginx" {
  name = "nginx:1.25.2"
}

resource "docker_container" "nginx" {
  name  = "nginx"
  image = docker_image.nginx.image_id

  restart = "unless-stopped"

  volumes {
    container_path = "/mount"
    host_path      = var.nginx_mount_host_path
  }
  volumes {
    container_path = "/smb"
    host_path      = var.nginx_smb_host_path
  }
  volumes {
    container_path = "/etc/nginx/conf.d/default.conf"
    host_path      = var.nginx_conf_host_path
  }
  volumes {
    container_path = "/etc/nginx/mime.types"
    host_path      = var.nginx_mime_host_path
  }

  ports {
    internal = 80
    external = 80
  }

}

