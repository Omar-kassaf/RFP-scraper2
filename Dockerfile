# # Use an official Python runtime as a parent image
# FROM python:3.12-slim

# # Set the working directory in the container
# WORKDIR /app

# # Copy the current directory contents into the container at /app
# COPY . /app

# # Install any needed packages specified in requirements.txt
# RUN apt-get update && apt-get install -y \
#     wget \
#     curl \
#     gnupg \
#     unzip \
#     && rm -rf /var/lib/apt/lists/*
# # install google chrome
# RUN wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add -
# RUN sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list'
# RUN apt-get -y update
# RUN apt-get install -y google-chrome-stable

# # install chromedriver
# RUN apt-get install -yqq unzip
# RUN wget -O /tmp/chromedriver.zip http://chromedriver.storage.googleapis.com/`curl -sS chromedriver.storage.googleapis.com/LATEST_RELEASE`/chromedriver_linux64.zip
# RUN unzip /tmp/chromedriver.zip chromedriver -d /usr/local/bin/

# # set display port to avoid crash
# ENV DISPLAY=:99
# RUN pip install --no-cache-dir -r requirements.txt



# # Define environment variable
# ENV PYTHONUNBUFFERED=1

# # Run scraper.py when the container launches
# CMD ["python", "main.py"]




# # Use an official Python runtime as a parent image
# FROM python:3.12-slim

# # Set the working directory in the container
# WORKDIR /app

# # Copy the current directory contents into the container at /app
# COPY . /app

# # Install required packages and dependencies
# RUN apt-get update && apt-get install -y \
#     wget \
#     curl \
#     gnupg \
#     unzip \
#     && rm -rf /var/lib/apt/lists/*

# # Install Google Chrome
# RUN wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add -
# RUN sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list'
# RUN apt-get -y update && apt-get install -y google-chrome-stable

# # Install Chromedriver
# RUN wget -O /tmp/chromedriver.zip http://chromedriver.storage.googleapis.com/$(curl -sS chromedriver.storage.googleapis.com/LATEST_RELEASE)/chromedriver_linux64.zip
# RUN unzip /tmp/chromedriver.zip chromedriver -d /usr/local/bin/

# # Set display port to avoid crash
# ENV DISPLAY=:99

# # Install Python dependencies
# RUN pip install --no-cache-dir -r requirements.txt

# # Define environment variable
# ENV PYTHONUNBUFFERED=1

# # Expose the port that the Streamlit application will run on
# EXPOSE 8080

# # Start the Streamlit application
# CMD ["streamlit", "run", "app_with_json.py", "--server.port=8080", "--server.enableCORS=false", "--server.enableWebsocketCompression=false", "--server.headless=true"]





# Use a base image with Python
FROM python:3.11

# Set the working directory
WORKDIR /app

# Install required packages for Chrome and other dependencies
RUN apt-get update && apt-get install -y \
    wget \
    unzip \
    libnss3 \
    libxss1 \
    libappindicator3-1 \
    libatk-bridge2.0-0 \
    libgtk-3-0 \
    libgbm-dev \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Add Google's official GPG key
RUN wget -q -O - https://dl.google.com/linux/linux_signing_key.pub | apt-key add - 

# Set up the Google repository
RUN echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" > /etc/apt/sources.list.d/google-chrome.list

# Install Google Chrome
RUN apt-get update && apt-get install -y google-chrome-stable

# Install Python dependencies (add your requirements.txt if you have one)
COPY requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt

# Copy the application code into the container
COPY . .

# Expose the port the app runs on
EXPOSE 8080

# Command to run the application
CMD ["streamlit", "run", "app_with_json.py", "--server.port=8080", "--server.address=0.0.0.0"]

