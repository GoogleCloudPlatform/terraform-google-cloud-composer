// Copyright 2022 Google LLC
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

package google_composer_environment_test

import (
	"fmt"
	"strings"
	"testing"

	"github.com/GoogleCloudPlatform/cloud-foundation-toolkit/infra/blueprint-test/pkg/gcloud"
	"github.com/GoogleCloudPlatform/cloud-foundation-toolkit/infra/blueprint-test/pkg/tft"
	"github.com/stretchr/testify/assert"
)

func TestGoogleComposerEnvironment(t *testing.T) {
	example := tft.NewTFBlueprintTest(t)

	example.DefineVerify(func(assert *assert.Assertions) {
		example.DefaultVerify(assert)

		projectID := example.GetStringOutput("project_id")
		assert.NotEmpty(projectID, "Project ID output must not be empty")

		envName := "example-composer-environment"
		region := "us-central1"

		composerID := example.GetStringOutput("composer_environment_id")
		composerName := example.GetStringOutput("composer_environment_name")
		gkeCluster := example.GetStringOutput("gke_cluster")
		dagGcsPrefix := example.GetStringOutput("dag_gcs_prefix")
		airflowUri := example.GetStringOutput("airflow_uri")

		assert.NotEmpty(composerID, "Composer environment ID should not be empty")
		assert.Contains(composerName, envName, "Composer environment name output should contain the input env_name")
		assert.NotEmpty(dagGcsPrefix, "DAG GCS prefix should not be empty")
		assert.NotEmpty(airflowUri, "Airflow URI should not be empty")
		assert.True(strings.HasPrefix(airflowUri, "https://"), "Airflow URI should be an HTTPS URL")

		compDescribe := gcloud.Run(t, "composer", "environments", "describe", envName,
			"--location", region,
			"--project", projectID,
		)
		// Expected format: projects/PROJECT_ID/locations/LOCATION/environments/ENV_NAME
		compNameParts := strings.Split(compDescribe.Get("name").String(), "/")
		assert.Equal(envName, compNameParts[len(compNameParts)-1], "Composer environment name mismatch in gcloud describe")
		assert.Equal("RUNNING", compDescribe.Get("state").String(), "Composer environment should be in RUNNING state")
	})

	// Run the test
	example.Test()
}
