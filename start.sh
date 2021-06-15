#!/bin/sh

nmbd --foreground --no-process-group --log-stdout & \
smbd --foreground --no-process-group --log-stdout
