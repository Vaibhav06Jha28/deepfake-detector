# 1. Use NVIDIA CUDA base image with Python 3 support
FROM nvidia/cuda:11.8.0-cudnn8-runtime-ubuntu20.04

# 2. Set environment variables
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

# 3. Set working directory
WORKDIR /app

# 4. Install system dependencies
RUN apt-get update && apt-get install -y \
    python3-pip \
    python3-dev \
    build-essential \
    cmake \
    ffmpeg \
    libsm6 \
    libxext6 \
    git \
    && apt-get clean

# 5. Copy and install Python dependencies
COPY ./requirements.txt /app/requirements.txt
RUN pip3 install --upgrade pip
RUN pip3 install -r /app/requirements.txt

# 6. Copy project files
COPY . /app

# 7. Ensure gunicorn script is executable
RUN chmod +x /app/bin/gunicorn_start.sh

# 8. Ensure required folders exist (optional)
RUN mkdir -p /app/run /app/uploaded_videos /app/uploaded_images /app/models

# 9. Collect static files
RUN python3 manage.py collectstatic --noinput

# 10. Expose port (optional, if you decide to use TCP socket instead of Unix socket)
# EXPOSE 8000

# 11. Define default command to run app
ENTRYPOINT ["/app/bin/gunicorn_start.sh"]
