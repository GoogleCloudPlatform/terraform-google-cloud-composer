<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| project\_id | The ID of the Google Cloud project in which to deploy the Reasoning Engine. | `string` | n/a | yes |
| service\_account | The Google Cloud Platform Service Account to be used by the node VMs. Must have roles/composer.worker. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| airflow\_uri | The URI of the Apache Airflow Web UI hosted within this environment. |
| composer\_environment\_id | The identifier for the Composer environment. |
| composer\_environment\_name | The name of the Composer environment. |
| dag\_gcs\_prefix | The Cloud Storage prefix of the DAGs for this environment. |
| gke\_cluster | The Kubernetes Engine cluster used to run this environment. |
| project\_id | Project id where composer environment is created. |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
