#!/bin/ash
export LD_LIBRARY_PATH=/opt/lib
SL="/volume1/squeezelite/squeezelite-i386"
LOGDIR="/volume1/squeezelite/log/"

DEFOPTS="-z -d all=info -f"

#setup asoundrc (sound card definitions)
ln -fs /volume1/squeezelite/asoundrc /root/.asoundrc

#reset mixer state
/opt/sbin/alsactl --file /volume1/squeezelite/asound.state restore

#stop older processes
killall squeezelite-i386
#$SL $DEFOPTS ${LOGDIR}BAD1.log -o mono_zone1 -n BAD1 -m 00:00:00:00:00:F1
#$SL $DEFOPTS ${LOGDIR}BAD2.log -o mono_zone2 -n BAD2 -m 00:00:00:00:00:F2
$SL $DEFOPTS ${LOGDIR}BAD1.log -o card1_dmix -n BAD1 -m 00:00:00:00:00:F1
$SL $DEFOPTS ${LOGDIR}BAD3.log -o mono_zone3 -n BAD3 -m 00:00:00:00:00:F3
$SL $DEFOPTS ${LOGDIR}BAD4.log -o mono_zone4 -n BAD4 -m 00:00:00:00:00:F4
$SL $DEFOPTS ${LOGDIR}BAD5.log -o mono_zone5 -n BAD5 -m 00:00:00:00:00:F5
$SL $DEFOPTS ${LOGDIR}BAD6.log -o mono_zone6 -n BAD6 -m 00:00:00:00:00:F6
$SL $DEFOPTS ${LOGDIR}BAD7.log -o mono_zone7 -n BAD7 -m 00:00:00:00:00:F7
$SL $DEFOPTS ${LOGDIR}BAD8.log -o mono_zone8 -n BAD8 -m 00:00:00:00:00:F8
$SL $DEFOPTS ${LOGDIR}BAD9.log -o mono_zone9 -n BAD9 -m 00:00:00:00:00:F9
$SL $DEFOPTS ${LOGDIR}BAD10.log -o mono_zone10 -n BAD10 -m 00:00:00:00:00:FA

# manual run for debugging
#LD_LIBRARY_PATH=/opt/lib /volume1/squeezelite/squeezelite-i386 -d all=info -n DEBUG -m 00:00:00:00:00:C0 -o mono_zone1
## sound card device nodes
## following /proc/asound/devices numbers
#mknod /dev/snd/controlC2 c 116 64
#mknod /dev/snd/controlC3 c 116 96
#mknod /dev/snd/pcmC2D0p  c 116 80
#mknod /dev/snd/pcmC3D0p  c 116 112

