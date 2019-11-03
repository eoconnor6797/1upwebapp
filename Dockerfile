FROM node:alpine
ARG NODE_ENV
# set NODE_ENV (defaults to dev)
ENV NODE_ENV=${NODE_ENV:-dev}
WORKDIR /usr/src/app
# install dependecies for gyp
RUN apk add --no-cache --virtual .gyp \
        python \
        make \
        g++
# copy in source
COPY . ./
# copy config depending on env
COPY config-${NODE_ENV}.json config.json
# install deps
RUN npm install
RUN apk del .gyp
# set environment variables
RUN source .env-${NODE_ENV}
# expose port (only necesary for local builds
# heroku randomly assigns port)
EXPOSE 3000
# build app
RUN npm run build
# command to run server
CMD npm run start
