# Livebook Chart

## Introduction

## Prerequisites

## Parameters

### Common parameters

| Name                | Description                                                                                  | Value           |
| ------------------- | -------------------------------------------------------------------------------------------- | --------------- |
| `nameOverride`      | String to partially override common.names.fullname template (will maintain the release name) | `""`            |
| `namespaceOverride` | String to fully override common.names.namespace                                              | `""`            |
| `fullnameOverride`  | String to fully override common.names.fullname template                                      | `""`            |
| `commonLabels`      | Labels to add to all deployed objects                                                        | `{}`            |
| `commonAnnotations` | Annotations to add to all deployed objects                                                   | `{}`            |
| `kubeVersion`       | Force target Kubernetes version (using Helm capabilities if not set)                         | `""`            |
| `clusterDomain`     | Default Kubernetes cluster domain                                                            | `cluster.local` |

### Livebook configuration parameters

| Name                               | Description                                                                                         | Value          |
| ---------------------------------- | --------------------------------------------------------------------------------------------------- | -------------- |
| `auth.livebookPassword`            | Password used to access Livebook. Must be at least 12 characters.                                   | `""`           |
| `auth.existingSecret`              | Optionally specify an existing secret holding the livebook password.                                | `{}`           |
| `clustering.livebookCookie`        | Optionally define the cookie for running Livebook in a cluster.                                     | `randomly set` |
| `clustering.existingSecret`        | Optionally specify an existing secret holding values for `livebookCookie`.                          | `{}`           |
| `networking.livebookSecretKeyBase` | Optionally define the cookie for running Livebook in a cluster.                                     | `randomly set` |
| `networking.existingSecret`        | Optionally specify an existing secret holding values for `livebookSecretKeyBase`.                   | `{}`           |
| `s3.livebookAwsCredentials`        | Whether or not to read the S3 credentials from environment variables.                               | `false`        |
| `s3.awsAccessKeyId`                | S3 Access Key ID                                                                                    | `""`           |
| `s3.awsSecretAccessKey`            | S3 Secret Access Key                                                                                | `""`           |
| `s3.existingSecret`                | Optionally specify an existing secret holding values for `awsAccessKeyId` and `awsSecretAccessKey`. | `{}`           |
