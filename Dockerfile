#base image
FROM node as build

#the working directory we want to store our app in
WORKDIR /my-react-app

#copy all the package*.json files
COPY package*.json .


#install said dependencies
RUN npm install 

COPY . . 

#build the app
RUN npm run build 

#base images
FROM nginx

#copy that configuration file and then put it in the default location ON the container
COPY ./nginx/nginx.conf /etc/nginx/nginx.conf

#grab the prod build and put it in the nginx html destination
COPY --from=build /my-react-app/build /usr/share/nginx/html