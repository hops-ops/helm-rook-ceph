# helm-rook-ceph

Crossplane configuration that installs the Rook Ceph operator Helm chart with a minimal, stable interface.

## Overview

This configuration provides a Crossplane XRD for deploying the Rook Ceph operator using the Helm provider. Rook provides cloud-native storage orchestration for Kubernetes, turning distributed storage systems into self-managing services.

## Usage

### Minimal Example

```yaml
apiVersion: helm.hops.ops.com.ai/v1alpha1
kind: RookCeph
metadata:
  name: rook-ceph
  namespace: my-namespace
spec:
  clusterName: my-cluster
```

### Standard Example

```yaml
apiVersion: helm.hops.ops.com.ai/v1alpha1
kind: RookCeph
metadata:
  name: rook-ceph
  namespace: my-namespace
spec:
  clusterName: my-cluster
  namespace: rook-ceph
  labels:
    team: platform
    environment: production
  providerConfigRef:
    name: my-cluster
    kind: ProviderConfig
  values:
    enableDiscoveryDaemon: true
    csi:
      enableRbdDriver: true
      enableCephfsDriver: true
```

## Configuration Options

| Field | Description | Default |
|-------|-------------|---------|
| `clusterName` | Target cluster name (used for provider config) | Required |
| `namespace` | Kubernetes namespace for the release | `rook-ceph` |
| `name` | Helm release name | XR metadata.name |
| `labels` | Labels applied to managed resources | See below |
| `providerConfigRef.name` | Helm ProviderConfig name | `clusterName` |
| `providerConfigRef.kind` | ProviderConfig kind | `ProviderConfig` |
| `values` | Helm values (merged with defaults) | `{}` |
| `overrideAllValues` | Helm values (replaces all defaults) | `{}` |
| `managementPolicies` | Crossplane management policies | `["*"]` |

### Default Labels

```yaml
hops.ops.com.ai/managed: "true"
hops.ops.com.ai/rookceph: "<name>"
```

## Helm Chart

- **Chart**: rook-ceph
- **Repository**: https://charts.rook.io/release
- **Version**: v1.18.3

## Dependencies

- Provider: crossplane-contrib/provider-helm >= v1.0.6
- Function: crossplane-contrib/function-auto-ready >= v0.6.0
