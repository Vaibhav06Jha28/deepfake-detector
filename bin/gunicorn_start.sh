#!/bin/bash

# ------------------ Configuration ------------------
NAME="deepfake_detector_app"                             # App name
DJANGODIR=/app                                            # Django app directory
SOCKFILE=/app/run/gunicorn.sock                          # Unix socket for communication
NUM_WORKERS=3                                             # Worker processes
DJANGO_SETTINGS_MODULE=project_settings.settings         # Settings module
DJANGO_WSGI_MODULE=project_settings.wsgi                 # WSGI entry point

# ------------------ Startup Log ---------------------
echo "Starting $NAME as `whoami`"

# ------------------ Ensure Socket Directory Exists ---
RUNDIR=$(dirname $SOCKFILE)
mkdir -p $RUNDIR

# ------------------ Start Gunicorn ------------------
exec gunicorn ${DJANGO_WSGI_MODULE}:application \
  --name $NAME \
  --workers $NUM_WORKERS \
  --timeout 600 \
  --bind unix:$SOCKFILE \
  --log-level=info \
  --log-file=-
