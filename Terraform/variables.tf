variable "region" {
  default = "us-west-1" 
  }

variable "key_name" {
  description = "Your existing AWS key pair name"
  type        = string
  default     = ""
}
