# This terraform file contains the variables and default values for 
# this architecture. Default values will be used unless changed at 
# deployment time.

# The Infrastructure API Key needed to deploy all resources. 
variable "iaasapikey" {
  description = "The IBM Cloud infrastructure API key"
  default     = ""
}

# The Platform as a Service API Key needed to deploy all resources. 
variable "paasapikey" {
  description = "The IBM Cloud platform API key"
  default     = ""
}

# Username for provided API Keys, needed to deploy all resources. 
variable "iaasusername" {
  description = "The IBM Cloud infrastructure user name"
  default     = ""
}

# The actual public key that will be created in IBM Cloud and
# assigned to the virtual servers
variable "ssh-key" {
  description = "ssh public key"
  default     = ""
}

# The region to deploy architecture.
variable "ibm-region" {
  description = "IBM Cloud region"
  default     = ""
}

# The zone to deploy the architecture. The tutorial uses a
# single zone.
variable "availability-zone" {
  description = "location to deploy"
  default     = ""
}

# Resource group to which these resources will belong 
variable "resource-group" {
  description = "resource group"
  default     = "vpc-test"
}

# Address Prefix used for creating VPC.
variable "address-prefix" {
  description = "address prefix used in vpc"
  default     = "172.21.0.0/21"
}

# Used by Security Group to give access to given resource.
variable "access-to-any-ip" {
  description = "Give access to any ip"
  default     = "0.0.0.0/0"
}

# OS image template used while provisioning VM. Default image is of Windows Server 2016.
variable "image-template-id" {
  description = "Image template id used for VM, use windows image. Use command `ibmcloud is images` to view list of available images."
  default     = "r006-54e9238a-ffdd-4f90-9742-7424eb2b9ff1"  
}

# Machine type used while provisioning VM.
variable "machine-type" {
  description = "VM machine type"
  default     = "cx2-2x4"
}

# Port speed used while provisioning VM.
variable "port-speed" {
  description = "vm port speed"
  default     = "1000"
}

# CIDR value for subnet.
variable "subnet-cidr" {
  description = "Used for creating subnet with given cidr"
  default     = "172.21.0.0/24"
}

variable "security-group-port" {
  description = "Used for adding rule for security group"
  default     = 3389
}

# CIDR value for ACL ingress/egress.
variable "ACLsource-ingress" {
  description = "Used for creating ACL source ingress cidr"
  default     = "0.0.0.0/0"
}

variable "ACLdest-ingress" {
  description = "Used for creating ACL destination ingress cidr"
  default     = "0.0.0.0/0"
}

variable "ACLsource-egress" {
  description = "Used for creating ACL source egress cidr"
  default     = "0.0.0.0/0"
}

variable "ACLdest-egress" {
  description = "Used for creating ACL destination egress cidr"
  default     = "0.0.0.0/0"
}

variable "tcp-max-port" {
  description = "The highest port in the range of ports to be matched"
  default     = 65535
}

variable "tcp-min-port" {
  description = "The highest port in the range of ports to be matched"
  default     = 1
}

