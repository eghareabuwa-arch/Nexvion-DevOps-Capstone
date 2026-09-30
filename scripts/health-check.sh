#!/bin/bash

URL="http://localhost:8083"

echo "Checking Nexvion application health..."

if curl --fail --silent "$URL" > /dev/null; then
    echo "SUCCESS: Nexvion application is healthy."
    echo "Application URL: $URL"
else
    echo "ERROR: Nexvion application health check failed."
    exit 1
fi