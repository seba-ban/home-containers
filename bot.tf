resource "docker_image" "bot" {
  name = "oldguardbot"
  build {
    context = local.bot_dockerfile_context
  }

  triggers = {
    dir_sha1 = local.bot_dir_sha1
  }
}

resource "docker_container" "bot" {
  name  = "oldguardbot"
  image = docker_image.bot.image_id

  restart = "unless-stopped"

  env = [
    "BOT_TOKEN=${var.bot_token}",
    "DB_USER=${var.bot_db_user}",
    "DB_PASSWORD=${var.bot_db_pass}",
    "DB_HOST=${var.bot_db_host}",
    "DB_PORT=${var.bot_db_port}",
    "DB_DB=${var.bot_db_db}",
  ]
}

