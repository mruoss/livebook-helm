# Livebook Helm Chart

[![Artifact Hub](https://img.shields.io/endpoint?url=https://artifacthub.io/badge/repository/livebook)](https://artifacthub.io/packages/helm/livebook/livebook)

Livebook is a web application for writing interactive and collaborative code
notebooks in Elixir.

[Livebook Website](https://livebook.dev/) - [Livebook Github
Repository](https://github.com/livebook-dev/livebook)

## TL;DR

    helm install my-release oci://ghcr.io/mruoss/charts/livebook --set livebook.auth.livebookPassword password-used-to-login

## Introduction

This chart deploys Livebook onto a [Kubernetes](https://kubernetes.io/) cluster
using the [Helm](https://helm.sh/) package manager.

## Prerequisites

- Kubernetes 1.23+
- Helm 3.8.0+

## Installing the Chart

## Parameters

### Global parameters

| Name                                                  | Description                                                                                                                                                                                                                                                                                                                                                         | Value  |
| ----------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------ |
| `global.imageRegistry`                                | Global Docker image registry                                                                                                                                                                                                                                                                                                                                        | `""`   |
| `global.imagePullSecrets`                             | Global Docker registry secret names as an array                                                                                                                                                                                                                                                                                                                     | `[]`   |
| `global.storageClass`                                 | Global StorageClass for Persistent Volume(s)                                                                                                                                                                                                                                                                                                                        | `""`   |
| `global.compatibility.openshift.adaptSecurityContext` | Adapt the securityContext sections of the deployment to make them compatible with Openshift restricted-v2 SCC: remove runAsUser, runAsGroup and fsGroup and let the platform use their allowed default IDs. Possible values: auto (apply if the detected running cluster is Openshift), force (perform the adaptation always), disabled (do not perform adaptation) | `auto` |

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

| Name                                        | Description                                                                                              | Value                   |
| ------------------------------------------- | -------------------------------------------------------------------------------------------------------- | ----------------------- |
| `livebook.auth.livebookPassword`            | Password used to access Livebook. Must be at least 12 characters.                                        | `""`                    |
| `livebook.auth.existingSecret`              | Optionally specify an existing secret holding the livebook password.                                     | `{}`                    |
| `livebook.clustering.livebookCookie`        | Optionally define the cookie for running Livebook in a cluster.                                          | `randomly set`          |
| `livebook.clustering.existingSecret`        | Optionally specify an existing secret holding values for `livebookCookie`.                               | `{}`                    |
| `livebook.networking.livebookSecretKeyBase` | Optionally define the cookie for running Livebook in a cluster.                                          | `randomly set`          |
| `livebook.networking.existingSecret`        | Optionally specify an existing secret holding values for `livebookSecretKeyBase`.                        | `{}`                    |
| `livebook.s3.livebookAwsCredentials`        | Whether or not to read the S3 credentials from environment variables.                                    | `false`                 |
| `livebook.s3.awsAccessKeyId`                | S3 Access Key ID                                                                                         | `""`                    |
| `livebook.s3.awsSecretAccessKey`            | S3 Secret Access Key                                                                                     | `""`                    |
| `livebook.s3.existingSecret`                | Optionally specify an existing secret holding values for `awsAccessKeyId` and `awsSecretAccessKey`.      | `{}`                    |
| `livebook.image.registry`                   | Livebook image registry                                                                                  | `ghcr.io`               |
| `livebook.image.repository`                 | Livebook image repository                                                                                | `livebook-dev/livebook` |
| `livebook.image.tag`                        | Livebook image tag                                                                                       | `0.15.5`                |
| `livebook.image.digest`                     | Livebook image digest in the way sha256:aa.... Please note this parameter, if set, will override the tag | `""`                    |
| `livebook.image.pullPolicy`                 | Image pull policy                                                                                        | `IfNotPresent`          |
| `livebook.image.pullSecrets`                | Specify docker-registry secret names as an array                                                         | `[]`                    |
| `livebook.replicaCount`                     | Number of livebook replicas to deploy                                                                    | `1`                     |
| `livebook.extraEnvVars`                     | Extra environment variables to be set on Livebook container                                              | `[]`                    |
| `livebook.extraEnvVarsCM`                   | ConfigMap with extra environment variables                                                               | `""`                    |
| `livebook.extraEnvVarsSecret`               | Secret with extra environment variables                                                                  | `""`                    |
| `livebook.command`                          | Default container command (useful when using custom images). Use array form                              | `[]`                    |
| `livebook.args`                             | Default container args (useful when using custom images). Use array form                                 | `[]`                    |

### Livebook deployment parameters

| Name                                                         | Description                                                                                                                                                                                                       | Value            |
| ------------------------------------------------------------ | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ---------------- |
| `livebook.schedulerName`                                     | Specifies the schedulerName, if it's nil uses kube-scheduler                                                                                                                                                      | `""`             |
| `livebook.terminationGracePeriodSeconds`                     | In seconds, time the given to the Livebook pod needs to terminate gracefully                                                                                                                                      | `""`             |
| `livebook.deployment.updateStrategy.type`                    | Deployment strategy type                                                                                                                                                                                          | `RollingUpdate`  |
| `livebook.automountServiceAccountToken`                      | Mount Service Account token in pod                                                                                                                                                                                | `true`           |
| `livebook.hostAliases`                                       | Livebook pod host aliases                                                                                                                                                                                         | `[]`             |
| `livebook.containerPorts.livebook`                           | Livebook container port to open                                                                                                                                                                                   | `9000`           |
| `livebook.podSecurityContext.enabled`                        | Enable pod Security Context                                                                                                                                                                                       | `true`           |
| `livebook.podSecurityContext.sysctls`                        | Set kernel settings using the sysctl interface                                                                                                                                                                    | `[]`             |
| `livebook.podSecurityContext.supplementalGroups`             | Set filesystem extra groups                                                                                                                                                                                       | `[]`             |
| `livebook.podSecurityContext.fsGroup`                        | Group ID for the container                                                                                                                                                                                        | `1001`           |
| `livebook.podSecurityContext.fsGroupChangePolicy`            | Set filesystem group change policy                                                                                                                                                                                | `OnRootMismatch` |
| `livebook.podSecurityContext.sysctls`                        | Set kernel settings using the sysctl interface                                                                                                                                                                    | `[]`             |
| `livebook.podSecurityContext.supplementalGroups`             | Set filesystem extra groups                                                                                                                                                                                       | `[]`             |
| `livebook.podSecurityContext.fsGroupChangePolicy`            | When K8s should preform chown on attached volumes                                                                                                                                                                 | `OnRootMismatch` |
| `livebook.containerSecurityContext.enabled`                  | Enabled containers' Security Context                                                                                                                                                                              | `true`           |
| `livebook.containerSecurityContext.seLinuxOptions`           | Set SELinux options in container                                                                                                                                                                                  | `{}`             |
| `livebook.containerSecurityContext.runAsUser`                | Set containers' Security Context runAsUser                                                                                                                                                                        | `1001`           |
| `livebook.containerSecurityContext.runAsGroup`               | Set containers' Security Context runAsGroup                                                                                                                                                                       | `1001`           |
| `livebook.containerSecurityContext.runAsNonRoot`             | Set container's Security Context runAsNonRoot                                                                                                                                                                     | `true`           |
| `livebook.containerSecurityContext.privileged`               | Set container's Security Context privileged                                                                                                                                                                       | `false`          |
| `livebook.containerSecurityContext.readOnlyRootFilesystem`   | Set container's Security Context readOnlyRootFilesystem                                                                                                                                                           | `true`           |
| `livebook.containerSecurityContext.allowPrivilegeEscalation` | Set container's Security Context allowPrivilegeEscalation                                                                                                                                                         | `false`          |
| `livebook.containerSecurityContext.capabilities.drop`        | List of capabilities to be dropped                                                                                                                                                                                | `["ALL"]`        |
| `livebook.containerSecurityContext.seccompProfile.type`      | Set container's Security Context seccomp profile                                                                                                                                                                  | `RuntimeDefault` |
| `livebook.podLabels`                                         | Extra labels for Livebook pods                                                                                                                                                                                    | `{}`             |
| `livebook.podAnnotations`                                    | Annotations for Livebook pods                                                                                                                                                                                     | `{}`             |
| `livebook.podAffinityPreset`                                 | Pod affinity preset. Ignored if `affinity` is set. Allowed values: `soft` or `hard`                                                                                                                               | `""`             |
| `livebook.podAntiAffinityPreset`                             | Pod anti-affinity preset. Ignored if `affinity` is set. Allowed values: `soft` or `hard`                                                                                                                          | `soft`           |
| `livebook.nodeAffinityPreset.type`                           | Node affinity preset type. Ignored if `affinity` is set. Allowed values: `soft` or `hard`                                                                                                                         | `""`             |
| `livebook.nodeAffinityPreset.key`                            | Node label key to match. Ignored if `affinity` is set.                                                                                                                                                            | `""`             |
| `livebook.nodeAffinityPreset.values`                         | Node label values to match. Ignored if `affinity` is set.                                                                                                                                                         | `[]`             |
| `livebook.affinity`                                          | Affinity for pod assignment. Evaluated as a template.                                                                                                                                                             | `{}`             |
| `livebook.nodeSelector`                                      | Node labels for pod assignment. Evaluated as a template.                                                                                                                                                          | `{}`             |
| `livebook.tolerations`                                       | Tolerations for pod assignment. Evaluated as a template.                                                                                                                                                          | `[]`             |
| `livebook.topologySpreadConstraints`                         | Topology Spread Constraints for Livebook pods assignment spread across your cluster among failure-domains                                                                                                         | `[]`             |
| `livebook.priorityClassName`                                 | Livebook pods' priorityClassName                                                                                                                                                                                  | `""`             |
| `livebook.runtimeClassName`                                  | Name of the runtime class to be used by Livebook pods'                                                                                                                                                            | `""`             |
| `livebook.resourcesPreset`                                   | Set container resources according to one common preset (allowed values: none, nano, micro, small, medium, large, xlarge, 2xlarge). This is ignored if resources is set (resources is recommended for production). | `micro`          |
| `livebook.resources`                                         | Set container requests and limits for different resources like CPU or memory (essential for production workloads)                                                                                                 | `{}`             |
| `livebook.livenessProbe.enabled`                             | Enable livenessProbe                                                                                                                                                                                              | `true`           |
| `livebook.livenessProbe.initialDelaySeconds`                 | Initial delay seconds for livenessProbe                                                                                                                                                                           | `5`              |
| `livebook.livenessProbe.periodSeconds`                       | Period seconds for livenessProbe                                                                                                                                                                                  | `5`              |
| `livebook.livenessProbe.timeoutSeconds`                      | Timeout seconds for livenessProbe                                                                                                                                                                                 | `5`              |
| `livebook.livenessProbe.failureThreshold`                    | Failure threshold for livenessProbe                                                                                                                                                                               | `5`              |
| `livebook.livenessProbe.successThreshold`                    | Success threshold for livenessProbe                                                                                                                                                                               | `1`              |
| `livebook.readinessProbe.enabled`                            | Enable readinessProbe                                                                                                                                                                                             | `true`           |
| `livebook.readinessProbe.initialDelaySeconds`                | Initial delay seconds for readinessProbe                                                                                                                                                                          | `5`              |
| `livebook.readinessProbe.periodSeconds`                      | Period seconds for readinessProbe                                                                                                                                                                                 | `5`              |
| `livebook.readinessProbe.timeoutSeconds`                     | Timeout seconds for readinessProbe                                                                                                                                                                                | `1`              |
| `livebook.readinessProbe.failureThreshold`                   | Failure threshold for readinessProbe                                                                                                                                                                              | `5`              |
| `livebook.readinessProbe.successThreshold`                   | Success threshold for readinessProbe                                                                                                                                                                              | `1`              |
| `livebook.customLivenessProbe`                               | Override default liveness probe                                                                                                                                                                                   | `{}`             |
| `livebook.customReadinessProbe`                              | Override default readiness probe                                                                                                                                                                                  | `{}`             |
| `livebook.customStartupProbe`                                | Override default startup probe                                                                                                                                                                                    | `{}`             |
| `livebook.lifecycleHooks`                                    | for the Livebookcontainer(s) to automate configuration before or after startup                                                                                                                                    | `{}`             |
| `livebook.extraVolumes`                                      | Optionally specify extra list of additional volumes for Livebook pods                                                                                                                                             | `[]`             |
| `livebook.extraVolumeMounts`                                 | Optionally specify extra list of additional volumeMounts for Livebook container(s)                                                                                                                                | `[]`             |
| `livebook.initContainers`                                    | Add additional init containers to the Livebook pods                                                                                                                                                               | `[]`             |
| `livebook.sidecars`                                          | Add additional sidecar containers to the Livebook pods                                                                                                                                                            | `[]`             |

### Traffic exposure parameters

| Name                                        | Description                                                                                                                      | Value               |
| ------------------------------------------- | -------------------------------------------------------------------------------------------------------------------------------- | ------------------- |
| `livebook.service.type`                     | Livebook service type                                                                                                            | `ClusterIP`         |
| `livebook.service.ports.livebook`           | Livebook service port                                                                                                            | `9000`              |
| `livebook.service.nodePorts.livebook`       | Specify the Livebook NodePort value for the LoadBalancer and NodePort service types                                              | `""`                |
| `livebook.service.clusterIP`                | Service Cluster IP                                                                                                               | `""`                |
| `livebook.service.loadBalancerIP`           | loadBalancerIP if service type is `LoadBalancer` (optional, cloud specific)                                                      | `""`                |
| `livebook.service.loadBalancerSourceRanges` | Addresses that are allowed when service is LoadBalancer                                                                          | `[]`                |
| `livebook.service.externalTrafficPolicy`    | Enable client source IP preservation                                                                                             | `Cluster`           |
| `livebook.service.extraPorts`               | Extra ports to expose in the service (normally used with the `sidecar` value)                                                    | `[]`                |
| `livebook.service.annotations`              | Annotations for Livebook service                                                                                                 | `{}`                |
| `livebook.service.headless.annotations`     | Annotations for the headless service.                                                                                            | `{}`                |
| `livebook.ingress.enabled`                  | Enable ingress controller resource for Livebook                                                                                  | `true`              |
| `livebook.ingress.apiVersion`               | Force Ingress API version (automatically detected if not set)                                                                    | `""`                |
| `livebook.ingress.ingressClassName`         | IngressClass that will be be used to implement the Ingress (Kubernetes 1.18+)                                                    | `""`                |
| `livebook.ingress.hostname`                 | Default host for the ingress resource                                                                                            | `livebook.local`    |
| `livebook.ingress.path`                     | The Path to Livebook. You may need to set this to '/*' in order to use this with ALB ingress controllers.                        | `/`                 |
| `livebook.ingress.pathType`                 | Ingress path type                                                                                                                | `Prefix`            |
| `livebook.ingress.servicePort`              | Service port to be used                                                                                                          | `livebook-main`     |
| `livebook.ingress.annotations`              | Additional annotations for the Ingress resource. To enable certificate autogeneration, place here your cert-manager annotations. | `{}`                |
| `livebook.ingress.tls`                      | Enable TLS configuration for the hostname defined at `ingress.hostname` parameter                                                | `false`             |
| `livebook.ingress.selfSigned`               | Create a TLS secret for this ingress record using self-signed certificates generated by Helm                                     | `false`             |
| `livebook.ingress.extraHosts`               | The list of additional hostnames to be covered with this ingress record.                                                         | `[]`                |
| `livebook.ingress.extraPaths`               | Any additional paths that may need to be added to the ingress under the main host                                                | `[]`                |
| `livebook.ingress.extraTls`                 | The tls configuration for additional hostnames to be covered with this ingress record.                                           | `[]`                |
| `livebook.ingress.secrets`                  | If you're providing your own certificates, please use this to add the certificates as secrets                                    | `[]`                |
| `livebook.ingress.extraRules`               | Additional rules to be covered with this ingress record                                                                          | `[]`                |
| `livebook.persistence.enabled`              | Enable Livebook data persistence using PVC. If false, use emptyDir                                                               | `false`             |
| `livebook.persistence.storageClass`         | PVC Storage Class for Livebook data volume                                                                                       | `""`                |
| `livebook.persistence.mountPath`            | Data volume mount path                                                                                                           | `/data`             |
| `livebook.persistence.accessModes`          | PVC Access Modes for Livebook data volume                                                                                        | `["ReadWriteOnce"]` |
| `livebook.persistence.size`                 | PVC Storage Request for Livebook data volume                                                                                     | `8Gi`               |
| `livebook.persistence.annotations`          | Annotations for the PVC                                                                                                          | `{}`                |
| `livebook.persistence.existingClaim`        | Name of an existing PVC to use (only in `standalone` mode)                                                                       | `""`                |

### Volume Permissions parameters

| Name                                                                 | Description                                                                                                                                                                                                                                           | Value                      |
| -------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | -------------------------- |
| `livebook.volumePermissions.enabled`                                 | Enable init container that changes the owner and group of the persistent volume(s) mountpoint to `runAsUser:fsGroup`                                                                                                                                  | `false`                    |
| `livebook.volumePermissions.image.registry`                          | Init container volume-permissions image registry                                                                                                                                                                                                      | `REGISTRY_NAME`            |
| `livebook.volumePermissions.image.repository`                        | Init container volume-permissions image repository                                                                                                                                                                                                    | `REPOSITORY_NAME/os-shell` |
| `livebook.volumePermissions.image.tag`                               | Init container volume-permissions image tag                                                                                                                                                                                                           | `12-debian-12-r43`         |
| `livebook.volumePermissions.image.digest`                            | Init container volume-permissions image digest in the way sha256:aa.... Please note this parameter, if set, will override the tag                                                                                                                     | `""`                       |
| `livebook.volumePermissions.image.pullPolicy`                        | Init container volume-permissions image pull policy                                                                                                                                                                                                   | `IfNotPresent`             |
| `livebook.volumePermissions.image.pullSecrets`                       | Specify docker-registry secret names as an array                                                                                                                                                                                                      | `[]`                       |
| `livebook.volumePermissions.resourcesPreset`                         | Set container resources according to one common preset (allowed values: none, nano, micro, small, medium, large, xlarge, 2xlarge). This is ignored if volumePermissions.resources is set (volumePermissions.resources is recommended for production). | `nano`                     |
| `livebook.volumePermissions.resources`                               | Set container requests and limits for different resources like CPU or memory (essential for production workloads)                                                                                                                                     | `{}`                       |
| `livebook.volumePermissions.containerSecurityContext.seLinuxOptions` | Set SELinux options in container                                                                                                                                                                                                                      | `{}`                       |
| `livebook.volumePermissions.containerSecurityContext.runAsUser`      | User ID for the init container                                                                                                                                                                                                                        | `0`                        |

### RBAC parameters

| Name                                                   | Description                                               | Value  |
| ------------------------------------------------------ | --------------------------------------------------------- | ------ |
| `livebook.serviceAccount.create`                       | Enable the creation of a ServiceAccount for Livebook pods | `true` |
| `livebook.serviceAccount.name`                         | Name of the created ServiceAccount                        | `""`   |
| `livebook.serviceAccount.automountServiceAccountToken` | Enable/disable auto mounting of the service account token | `true` |
| `livebook.serviceAccount.annotations`                  | Custom annotations for Livebook ServiceAccount            | `{}`   |

### Other parameters

| Name                          | Description                                                                       | Value  |
| ----------------------------- | --------------------------------------------------------------------------------- | ------ |
| `livebook.pdb.create`         | Enable/disable a Pod Disruption Budget creation                                   | `true` |
| `livebook.pdb.minAvailable`   | Minimum number/percentage of pods that must still be available after the eviction | `""`   |
| `livebook.pdb.maxUnavailable` | Maximum number/percentage of pods that may be made unavailable after the eviction | `""`   |

To install the chart with the release name `my-release`:

    helm install my-release oci://ghcr.io/mruoss/charts/livebook --set livebook.auth.livebookPassword password-used-to-login

## Configuration and installation details

### Password Protection

Livebook cannot be deployed without protection. This Helm chart therefore
requires defining a password. The password can be given as a value to `helm
install`. Alternatively, an existing secret can be deployed separately and
referenced under `livebook.auth.existingSecret`. The referenced secret must define a
key `.data.livebookPassword` containing the password.

### Persistence

Setting `livebook.persistence.enabled` to `true` will mount a volume on the
default path for locally stored livebooks. Note that using persistence on
multilple replicas will lead to problems. See the next section for further
information.

### Multiple Replicas and Clustering

Multiple replicas (`livebook.replicaCount > 0`) are joined to form an Erlang
cluster by default. This means that all sessions are shared among all replicas
of Livebook.

Note that using persistence on multilple replicas should be
avoided because each replica only has access to notebooks that were saved on
that node. You can store livebooks on S3 (see `livebook.s3.*`values) in order to
have access to all notebooks from all nodes.

### Global parameters

| Name                                                  | Description                                                                                                                                                                                                                                                                                                                                                         | Value  |
| ----------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------ |
| `global.imageRegistry`                                | Global Docker image registry                                                                                                                                                                                                                                                                                                                                        | `""`   |
| `global.imagePullSecrets`                             | Global Docker registry secret names as an array                                                                                                                                                                                                                                                                                                                     | `[]`   |
| `global.storageClass`                                 | Global StorageClass for Persistent Volume(s)                                                                                                                                                                                                                                                                                                                        | `""`   |
| `global.compatibility.openshift.adaptSecurityContext` | Adapt the securityContext sections of the deployment to make them compatible with Openshift restricted-v2 SCC: remove runAsUser, runAsGroup and fsGroup and let the platform use their allowed default IDs. Possible values: auto (apply if the detected running cluster is Openshift), force (perform the adaptation always), disabled (do not perform adaptation) | `auto` |

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

| Name                                        | Description                                                                                              | Value                           |
| ------------------------------------------- | -------------------------------------------------------------------------------------------------------- | ------------------------------- |
| `livebook.auth.livebookPassword`            | Password used to access Livebook. Must be at least 12 characters.                                        | `""`                            |
| `livebook.auth.existingSecret`              | Optionally specify an existing secret holding the livebook password.                                     | `{}`                            |
| `livebook.clustering.livebookCookie`        | Optionally define the cookie for running Livebook in a cluster.                                          | `randomly set`                  |
| `livebook.clustering.existingSecret`        | Optionally specify an existing secret holding values for `livebookCookie`.                               | `{}`                            |
| `livebook.networking.livebookSecretKeyBase` | Optionally define the cookie for running Livebook in a cluster.                                          | `randomly set`                  |
| `livebook.networking.existingSecret`        | Optionally specify an existing secret holding values for `livebookSecretKeyBase`.                        | `{}`                            |
| `livebook.s3.livebookAwsCredentials`        | Whether or not to read the S3 credentials from environment variables.                                    | `false`                         |
| `livebook.s3.awsAccessKeyId`                | S3 Access Key ID                                                                                         | `""`                            |
| `livebook.s3.awsSecretAccessKey`            | S3 Secret Access Key                                                                                     | `""`                            |
| `livebook.s3.existingSecret`                | Optionally specify an existing secret holding values for `awsAccessKeyId` and `awsSecretAccessKey`.      | `{}`                            |
| `livebook.image.registry`                   | Livebook image registry                                                                                  | `ghcr.io`                       |
| `livebook.image.repository`                 | Livebook image repository                                                                                | `ghcr.io/livebook-dev/livebook` |
| `livebook.image.digest`                     | Livebook image digest in the way sha256:aa.... Please note this parameter, if set, will override the tag | `""`                            |
| `livebook.image.pullPolicy`                 | Image pull policy                                                                                        | `IfNotPresent`                  |
| `livebook.image.pullSecrets`                | Specify docker-registry secret names as an array                                                         | `[]`                            |
| `livebook.replicaCount`                     | Number of livebook replicas to deploy                                                                    | `1`                             |
| `livebook.extraEnvVars`                     | Extra environment variables to be set on Livebook container                                              | `[]`                            |
| `livebook.extraEnvVarsCM`                   | ConfigMap with extra environment variables                                                               | `""`                            |
| `livebook.extraEnvVarsSecret`               | Secret with extra environment variables                                                                  | `""`                            |
| `livebook.command`                          | Default container command (useful when using custom images). Use array form                              | `[]`                            |
| `livebook.args`                             | Default container args (useful when using custom images). Use array form                                 | `[]`                            |

### Livebook deployment parameters

| Name                                                         | Description                                                                                                                                                                                                       | Value            |
| ------------------------------------------------------------ | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ---------------- |
| `livebook.schedulerName`                                     | Specifies the schedulerName, if it's nil uses kube-scheduler                                                                                                                                                      | `""`             |
| `livebook.terminationGracePeriodSeconds`                     | In seconds, time the given to the Livebook pod needs to terminate gracefully                                                                                                                                      | `""`             |
| `livebook.deployment.updateStrategy.type`                    | Deployment strategy type                                                                                                                                                                                          | `RollingUpdate`  |
| `livebook.deployment.updateStrategy.rollingUpdate`           | Controller deployment rolling update configuration parameters                                                                                                                                                     | `{}`             |
| `livebook.automountServiceAccountToken`                      | Mount Service Account token in pod                                                                                                                                                                                | `false`          |
| `livebook.hostAliases`                                       | Livebook pod host aliases                                                                                                                                                                                         | `[]`             |
| `livebook.containerPorts.livebook`                           | Livebook container port to open                                                                                                                                                                                   | `9000`           |
| `livebook.podSecurityContext.enabled`                        | Enable pod Security Context                                                                                                                                                                                       | `true`           |
| `livebook.podSecurityContext.sysctls`                        | Set kernel settings using the sysctl interface                                                                                                                                                                    | `[]`             |
| `livebook.podSecurityContext.supplementalGroups`             | Set filesystem extra groups                                                                                                                                                                                       | `[]`             |
| `livebook.podSecurityContext.fsGroup`                        | Group ID for the container                                                                                                                                                                                        | `1001`           |
| `livebook.podSecurityContext.fsGroupChangePolicy`            | Set filesystem group change policy                                                                                                                                                                                | `OnRootMismatch` |
| `livebook.podSecurityContext.sysctls`                        | Set kernel settings using the sysctl interface                                                                                                                                                                    | `[]`             |
| `livebook.podSecurityContext.supplementalGroups`             | Set filesystem extra groups                                                                                                                                                                                       | `[]`             |
| `livebook.podSecurityContext.fsGroupChangePolicy`            | When K8s should preform chown on attached volumes                                                                                                                                                                 | `OnRootMismatch` |
| `livebook.containerSecurityContext.enabled`                  | Enabled containers' Security Context                                                                                                                                                                              | `true`           |
| `livebook.containerSecurityContext.seLinuxOptions`           | Set SELinux options in container                                                                                                                                                                                  | `{}`             |
| `livebook.containerSecurityContext.runAsUser`                | Set containers' Security Context runAsUser                                                                                                                                                                        | `1001`           |
| `livebook.containerSecurityContext.runAsGroup`               | Set containers' Security Context runAsGroup                                                                                                                                                                       | `1001`           |
| `livebook.containerSecurityContext.runAsNonRoot`             | Set container's Security Context runAsNonRoot                                                                                                                                                                     | `true`           |
| `livebook.containerSecurityContext.privileged`               | Set container's Security Context privileged                                                                                                                                                                       | `false`          |
| `livebook.containerSecurityContext.readOnlyRootFilesystem`   | Set container's Security Context readOnlyRootFilesystem                                                                                                                                                           | `true`           |
| `livebook.containerSecurityContext.allowPrivilegeEscalation` | Set container's Security Context allowPrivilegeEscalation                                                                                                                                                         | `false`          |
| `livebook.containerSecurityContext.capabilities.drop`        | List of capabilities to be dropped                                                                                                                                                                                | `["ALL"]`        |
| `livebook.containerSecurityContext.seccompProfile.type`      | Set container's Security Context seccomp profile                                                                                                                                                                  | `RuntimeDefault` |
| `livebook.podLabels`                                         | Extra labels for Livebook pods                                                                                                                                                                                    | `{}`             |
| `livebook.podAnnotations`                                    | Annotations for Livebook pods                                                                                                                                                                                     | `{}`             |
| `livebook.podAffinityPreset`                                 | Pod affinity preset. Ignored if `affinity` is set. Allowed values: `soft` or `hard`                                                                                                                               | `""`             |
| `livebook.podAntiAffinityPreset`                             | Pod anti-affinity preset. Ignored if `affinity` is set. Allowed values: `soft` or `hard`                                                                                                                          | `soft`           |
| `livebook.nodeAffinityPreset.type`                           | Node affinity preset type. Ignored if `affinity` is set. Allowed values: `soft` or `hard`                                                                                                                         | `""`             |
| `livebook.nodeAffinityPreset.key`                            | Node label key to match. Ignored if `affinity` is set.                                                                                                                                                            | `""`             |
| `livebook.nodeAffinityPreset.values`                         | Node label values to match. Ignored if `affinity` is set.                                                                                                                                                         | `[]`             |
| `livebook.affinity`                                          | Affinity for pod assignment. Evaluated as a template.                                                                                                                                                             | `{}`             |
| `livebook.nodeSelector`                                      | Node labels for pod assignment. Evaluated as a template.                                                                                                                                                          | `{}`             |
| `livebook.tolerations`                                       | Tolerations for pod assignment. Evaluated as a template.                                                                                                                                                          | `[]`             |
| `livebook.topologySpreadConstraints`                         | Topology Spread Constraints for Livebook pods assignment spread across your cluster among failure-domains                                                                                                         | `[]`             |
| `livebook.priorityClassName`                                 | Livebook pods' priorityClassName                                                                                                                                                                                  | `""`             |
| `livebook.runtimeClassName`                                  | Name of the runtime class to be used by Livebook pods'                                                                                                                                                            | `""`             |
| `livebook.resourcesPreset`                                   | Set container resources according to one common preset (allowed values: none, nano, micro, small, medium, large, xlarge, 2xlarge). This is ignored if resources is set (resources is recommended for production). | `micro`          |
| `livebook.resources`                                         | Set container requests and limits for different resources like CPU or memory (essential for production workloads)                                                                                                 | `{}`             |
| `livebook.livenessProbe.enabled`                             | Enable livenessProbe                                                                                                                                                                                              | `true`           |
| `livebook.livenessProbe.initialDelaySeconds`                 | Initial delay seconds for livenessProbe                                                                                                                                                                           | `5`              |
| `livebook.livenessProbe.periodSeconds`                       | Period seconds for livenessProbe                                                                                                                                                                                  | `5`              |
| `livebook.livenessProbe.timeoutSeconds`                      | Timeout seconds for livenessProbe                                                                                                                                                                                 | `5`              |
| `livebook.livenessProbe.failureThreshold`                    | Failure threshold for livenessProbe                                                                                                                                                                               | `5`              |
| `livebook.livenessProbe.successThreshold`                    | Success threshold for livenessProbe                                                                                                                                                                               | `1`              |
| `livebook.readinessProbe.enabled`                            | Enable readinessProbe                                                                                                                                                                                             | `true`           |
| `livebook.readinessProbe.initialDelaySeconds`                | Initial delay seconds for readinessProbe                                                                                                                                                                          | `5`              |
| `livebook.readinessProbe.periodSeconds`                      | Period seconds for readinessProbe                                                                                                                                                                                 | `5`              |
| `livebook.readinessProbe.timeoutSeconds`                     | Timeout seconds for readinessProbe                                                                                                                                                                                | `1`              |
| `livebook.readinessProbe.failureThreshold`                   | Failure threshold for readinessProbe                                                                                                                                                                              | `5`              |
| `livebook.readinessProbe.successThreshold`                   | Success threshold for readinessProbe                                                                                                                                                                              | `1`              |
| `livebook.customLivenessProbe`                               | Override default liveness probe                                                                                                                                                                                   | `{}`             |
| `livebook.customReadinessProbe`                              | Override default readiness probe                                                                                                                                                                                  | `{}`             |
| `livebook.customStartupProbe`                                | Override default startup probe                                                                                                                                                                                    | `{}`             |
| `livebook.lifecycleHooks`                                    | for the Livebookcontainer(s) to automate configuration before or after startup                                                                                                                                    | `{}`             |
| `livebook.extraVolumes`                                      | Optionally specify extra list of additional volumes for Livebook pods                                                                                                                                             | `[]`             |
| `livebook.extraVolumeMounts`                                 | Optionally specify extra list of additional volumeMounts for Livebook container(s)                                                                                                                                | `[]`             |
| `livebook.initContainers`                                    | Add additional init containers to the Livebook pods                                                                                                                                                               | `[]`             |
| `livebook.sidecars`                                          | Add additional sidecar containers to the Livebook pods                                                                                                                                                            | `[]`             |

### Traffic exposure parameters

| Name                                        | Description                                                                                                                      | Value               |
| ------------------------------------------- | -------------------------------------------------------------------------------------------------------------------------------- | ------------------- |
| `livebook.service.type`                     | Livebook service type                                                                                                            | `ClusterIP`         |
| `livebook.service.ports.livebook`           | Livebook service port                                                                                                            | `9000`              |
| `livebook.service.nodePorts.livebook`       | Specify the Livebook NodePort value for the LoadBalancer and NodePort service types                                              | `""`                |
| `livebook.service.clusterIP`                | Service Cluster IP                                                                                                               | `""`                |
| `livebook.service.loadBalancerIP`           | loadBalancerIP if service type is `LoadBalancer` (optional, cloud specific)                                                      | `""`                |
| `livebook.service.loadBalancerSourceRanges` | Addresses that are allowed when service is LoadBalancer                                                                          | `[]`                |
| `livebook.service.externalTrafficPolicy`    | Enable client source IP preservation                                                                                             | `Cluster`           |
| `livebook.service.extraPorts`               | Extra ports to expose in the service (normally used with the `sidecar` value)                                                    | `[]`                |
| `livebook.service.annotations`              | Annotations for Livebook service                                                                                                 | `{}`                |
| `livebook.service.headless.annotations`     | Annotations for the headless service.                                                                                            | `{}`                |
| `livebook.ingress.enabled`                  | Enable ingress controller resource for Livebook                                                                                  | `true`              |
| `livebook.ingress.apiVersion`               | Force Ingress API version (automatically detected if not set)                                                                    | `""`                |
| `livebook.ingress.ingressClassName`         | IngressClass that will be be used to implement the Ingress (Kubernetes 1.18+)                                                    | `""`                |
| `livebook.ingress.hostname`                 | Default host for the ingress resource                                                                                            | `livebook.local`    |
| `livebook.ingress.path`                     | The Path to Livebook. You may need to set this to '/\*' in order to use this with ALB ingress controllers.                       | `/`                 |
| `livebook.ingress.pathType`                 | Ingress path type                                                                                                                | `Prefix`            |
| `livebook.ingress.servicePort`              | Service port to be used                                                                                                          | `livebook-main`     |
| `livebook.ingress.annotations`              | Additional annotations for the Ingress resource. To enable certificate autogeneration, place here your cert-manager annotations. | `{}`                |
| `livebook.ingress.tls`                      | Enable TLS configuration for the hostname defined at `ingress.hostname` parameter                                                | `false`             |
| `livebook.ingress.selfSigned`               | Create a TLS secret for this ingress record using self-signed certificates generated by Helm                                     | `false`             |
| `livebook.ingress.extraHosts`               | The list of additional hostnames to be covered with this ingress record.                                                         | `[]`                |
| `livebook.ingress.extraPaths`               | Any additional paths that may need to be added to the ingress under the main host                                                | `[]`                |
| `livebook.ingress.extraTls`                 | The tls configuration for additional hostnames to be covered with this ingress record.                                           | `[]`                |
| `livebook.ingress.secrets`                  | If you're providing your own certificates, please use this to add the certificates as secrets                                    | `[]`                |
| `livebook.ingress.extraRules`               | Additional rules to be covered with this ingress record                                                                          | `[]`                |
| `livebook.persistence.enabled`              | Enable Livebook data persistence using PVC. If false, use emptyDir                                                               | `false`             |
| `livebook.persistence.storageClass`         | PVC Storage Class for Livebook data volume                                                                                       | `""`                |
| `livebook.persistence.mountPath`            | Data volume mount path                                                                                                           | `/data`             |
| `livebook.persistence.accessModes`          | PVC Access Modes for Livebook data volume                                                                                        | `["ReadWriteOnce"]` |
| `livebook.persistence.size`                 | PVC Storage Request for Livebook data volume                                                                                     | `8Gi`               |
| `livebook.persistence.annotations`          | Annotations for the PVC                                                                                                          | `{}`                |
| `livebook.persistence.existingClaim`        | Name of an existing PVC to use (only in `standalone` mode)                                                                       | `""`                |

### Volume Permissions parameters

| Name                                                                 | Description                                                                                                                                                                                                                                           | Value                      |
| -------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | -------------------------- |
| `livebook.volumePermissions.enabled`                                 | Enable init container that changes the owner and group of the persistent volume(s) mountpoint to `runAsUser:fsGroup`                                                                                                                                  | `false`                    |
| `livebook.volumePermissions.image.registry`                          | Init container volume-permissions image registry                                                                                                                                                                                                      | `REGISTRY_NAME`            |
| `livebook.volumePermissions.image.repository`                        | Init container volume-permissions image repository                                                                                                                                                                                                    | `REPOSITORY_NAME/os-shell` |
| `livebook.volumePermissions.image.digest`                            | Init container volume-permissions image digest in the way sha256:aa.... Please note this parameter, if set, will override the tag                                                                                                                     | `""`                       |
| `livebook.volumePermissions.image.pullPolicy`                        | Init container volume-permissions image pull policy                                                                                                                                                                                                   | `IfNotPresent`             |
| `livebook.volumePermissions.image.pullSecrets`                       | Specify docker-registry secret names as an array                                                                                                                                                                                                      | `[]`                       |
| `livebook.volumePermissions.resourcesPreset`                         | Set container resources according to one common preset (allowed values: none, nano, micro, small, medium, large, xlarge, 2xlarge). This is ignored if volumePermissions.resources is set (volumePermissions.resources is recommended for production). | `nano`                     |
| `livebook.volumePermissions.resources`                               | Set container requests and limits for different resources like CPU or memory (essential for production workloads)                                                                                                                                     | `{}`                       |
| `livebook.volumePermissions.containerSecurityContext.seLinuxOptions` | Set SELinux options in container                                                                                                                                                                                                                      | `{}`                       |
| `livebook.volumePermissions.containerSecurityContext.runAsUser`      | User ID for the init container                                                                                                                                                                                                                        | `0`                        |

### RBAC parameters

| Name                                                   | Description                                               | Value   |
| ------------------------------------------------------ | --------------------------------------------------------- | ------- |
| `livebook.serviceAccount.create`                       | Enable the creation of a ServiceAccount for Livebook pods | `true`  |
| `livebook.serviceAccount.name`                         | Name of the created ServiceAccount                        | `""`    |
| `livebook.serviceAccount.automountServiceAccountToken` | Enable/disable auto mounting of the service account token | `false` |
| `livebook.serviceAccount.annotations`                  | Custom annotations for Livebook ServiceAccount            | `{}`    |

### Other parameters

| Name                          | Description                                                                       | Value  |
| ----------------------------- | --------------------------------------------------------------------------------- | ------ |
| `livebook.pdb.create`         | Enable/disable a Pod Disruption Budget creation                                   | `true` |
| `livebook.pdb.minAvailable`   | Minimum number/percentage of pods that must still be available after the eviction | `""`   |
| `livebook.pdb.maxUnavailable` | Maximum number/percentage of pods that may be made unavailable after the eviction | `""`   |
