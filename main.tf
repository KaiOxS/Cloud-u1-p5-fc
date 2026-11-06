# Configuración del proveedor de AWS
provider "aws" {
  region = "us-east-1" #región donde se desplegarán los recursos
}

# Creamos el security group
resource "aws_security_group" "mi-sg" {
  name        = "mi-security-group-terraform"
  description = "Security Group para mi instancia de terraform"
  vpc_id      = "vpc-0b00fca964fd3d8d5"

  #Regla de entrada para SSH
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  #Regla de salida para HTTP
  egress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Declaración de los recursos de aws
resource "aws_instance" "mi_instancia_2" {
  ami           = "ami-0c230065b91270bc6" # ID de la imagen de amazon linux
  instance_type = "t2.micro"              # Tipo de instancia 
  key_name      = "mi-primera-llaves-fc"  # Nombre del par de claves para acceder a la instancia
  tags = {
    Name = "MiInstanciaTerraform2" # Etiqueta para identificar a la instancia
  }
  vpc_security_group_ids = [aws_security_group.mi-sg.id] # Asignamos el secturity group a la instancia y listo xD
}
