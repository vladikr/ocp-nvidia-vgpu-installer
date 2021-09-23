#!/bin/sh
/root/nvidia/NVIDIA-Linux-x86_64-470.63-vgpu-kvm.run --kernel-source-path=/usr/src/kernels/4.18.0-305.17.1.el8_4.x86_64 --kernel-install-path=/lib/modules/4.18.0-305.17.1.el8_4.x86_64/kernel/drivers/video/ --silent --tmpdir /root/tmp/
systemctl start nvidia-vgpud
systemctl start nvidia-vgpu-mgr

