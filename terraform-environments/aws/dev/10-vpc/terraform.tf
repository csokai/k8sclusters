#setup tf config and backend

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 3.37.0"
    }
  }

  backend "remote" {
    organization = "k8sclusters"

    workspaces {
      name = "k8sclusters-dev-10-vpc"
    }
  }
}

provider "aws" {
  region = local.aws_region
}
