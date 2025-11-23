output "vnet_id" {
  value = module.primary_vnet.vnet_id # vnet_id is derived from modules/vnet/outputs.tf
}

output "subnet_ids" {
  value = module.primary_vnet.subnet_ids # subnet_ids is derived from modules/vnet/outputs.tf
}