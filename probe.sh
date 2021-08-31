#!/bin/bash
# mprobe v1

# list all file streams with 

### functions ###

function video {
    v=$( ffprobe -select_streams v -v error -show_entries stream=index -of default=noprint_wrappers=1 "$*" | wc -l )
    n=0
    while [ ! "$n" -eq 1 ]; do
        ffprobe -select_streams v:$n -v error \
        -show_entries stream=index,codec_type,codec_name,bit_rate,pix_fmt,channel_layout,width,height \
        -of default=noprint_wrappers=1:nokey=1 "$*" \
        | tr '\n' ' '
        n=$(( n + 1 ))
        echo
    done
}

function audio {
    a=$( ffprobe -select_streams a -v error -show_entries stream=index -of default=noprint_wrappers=1 "$1" | wc -l )
    n=0
    while [ ! "$n" -eq "$a" ]; do
        ffprobe -select_streams a:$n -v error \
        -show_entries stream=index,codec_name,codec_type,channel_layout,channels,sample_rate:stream_tags=language \
        -of default=noprint_wrappers=1:nokey=1 "$1" \
        | tr '\n' ' '
        n=$(( n + 1 ))
        echo
    done
}

function subs {
    s=$( ffprobe -select_streams s -v error -show_entries stream=index -of default=noprint_wrappers=1 "$1" | wc -l )
    n=0
    while [ ! "$n" -eq "$s" ]; do
        ffprobe -select_streams s:$n -v error \
        -show_entries stream=index,codec_type,codec_name:stream_tags=language \
        -of default=noprint_wrappers=1:nokey=1 "$1" \
        | tr '\n' ' '
        n=$(( n + 1 ))
        echo
    done
}

### main code ###

#video "$1"
#audio "$1"
#subs "$1"


