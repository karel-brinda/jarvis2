#!/bin/bash
#
INPUT="$1";
#
# Make sure file name supplied
[ $# -eq 0 ] && { echo "Usage: $0 filename"; exit 1; }
# Make sure file exits else die
[ ! -f $INPUT ] && { echo "$0: file $INPUT not found."; exit 2; }
#
./SplitFastaStreams < $INPUT
./JARVIS2 -f DNA.JV2 &
./bbb cfm30q HEADERS.JV2 HEADERS.JV2.bbb &
bzip2 -f EXTRA.JV2 &
wait
tar -cvf $INPUT.tar DNA.JV2.jc EXTRA.JV2.bz2 HEADERS.JV2.bbb
#
ls -la DNA.JV2.jc | awk '{ print "DNA:\t"$5; }'
ls -la HEADERS.JV2.bbb | awk '{ print "HEADS:\t"$5; }'
ls -la EXTRA.JV2.bz2 | awk '{ print "EXTRA:\t"$5; }'
ls -la $INPUT.tar | awk '{ print "TOTAL:\t"$5; }'
#
rm -f DNA.JV2 EXTRA.JV2 HEADERS.JV2 
#
