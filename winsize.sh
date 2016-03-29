#!/bin/bash
# Argument = -r <window title>  -t <from top> -l <from left> -h <height> -w <width> -z <[16|4] aspect ratio> \
#            -a <will activate window> 

usage()
{
cat << EOF
usage: $0 options

$0
    Front-end to wmctrl for window geometrics

OPTIONS:
   -?      this message
   -a      activate window referenced (-r ) once resize complete
   -r      window being referenced 
           (in quotes, if window title has white space)
   -l      from left in pixels (omit switch or -1 to leave unchanged)
   -t      from top in pixels (omit switch or -1 to leave unchanged)
   -h      height in pixels (omit switch or -1 to leave unchanged)
           specify -h 0 with -z [16|4] and script will
           calculate the height depending on a 16:9 or 4:3 aspect ratio
   -w      width in pixels (omit switch or -1 to leave unchanged)
   -z      aspect ratio (if stated [16|4] and -h is 0, height will be calculated)
EOF
}

REF=
TOP=-1
LEFT=-1
HEIGHT=
WIDTH=-1
RATIO=
ACTIVATE=
#set -x
while getopts “r:l:t:h:w:z:?a” OPTION
do
     case $OPTION in
         z)
             RATIO=$OPTARG
             ;;
         r)
             REF=$OPTARG
             ;;
         t)
             TOP=$OPTARG
             ;;
         h)
             HEIGHT=$OPTARG
             ;;
         l)
            LEFT=$OPTARG
            ;;
         a)
            ACTIVATE=1
            ;;
         w)
            WIDTH=$OPTARG
            ;;
         \?)
             usage
             exit
             ;;
     esac
done
if [[ "$RATIO" = "4" ]] || [[ "$RATIO" = "16" ]] && [[ "$HEIGHT" -eq "0" ]]; then
    if [[ "$RATIO" = "16" ]]; then
        HEIGHT=$((($WIDTH * 9)/16))
    fi
    if [[ "$RATIO" = "4" ]]; then
        HEIGHT=$((($WIDTH * 3)/4))
    fi
fi

if [[ "$REF" == "" ]]; then
    usage
    exit
fi

if [[ "$HEIGHT" = "" ]]; then
    HEIGHT=-1 
fi

cat << EOF

Window:  $REF  LEFT:  $LEFT  TOP:  $TOP   WIDTH:  $WIDTH   HEIGHT:  $HEIGHT   Aspect  Ratio:  $RATIO
EOF


wmctrl -r $REF -e 1,$LEFT,$TOP,$WIDTH,$HEIGHT

if [[ $ACTIVATE = 1 ]]; then
    wmctrl -a "$REF"
fi
