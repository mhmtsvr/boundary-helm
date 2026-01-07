variable "boundary_addr" {
  type      = string
  sensitive = true
  default   = "http://localhost:9200/"
}

variable "boundary_username" {
  type      = string
  sensitive = true
  default   = "admin"
}

variable "boundary_password" {
  type      = string
  sensitive = true
}
