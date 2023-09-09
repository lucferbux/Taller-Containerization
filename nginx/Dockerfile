FROM node:18-alpine3.17 AS builder
WORKDIR /usr/src/app
COPY ui/package*.json ./
ADD ui/package.json /usr/src/app/package.json
RUN npm ci
COPY ./ui/ .
RUN npm run build


FROM nginx:1.21.6-alpine AS runtime
ENV NGINX_PORT 80
ENV NGINX_HTTPS_PORT 443
ENV FORCE_HTTPS 'false'
ENV BACKEND_API https://host.docker.internal:5000
# Copy custom nginx config with template value
COPY ./nginx/default.conf.template /etc/nginx/templates/
# Copy certificates
COPY ./nginx/certificates/ /var/certificates
# Copy deployment
COPY --from=builder /usr/src/app/dist/ /usr/share/nginx/html
