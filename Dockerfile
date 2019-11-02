FROM node:alpine
WORKDIR /usr/src/app
RUN apk add --no-cache --virtual .gyp \
        python \
        make \
        g++
COPY . ./
ENV NODE_ENV=production
RUN npm install
RUN apk del .gyp
RUN source .env
EXPOSE 3000
RUN npm run build
CMD npm run start
