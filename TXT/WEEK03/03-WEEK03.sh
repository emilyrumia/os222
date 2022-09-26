#!/bin/bash
# 2E:8A866861
# REV01: Mon 19 Sep 2022 10:00
# START: Sun 27 Feb 2022 17:00

WEEK="05"
SEQ="03"

if   [ -f  98-include.sh ] ; then
    .  ./98-include.sh
elif [ -f  $HOME/bin/98-include.sh ] ; then
    .  $HOME/bin/98-include.sh
else
    echo "98-include.sh not found"
    exit
fi

[[ "$WEEK" != "03" ]] && error Week 03 only

# ZCZC START #### #### #### ####
FILE="$WEEKDIR/WEEK$WEEK-$SEQ-DISK-CHECK.txt"
[ -f $FILE      ] && /bin/rm -f $FILE
[ -d $HOME/bin/ ] || mkdir -pv $HOME/bin/
[ -d $WEEKDIR/  ] || mkdir -pv $WEEKDIR/

fecho SCRIPT $(head -3 $0 | tail -1)
fecho STAMPX $(mkSTAMP)
fecho VERSUM $(versum $0)
fecho WEEKSQ $WEEK $SEQ
fecho VERDSK $(verdisk)
fecho VERLNX $(verkernel)
fecho PATHXX $(echo $PATH|grep -Eo \/home\/$(whoami)\/bin) IS OK
fecho hoBIN  $(ls $HOME/bin/)
fecho CHDATE $(date '+%y%m%d %H%M')
fecho CMOUNT $(cat /proc/mounts | grep $WHOAMI)
if [ -w "/$WHOAMI/" ] ; then
    fecho FSWRITE $(echo "Date: $(date)" | tee /$WHOAMI/$WHOAMI.txt)
    if [ -f /$WHOAMI/$WHOAMI.txt ] ; then
      fecho LSFILE $(ls -alR /$WHOAMI/$WHOAMI.txt)
      fecho CHKUSR $(cat /$WHOAMI/$WHOAMI.txt)
    fi
else
    fecho ERROR FILESYSTEM
fi
fecho ===== RESULT IN $FILE =====

exit 0

