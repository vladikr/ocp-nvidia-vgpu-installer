FROM quay.io/openshift-release-dev/ocp-v4.0-art-dev@sha256:0f046d61ecc9855e0b7d1846d645661b32654a358c1530dd20efb31f65686f8d
ARG NVIDIA_INSTALLER_BINARY
ENV NVIDIA_INSTALLER_BINARY=${NVIDIA_INSTALLER_BINARY:-NVIDIA-Linux-x86_64-470.63-vgpu-kvm.run}

RUN dnf -y install git make sudo gcc \
&& dnf clean all \
&& rm -rf /var/cache/dnf

RUN mkdir -p /root/nvidia
WORKDIR /root/nvidia
ADD ${NVIDIA_INSTALLER_BINARY} .
RUN chmod +x /root/nvidia/${NVIDIA_INSTALLER_BINARY}
ADD entrypoint.sh .
RUN chmod +x /root/nvidia/entrypoint.sh

RUN mkdir -p /root/tmp
