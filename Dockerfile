FROM python:3.8-alpine
MAINTAINER Phoenix <hkxseven007@gmail.com>

ENV LANG C.UTF-8
ENV TZ 'Asia/Shanghai'

RUN set -ex \
        && apk add --no-cache --virtual .build-deps sed gcc musl-dev libffi-dev openssl-dev git \
        && apk add --no-cache tzdata ca-certificates ffmpeg libmagic openjpeg zlib-dev libwebp cairo \
        && ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
        && echo "Asia/Shanghai" > /etc/timezone

RUN set -ex \
        && pip3 install --upgrade pip \
        && pip3 install git+https://github.com/ehForwarderBot/ehForwarderBot@832997a38fb795f5135ae7f5f261f3bebb9ad943 \
        #&& pip3 install git+https://github.com/QQ-War/efb-telegram-master.git \
        && pip3 install git+https://github.com/ehForwarderBot/efb-telegram-master \
        && pip3 install git+https://github.com/ehForwarderBot/efb-wechat-slave \
        #&& pip3 install git+https://github.com/phoenixxie0/efb-wechat-slave \
        && pip3 install lottie \
        && pip3 install cairosvg \
        && sed -i 's/channel_emoji = "💬"/channel_emoji = "𝙒𝙚𝙘𝙝𝙖𝙩"/g' /usr/local/lib/python3.*/site-packages/efb_wechat_slave/__init__.py \
        #&& sed -i "s/{self.chat_type_emoji}/丨/g" /usr/local/lib/python3.*/site-packages/efb_telegram_master/chat.py \
        && pip3 install git+https://github.com/ehForwarderBot/efb-mp-instantview-middleware \
        && pip3 install git+https://github.com/ehForwarderBot/efb-link_preview-middleware \
        #&& pip3 install git+https://github.com/ehForwarderBot/efb-voice_recog-middleware \
        #&& pip3 install git+https://github.com/ehForwarderBot/efb-msg_blocker-middleware \
        && pip3 install git+https://github.com/ehForwarderBot/efb-patch-middleware \
        #&& pip3 install git+https://github.com/zhangzhishan/efb-filter-middleware \
        && pip3 install git+https://github.com/ahxxm/efb-filter-middleware \
        && pip3 install python-telegram-bot[socks] \
        && apk del .build-deps \
        && rm -rf ~/.cache 

CMD ["ehforwarderbot"]
