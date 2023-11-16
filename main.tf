terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "3.0.2"
    }
  }
}

provider "docker" {
  host = "unix:///var/run/docker.sock"
}

locals {
  files_dir                             = "${abspath(path.root)}/files"
  pg_dockerfile_context                 = "${local.files_dir}/pg"
  bot_dockerfile_context                = "${local.files_dir}/discord-bot"
  seen_places_dockerfile_context        = "${local.files_dir}/seen-places"
  seen_places_garmin_dockerfile_context = "${local.seen_places_dockerfile_context}/formatHandlers/garmin"
  seen_places_gopro_dockerfile_context  = "${local.seen_places_dockerfile_context}/formatHandlers/gopro"
}
