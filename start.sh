#! /bin/bash

VBR="1500k" #video bitrate
FPS="24" #fps of the stream (increase it if you stream videos)
QUAL="ultrafast" #quality of the stream
RTMP_URL="rtmp://x.rtmp.youtube.com/live2" #YouTube or Twitch's RTMP URL you can find on streaming settings
STREAM_KEY="" #insert here your streaming key
VIDEO_SOURCE="background.png" #default background you can see in the main path
AUDIO_ENCODER="aac" #audio encoder :)

echo "Updating the list..."
rm list.txt
cd songs
ls *.mp3 | sort -R | while read file; do
    echo "file 'songs/$file'" >> ../list.txt
done
cd ..
echo "Starting the streaming..."

ffmpeg \
 -loop 1 \
 -re \
 -framerate $FPS \
 -i "$VIDEO_SOURCE" \
 -thread_queue_size 512 \
 -f concat \
 -safe 0 \
 -i list.txt \
 -loop -1 \
 -c:v libx264 -tune stillimage -pix_fmt yuv420p -preset $QUAL -r $FPS -g $(($FPS *2)) -b:v $VBR \
 -c:a $AUDIO_ENCODER -threads $(nproc) -ar 44100 -b:a 128k -bufsize 512k -pix_fmt yuv420p \
 -f flv $RTMP_URL/$STREAM_KEY
