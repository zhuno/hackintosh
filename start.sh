#!/bin/bash

OSK="ourhardworkbythesewordsguardedpleasedontsteal(c)AppleComputerInc"
VMDIR=$PWD
OVMF=$VMDIR/firmware
#export QEMU_AUDIO_DRV=pa
#QEMU_AUDIO_DRV=pa

# VM-Konfiguration
qemu-system-x86_64 \
    -enable-kvm \
    # Arbeitsspeicher (für MacOS nutzbar)
    -m 4G \
	# -/-
    -machine q35,accel=kvm \
    # CPU-Konfiguration
    -smp cores=2,threads=4,sockets=1 \
    # -/-
    -cpu Penryn,vendor=GenuineIntel,kvm=on,+sse3,+sse4.2,+aes,+xsave,+avx,+xsaveopt,+xsavec,+xgetbv1,+avx2,+bmi2,+smep,+bmi1,+fma,+movbe,+invtsc \
    -device isa-applesmc,osk="$OSK" \
    -smbios type=2 \
    -drive if=pflash,format=raw,readonly,file="$OVMF/OVMF_CODE.fd" \
    -drive if=pflash,format=raw,file="$OVMF/OVMF_VARS-1024x768.fd" \
    -vga qxl \
    -device ich9-intel-hda -device hda-output \
    -usb -device usb-kbd -device usb-mouse \
    -netdev user,id=net0 \
    # Mac-Adresse (Notwendig für Apple-Dienste)
    -device e1000-82545em,netdev=net0,id=net0,mac=52:54:00:c9:18:27 \
    -device ich9-ahci,id=sata \
    -drive id=ESP,if=none,format=qcow2,file=ESP.qcow2 \
    -device ide-hd,bus=sata.2,drive=ESP \
    # Boot-Medium (kann nach Installation entfernt werden)
    -drive id=InstallMedia,format=raw,if=none,file=BaseSystem.img \
    -device ide-hd,bus=sata.3,drive=InstallMedia \
    # System-Partition 
    -drive id=SystemDisk,if=none,file=Disk.qcow2 \
    -device ide-hd,bus=sata.4,drive=SystemDisk \
