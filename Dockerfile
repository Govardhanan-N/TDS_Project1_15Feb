# Use a lightweight Python base image
FROM python:3.9-slim

# Set the working directory
WORKDIR /app

# Copy the current directory contents into the container
COPY . /app

# Install necessary dependencies
RUN apt-get update && \
    apt-get install -y --no-install-recommends git nodejs npm && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Create virtual environment and activate it
ENV VIRTUAL_ENV=/opt/venv
RUN python3 -m venv $VIRTUAL_ENV
ENV PATH="$VIRTUAL_ENV/bin:$PATH"

# Install FastAPI, Uvicorn, and other Python dependencies using pip
RUN pip install --no-cache-dir fastapi uvicorn uv httpx python-dateutil requests numpy

# Configure Git
RUN git config --global user.name "GOVA" \
    && git config --global user.email "govardhanan1303@gmail.com"

# Expose the application port
EXPOSE 8000

# Run the application using Uvicorn
CMD ["uvicorn", "Main:app", "--host", "0.0.0.0", "--port", "8000"]
