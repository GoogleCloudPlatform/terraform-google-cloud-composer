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

output "composer_environment_id" {
  description = "The identifier for the Composer environment."
  value       = google_composer_environment.this.id
}

output "composer_environment_name" {
  description = "The name of the Composer environment."
  value       = google_composer_environment.this.name
}

output "gke_cluster" {
  description = "The Kubernetes Engine cluster used to run this environment."
  value       = google_composer_environment.this.config[0].gke_cluster
}

output "dag_gcs_prefix" {
  description = "The Cloud Storage prefix of the DAGs for this environment."
  value       = google_composer_environment.this.config[0].dag_gcs_prefix
}

output "airflow_uri" {
  description = "The URI of the Apache Airflow Web UI hosted within this environment."
  value       = google_composer_environment.this.config[0].airflow_uri
}
