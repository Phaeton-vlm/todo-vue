FROM node:14 as build-stage
WORKDIR /app
COPY package*.json ./
RUN npm install 
COPY . .
RUN npm run build

FROM nginx:stable-alpine as production-stage
RUN mkdir /vue-app
COPY --from=build-stage /app/dist /vue-app
COPY nginx.conf /etc/nginx/nginx.conf
#EXPOSE 80
#CMD ["nginx", "-g", "daemon off;"]