/**
 * Copyright 2021 Google LLC
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

variable "project_id" {
  type        = string
  description = "The ID of the project in which the resource belongs."
}

variable "env_name" {
  type        = string
  description = "Name of the Composer environment."
}

variable "region" {
  type        = string
  description = "The region where the Composer environment will be created."
}

variable "labels" {
  type        = map(string)
  description = "User-defined labels for this environment."
  default     = {}
}

variable "image_version" {
  type        = string
  description = "The version of the software running in the environment. e.g., composer-3-airflow-2.7.3"
}

variable "service_account" {
  type        = string
  description = "The Google Cloud Platform Service Account to be used by the node VMs. Must have roles/composer.worker."
}

variable "environment_size" {
  type        = string
  description = "The environment size (ENVIRONMENT_SIZE_SMALL, ENVIRONMENT_SIZE_MEDIUM, ENVIRONMENT_SIZE_LARGE)."
  default     = "ENVIRONMENT_SIZE_SMALL"
}

variable "enable_private_environment" {
  type        = bool
  description = "If true, a private Composer environment will be created."
  default     = false
}

variable "network" {
  type        = string
  description = "The Compute Engine network to be used for machine communications."
  default     = null
}

variable "subnetwork" {
  type        = string
  description = "The Compute Engine subnetwork to be used for machine communications."
  default     = null
}

variable "composer_network_attachment" {
  type        = string
  description = "PSC (Private Service Connect) Network entry point."
  default     = null
}

variable "workloads_config" {
  type = object({
    scheduler = optional(object({
      cpu        = optional(number)
      memory_gb  = optional(number)
      storage_gb = optional(number)
      count      = optional(number)
    }))
    triggerer = optional(object({
      cpu       = number
      memory_gb = number
      count     = number
    }))
    dag_processor = optional(object({
      cpu        = optional(number)
      memory_gb  = optional(number)
      storage_gb = optional(number)
      count      = number
    }))
    web_server = optional(object({
      cpu        = optional(number)
      memory_gb  = optional(number)
      storage_gb = optional(number)
    }))
    worker = optional(object({
      cpu        = optional(number)
      memory_gb  = optional(number)
      storage_gb = optional(number)
      min_count  = optional(number)
      max_count  = optional(number)
    }))
  })
  description = "The Kubernetes workloads configuration for the GKE cluster."
  default     = {}
}

variable "airflow_config_overrides" {
  type        = map(string)
  description = "Apache Airflow configuration properties to override."
  default     = {}
}

variable "pypi_packages" {
  type        = map(string)
  description = "Custom Python Package Index (PyPI) packages to be installed."
  default     = {}
}

variable "env_variables" {
  type        = map(string)
  description = "Additional environment variables for the Airflow processes."
  default     = {}
}

variable "kms_key_name" {
  type        = string
  description = "Customer-managed Encryption Key for the environment."
  default     = null
}

variable "storage_bucket" {
  type        = string
  description = "Name of an existing Cloud Storage bucket to be used by the environment. If null, Composer creates one."
  default     = null
}
