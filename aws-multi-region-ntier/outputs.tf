output "primary_public_ip" {
  value = format("http://%s", module.primary_web_server.public_ip) # format the public IP as a URL
}

