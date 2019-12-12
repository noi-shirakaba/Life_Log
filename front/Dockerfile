# FROM node:8.11.3-alpine
FROM node:12.13.1-alpine

ENV APP_HOME /app

WORKDIR $APP_HOME

RUN apk update && \
    apk add git && \
    apk add --no-cache curl && \
    curl -o- -L https://yarnpkg.com/install.sh | sh

ENV PATH $HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH

# ホットリロード
ENV CHOKIDAR_USEPOLLING=true
RUN yarn global add @vue/cli
ADD . $APP_HOME
RUN yarn install --network-timeout 1000000

EXPOSE 8080

CMD ["/bin/sh"]