FROM node:10.7.0-stretch as node
FROM ruby:2.5.1-stretch

COPY --from=node /opt/* /opt/
COPY --from=node /usr/local/lib/node_modules /usr/local/lib/
COPY --from=node /usr/local/bin/* /usr/local/bin/

RUN set -ex \
  && apt-get update \
  && apt-get upgrade -y \
  && apt-get install -y --no-install-recommends locales task-japanese gosu sudo vim less zsh \
  && rm -rf /var/lib/apt/lists/* \
  && echo 'ja_JP.UTF-8 UTF-8' > /etc/locale.gen \
  && locale-gen \
  && update-locale LANG=ja_JP.UTF-8 \
  && cp -p /usr/share/zoneinfo/Asia/Tokyo /etc/localtime
ENV LANG ja_JP.UTF-8