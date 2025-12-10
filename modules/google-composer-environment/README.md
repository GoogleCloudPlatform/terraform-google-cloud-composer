# Google Composer Environment module

This module provisions a Google Cloud Composer environment.

<!-- BEGIN_TF_DOCS -->
<!-- END_TF_DOCS -->
<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| airflow\_config\_overrides | Apache Airflow configuration properties to override. | `map(string)` | `{}` | no |
| composer\_network\_attachment | PSC (Private Service Connect) Network entry point. | `string` | `null` | no |
| enable\_private\_environment | If true, a private Composer environment will be created. | `bool` | `false` | no |
| env\_name | Name of the Composer environment. | `string` | n/a | yes |
| env\_variables | Additional environment variables for the Airflow processes. | `map(string)` | `{}` | no |
| environment\_size | The environment size (ENVIRONMENT\_SIZE\_SMALL, ENVIRONMENT\_SIZE\_MEDIUM, ENVIRONMENT\_SIZE\_LARGE). | `string` | `"ENVIRONMENT_SIZE_SMALL"` | no |
| image\_version | The version of the software running in the environment. e.g., composer-3-airflow-2.7.3 | `string` | n/a | yes |
| kms\_key\_name | Customer-managed Encryption Key for the environment. | `string` | `null` | no |
| labels | User-defined labels for this environment. | `map(string)` | `{}` | no |
| network | The Compute Engine network to be used for machine communications. | `string` | `null` | no |
| project\_id | The ID of the project in which the resource belongs. | `string` | n/a | yes |
| pypi\_packages | Custom Python Package Index (PyPI) packages to be installed. | `map(string)` | `{}` | no |
| region | The region where the Composer environment will be created. | `string` | n/a | yes |
| service\_account | The Google Cloud Platform Service Account to be used by the node VMs. Must have roles/composer.worker. | `string` | n/a | yes |
| storage\_bucket | Name of an existing Cloud Storage bucket to be used by the environment. If null, Composer creates one. | `string` | `null` | no |
| subnetwork | The Compute Engine subnetwork to be used for machine communications. | `string` | `null` | no |
| workloads\_config | The Kubernetes workloads configuration for the GKE cluster. | <pre>object({<br>    scheduler = optional(object({<br>      cpu        = optional(number)<br>      memory_gb  = optional(number)<br>      storage_gb = optional(number)<br>      count      = optional(number)<br>    }))<br>    triggerer = optional(object({<br>      cpu       = number<br>      memory_gb = number<br>      count     = number<br>    }))<br>    dag_processor = optional(object({<br>      cpu        = optional(number)<br>      memory_gb  = optional(number)<br>      storage_gb = optional(number)<br>      count      = number<br>    }))<br>    web_server = optional(object({<br>      cpu        = optional(number)<br>      memory_gb  = optional(number)<br>      storage_gb = optional(number)<br>    }))<br>    worker = optional(object({<br>      cpu        = optional(number)<br>      memory_gb  = optional(number)<br>      storage_gb = optional(number)<br>      min_count  = optional(number)<br>      max_count  = optional(number)<br>    }))<br>  })</pre> | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| airflow\_uri | The URI of the Apache Airflow Web UI hosted within this environment. |
| dag\_gcs\_prefix | The Cloud Storage prefix of the DAGs for this environment. |
| gke\_cluster | The Kubernetes Engine cluster used to run this environment. |
| id | The identifier for the Composer environment. |
| name | The name of the Composer environment. |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->