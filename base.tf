# Microsoft Azure Provider
provider "azurerm" {
  # If using a service principal, fill in details here
}

variable "ssh_key" {
  type = "string"
}

# This is the primary username used to administer the machine
variable "admin_username" {
  type    = "string"
  default = "azureuser"
}

variable "instance_prefix" {
  default = "sv"
}

variable "shared_prefix" {
  default = "ha"
}

variable "solution_name" {
  default = "acme-backend-ha"
}

variable "ssh_port" {
  default = "22"
}

variable "location" {
  default = "West Europe"
}

variable "standard_vm_size" {
  default = "Standard_B1s"
}

variable "storage_type" {
  default = "Premium_LRS"
}

locals {
  resource_group_name = "${var.solution_name}-ilb"
  layer_name          = "backend"

  tags = {
    environment = "testing"
    layer_name  = "${local.layer_name}"
    solution    = "${var.solution_name}"
  }

  vnet_name                    = "${var.solution_name}"
  vnet_address_space           = "10.0.0.0/16"
  client_subnet_name           = "default"
  client_subnet_address_prefix = "10.0.0.0/24"
  server_subnet_name           = "servers"
  server_subnet_address_prefix = "10.0.1.0/24"
}

# Resource group
resource "azurerm_resource_group" "rg" {
  name     = "${local.resource_group_name}"
  location = "${var.location}"
  tags     = "${merge(local.tags, map("provisionedBy", "terraform"))}"
}

# Networking
resource "azurerm_virtual_network" "vnet" {
  name                = "${local.vnet_name}"
  location            = "${azurerm_resource_group.rg.location}"
  address_space       = ["${local.vnet_address_space}"]
  resource_group_name = "${azurerm_resource_group.rg.name}"
  tags                = "${local.tags}"
}

resource "azurerm_subnet" "default" {
  name                 = "${local.client_subnet_name}"
  virtual_network_name = "${azurerm_virtual_network.vnet.name}"
  resource_group_name  = "${azurerm_resource_group.rg.name}"
  address_prefix       = "${local.client_subnet_address_prefix}"
}

resource "azurerm_subnet" "servers" {
  name                 = "${local.server_subnet_name}"
  virtual_network_name = "${azurerm_virtual_network.vnet.name}"
  resource_group_name  = "${azurerm_resource_group.rg.name}"
  address_prefix       = "${local.server_subnet_address_prefix}"
}


# Generate random text for a unique storage account name
resource "random_id" "pseudo" {
  keepers = {
    resource_group = "${azurerm_resource_group.rg.name}"
    location       = "${azurerm_resource_group.rg.location}"
  }

  byte_length = 4
}

resource "azurerm_storage_account" "diagnostics" {
  name                     = "${var.shared_prefix}diag${random_id.pseudo.hex}"
  location                 = "${azurerm_resource_group.rg.location}"
  resource_group_name      = "${azurerm_resource_group.rg.name}"
  account_replication_type = "LRS"
  account_tier             = "Standard"
  tags                     = "${local.tags}"
}


#--- Client ---

data "template_file" "client_config" {
  template = "${file("${path.module}/cloud-config/client.yml.tpl")}"

  vars {
    ssh_port       = "${var.ssh_port}"
    ssh_key        = "${var.ssh_key}"
    admin_username = "${var.admin_username}"
  }
}

# This is the client machine. 
module "client" {
  source = "./linux"

  name                = "client"
  vm_size             = "${var.standard_vm_size}"
  location            = "${var.location}"
  resource_group_name = "${azurerm_resource_group.rg.name}"
  admin_username      = "${var.admin_username}"
  ssh_key             = "${var.ssh_key}"
  ssh_port            = "${var.ssh_port}"

  // this is something that annoys me - passing the resource would be nicer
  diag_storage_name                  = "${azurerm_storage_account.diagnostics.name}"
  diag_storage_primary_blob_endpoint = "${azurerm_storage_account.diagnostics.primary_blob_endpoint}"
  diag_storage_primary_access_key    = "${azurerm_storage_account.diagnostics.primary_access_key}"
  availability_set_id                = "" 
  subnet_id                          = "${azurerm_subnet.default.id}"
  storage_type                       = "${var.storage_type}"
  tags                               = "${local.tags}"
  cloud_config                       = "${base64encode(data.template_file.client_config.rendered)}"
}

#--- Servers ---

resource "azurerm_availability_set" "servers" {
  name                = "${var.shared_prefix}-${local.layer_name}-avset"
  location            = "${azurerm_resource_group.rg.location}"
  resource_group_name = "${azurerm_resource_group.rg.name}"
  managed             = true
  tags                = "${local.tags}"
}
data "template_file" "server_config" {
  template = "${file("${path.module}/cloud-config/server.yml.tpl")}"

  vars {
    ssh_port       = "${var.ssh_port}"
    ssh_key        = "${var.ssh_key}"
    admin_username = "${var.admin_username}"
  }
}
module "backend1" {
  source = "./linux"

