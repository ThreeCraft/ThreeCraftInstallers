#!/bin/bash
# ThreeCraft Installer

# Define colors
YELLOW='\033[0;93m'
GREEN='\033[0;92m'
NC='\033[0m' # No Color

SERVER_JS_URL="https://cdn.jsdelivr.net/gh/ThreeCraft/ThreeCraftServer/server.js"
PACKAGE_JSON_URL="https://cdn.jsdelivr.net/gh/ThreeCraft/ThreeCraftServer/package.json"

echo "ThreeCraft Installer"

# Select installation directory (default: current directory + /ThreeCraftServer)
read -p "Enter installation directory (default: $(pwd)/ThreeCraftServer): " installDir

if [ -z "$installDir" ]; then
    installDir="$(pwd)/ThreeCraftServer"
fi

mkdir -p "$installDir"
cd "$installDir" || exit

echo -e "\n${YELLOW}Installing ThreeCraft Server to $installDir${NC}\n"

# Download server.js using curl
echo -e "${GREEN}Downloading server.js...${NC}"
curl -O "$SERVER_JS_URL"
echo ""

# Download package.json using curl
echo -e "${GREEN}Downloading package.json...${NC}"
curl -O "$PACKAGE_JSON_URL"
echo ""

# Start npm install
echo -e "${GREEN}Installing dependencies...${NC}"
npm install
echo ""

echo -e "${GREEN}Installation complete!${NC}"
echo "Starting Server..."
echo ""

# Call node server.js
node server.js
