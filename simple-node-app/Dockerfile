FROM node:10.16.3-stretch-slim

RUN groupadd -r app \
    && useradd -m -r -g app app \
    && apt-get update \
    && apt-get install -y gosu \
    && rm -rf /var/lib/apt/lists/* \
    && gosu nobody true

WORKDIR /app

COPY *.json /app/
COPY src /app/src
COPY node_modules /app/node_modules
COPY entrypoint.sh /app/

EXPOSE 3000

ENTRYPOINT ["/app/entrypoint.sh"]
