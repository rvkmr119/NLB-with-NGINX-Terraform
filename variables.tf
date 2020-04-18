variable "nlb" {
  }
variable "lb_type" {
  }
variable "sgs" {
  type = "list"
  }
variable "subs" {
  type = "list"
  }
variable "vpc" {
  }
variable "tg" {
  }
variable "tg_protocol" {
  }
variable "tg_port" {
  }
variable "tg_type" {
  }
variable "region" {
  }

variable "amitype" {
  }

variable "i_type" {
  }

variable "project" {
  }

variable "azs" {
  type = "list"
  default = ["us-east-1a", "us-east-1b",]
  }
