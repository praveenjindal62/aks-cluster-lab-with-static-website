FROM alpine:3.12
RUN apk add --no-cache bc
COPY src/entrypoint.sh /
ENTRYPOINT ["/entrypoint.sh"]
CMD [ "100", "5000" ]