  name                = "${var.instance_prefix}-backend1"
  vm_size             = "${var.standard_vm_size}"
  location            = "${var.location}"
  resource_group_name = "${azurerm_resource_group.rg.name}"
  admin_username      = "${var.admin_username}"
  ssh_key             = "${var.ssh_key}"
  ssh_port            = "${var.ssh_port}"

  // this is something that annoys me - passing the resource would be nicer
  diag_storage_name                  = "${azurerm_storage_account.diagnostics.name}"
  diag_storage_primary_blob_endpoint = "${azurerm_storage_account.diagnostics.primary_blob_endpoint}"
  diag_storage_primary_access_key    = "${azurerm_storage_account.diagnostics.primary_access_key}"
  availability_set_id                = "${azurerm_availability_set.servers.id}"
  subnet_id                          = "${azurerm_subnet.servers.id}"
  storage_type                       = "${var.storage_type}"
  tags                               = "${local.tags}"
  cloud_config                       = "${base64encode(data.template_file.server_config.rendered)}"
}


module "backend2" {
  source = "./linux"

  name                = "${var.instance_prefix}-backend2"
  vm_size             = "${var.standard_vm_size}"
  location            = "${var.location}"
  resource_group_name = "${azurerm_resource_group.rg.name}"
  admin_username      = "${var.admin_username}"
  ssh_key             = "${var.ssh_key}"
  ssh_port            = "${var.ssh_port}"

  // this is something that annoys me - passing the resource would be nicer
  diag_storage_name                  = "${azurerm_storage_account.diagnostics.name}"
  diag_storage_primary_blob_endpoint = "${azurerm_storage_account.diagnostics.primary_blob_endpoint}"
  diag_storage_primary_access_key    = "${azurerm_storage_account.diagnostics.primary_access_key}"
  availability_set_id                = "${azurerm_availability_set.servers.id}"
  subnet_id                          = "${azurerm_subnet.servers.id}"
  storage_type                       = "${var.storage_type}"
  tags                               = "${local.tags}"
  cloud_config                       = "${base64encode(data.template_file.server_config.rendered)}"
}


###--- Load Balancer ---

resource "azurerm_lb" "ha" {
  name                = "${local.layer_name}-lb"
  location            = "${var.location}"
  resource_group_name = "${azurerm_resource_group.rg.name}"
  sku                 = "Standard"

 frontend_ip_configuration {
    name                          = "ha"
    subnet_id                     = "${azurerm_subnet.default.id}" # the endpoint is on the client subnet
    private_ip_address_allocation = "dynamic" # just so that we don't have to manually allocate one
  }
}

## TODO: document the options here

resource "azurerm_lb_rule" "ha" {
  resource_group_name            = "${azurerm_resource_group.rg.name}"
  loadbalancer_id                = "${azurerm_lb.ha.id}"
  name                           = "${local.layer_name}-ha-rule"
  protocol                       = "All"
  frontend_port                  = 0
  backend_port                   = 0
  frontend_ip_configuration_name = "ha"
  probe_id                       = "${azurerm_lb_probe.ha.id}"
  backend_address_pool_id        = "${azurerm_lb_backend_address_pool.ha.id}"
}

resource "azurerm_lb_backend_address_pool" "ha" {
  resource_group_name = "${azurerm_resource_group.rg.name}"
  loadbalancer_id     = "${azurerm_lb.ha.id}"
  name                = "ha-pool"
}

resource "azurerm_network_interface_backend_address_pool_association" "server1" {
  network_interface_id    = "${module.backend1.virtual_machine_nic}"
  ip_configuration_name   = "${module.backend1.virtual_machine_ip_configuration}"
  backend_address_pool_id = "${azurerm_lb_backend_address_pool.ha.id}"
}

resource "azurerm_network_interface_backend_address_pool_association" "server2" {
  network_interface_id    = "${module.backend2.virtual_machine_nic}"
  ip_configuration_name   = "${module.backend2.virtual_machine_ip_configuration}"
  backend_address_pool_id = "${azurerm_lb_backend_address_pool.ha.id}"
}

resource "azurerm_lb_probe" "ha" {
  resource_group_name = "${azurerm_resource_group.rg.name}"
  loadbalancer_id     = "${azurerm_lb.ha.id}"
  name                = "http-running-probe"
  port                = 80
  protocol            = "http"
  request_path        = "/hostname"
  interval_in_seconds = 5
  number_of_probes    = 2 # number_of_probes * interval_in_seconds >= 10
}