output "public_ip" {
  value = format("http://%s", module.primary_vm.vm_public_ip) # vm_public_ip is derived from modules/linux-vm/outputs.tf
}