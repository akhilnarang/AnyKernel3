# AnyKernel2 Ramdisk Mod Script
# osm0sis @ xda-developers

## AnyKernel setup
# begin properties
properties() {
kernel.string=Dominator by Abhishek
do.devicecheck=1
do.modules=0
do.cleanup=1
do.cleanuponabort=0
device.name1=kenzo
device.name2=redminote3
device.name3=rn3
device.name4=redmi note 3
device.name5=kate
} # end properties

# shell variables
block=/dev/block/bootdevice/by-name/boot;
is_slot_device=0;


## AnyKernel methods (DO NOT CHANGE)
# import patching functions/variables - see for reference
. /tmp/anykernel/tools/ak2-core.sh;


## AnyKernel permissions
# set permissions for included ramdisk files
chmod -R 755 $ramdisk

## AnyKernel install
dump_boot;

# begin ramdisk changes

# Umm well, no ramdisk changes

# end ramdisk changes

write_boot;

## end install

