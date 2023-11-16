# BOT variables
variable "bot_token" {
  type = string
}
variable "bot_db_user" {
  type = string
}
variable "bot_db_pass" {
  type = string
}
variable "bot_db_host" {
  type = string
}
variable "bot_db_port" {
  type    = number
  default = 5432
}
variable "bot_db_db" {
  type = string
}

# MINIO variables
variable "minio_host_path" {
  type = string
}
variable "minio_root_user" {
  type = string
}
variable "minio_root_password" {
  type = string
}

# NGINX variables
variable "nginx_mount_host_path" {
  type = string
}
variable "nginx_smb_host_path" {
  type = string
}
variable "nginx_conf_host_path" {
  type = string
}
variable "nginx_mime_host_path" {
  type = string
}

# POSTGRES variables
variable "postgres_password" {
  type = string
}
variable "postgres_volume_host_path" {
  type = string
}

# RABBITMQ
variable "rabbitmq_root_user" {
  type = string
}
variable "rabbitmq_root_password" {
  type = string
}
variable "rabbitmq_host_path" {
  type = string
}

# SEEN PLACES
variable "seen_places_storage_host_dir" {
  type = string
}
variable "seen_places_storage_tmp_dir" {
  type = string
}

variable "seen_places_db_user" {
  type = string
}
variable "seen_places_db_password" {
  type = string
}
variable "seen_places_db_host" {
  type = string
}
variable "seen_places_db_port" {
  type = string
}
variable "seen_places_db_name" {
  type = string
}
variable "seen_places_db_sslmode" {
  type = string
}
variable "seen_places_broker_host" {
  type = string
}
variable "seen_places_broker_port" {
  type = string
}
variable "seen_places_broker_user" {
  type = string
}
variable "seen_places_broker_password" {
  type = string
}
variable "seen_places_s3_raw_files_bucket" {
  type = string
}
variable "seen_places_s3_access_key" {
  type = string
}
variable "seen_places_s3_secret_key" {
  type = string
}
variable "seen_places_s3_endpoint_url" {
  type = string
}
variable "seen_places_garmin_queue" {
  type = string
}
variable "seen_places_gopro_queue" {
  type = string
}
variable "seen_places_points_queue" {
  type = string
}