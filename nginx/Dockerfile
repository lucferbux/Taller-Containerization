FROM nginx:alpine

# Copy custom nginx config
COPY ./nginx/nginx.conf /etc/nginx/nginx.conf

# Copy certificates
COPY ./nginx/certificates/ /var/certificates

# Copy deployment
COPY ./ui/build/ /usr/share/nginx/html


ENTRYPOINT ["nginx"]
CMD ["-g", "daemon off;"]