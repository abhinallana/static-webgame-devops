#Using the base image as nginx to host a static web application.
FROM nginx:alpine
# Set the working directory to /usr/share/nginx/html
# This is the default directory where nginx serves files from.

WORKDIR /usr/share/nginx/html
# Copying index.html from the current directory to the working directory in the container.
COPY index.html /usr/share/nginx/html/index.html

#Copying the nginx.conf file from the current directory to the nginx configuration directory in the container.
COPY nginx.conf /etc/nginx/conf.d/default.conf
# The default port for nginx is 80, but we will expose port 3000 as 80 is used by jenkins in my case.
EXPOSE 3000

#Running the nginx server in the background.
CMD ["nginx", "-g", "daemon off;"]