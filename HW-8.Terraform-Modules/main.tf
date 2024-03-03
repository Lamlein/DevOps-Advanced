module "ec2" {
  depends_on            = [module.networking]
  source                = "./ec2"
  public_instance_type  = "t2.micro"
  private_instance_type = "t2.micro"
  public_subnet_id      = module.networking.public_subnet_id
  private_subnet_id     = module.networking.private_subnet_id
}


module "networking" {
  source = "./networking"
  # vpc_cidr            = "10.0.0.0/16"
  # private_subnet_cidr = "10.0.101.0/24"
  # public_subnet_cidr  = "10.0.1.0/24"
  vpc_cidr            = var.vpc_cidr
  private_subnet_cidr = var.private_subnet_cidr
  public_subnet_cidr  = var.public_subnet_cidr

}
