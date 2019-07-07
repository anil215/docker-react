FROM node:alpine as builder
WORKDIR '/app'
COPY package.json .
RUN npm install 
COPY . .
RUN npm run build
# volumes are not required in production setting since we aren't
# changing code

FROM nginx 
COPY --from=builder /app/build /usr/share/nginx/html

# the nginx container would handle the starting of nginx server
# for prod not creating docker-compose.yml file
# commands
# docker build .
# docker run -p 8080:80 <image-id>
