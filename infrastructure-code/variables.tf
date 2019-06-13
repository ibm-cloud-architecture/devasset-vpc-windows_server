# This terraform file contains the variables and default values for 
# this architecture. Default values will be used unless changed at 
# deployment time.


# The Infrastructure API Key needed to deploy all resources. 
variable iaasapikey {
  description = "The IBM Cloud infrastructure API key"
  default = ""
}

# The Platform as a Service API Key needed to deploy all resources. 
variable paasapikey {
  description = "The IBM Cloud platform API key"
  default = ""
}

# Username for provided API Keys, needed to deploy all resources. 
variable iaasusername {
 description = "The IBM Cloud infrastructure user name"
 default = ""
}

# The actual public key that will be created in IBM Cloud and
# assigned to the virtual servers
variable ssh_key {
 description = "ssh public key"
 default = ""
}

# The region to deploy architecture.
variable ibm_region {
 description = "IBM Cloud region"
 default = ""
}

# The zone to deploy the architecture. The tutorial uses a
# single zone.
variable availability_zone {
 description = "location to deploy"
 default = "" 
}

# The next generation infrastructure service API endpoint . 
# It can also be sourced from the RIAAS_ENDPOINT. 
# Default value: us-south.iaas.cloud.ibm.com
variable  riaas_endpoint {
  description = "infrastructure service API endpoint"
  default= ""
}


# Resource group to which these resources will belong 
variable resource_group {
  description = "resource group"
  default = "vpc-test"  
}

# Address Prefix used for creating VPC.
variable address_prefix {
  description = "address prefix used in vpc"
  default = "10.10.13.0/24"
}

# Used by Security Group to give access to given resource.
variable access_to_any_ip {
  description = "Give access to any ip"
  default = "0.0.0.0/0"
}

# OS image template used while provisioning VM. Default image is of Ubuntu.
variable  image_template_id {
  description = "Image template id used for VM, use windows image. Use command `ibmcloud is images` to view list of available images."
  default = "b45450d3-1a17-2226-c518-a8ad0a75f5f8"
}

# Machine type used while provisioning VM.
variable machine_type {
  description = "VM machine type"
  default = "cc1-2x4"
}

# Port speed used while provisioning VM.
variable port_speed  {
  description = "vm port speed"
  default = "1000"
}

# CIDR value for subnet.
variable subnet_cidr {
  description = "Used for creating subnet with given cidr"
  default = "10.243.132.0/24"
}

variable security_group_port {
  description = "Used for adding rule for security group"
  default = 3389
}
# CIDR value for ACL ingress/egress.
variable ACLsource_ingress {
  description = "Used for creating ACL source ingress cidr"
  default = "0.0.0.0/0"
}
variable ACLdest_ingress {
  description = "Used for creating ACL destination ingress cidr"
  default = "0.0.0.0/0"
}
variable ACLsource_egress {
  description = "Used for creating ACL source egress cidr"
  default = "0.0.0.0/0"
}
variable ACLdest_egress {
  description = "Used for creating ACL destination egress cidr"
  default = "0.0.0.0/0"
}

variable tcp_max_port {
  description = "The highest port in the range of ports to be matched"
  default = 65535
}

variable tcp_min_port {
  description = "The highest port in the range of ports to be matched"
  default = 1
}

