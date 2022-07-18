FROM alpine:3.16.0 

COPY ./app /app
COPY ./web /web

EXPOSE 8080

USER nobody:nobody

ENTRYPOINT ["/app"]
