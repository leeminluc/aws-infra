resource "aws_instance" "k3s_server" {
  ami                    = "ami-0884d2865dbe9de4b"
  instance_type          = "t2.micro"  # Free-tier
  key_name               = "leeminluc-ssh"
  associate_public_ip_address = true
  security_groups = [aws_security_group.k3s_sg.name]
  user_data = <<-EOF
              #!/bin/bash
              curl -sfL https://get.k3s.io | sh -
              echo "export KUBECONFIG=/etc/rancher/k3s/k3s.yaml" >> /home/ubuntu/.bashrc
              chown ubuntu:ubuntu /etc/rancher/k3s/k3s.yaml
              EOF
  tags = {
    Name = "k3s-server"
  }
}
resource "aws_security_group" "k3s_sg" {
  name        = "k3s_sg"
  description = "Allow Kubernetes traffic"
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # SSH Access (restrict this in production)
  }
  ingress {
    from_port   = 6443
    to_port     = 6443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Kubernetes API Access (optional)
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
output "instance_public_ip" {
  value = aws_instance.k3s_server.public_ip
}