#FROM node:14-alpine3.12
FROM mcr.microsoft.com/playwright:v1.37.0-jammy
WORKDIR /app
COPY ui/. ./ui
COPY api/. ./api
COPY package.json .
COPY package-lock.json .
RUN npm ci
RUN cd ui && npm ci
RUN cd api && npm ci
