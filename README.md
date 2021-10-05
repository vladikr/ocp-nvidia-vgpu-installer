# NVIDIA GRID driver delivery with OpenShift Driver-Container Toolkit

This repository is a container image that is based on the (OpenShift Driver-Container Toolkit)[https://github.com/openshift/driver-toolkit].
This container image installs the NVIDIA's generic Linux GRID driver on Red Hat CoreOS nodes. 

## Requirements

* The generic GRID Linux installer for vGPU should be obtained from the NVIDIA Licensing portal. This repo uses the NVIDIA-Linux-x86_64-470.63-vgpu-kvm.run
* Knowledge of the host's kernel version.
* An image of the OpenShift Driver-Container Toolkit that matches the target cluster version.

### Obtaining the driver toolkit base image
```
$ oc adm release info --image-for=driver-toolkit
quay.io/openshift-release-dev/ocp-v4.0-art-dev@sha256:e0f9b9154538af082596f60af99290b5a751e61fd61100912defb71b6cac15c6
```

### Configure 
 - Update the `FROM` in the (Dockerfile)[Dockerfile] with the relevant driver toolkit image.
 - Update the relevant `ADD` in the (Dockerfile)[Dockerfile] with the relevant NVIDIA installer binary (E.g. `NVIDIA-Linux-x86_64-470.63-vgpu-kvm.run`)
 - Update the `entrypoint.sh` file with the host's kernel version. (E.g. `4.18.0-305.17.1.el8_4.x86_64`)

### Building the container image:

```
podman build -t ocp-nvidia-vgpu-nstaller .
podman push [registry_url]/ocp-nvidia-vgpu-nstaller
```

### Deployment

 - Update the 1000-drivercontainer.yaml to point to the container image.
 - Use an existing node label or label the relevant nodes where this driver should be installed
   - `oc label nodes worker-0 hasGpu=true`
 - Apply the 1000-drivercontainer.yaml to the cluster
   - `oc create -f 1000-driverscontainer.yaml`

