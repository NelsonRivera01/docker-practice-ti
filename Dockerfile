#Specify base image
FROM node:18-alpine AS builder

#Set a working directory ---> rootfolder of the container/app
WORKDIR '/app'

COPY package.json .
#Install dependencies
RUN npm install
#Copy the rest of the files to the working directory
COPY . .
#Build the project ---> /app/build
RUN npm run build 


#Specify base image
FROM nginx:1.21.3-alpine AS implementer
#Copy the build from the previous phase [Builder] to the nginx server, 
#and specify the directory (based on documentation)
COPY --from=builder /app/build /usr/share/nginx/html 
