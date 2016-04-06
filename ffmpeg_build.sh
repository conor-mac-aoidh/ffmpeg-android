#!/bin/bash

. abi_settings.sh $1 $2 $3

pushd ffmpeg

case $1 in
  armeabi-v7a | armeabi-v7a-neon)
    CPU='cortex-a8'
  ;;
  x86)
    CPU='i686'
  ;;
esac

make clean

./configure \
--target-os="$TARGET_OS" \
--cross-prefix="$CROSS_PREFIX" \
--arch="$NDK_ABI" \
--cpu="$CPU" \
--sysroot="$NDK_SYSROOT" \
--disable-everything \
--enable-runtime-cpudetect \
--enable-pic \
--enable-libx264 \
--enable-hardcoded-tables \
--enable-gpl \
--enable-nonfree \
--enable-yasm \
--disable-shared \
--disable-ffplay \
--disable-ffprobe \
--disable-ffserver \
--disable-network \
--disable-doc \
--enable-static \
--enable-filters \
--enable-avresample \
--enable-avformat \
--enable-avcodec \
--enable-indev=lavfi \
--enable-hwaccels \
--enable-ffmpeg \
--enable-zlib \
--enable-gpl \
--enable-small \
--disable-filters \
--enable-filter=volume \
--enable-filter=trim \
--enable-filter=concat \
--enable-filter=rotate \
--enable-filter=aresample \
--enable-filter=copy \
--enable-filter=fps \
--enable-filter=format \
--enable-filter=null \
--enable-filter=nullsrc \
--enable-filter=pad \
--enable-filter=scale \
--enable-filter=setpts \
--enable-filter=setdar \
--enable-filter=setsar \
--enable-filter=trim \
--enable-filter=transpose \
--enable-bsf=aac_adtstoasc \
--enable-bsf=h264_mp4toannexb \
--disable-encoders \
--enable-encoder=zlib \
--enable-encoder=png \
--enable-encoder=libx264 \
--enable-encoder=mpeg4 \
--enable-encoder=mjpeg \
--enable-encoder=aac \
--disable-muxers \
--enable-muxer=mp4 \
--enable-muxer=adts \
--enable-muxer=h264 \
--enable-muxer=mjpeg \
--enable-muxer=image2 \
--disable-demuxers \
--enable-demuxer=mjpeg \
--enable-demuxer=image2 \
--enable-demuxer=aac \
--enable-demuxer=m4v \
--enable-demuxer=rawvideo \
--enable-demuxer=amr \
--enable-demuxer=mp3 \
--enable-demuxer=ogg \
--enable-demuxer=flac \
--enable-demuxer=concat \
--enable-demuxer=mpegvideo \
--enable-demuxer=mpegts \
--enable-demuxer=h264 \
--enable-demuxer=h263 \
--enable-demuxer=h261 \
--enable-demuxer=mov \
--enable-demuxer=avi \
--enable-demuxer=pcm_s16le \
--disable-decoders \
--enable-decoder=zlib \
--enable-decoder=aac \
--enable-decoder=aac_fixed \
--enable-decoder=aac_latm \
--enable-decoder=amrnb \
--enable-decoder=amrwb \
--enable-decoder=mp3 \
--enable-decoder=mp2 \
--enable-decoder=flac \
--enable-decoder=vorbis \
--enable-decoder=pcm_s16le \
--enable-decoder=pcm_s16be \
--enable-decoder=pcm_s16le_planar \
--enable-decoder=opus \
--enable-decoder=h263 \
--enable-decoder=h264 \
--enable-decoder=mpeg4 \
--enable-decoder=mpeg2video \
--enable-decoder=mpegvideo \
--enable-decoder=vp8 \
--enable-decoder=vp9 \
--enable-decoder=rawvideo \
--enable-decoder=mjpeg \
--disable-parsers \
--enable-parser=aac \
--enable-parser=aac_latm \
--enable-parser=mpegaudio \
--enable-parser=mpeg4video \
--enable-parser=flac \
--enable-parser=opus \
--enable-parser=png \
--enable-parser=h264 \
--enable-parser=mjpeg \
--enable-parser=h264 \
--enable-parser=vorbis \
--enable-parser=vp8 \
--enable-parser=vp9 \
--disable-protocols \
--enable-protocol=file \
--enable-protocol=concat \
--pkg-config="${2}/ffmpeg-pkg-config" \
--prefix="${2}/build/${1}" \
--extra-cflags="-I${TOOLCHAIN_PREFIX}/include $CFLAGS" \
--extra-ldflags="-L${TOOLCHAIN_PREFIX}/lib $LDFLAGS" \
--extra-libs="-lpng -lx264 -lexpat -lm" || exit 1

make -j${NUMBER_OF_CORES} && make install || exit 1

popd
