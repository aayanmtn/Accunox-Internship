# Use the openSUSE Tumbleweed base image
FROM opensuse/tumbleweed:latest

# Install necessary packages: bash, fortune, cowsay, and netcat
RUN zypper refresh && \
    zypper install -y bash fortune cowsay netcat && \
    zypper clean

# Set the working directory inside the container
WORKDIR /app

# Copy the wisecow.sh script into the container
COPY wisecow.sh .

# Make the script executable
RUN chmod +x wisecow.sh

# Expose the port that the application will run on
EXPOSE 4499

# Define the command to run the application
CMD ["./wisecow.sh"]
