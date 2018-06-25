FROM nginx:1.15.0-alpine
COPY ./nginx.conf /etc/nginx/
COPY passwd /etc/nginx/
RUN rm -rf /etc/nginx/conf.d/default.conf