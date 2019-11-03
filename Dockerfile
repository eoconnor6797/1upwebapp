FROM node:alpine
# set environment variables
ARG NODE_ENV
ARG ONEUP_DEMOWEBAPPLOCAL_CLIENTSECRET
ARG ONEUP_DEMOWEBAPPLOCAL_CLIENTID
ENV ONEUP_DEMOWEBAPPLOCAL_CLIENTSECRET ${ONEUP_DEMOWEBAPPLOCAL_CLIENTSECRET}
ENV ONEUP_DEMOWEBAPPLOCAL_CLIENTID ${ONEUP_DEMOWEBAPPLOCAL_CLIENTID}
ENV NODE_ENV=${NODE_ENV:-dev}
WORKDIR /usr/src/app
# install dependecies for gyp
RUN apk add --no-cache --virtual .gyp \
        python \
        make \
        g++
COPY . ./
# copy config depending on env
COPY config-${NODE_ENV}.json config.json
RUN npm install
RUN apk del .gyp
# expose port (only necesary for local builds
# heroku randomly assigns port)
EXPOSE 3000
RUN npm run build
CMD npm run start
