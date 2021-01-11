# specify the node base image with your desired version node:<version>
FROM node:10
# create "app" directory for it self
WORKDIR /app
# copy package json inside the "app" directory
COPY package.json /app
# tell docker to run "npm install"
RUN npm install
# tell docker to copy everything to the "app" dirrectory
COPY . /app
# type and run "node index.js" on terminal
CMD node index.js
# expose ort number
EXPOSE 3000
