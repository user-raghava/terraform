# data source to fetch the latest Amazon Linux 2 AMI
data "aws_ami" "amazon_linux" {
  most_recent = true

  owners = ["amazon"]
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}

# EC2 instance resource
resource "aws_instance" "web_server" {
  ami                         = data.aws_ami.amazon_linux.id
  instance_type               = var.instance_type
  subnet_id                   = var.subnet_id
  vpc_security_group_ids      = var.security_group_ids
  associate_public_ip_address = var.associate_public_ip
  key_name                    = var.key_name
  user_data                   = var.user_data


  root_block_device {
    volume_size           = var.root_volume_size
    volume_type           = var.root_volume_type
    delete_on_termination = true
  }

  tags = var.tags
}

# Provisioner to install software on the EC2 instance after creation
resource "null_resource" "install_software" {
  triggers = {
    always_run = timestamp() # Force re-provisioning on every terraform apply
  }

  connection { # SSH connection details to the EC2 instance
    type        = "ssh"
    host        = aws_instance.web_server.public_ip
    user        = "ec2-user"
    private_key = file("~/.ssh/id_ed25519") # Path to your private key file
  }

  provisioner "remote-exec" {
    inline = [
      "sudo yum install -y httpd", # Install Apache HTTP server
      "sudo systemctl start httpd",
      "sudo systemctl enable httpd",
      "sudo yum install tree -y"

    ]
  }
}
