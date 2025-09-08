provider "aws" {
  alias  = "source"
  region = var.source_region
}

provider "aws" {
  alias  = "destination"
  region = var.destination_region
}

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.5.0"
    }
  }
}
