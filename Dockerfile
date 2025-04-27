# Use the official Nginx image based on Alpine
FROM nginx:alpine

# Copy your custom index.html to the default Nginx HTML directory
COPY index.html /usr/share/nginx/html/index.html

# Copy your custom Nginx configuration file
COPY default.conf /etc/nginx/conf.d/default.conf

# Expose port 80
EXPOSE 80

# Start Nginx in the foreground
CMD ["nginx", "-g", "daemon off;"]