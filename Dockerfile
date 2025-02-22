# Base image
FROM node as build

# The working directory we want to store our app in
WORKDIR /my-react-app

# Copy all the package*.json files
COPY package*.json .

# Install said dependencies
RUN npm install 

# Copy the rest of the app (including jest.config.js)
COPY . . 

# Create coverage and reports directories
RUN mkdir -p /my-react-app/test-coverage
RUN mkdir -p /my-react-app/test-reports

# Run tests with Jest config handling coverage and reporters
RUN npm run test -- --watchAll=false

# Build the app
RUN npm run build 

# Base image for production
FROM nginx

# Copy that configuration file and then put it in the default location ON the container
COPY ./nginx/nginx.conf /etc/nginx/nginx.conf

# Grab the prod build and put it in the nginx html destination
COPY --from=build /my-react-app/build /usr/share/nginx/html