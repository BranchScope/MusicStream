#! /bin/bash

VBR="1500k" #video bitrate
FPS="30" #fps of the stream
QUAL="ultrafast" #quality of the stream
YOUTUBE_URL="rtmp://x.rtmp.youtube.com/live2" #usually it's this, but change if you see a different one on your live settings
YOUTUBE_KEY="" #insert here your youtube key
VIDEO_SOURCE="background.png" #default background you can see in the main path, change it if you want
AUDIO_ENCODER="aac" #audio encoder :)
THREADS = 5 #put cores +1

echo "Updating the list..."
cd songs
rm list.txt
php kek.php
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
 -i songs/list.txt \
 -loop -1 \
 -c:v libx264 -tune stillimage -pix_fmt yuv420p -preset $QUAL -r $FPS -g $(($FPS *2)) -b:v $VBR \
 -c:a $AUDIO_ENCODER -threads $THREADS -ar 44100 -b:a 128k -bufsize 512k -pix_fmt yuv420p \
 -f flv $YOUTUBE_URL/$YOUTUBE_KEY 
