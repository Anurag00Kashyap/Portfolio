FROM node:alpine AS build

WORKDIR /app

COPY package*.json ./

RUN npm ci --production

COPY . .

RUN npm run build

FROM nginx:alpine

RUN rm -rf /usr/share/nginx/html/*

COPY --from=build /app/build /usr/share/nginx/html

EXPOSE 80
