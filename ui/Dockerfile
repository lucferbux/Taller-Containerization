FROM node:17-alpine3.14
WORKDIR /usr/src/app
RUN npm install react-scripts@4.0.3 -g
COPY package*.json ./
ADD package.json /usr/src/app/package.json
RUN npm install
COPY . .
CMD ["npm", "run", "start:docker"];
