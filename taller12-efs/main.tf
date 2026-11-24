provider "aws" {
  region = var.region
}

# Creamos el security group
resource "aws_security_group" "mi-sg-efs-instancias" {
  name        = "mi-security-group-terraform-efs-instancias"
  description = "Security Group para mi instancia de terraform"
  vpc_id      = "vpc-0b00fca964fd3d8d5"

  #Regla de entrada para SSH
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  #Regla de salida para HTTP
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 2049
    to_port     = 2049
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Creamos el security group 2 
resource "aws_security_group" "mi-sg-efs" {
  name        = "mi-security-group-terraform-efs"
  description = "Security Group para mi instancia de terraform"
  vpc_id      = "vpc-0b00fca964fd3d8d5"

  #Regla de entrada para SSH
  ingress {
    from_port   = 2049
    to_port     = 2049
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Declaración de los recursos de aws efs
resource "aws_instance" "mi_instancia_efs" {
  ami             = var.ami_id         # ID de la imagen de amazon linux
  instance_type   = var.tipo_instancia # Tipo de instancia 
  key_name        = var.nombre_llave   # Nombre del par de claves para acceder a la instancia
  security_groups = [aws_security_group.mi-sg-efs-instancias.name]
  count           = var.cantidad_instancias
  tags = {
    Name = "Mi instancia EFS - ${count.index + 1}" # Etiqueta para identificar a la instancia
  }
  vpc_security_group_ids = [aws_security_group.mi-sg-efs-instancias.id] # Asignamos el secturity group a la instancia
}
