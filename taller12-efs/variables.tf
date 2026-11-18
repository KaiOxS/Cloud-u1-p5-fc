#Región donde se desplegarán los recursos
variable "region" {
  description = "The AWS Region"
  type        = string
  default     = "us-east-1" # Valor por defecto
}

variable "ami_id" {
  description = "ID de la AMI"
  type        = string
  default     = "ami-0c230065b91270bc6"
}

variable "tipo_instancia" {
  description = "Tipo de la instancia"
  type        = string
  default     = "t2.micro"
}

variable "nombre_llave" {
  description = "Nombre del par de llaves"
  type        = string
  default     = "mi-primera-llaves-fc"
}

variable "cantidad_instancias" {
  description = "Cantidad de instancias"
  type        = number
  default     = 2
}
