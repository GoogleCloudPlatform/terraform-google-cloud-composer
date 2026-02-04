# terraform-google-cloud-composer

## Description

This Terraform module handles the creation and management of Cloud Composer environments on Google Cloud Platform.

## Assumptions and prerequisites

This module assumes that the below mentioned prerequisites are in place:

-   To deploy this blueprint you must have an active billing account and billing permissions.
-   Required APIs are enabled on the project.
-   The service account used has the necessary permissions.

## Documentation

-   [Cloud Composer Documentation](https://cloud.google.com/composer/docs)

## Usage

Basic usage of this module is as follows:

```hcl
module "cloud_composer_environment" {
  source  = "GoogleCloudPlatform/cloud-composer/google//modules/google-composer-environment"
  version = "~> 0.1" # Replace with the desired version

  project_id      = "<PROJECT ID>"
  env_name        = "<COMPOSER ENV NAME>"
  region          = "<GCP REGION>"
  image_version   = "composer-3-airflow-2.7.3" # Specify appropriate image version
  service_account = "<SERVICE ACCOUNT EMAIL>"

}

Functional examples are included in the
[examples](./examples/) directory.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| airflow\_config\_overrides | Apache Airflow configuration properties to override. | `map(string)` | {} | no |
| composer\_network\_attachment | PSC (Private Service Connect) Network entry point. | `string` | null | no |
| enable\_private\_environment | If true, a private Composer environment will be created. | `bool` | false | no |
| env\_name | Name of the Composer environment. | `string` | n/a | yes |
| env\_variables | Additional environment variables for the Airflow processes. | `map(string)` | {} | no |
| environment\_size | The environment size (ENVIRONMENT_SIZE_SMALL, ENVIRONMENT_SIZE_MEDIUM, ENVIRONMENT_SIZE_LARGE). | `string` | "ENVIRONMENT_SIZE_SMALL" | no |
| image\_version | The version of the software running in the environment. e.g., composer-3-airflow-2.7.3 | `string` | n/a | yes |
| kms\_key\_name | Customer-managed Encryption Key for the environment. | `string` | null | no |
| labels | User-defined labels for this environment. | `map(string)` | {} | no |
| network | The Compute Engine network to be used for machine communications. | `string` | null | no |
| project\_id | The ID of the project in which the resource belongs. | `string` | n/a | yes |
| pypi\_packages | Custom Python Package Index (PyPI) packages to be installed. | `map(string)` | {} | no |
| region | The region where the Composer environment will be created. | `string` | n/a | yes |
| service\_account | The Google Cloud Platform Service Account to be used by the node VMs. Must have roles/composer.worker. | `string` | n/a | yes |
| storage\_bucket | Name of an existing Cloud Storage bucket to be used by the environment. If null, Composer creates one. | `string` | null | no |
| subnetwork | The Compute Engine subnetwork to be used for machine communications. | `string` | null | no |
| workloads\_config | The Kubernetes workloads configuration for the GKE cluster. | <pre>object({<br> scheduler = optional(object({<br> cpu = optional(number)<br> memory_gb = optional(number)<br> storage_gb = optional(number)<br> count = optional(number)<br> }))<br> triggerer = optional(object({<br> cpu = number<br> memory_gb = number<br> count = number<br> }))<br> dag_processor = optional(object({<br> cpu = optional(number)<br> memory_gb = optional(number)<br> storage_gb = optional(number)<br> count = number<br> }))<br> web_server = optional(object({<br> cpu = optional(number)<br> memory_gb = optional(number)<br> storage_gb = optional(number)<br> }))<br> worker = optional(object({<br> cpu = optional(number)<br> memory_gb = optional(number)<br> storage_gb = optional(number)<br> min_count = optional(number)<br> max_count = optional(number)<br> }))<br> })</pre> | {} | no |

## Outputs

| Name | Description |
|------|-------------|
| airflow\_uri | The URI of the Apache Airflow Web UI hosted within this environment. |
| composer\_environment\_id | The identifier for the Composer environment. |
| composer\_environment\_name | The name of the Composer environment. |
| dag\_gcs\_prefix | The Cloud Storage prefix of the DAGs for this environment. |
| gke\_cluster | The Kubernetes Engine cluster used to run this environment. |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

These sections describe requirements for using this module.

### Software

The following dependencies must be available:

- [Terraform][terraform] v0.13
- [Terraform Provider for GCP][terraform-provider-gcp] plugin v3.0

### Service Account

A service account with the following roles must be used to provision
the resources of this module:

- Composer Admin: `roles/composer.admin`
- Service Account User: `roles/iam.serviceAccountUser`
- Storage Admin: `roles/storage.admin` (Required for Composer to manage GCS buckets and objects)
- The service account assigned to var.service_account requires `roles/composer.worker`.

The [Project Factory module][project-factory-module] and the
[IAM module][iam-module] may be used in combination to provision a
service account with the necessary roles applied.

### APIs

A project with the following APIs enabled must be used to host the
resources of this module:

- Cloud Composer API: `composer.googleapis.com`
- Cloud Resource Manager API: `cloudresourcemanager.googleapis.com`
- IAM API: `iam.googleapis.com`
- Service Usage API: `serviceusage.googleapis.com`
- Cloud Storage API: `storage.googleapis.com`
- Compute Engine API: `compute.googleapis.com`
- Artifact Registry API: `artifactregistry.googleapis.com`
- Google Kubernetes Engine API: `container.googleapis.com`

The [Project Factory module][project-factory-module] can be used to
provision a project with the necessary APIs enabled.

## Contributing

Refer to the [contribution guidelines](./CONTRIBUTING.md) for
information on contributing to this module.

## Security Disclosures

Please see our [security disclosure process](./SECURITY.md).