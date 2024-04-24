FROM python:3.10-slim-buster

# Set user to root for installations
USER root

# Set the working directory in the container
WORKDIR /src

# Copy only the requirements file to install dependencies first
COPY ./requirements.txt requirements.txt

# Install system dependencies required for psycopg2 and other packages
RUN apt update -y && apt install -y --fix-missing build-essential libpq-dev \
    && rm -rf /var/lib/apt/lists/*

# Install Python dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Copy the rest of your application
COPY . .

# Create a user to run your application
RUN useradd -m myuser
USER myuser

# Command to run on container start
CMD ["python", "app.py"]
