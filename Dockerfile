ARG DEBIAN_VERSION=bookworm
ARG ESSENTIA_COMMIT=HEAD
ARG ENABLE_VAMP=1
ARG ENABLE_TENSORFLOW=1
ARG TENSORFLOW_USE_GPU=0
ARG TENSORFLOW_VERSION=2.13.0
ARG FFMPEG_VERSION=4.4.4

# ---- build stage ----------------------------------------------------------
FROM debian:${DEBIAN_VERSION}-slim AS build

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    build-essential \
    libeigen3-dev \
    libyaml-dev \
    libfftw3-dev \
    libavcodec-dev \
    libavformat-dev \
    libavutil-dev \
    libswresample-dev \
    libsamplerate0-dev \
    libtag1-dev \
    libchromaprint-dev \
    python3 \
    python3-dev \
    git \
    ca-certificates \
    wget \
    curl \
    libx264-dev \
    libx265-dev \
    libvpx-dev \
    libmp3lame-dev \
    libopus-dev \
    libvorbis-dev \
    libass-dev \
    libfreetype6-dev \
    zlib1g-dev \
    libssl-dev && \
    rm -rf /var/lib/apt/lists/*

ARG FFMPEG_VERSION
WORKDIR /opt
RUN curl -LO https://ffmpeg.org/releases/ffmpeg-${FFMPEG_VERSION}.tar.xz && \
    tar xJf ffmpeg-${FFMPEG_VERSION}.tar.xz && \
    cd ffmpeg-${FFMPEG_VERSION} && \
    ./configure --prefix=/usr/local \
    --enable-gpl \
    --enable-nonfree \
    --enable-pic \
    --enable-shared \
    --disable-static \
    --enable-libx264 \
    --enable-libmp3lame \
    --enable-libopus \
    --enable-libvpx && \
    make -j$(nproc) && \
    make install && \
    cd /opt && \
    rm -rf ffmpeg-${FFMPEG_VERSION}*

ARG ENABLE_TENSORFLOW
ARG TENSORFLOW_USE_GPU
ARG TENSORFLOW_VERSION
COPY install_tensorflow.sh /opt/install_tensorflow.sh
RUN if [ "$ENABLE_TENSORFLOW" = "1" ]; then \
    bash /opt/install_tensorflow.sh "${TENSORFLOW_VERSION}" "${TENSORFLOW_USE_GPU}"; \
    fi

ARG ESSENTIA_COMMIT
RUN git clone --depth 1 --branch "$ESSENTIA_COMMIT" https://github.com/MTG/essentia.git /opt/essentia

WORKDIR /opt/essentia

ARG ENABLE_VAMP
RUN python3 waf configure $( [ "$ENABLE_VAMP" = "1" ] && echo "--with-vamp" ) $( [ "$ENABLE_TENSORFLOW" = "1" ] && echo "--with-tensorflow" ) && \
    python3 waf && \
    python3 waf install

# ---- main stage ---------------------------------------------------------
FROM debian:${DEBIAN_VERSION}-slim
ENV DEBIAN_FRONTEND=noninteractive

COPY --from=build /usr/local/lib /usr/local/lib
COPY --from=build /usr/local/include /usr/local/include
COPY --from=build /usr/lib /usr/lib
COPY --from=build /usr/include /usr/include
COPY --from=build /usr/share/pkgconfig /usr/share/pkgconfig
COPY --from=build /usr/local/lib/pkgconfig /usr/local/lib/pkgconfig
