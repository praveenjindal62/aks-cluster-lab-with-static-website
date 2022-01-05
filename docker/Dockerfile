FROM nginx:latest
WORKDIR /usr/share/nginx/html/
COPY src /usr/share/nginx/html/
RUN sed -i "s/Dimension/Demo 1/g" index.html
EXPOSE 80