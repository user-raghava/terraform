output "primary_vpc_id" {
  value = module.primary_vpc.vpc_id
}

output "primary_public_subnet_ids" {
  value = module.primary_vpc.public_subnet_ids
}

output "secondary_vpc_id" {
  value = module.secondary_vpc.vpc_id
}

output "secondary_private_subnet_ids" {
  value = module.secondary_vpc.private_subnet_ids

}