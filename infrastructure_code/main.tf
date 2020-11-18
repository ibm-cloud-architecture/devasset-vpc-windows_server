#############     ACCOUNT SET UP - Organizational structure, roles and users         ############

# Create the Resource Group that is used when deploying the VPC
resource "ibm_resource_group" "resource-group" {
  name = var.resource-group
}

#############     NETWORK INFRASTRUCTURE - VPC, subnets, ACLs, security groups          ############

# Create A VPC in default zone. 
resource "ibm_is_vpc" "vpc" {
  name           = "terraform-vpc"
  resource_group = ibm_resource_group.resource-group.id
}

# (Optional) This moves VPC from default zone to specified zone using a variable.
# This can be also be used in case default zone has reached max capacity.
resource "ibm_is_vpc_address_prefix" "address-_prefix" {
  name = "terraform-vpc-address-fix"
  zone = var.availability-zone
  vpc  = ibm_is_vpc.vpc.id
  cidr = var.address-prefix
}

# This will add new rules to default security_group created for VPC.
# Rules are stateful, which means that reverse traffic in response to 
# allowed traffic is automatically permitted. So for example, a rule 
# allowing inbound TCP traffic on port 80 also allows replying outbound 
# TCP traffic on port 80 back to the originating host, without the need 
# In this case, Inbound rules with TCP port 7000 is added.
resource "ibm_is_security_group_rule" "security_group_rule_tcp" {
  group     = ibm_is_vpc.vpc.default_security_group
  direction = "inbound"
  remote    = var.access-to-any-ip
  tcp {
    port_min = var.security-group-port
    port_max = var.security-group-port
  }
}

# This terraform script will create subnet in VPC for VM workload.
resource "ibm_is_subnet" "vpc-subnet" {
  name            = "terraform-vpc-subnet"
  vpc             = ibm_is_vpc.vpc.id
  zone            = var.availability-zone
  ipv4_cidr_block = var.subnet-cidr
  network_acl     = ibm_is_network_acl.subnetacl.id
}

# This will create a network ACL for the subnet in this resource group.
# The when the subnet is created, this ACL will be associated.
# Types of protocols available: icmp {code , type}, tcp {port_max, port_min}, udp {port_max, port_min}.
# This example has no limits
resource "ibm_is_network_acl" "subnetacl" {
  name = "subnetacl"
  rules {
    name        = "egress-upd"
    action      = "allow"
    source      = var.ACLsource-egress
    destination = var.ACLdest-egress
    direction   = "outbound"
    udp {
      port_max = var.tcp-max-port
      port_min = var.tcp-min-port
    }
  }
  rules {
    name        = "ingress-udp"
    action      = "allow"
    source      = var.ACLsource-ingress
    destination = var.ACLdest-ingress
    direction   = "inbound"
    udp {
      port_max = var.tcp-max-port
      port_min = var.tcp-min-port
    }
  }
  rules {
    name        = "egress-tcp"
    action      = "allow"
    source      = var.ACLsource-egress
    destination = var.ACLdest-egress
    direction   = "outbound"
    tcp {
      port_max = var.tcp-max-port
      port_min = var.tcp-min-port
    }
  }
  rules {
    name        = "ingress-tcp"
    action      = "allow"
    source      = var.ACLsource-ingress
    destination = var.ACLdest-ingress
    direction   = "inbound"
    tcp {
      port_max = var.tcp-max-port
      port_min = var.tcp-min-port
    }
  }
}

#############      VIRTUAL SERVER - Deploy, connect, ssh and app install with bootstrap     ############

# Create VPC ssh-key in given zone. We require ssh key for privisioning VM.
resource "ibm_is_ssh_key" "vpc-sshkey" {
  name       = "vpc-sshkey"
  public_key = var.ssh-key
}

# This terrform file has script to deploy virtual server on VPC. 
# Required attributes:
# name: name of vsi. Length 15 characters
# image: os image id.
# profile: machine type.
# subnet: vpc subnet id. e.x: "61a3af2e-a66e-4f36-a27e-e71cb537121d"
# vpc: deployed vpc id. e.x: ebfdb465-04a2-4668-a513-4f86fde6320f
# zone: zone in which vsi will be deployed to. Should be same as vpc zone. e.x: "eu-de-3"
# key: vpc ssh key. e.x:["636f6d70-0000-0001-0000-00000015d753"]
# user_data: upload bash file with IoT application.  
resource "ibm_is_instance" "vpc-vm" {
  name    = "vpc-windows-vm"
  image   = var.image-template-id
  profile = var.machine-type
  primary_network_interface {
    port_speed      = var.port-speed
    subnet          = ibm_is_subnet.vpc-subnet.id
    security_groups = [ibm_is_vpc.vpc.default_security_group]
  }
  vpc  = ibm_is_vpc.vpc.id
  zone = var.availability-zone
  keys = [ibm_is_ssh_key.vpc-sshkey.id]
}

# Reserve a floating IP and associate it to the network interface of 
# a virtual server instance to allow public traffic to the instance.
resource "ibm_is_floating_ip" "vpc-floating-ip" {
  name   = "vpc-floating-ip"
  target = ibm_is_instance.vpc-vm.primary_network_interface[0].id
}

