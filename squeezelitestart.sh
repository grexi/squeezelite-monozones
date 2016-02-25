#!/bin/ash
export LD_LIBRARY_PATH=/opt/lib
export PATH=/sbin:/bin:/usr/sbin:/usr/bin:/usr/syno/sbin:/usr/syno/bin:/usr/local/sbin:/usr/local/bin
export HOME=/root

SL="/volume1/squeezelite/squeezelite-i386"
LOGDIR="/volume1/squeezelite/log/"

echo "Starting up Squeezelites" >> ${LOGDIR}startup.log
date >> ${LOGDIR}startup.log

echo "setup asoundrc (sound card definitions)" >> ${LOGDIR}startup.log
ln -fs /volume1/squeezelite/asoundrc /etc/asound.conf


echo "initializing alsa" >> ${LOGDIR}startup.log
/opt/sbin/alsactl init
echo "reset mixer state from asound.state" >> ${LOGDIR}startup.log
/opt/sbin/alsactl --file /volume1/squeezelite/asound.state restore

echo "checking output devices" >> ${LOGDIR}startup.log
/opt/bin/aplay -l >> ${LOGDIR}startup.log

$SL -l >> ${LOGDIR}startup.log

if [ "$1" = "sleep" ]; then
echo "Using start up delay of 60 secs" >> ${LOGDIR}startup.log
sleep 60
echo "initializing alsa" >> ${LOGDIR}startup.log
/opt/sbin/alsactl init
echo "reset mixer state from asound.state" >> ${LOGDIR}startup.log
/opt/sbin/alsactl --file /volume1/squeezelite/asound.state restore

echo "checking output devices, again" >> ${LOGDIR}startup.log
/opt/bin/aplay -l >> ${LOGDIR}startup.log
$SL -l >> ${LOGDIR}startup.log
fi

echo "starting squeezelite instances" >> ${LOGDIR}startup.log
date >> ${LOGDIR}startup.log

DEFOPTS="-z -d all=info -f"

#/opt/bin/strace -o ${LOGDIR}strace.log 
#stop older processes
! killall squeezelite-i386
$SL $DEFOPTS ${LOGDIR}BAD.log -o mono_zone1 -n Bad -m 00:00:00:00:00:F1
$SL $DEFOPTS ${LOGDIR}GAESTEBAD.log -o mono_zone2 -n Gästebad -m 00:00:00:00:00:F2
#$SL $DEFOPTS ${LOGDIR}BAD1.log -o card1_dmix -n BAD1 -m 00:00:00:00:00:F1
$SL $DEFOPTS ${LOGDIR}ESSZIMMER.log -o card2_dmix -n Esszimmer -m 00:00:00:00:00:F3
#$SL $DEFOPTS ${LOGDIR}BAD4.log -o mono_zone4 -n BAD4 -m 00:00:00:00:00:F4
$SL $DEFOPTS ${LOGDIR}BUERO.log -o card3_dmix -n Büro -m 00:00:00:00:00:F4

$SL $DEFOPTS ${LOGDIR}KIND_LINKS.log -o mono_zone7 -n "Kinderzimmer Links" -m 00:00:00:00:00:F5
$SL $DEFOPTS ${LOGDIR}KIND_RECHTS.log -o mono_zone8 -n "Kinderzimmer Rechts" -m 00:00:00:00:00:F6
$SL $DEFOPTS ${LOGDIR}SCHLAFZIMMER.log -o mono_zone9 -n "Schlafzimmer" -m 00:00:00:00:00:F7
$SL $DEFOPTS ${LOGDIR}GAESTEZIMMER.log -o mono_zone10 -n "Gästezimmer"  -m 00:00:00:00:00:F8
#$SL $DEFOPTS ${LOGDIR}BAD10.log -o mono_zone10 -n BAD10 -m 00:00:00:00:00:FA



# manual run for debugging
#LD_LIBRARY_PATH=/opt/lib /volume1/squeezelite/squeezelite-i386 -d all=info -n DEBUG -m 00:00:00:00:00:C0 -o mono_zone1
## sound card device nodes
## following /proc/asound/devices numbers
#mknod /dev/snd/controlC2 c 116 64
#mknod /dev/snd/controlC3 c 116 96
#mknod /dev/snd/pcmC2D0p  c 116 80
#mknod /dev/snd/pcmC3D0p  c 116 112

echo "Done!" >> ${LOGDIR}startup.log
date >> ${LOGDIR}startup.log

