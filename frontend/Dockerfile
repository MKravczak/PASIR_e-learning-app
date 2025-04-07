FROM node:18-alpine as admin-panel-build
WORKDIR /app/admin-panel
COPY ./admin-panel/package*.json ./
RUN npm install
COPY ./admin-panel/ ./
RUN npm run build

FROM node:18-alpine as quiz-app-build
WORKDIR /app/quiz-app
COPY ./quiz-app/package*.json ./
RUN npm install
COPY ./quiz-app/ ./
RUN npm run build

FROM nginx:alpine
COPY --from=admin-panel-build /app/admin-panel/dist /usr/share/nginx/html/app
COPY --from=quiz-app-build /app/quiz-app/dist /usr/share/nginx/html/quiz
COPY ./nginx.conf /etc/nginx/conf.d/default.conf
EXPOSE 80

CMD ["nginx", "-g", "daemon off;"] 