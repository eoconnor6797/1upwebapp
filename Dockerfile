FROM node:alpine
ARG NODE_ENV
ENV NODE_ENV=${NODE_ENV:-dev}
WORKDIR /usr/src/app
RUN apk add --no-cache --virtual .gyp \
        python \
        make \
        g++
COPY . ./
COPY config-${NODE_ENV}.json config.json
RUN npm install
RUN apk del .gyp
RUN source .env-${NODE_ENV}
EXPOSE 3000
RUN npm run build
CMD npm run start
