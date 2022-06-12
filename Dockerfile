FROM alpine:latest
MAINTAINER Phoenix <hkxseven007@gmail.com>

ENV LANG C.UTF-8
ENV TZ 'Asia/Shanghai'

RUN set -ex \
        && apk add --no-cache --virtual .build-deps sed build-base libffi-dev openssl-dev python3-dev git \
        && apk add --no-cache tzdata ca-certificates ffmpeg libmagic tiff libwebp freetype lcms2 openjpeg openblas zlib-dev cairo \
                 python3 py3-olefile py3-numpy py3-pillow py3-pip py3-cryptography py3-decorator \

        && ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
        && echo "Asia/Shanghai" > /etc/timezone

RUN set -ex \
        && pip3 install --upgrade pip \
        && pip3 install git+https://github.com/ehForwarderBot/ehForwarderBot \
        && pip3 install git+https://github.com/ehForwarderBot/efb-telegram-master \
        && pip3 install git+https://github.com/ehForwarderBot/efb-wechat-slave \
        && pip3 install lottie \
        && pip3 install cairosvg \
        && sed -i 's/channel_emoji = "💬"/channel_emoji = "𝙒𝙚𝙘𝙝𝙖𝙩"/g' /usr/lib/python3.*/site-packages/efb_wechat_slave/__init__.py \
        && sed -i "s/{self.chat_type_emoji}/丨/g" /usr/lib/python3.*/site-packages/efb_telegram_master/chat.py \
        && pip3 install git+https://github.com/ehForwarderBot/efb-mp-instantview-middleware \
        && pip3 install git+https://github.com/ehForwarderBot/efb-link_preview-middleware \
        && pip3 install git+https://github.com/ehForwarderBot/efb-voice_recog-middleware \
        && pip3 install git+https://github.com/ehForwarderBot/efb-msg_blocker-middleware \
        && pip3 install git+https://github.com/ehForwarderBot/efb-patch-middleware \
        #&& pip3 install git+https://github.com/zhangzhishan/efb-filter-middleware \
        && pip3 install git+https://github.com/ahxxm/efb-filter-middleware \
        && pip3 install python-telegram-bot[socks] \
        && apk del .build-deps \
        && rm -rf ~/.cache

CMD ["ehforwarderbot"]
