FROM quay.io/openshift-release-dev/ocp-v4.0-art-dev@sha256:4a197c0dfdf5ca30ff48d6eee25960001dbaa82c86b6dd920c6acc47f5680701
ARG NVIDIA_INSTALLER_BINARY
ENV NVIDIA_INSTALLER_BINARY=${NVIDIA_INSTALLER_BINARY:-NVIDIA-Linux-x86_64-470.63-vgpu-kvm.run}

RUN mkdir -p /root/nvidia
WORKDIR /root/nvidia
ADD ${NVIDIA_INSTALLER_BINARY} .
RUN chmod +x /root/nvidia/${NVIDIA_INSTALLER_BINARY}
ADD entrypoint.sh .
RUN chmod +x /root/nvidia/entrypoint.sh

RUN mkdir -p /root/tmp
