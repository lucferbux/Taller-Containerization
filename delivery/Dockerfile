FROM node:14-alpine3.12
WORKDIR /app
COPY ui/. ./ui
COPY api/. ./api
COPY package.json .
COPY package-lock.json .
RUN npm install
RUN npm run postinstall
