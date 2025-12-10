variable "azure_region" {
  type        = string
  description = "AWS region to deploy into"
  default     = "Canada Central"
}
variable "resource_group" {
  type        = string
  description = "Name of the resource group"
  default     = "metroc-resource-group"
}
variable "nsg" {
  type        = string
  description = "Name of the network security group"
  default     = "metroc-nsg"
}
variable "vnet" {
  type        = string
  description = "Name of the virtual network"
  default     = "metroc-virtual-network"
}
variable "address_space" {
  type        = list(string)
  description = "Address space for the virtual network"
  default     = ["10.0.0.0/16"]
}
variable "dmz_subnet_cidr" {
  type        = list(string)
  description = "DNS servers for the virtual network"
  default     = ["10.0.1.0/24"]
}
variable "web_subnet_cidr" {
  type        = list(string)
  description = "Web subnet CIDR block"
  default     = ["10.0.2.0/24"]
}
variable "app_subnet_cidr" {
  type        = list(string)
  description = "App subnet CIDR block"
  default     = ["10.0.3.0/24"]
}
variable "db_subnet_cidr" {
  type        = list(string)
  description = "DB subnet CIDR block"
  default     = ["10.0.4.0/24"]
}
variable "firewall_subnet_cidr" {
  type        = list(string)
  description = "Firewall subnet CIDR block"
  default     = ["10.0.5.0/24"]
}

variable "bastion_subnet_cidr" {
  type        = list(string)
  description = "Bastion subnet CIDR block"
  default     = ["10.0.6.0/24"]
}
variable "bastion_public_ip" {
  type        = string
  description = "Name of the bastion public IP"
  default     = "metrocpip"
}
variable "bastion_host_name" {
  type        = string
  description = "Name of the bastion host"
  default     = "bastion-host"
}
variable "firewall_public_ip_name" {
  type        = string
  description = "Name of the firewall public IP"
  default     = "firewall-pip"
}
variable "firewall_name" {
  type        = string
  description = "Name of the firewall"
  default     = "metroc-firewall"
}
variable "dmz_lb_public_ip" {
  type        = string
  description = "Name of the load balancer public IP"
  default     = "PublicIPForLB"
}
variable "dmz_lb" {
  type        = string
  description = "Name of the load balancer"
  default     = "metroc-dmz-loadbalancer"
}

variable "web_network_interface" {
  type        = string
  description = "Name of the web VM network interface"
  default     = "web-vm-nic"
}
variable "web_vm" {
  type        = string
  description = "Name of the web VM"
  default     = "web-vm"
}
variable "app_network_interface" {
  type        = string
  description = "Name of the app VM network interface"
  default     = "app-vm-nic"
}
variable "app_vm" {
  type        = string
  description = "Name of the app VM"
  default     = "app-vm"
}
variable "db_server" {
  type        = string
  description = "Name of the database server"
  default     = "metroc-sqlserver"
}
variable "db_name" {
  type        = string
  description = "Name of the database"
  default     = "metroc-db"

}
variable "db_username" {
  type        = string
  description = "Database admin username"
  default     = "adminuser"
}
variable "db_password" {
  type        = string
  description = "Database admin password"
  default     = "Passw0rd@1234!"
}

variable "vm_sizes" {
  description = "Preferred VM sizes"
  type        = list(string)
  default     = ["Standard_D2s_v3", "Standard_B2ms", "Standard_DS2_v2", "Standard_B16ms", "Standard_F4s_v2"]
}
