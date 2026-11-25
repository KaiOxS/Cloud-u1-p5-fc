provider "aws" {
  region = var.region
}

# Creamos el security group
resource "aws_security_group" "mi-sg-efs-instancias-14" {
  name        = "mi-security-group-terraform-efs-instancias"
  description = "Security Group para mi instancia de terraform"
  vpc_id      = "vpc-0b00fca964fd3d8d5"
}

# Creamos el security group 2 efs
resource "aws_security_group" "mi-sg-efs-14" {
  name        = "mi-security-group-terraform-efs"
  description = "Security Group para mi instancia de terraform"
  vpc_id      = "vpc-0b00fca964fd3d8d5"
}

# Reglas SG Instancias -------------------------------------
# Entrada
# SSH
resource "aws_vpc_security_group_ingress_rule" "entrada_ssh_instancias" {
  security_group_id = aws_security_group.mi-sg-efs-instancias-14.id
  ip_protocol       = "tcp"
  from_port         = 22
  to_port           = 22
  # Origen
  cidr_ipv4 = "0.0.0.0/0"
}

# Salida
# Salida NFS a EFS 2049
resource "aws_vpc_security_group_egress_rule" "salida_efs" {
  security_group_id = aws_security_group.mi-sg-efs-instancias-14.id
  ip_protocol       = "tcp"
  from_port         = 2049
  to_port           = 2049
  #Destino
  referenced_security_group_id = aws_security_group.mi-sg-efs-14.id
}

# Salida a Internet All traffic
resource "aws_vpc_security_group_egress_rule" "salida_internet" {
  security_group_id = aws_security_group.mi-sg-efs-instancias-14.id
  ip_protocol       = "-1"
  #Destino
  cidr_ipv4 = "0.0.0.0/0"
}

# Reglas SG EFS -------------------------------------
# Entrada
# Regla entrada EFS 2049
resource "aws_vpc_security_group_ingress_rule" "entrada_efs" {
  security_group_id = aws_security_group.mi-sg-efs-14.id
  ip_protocol       = "tcp"
  from_port         = 2049
  to_port           = 2049
  # Origen
  referenced_security_group_id = aws_security_group.mi-sg-efs-instancias-14.id
}

# Salida
# No se requiere reglas de salida

# Declaración de los recursos de aws efs
/*resource "aws_instance" "mi_instancia_efs" {
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
*/
