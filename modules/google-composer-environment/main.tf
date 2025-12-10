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

resource "google_composer_environment" "this" {
  provider = google-beta

  name    = var.env_name
  project = var.project_id
  region  = var.region
  labels  = var.labels

  dynamic "storage_config" {
    for_each = var.storage_bucket == null ? [] : [1]
    content {
      bucket = var.storage_bucket
    }
  }

  config {
    software_config {
      image_version            = var.image_version
      airflow_config_overrides = var.airflow_config_overrides
      pypi_packages            = var.pypi_packages
      env_variables            = var.env_variables
    }

    node_config {
      service_account             = var.service_account
      network                     = var.network
      subnetwork                  = var.subnetwork
      composer_network_attachment = var.composer_network_attachment
    }

    dynamic "workloads_config" {
      for_each = anytrue([
        for v in values(var.workloads_config) : v != null
      ]) ? [1] : []

      content {
        dynamic "scheduler" {
          for_each = try(var.workloads_config.scheduler, null) == null ? [] : [1]
          content {
            cpu        = try(var.workloads_config.scheduler.cpu, null)
            memory_gb  = try(var.workloads_config.scheduler.memory_gb, null)
            storage_gb = try(var.workloads_config.scheduler.storage_gb, null)
            count      = try(var.workloads_config.scheduler.count, null)
          }
        }
        dynamic "triggerer" {
          for_each = try(var.workloads_config.triggerer, null) == null ? [] : [1]
          content {
            cpu       = var.workloads_config.triggerer.cpu
            memory_gb = var.workloads_config.triggerer.memory_gb
            count     = var.workloads_config.triggerer.count
          }
        }
        dynamic "dag_processor" {
          for_each = try(var.workloads_config.dag_processor, null) == null ? [] : [1]
          content {
            cpu        = try(var.workloads_config.dag_processor.cpu, null)
            memory_gb  = try(var.workloads_config.dag_processor.memory_gb, null)
            storage_gb = try(var.workloads_config.dag_processor.storage_gb, null)
            count      = var.workloads_config.dag_processor.count
          }
        }
        dynamic "web_server" {
          for_each = try(var.workloads_config.web_server, null) == null ? [] : [1]
          content {
            cpu        = try(var.workloads_config.web_server.cpu, null)
            memory_gb  = try(var.workloads_config.web_server.memory_gb, null)
            storage_gb = try(var.workloads_config.web_server.storage_gb, null)
          }
        }
        dynamic "worker" {
          for_each = try(var.workloads_config.worker, null) == null ? [] : [1]
          content {
            cpu        = try(var.workloads_config.worker.cpu, null)
            memory_gb  = try(var.workloads_config.worker.memory_gb, null)
            storage_gb = try(var.workloads_config.worker.storage_gb, null)
            min_count  = try(var.workloads_config.worker.min_count, null)
            max_count  = try(var.workloads_config.worker.max_count, null)
          }
        }
      }
    }

    environment_size = var.environment_size

    enable_private_environment = var.enable_private_environment

    dynamic "encryption_config" {
      for_each = var.kms_key_name == null ? [] : [1]
      content {
        kms_key_name = var.kms_key_name
      }
    }
  }
}
