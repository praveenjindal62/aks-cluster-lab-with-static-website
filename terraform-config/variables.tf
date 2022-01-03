variable "rgname" {
  type = string
}

variable "rglocation" {
  type = string
}

variable "acrname" {
  type = string
}

variable "acrsku" {
  type = string
}

variable "vnetname" {
  type = string
}

variable "vnetcidr" {
  type = list(string)
}

variable "subnet1_name" {
  type = string
}

variable "subnet2_name" {
  type = string
}

variable "subnet1_prefix" {
  type = list(string)
}

variable "subnet2_prefix" {
  type = list(string)
}

variable "aksname" {
  type = string 
}

variable "aksnodesku" {
  type = string
}

variable "aksnodecount" {
  type = number
}
