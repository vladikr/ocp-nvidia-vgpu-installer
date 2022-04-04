# NVIDIA GRID driver delivery with OpenShift Driver-Container Toolkit

This repository is a container image that is based on the [OpenShift Driver-Container Toolkit](https://github.com/openshift/driver-toolkit).
This container image installs the NVIDIA's generic Linux GRID driver on Red Hat CoreOS nodes.

## Requirements

* The generic GRID Linux installer for vGPU should be obtained from the NVIDIA Licensing portal. This repo uses the `NVIDIA-Linux-x86_64-470.63-vgpu-kvm.run`
* An image of the OpenShift Driver-Container Toolkit that matches the target cluster version.

### Obtaining the driver toolkit base image
```
$ oc adm release info --image-for=driver-toolkit
quay.io/openshift-release-dev/ocp-v4.0-art-dev@sha256:4a197c0dfdf5ca30ff48d6eee25960001dbaa82c86b6dd920c6acc47f5680701
```

### Configure
 - Update the `FROM` in the [Dockerfile](Dockerfile) with the relevant driver toolkit image.

### Building the container image:

```
podman build --build-arg NVIDIA_INSTALLER_BINARY=NVIDIA-Linux-x86_64-470.63-vgpu-kvm.run -t ocp-nvidia-vgpu-nstaller .
podman push [registry_url]/ocp-nvidia-vgpu-nstaller
```

### Deployment

 - Update the 1000-drivercontainer.yaml to point to the container image.
 - Use an existing node label or label the relevant nodes where this driver should be installed
   - `oc label nodes worker-0 hasGpu=true`
 - Apply the 1000-drivercontainer.yaml to the cluster
   - `oc create -f 1000-driverscontainer.yaml`

