FROM nginx:1.15-alpine

RUN rm /usr/share/nginx/html/* && apk update && apk add git openssh-client

# Yes, TODO, insecure...
RUN mkdir -p /root/.ssh && \
  echo "  StrictHostKeyChecking no" > /root/.ssh/config && \
  chmod 600 /root/.ssh/config

COPY nginx/default.conf /etc/nginx/conf.d
COPY scripts/startup.sh /

CMD [ "sh", "-c", "/startup.sh"]
