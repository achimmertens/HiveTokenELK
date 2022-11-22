#!/bin/bash

# This tool deletes the merge conflicts, that means Header, footer and everything, which is included between them: 
# <<<<< HEAD
# Blabla
# >>>>>>>
# recursive in all included files
#
# So be careful when you use it!!!
# 




for f in $(grep -Rl '^>>>>>>> ' --include="*.log" --include="*.txt" --include="*.json" .)
do
sed -i -e '/^=======/,/^>>>>>>> /d' -e '/^<<<<<<< /d' $f
sed -i -e '/^>>>>>>> /d' $f
echo "$f Fixed"
done
