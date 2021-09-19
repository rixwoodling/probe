#!/bin/bash
# mprobe v2

# show all streams in a media file and list essential info 

### functions ###

function video {
    v=$( ffprobe -select_streams v -loglevel panic -show_entries stream=index -of default=noprint_wrappers=1 "$1" | wc -l )
    n=0
    while [ ! "$n" -eq 1 ]; do
        ffprobe -select_streams v:$n -loglevel panic \
        -show_entries stream=index,codec_type,codec_name,bit_rate,pix_fmt,channel_layout,width,height \
        -of default=noprint_wrappers=1:nokey=1 "$1" \
        | tr '\n' ' '
        n=$(( n + 1 ))
        if [ -z 2>&1 ]; then echo -n
        else echo; fi
    done
}

function audio {
    a=$( ffprobe -select_streams a -loglevel panic -show_entries stream=index -of default=noprint_wrappers=1 "$1" | wc -l )
    n=0
    while [ ! "$n" -eq "$a" ]; do
        ffprobe -select_streams a:$n -loglevel panic \
        -show_entries stream=index,codec_name,codec_type,channel_layout,channels,sample_rate:stream_tags=language \
        -of default=noprint_wrappers=1:nokey=1 "$1" \
        | tr '\n' ' '
        n=$(( n + 1 ))
        if [ -z 2>&1 ]; then echo -n
        else echo; fi
    done
}

function subs {
    s=$( ffprobe -select_streams s -loglevel panic -show_entries stream=index -of default=noprint_wrappers=1 "$1" | wc -l )
    n=0
    while [ ! "$n" -eq "$s" ]; do
        ffprobe -select_streams s:$n -loglevel panic \
        -show_entries stream=index,codec_type,codec_name:stream_tags=language \
        -of default=noprint_wrappers=1:nokey=1 "$1" \
        | tr '\n' ' '
        n=$(( n + 1 ))
        if [ -z 2>&1 ]; then echo -n
        else echo; fi
    done
}

### main code ###

video "$1"
audio "$1"
subs "$1"



