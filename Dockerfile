FROM python:3.9

# Set the working directory in the container
WORKDIR /app/backend

# Copy requirements.txt to the working directory
COPY requirements.txt /app/backend

# Install dependencies for MySQL client and build tools
RUN apt-get update \
    && apt-get upgrade -y \
    && apt-get install -y gcc default-libmysqlclient-dev pkg-config \
    && rm -rf /var/lib/apt/lists/*

# Install app dependencies (Python packages from requirements.txt)
RUN pip install mysqlclient
RUN pip install --no-cache-dir -r requirements.txt

# Copy the rest of the application code
COPY . /app/backend

# Expose port 8000 for Django
EXPOSE 8000

# Run Django migrations (optional, but good practice to ensure DB schema is updated)
# Uncomment this line if you want migrations to run on container startup
# RUN python manage.py migrate

# Start the Django development server (the key change here)
CMD ["python3", "manage.py", "runserver", "0.0.0.0:8000"]

