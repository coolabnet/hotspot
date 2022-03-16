FROM jc21/nginx-proxy-manager

COPY config.json /app/config/production.json

COPY nginx.conf.patch /app/

# RUN patch -u /etc/nginx/nginx.conf -i /app/nginx.conf.patch

COPY custom/ /app/custom/

COPY init/ /etc/cont-init.d/

HEALTHCHECK --interval=10s --timeout=5s CMD /bin/check-health
