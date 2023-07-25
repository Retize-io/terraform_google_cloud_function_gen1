# Deploy Function Terraform Module

This Terraform module deploys a Google Cloud Function.

## Usage

You can use this module by referencing it in your Terraform code:

```terraform
module "deploy_function" {
source  = "git@github.com:Retize-io/terraform_google_cloud_function_gen1.git//http/rg?ref=v1.0.0"

  project                = "my-project"
  function_name          = "my-function"
  description            = "My function description"
  runtime                = "nodejs18"
  entry_point            = "myFunction"
  timeout                = 60
  available_memory_mb    = 128
  environment_variables  = {
    MY_VARIABLE = "my-value"
  }
  region                 = "us-central1"
  bucket_name            = "my-bucket"
  service_account_email  = "my-service-account@my-project.iam.gserviceaccount.com"
  function_path          = "path/to/function"
}
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|----------|
| project | The ID of the Google Cloud project where the function will be deployed. | `string` | n/a | yes |
| function_name | The name of the function to be deployed. | `string` | n/a | yes |
| description | A description of the function. | `string` | `""` | no |
| runtime | The runtime of the function. | `string` | `"nodejs18"` | no |
| entry_point | The name of the function that will be executed. | `string` | n/a | yes |
| timeout | The maximum amount of time that the function can run. | `number` | `60` | no |
| available_memory_mb | The amount of memory available to the function. | `number` | `128` | no |
| environment_variables | A map of environment variables that will be passed to the function. | `map(string)` | `{}` | no |
| region | The region where the function will be deployed. | `string` | `"us-central1"` | no |
| bucket_name | The name of the bucket where the source code is stored. | `string` | n/a | yes |
| service_account_email | The email address of the service account that will be used to deploy the function. | `string` | n/a | yes |
| function_path | The path to the function directory relative to the root of the repository. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| function_url | The URL of the deployed function. |

## Contributing

Contributions are welcome! Please read the [contributing guidelines](CONTRIBUTING.md) before submitting a pull request.

## Authors

This module is maintained by [Retize](https://github.com/Retize-io).

## License

This module is licensed under the Mozilla Public License 2.0. See [LICENSE](LICENSE) for full details.
