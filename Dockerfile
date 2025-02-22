# Base image
FROM node as build

# The working directory we want to store our app in
WORKDIR /my-react-app

# Copy all the package*.json files
COPY package*.json .

# Install said dependencies
RUN npm install 

# Copy the rest of the app
COPY . . 

# Create coverage directory (adjusted path)
RUN mkdir -p /my-react-app/test-coverage

# Run tests with corrected flags
RUN npm run test -- --coverage --coverageDirectory=/my-react-app/test-coverage --watchAll=false

# Build the app
RUN npm run build 

# Base image for production
FROM nginx

# Copy that configuration file and then put it in the default location ON the container
COPY ./nginx/nginx.conf /etc/nginx/nginx.conf

# Grab the prod build and put it in the nginx html destination
COPY --from=build /my-react-app/build /usr/share/nginx/html