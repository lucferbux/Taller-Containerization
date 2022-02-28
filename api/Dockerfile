FROM node:17-alpine3.14 AS builder
WORKDIR /usr/src/app 
COPY package*.json ./
ADD package.json /usr/src/app/package.json
RUN npm install
COPY . .
CMD ["npm", "run", "start:dev"];