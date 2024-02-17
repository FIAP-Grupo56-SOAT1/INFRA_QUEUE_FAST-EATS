variable "region" {
  description = "Região onde s recursos serão criados"
  type        = string
  default     = "us-east-1"
}

variable "owner" {
  description = "Dono da conta"
  type        = string
  default     = "fasteats"
}

variable "managedby" {
  description = "Quem gerencia gerenciado"
  type        = string
  default     = "terraform"
}

variable "db_password_pedido" {
  description = "Database pedido password"
  default = "password"
  type = string
  sensitive = false
}

variable "db_name_pedido" {
  default = "dbname"
  description = "Database name"
  type = string
  sensitive = false
}