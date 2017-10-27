# AnyKernel2 Ramdisk Mod Script
# osm0sis @ xda-developers

## AnyKernel setup
# begin properties
properties() {
kernel.string=Flash Kernel for the OnePlus 5 by @nathanchance
do.devicecheck=1
do.modules=1
do.cleanup=1
do.cleanuponabort=0
device.name1=OnePlus5
device.name2=oneplus5
device.name3=cheeseburger
device.name4=
device.name5=
} # end properties

# shell variables
block=/dev/block/bootdevice/by-name/boot;
is_slot_device=0;


## AnyKernel methods (DO NOT CHANGE)
# import patching functions/variables - see for reference
. /tmp/anykernel/tools/ak2-core.sh;


## AnyKernel file attributes
# set permissions/ownership for included ramdisk files
chmod -R 750 $ramdisk/*;
chmod -R root:root $ramdisk/*;

## Alert of unsupported Android version
android_ver=$(mount /system; grep "^ro.build.version.release" /system/build.prop | cut -d= -f2; umount /system);
case "$android_ver" in
  "7.1.1"|"7.1.2") support_status="supported";;
  *) support_status="unsupported";;
esac;
ui_print "Running Android $android_ver, your version is $support_status for this release!";

## AnyKernel install
dump_boot;

# begin ramdisk changes

# Import Flash init file (currently a no-op)
insert_line init.qcom.rc "init.flash.rc" after "import init.qcom.usb.rc" "import init.flash.rc";

# Set the default background app limit to 60
insert_line default.prop "ro.sys.fw.bg_apps_limit=60" before "ro.secure=1" "ro.sys.fw.bg_apps_limit=60";

# Disable dm-verity on /system (due to changed modules)
patch_fstab fstab.qcom /system ext4 options ",errors=panic" ""
patch_fstab fstab.qcom /system ext4 flags ",verify" ""

# end ramdisk changes

write_boot;

## end install

