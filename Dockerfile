FROM quay.io/openshift-release-dev/ocp-v4.0-art-dev@sha256:0f046d61ecc9855e0b7d1846d645661b32654a358c1530dd20efb31f65686f8d

RUN dnf -y install git make sudo gcc \
&& dnf clean all \
&& rm -rf /var/cache/dnf

# Grab the software from upstream and place in the current working director
# before running the contianer build commands
RUN mkdir -p /root/nvidia
WORKDIR /root/nvidia
ADD NVIDIA-Linux-x86_64-470.63-vgpu-kvm.run .
RUN chmod +x /root/nvidia/NVIDIA-Linux-x86_64-470.63-vgpu-kvm.run
ADD entrypoint.sh .
RUN chmod +x /root/nvidia/entrypoint.sh
# ADD Makefile .

COPY ./install-nvidia-driver.service /etc/systemd/system/
RUN systemctl enable install-nvidia-driver

# Extract the NVIDIA drivers, and run the make command to build the kernel modules
# Move the required files into their proper locations
# Enable the required services
RUN mkdir -p /root/tmp
RUN systemctl enable kmods-via-containers@simple-kmod
ENTRYPOINT ["/entrypoint.sh"]
