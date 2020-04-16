FROM alpine:3.11
LABEL maintainer="AppleNectar"

RUN set -eu \
    && apk update \
    && apk --update add \
        tzdata \
        openrc \
        procps \
        net-tools \
        shadow \
        vim \
        wget \
        less \
        tree \
        unzip \
        zip \
        bzip2 \
        git \
        gcc \
        g++ \
        make \
        autoconf \
        m4 \
        curl \
        openssl \
        libbz2 \
        chromium \
        udev \
        ttf-freefont

WORKDIR /usr/local/src

# Install google fonts
RUN wget https://github.com/google/fonts/archive/master.tar.gz -O gf.tar.gz \
    && tar -xf gf.tar.gz \
    && mkdir -p /usr/share/fonts/truetype/google-fonts \
    && find $PWD/fonts-master/ -name "*.ttf" -exec install -m644 {} /usr/share/fonts/truetype/google-fonts/ \; || return 1 \
    && fc-cache -f && rm -rf /var/cache/* \
    && rm -f gf.tar.gz \
    && rm -rf $PWD/fonts-master

RUN groupadd -g 1000 chromium \
    && useradd -u 1000 -g chromium -s /bin/ash -m chromium

USER chromium

RUN mkdir /home/chromium/work

WORKDIR /home/chromium/work

ENTRYPOINT ["chromium-browser", "--headless", "--disable-gpu", "--disable-software-rasterizer", "--disable-dev-shm-usage,", "--no-sandbox"]
