#!/bin/sh

if [ -z "$ROLE_ARN" ]; then
    echo "Error: ROLE_ARN environment variable is not set."
    exit 1
fi

if [ -z "$REGION" ]; then
    echo "Error: REGION environment variable is not set."
    exit 1
fi

YACE_CONFIG="/opt/yace/config.yml"
echo "Updating YACE_CONFIG with ROLE_ARN: $ROLE_ARN and REGION: $REGION"
sed -i "s|roleArn: \"\${ROLE_ARN}\"|roleArn: \"$ROLE_ARN\"|g" "$YACE_CONFIG"
sed -i "s|regions:|regions:\n      - \"$REGION\"|g" "$YACE_CONFIG"

if [ ! -x "./yace" ]; then
    echo "Error: YACE exporter binary not found or not executable."
    exit 1
fi

echo "Starting YACE exporter..."
./yace --config.file "$YACE_CONFIG" --scraping-interval 300 --listen-address ":5000" -labels-snake-case=true
