FROM node:lts-bullseye

WORKDIR /build

RUN apt-get update && apt-get install -y calibre --no-install-recommends

RUN apt-get update && apt-get install -y fontconfig unzip sudo

COPY ./fonts /build/fonts

RUN unzip "./fonts/*.zip" -d /usr/share/fonts/ && fc-cache -fv

RUN mkdir -p /etc/fonts/conf.d && \
  cp -a ./fonts/fonts.conf /etc/fonts/conf.d/99-firgenerd.conf && fc-cache -fv

RUN sudo corepack enable


ENV LANG=ja_JP.UTF-8

USER node

ENTRYPOINT exec sh -c "pnpm install && pnpm run build"

