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