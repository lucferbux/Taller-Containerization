FROM node:17-alpine3.14 AS builder
WORKDIR /usr/src/app 
COPY package*.json ./
ADD package.json /usr/src/app/package.json
RUN npm install
COPY . .
RUN npm run build


FROM node:17-alpine3.14
WORKDIR /usr/src/app 
COPY package*.json ./
ADD package.json /usr/src/app/package.json
RUN npm install
COPY --from=builder /usr/src/app/build  ./build
CMD ["npm", "run", "start"];