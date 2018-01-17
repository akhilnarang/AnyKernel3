# AnyKernel2 Ramdisk Mod Script
# osm0sis @ xda-developers

## AnyKernel setup
# begin properties
properties() {
kernel.string=Flash Kernel for the OnePlus 5/T by @nathanchance
do.devicecheck=1
do.modules=1
do.cleanup=1
do.cleanuponabort=0
device.name1=OnePlus5
device.name2=OnePlus5T
device.name3=cheeseburger
device.name4=dumpling
device.name5=
} # end properties

# shell variables
block=/dev/block/bootdevice/by-name/boot;
is_slot_device=0;
ramdisk_compression=auto;


## AnyKernel methods (DO NOT CHANGE)
# import patching functions/variables - see for reference
. /tmp/anykernel/tools/ak2-core.sh;


## AnyKernel file attributes
# set permissions/ownership for included ramdisk files
chmod -R 750 $ramdisk/*;
chown -R root:root $ramdisk/*;

## Alert of unsupported Android version
android_ver=$(mount -o rw,remount -t auto /system;
              grep "^ro.build.version.release" /system/build.prop | cut -d= -f2;
              mount -o ro,remount -t auto /system);
case "$android_ver" in
  "8.0.0"|"8.1.0") support_status="supported";;
  *) support_status="unsupported";;
esac;
ui_print "Running Android $android_ver..."
ui_print "This kernel is $support_status for this version!";

## AnyKernel install
dump_boot;

# begin ramdisk changes

# Set the default background app limit to 60
insert_line default.prop "ro.sys.fw.bg_apps_limit=60" before "ro.secure=1" "ro.sys.fw.bg_apps_limit=60";

# Disable sched_boost as it can hold cores at max frequency
insert_line test "sched_boost 0" after "on property:sys.boot_completed=1" "    write /proc/sys/kernel/sched_boost 0"
insert_line test "sched_boost 1" after "on property:sys.boot_completed=1" "    write /proc/sys/kernel/sched_boost 1"

# end ramdisk changes

write_boot;

## end install

