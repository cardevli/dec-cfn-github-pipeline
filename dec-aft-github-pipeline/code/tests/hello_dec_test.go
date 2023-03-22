package tests

import (
  "testing"

  "github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"

)

func TestHelloDEC(t *testing.T)  {

  // Construct the terraform options with default retryable errors to handle the most common
	// retryable errors in terraform testing.
  terraformOptions := terraform.WithDefaultRetryableErrors(t, &terraform.Options{

    // Set the path to the Terraform code that will be tested.
    TerraformDir: "../../dec-project-template-terraform",
  })

	// Run "terraform init" and "terraform apply". Fail the test if there are any errors.
  terraform.InitAndApply(t, terraformOptions)

  // Run `terraform output` to get the values of output variables and check they have the expected values.
  output := terraform.Output(t, terraformOptions, "hello_dec")

  assert.NotEqual(t, "Hello test", output)

  assert.Equal(t, "Hello, DEC!", output)

  // Finally: Run terraform destroy
  defer terraform.Destroy(t, terraformOptions)
}
