# Builder
FROM --platform=linux/amd64 awesometechnologies/amp-chat:2020.09.1-amp.chat as builder

# App
FROM nginx:alpine

COPY --from=builder /app /app

# Insert wasm type into Nginx mime.types file so they load correctly.
RUN sed -i '3i\ \ \ \ application/wasm wasm\;' /etc/nginx/mime.types

RUN rm -rf /usr/share/nginx/html \
 && ln -s /app /usr/share/nginx/html
