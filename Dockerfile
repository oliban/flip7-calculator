FROM nginx:1.27-alpine

# Static single-file app
COPY index.html /usr/share/nginx/html/index.html

# Listen on 8080 to match fly.toml internal_port
RUN sed -i 's/listen       80;/listen       8080;/' /etc/nginx/conf.d/default.conf

EXPOSE 8080
