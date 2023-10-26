FROM node:lts-bullseye

ENV PNPM_HOME="/pnpm"
ENV PATH="$PNPM_HOME:$PATH"

RUN corepack enable

WORKDIR /build

RUN apt-get update && apt-get install -y calibre --no-install-recommends

RUN apt-get update && apt-get install -y fontconfig unzip sudo

COPY ./fonts /build/fonts

RUN unzip "./fonts/*.zip" -d /usr/share/fonts/ && fc-cache -fv

RUN mkdir -p /etc/fonts/conf.d && \
  cp -a ./fonts/fonts.conf /etc/fonts/conf.d/99-firgenerd.conf && fc-cache -fv

CMD exec sh -c "chown -R node:node /build && sudo -u node pnpm install && sudo -u node pnpm run build"

