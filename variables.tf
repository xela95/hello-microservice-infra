# --------------------------------------
# GENERAL VARIABLES
# --------------------------------------

variable "location" {
  description = "Azure region where all components will be created"
  type        = string
}

variable "tags" {
  description = "Optional tags to apply to all resources"
  type        = map(string)
  default = {
    Environment = "Dev"
  }
}

# --------------------------------------
# RESOURCE GROUP
# --------------------------------------

variable "rg_01_name" {
  description = "Name of Resource Group 01"
  type        = string
}

# --------------------------------------
# CONTAINER APPS ENVIRONMENT (CAE)
# --------------------------------------

variable "cae_01_name" {
  description = "Name of Container Apps Environment 01"
  type        = string
}

# --------------------------------------
# CONTAINER APP (ACA)
# --------------------------------------

variable "aca_01_name" {
  description = "Name of Container App 01"
  type        = string
}

# -------------------------
# DOCKER IMAGE
# -------------------------
variable "docker_image" {
  description = "Docker image used by the Container App (from DockerHub)"
  type        = string
}
