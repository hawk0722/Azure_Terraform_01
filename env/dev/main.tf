module "rg" {
  source = "../../modules/rg"

  location = var.location
  env      = var.env
  code     = var.code
}

module "vnet" {
  source = "../../modules/vnet"

  location = var.location
  env      = var.env
  code     = var.code
  cidr     = var.cidr

  rg_name = module.rg.rg_name
}

module "st" {
  source = "../../modules/st"

  location = var.location
  env      = var.env
  code     = var.code

  rg_name = module.rg.rg_name
}

module "pep" {
  source = "../../modules/pep"

  location = var.location
  env      = var.env
  code     = var.code

  rg_name     = module.rg.rg_name
  vnet_id     = module.vnet.vnet_id
  snet_pep_id = module.vnet.snet_pep_id
  st_name     = module.st.st_name
  st_id       = module.st.st_id
}
