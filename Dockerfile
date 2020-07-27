  
# First step: Build with Node.js
FROM node:lts-alpine AS Builder
WORKDIR /front
COPY package.json yarn.lock /front/
RUN yarn install
COPY . /front
RUN yarn build

# Deliver the dist folder with Nginx
FROM nginx:stable-alpine
LABEL maintainer="mail@georg-ledermann.de"

COPY nginx.conf /etc/nginx/conf.d/default.conf
COPY --from=Builder /app/dist /usr/share/nginx/html
COPY entrypoint.sh /

CMD ["/entrypoint.sh"]
