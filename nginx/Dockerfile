FROM node:17-alpine3.14 AS builder
WORKDIR /usr/src/app
RUN npm install react-scripts@4.0.3 -g
COPY ui/package*.json ./
ADD ui/package.json /usr/src/app/package.json
RUN npm install
COPY ./ui/ .
RUN npm run build:docker


FROM nginx:alpine
# Copy custom nginx config
COPY ./nginx/nginx.conf /etc/nginx/nginx.conf
# Copy certificates
COPY ./nginx/certificates/ /var/certificates
# Copy deployment
COPY --from=builder /usr/src/app/build/ /usr/share/nginx/html

ENTRYPOINT ["nginx"]
CMD ["-g", "daemon off;"]