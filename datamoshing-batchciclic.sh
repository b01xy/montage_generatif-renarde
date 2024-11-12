#!/bin/bash
for i in /home/gedeon/Vidéos/CICLICaMOSHED/*.mp4;
  do name=`echo "${i%.*}"`;
  echo $name;
  ffmpeg -i "${i}" -vcodec libxvid -b 50000k -g 250 -keyint_min 25 -sc_threshold 200 -i_qfactor 0.21 -b_strategy 1 "${name}".xvid.avi;
#  ffmpeg -i "${i}" -vcodec libxvid -qscale 1 -g 128 -me_method epzs -bf 0 -mbd 0 -aspect 16:9 "${name}".xvid.avi;
  perl autodatamosh.pl -i "${name}".xvid.avi -dprob 1 -dmin 30 -dmax 100 -o "${name}".xvid.moshed.avi;
#  ffmpeg -i "${name}".xvid.moshed.avi -c:v libx264 -profile high -c:a copy -strict experimental "${name}".moshed.mp4;
  ffmpeg -i "${name}".xvid.moshed.avi -r 25 -vcodec mjpeg -b 20000k -g 25 -an -acodec copy "${name}".moshed.mov;
  rm "${name}".xvid.avi;
  rm "${name}".xvid.moshed.avi;
done
