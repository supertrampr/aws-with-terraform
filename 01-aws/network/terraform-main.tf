module "network" {
  source = "../modules/aws/network"

  owner                      = var.owner
  aws_region                 = var.aws_region
  region_code                = "euc1"
  vpc_cidr_block             = "172.16.0.0/21"
  subnets_availability_zones = data.aws_availability_zones.available.names
  private_subnets_cidr_block = var.private_subnets_cidr_block
  public_subnets_cidr_block  = var.public_subnets_cidr_block
}