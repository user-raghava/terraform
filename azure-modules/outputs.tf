output "vnet_id" {
  value = module.primary_vnet.vnet_id # vnet_id is derived from modules/vnet/outputs.tf
}

output "subnet_ids" {
  value = module.primary_vnet.subnet_ids # subnet_ids is derived from modules/vnet/outputs.tf
}

output "public_ip" {
  value = module.primary_vm.vm_public_ip # vm_public_ip is derived from modules/linux-vm/outputs.tf
}