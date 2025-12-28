#!/bin/bash

# Cool Wallpaper App - Build & Install Script

set -e

PROJECT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
BUILD_DIR="$PROJECT_DIR/build"
APP_NAME="Cool"

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${BLUE}   $APP_NAME Wallpaper App Build${NC}"
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"

# Determine build configuration
CONFIGURATION="${1:-Release}"

echo -e "${YELLOW}Building $CONFIGURATION configuration...${NC}"

# Build
cd "$BUILD_DIR"
xcodebuild -configuration "$CONFIGURATION" -quiet

APP_PATH="$BUILD_DIR/$CONFIGURATION/$APP_NAME.app"
APPS_PATH="/Applications/$APP_NAME.app"

if [ ! -d "$APP_PATH" ]; then
    echo -e "${YELLOW}❌ Build failed - app not found at $APP_PATH${NC}"
    exit 1
fi

echo -e "${GREEN}✅ Build succeeded${NC}"

# Install to Applications
echo -e "${YELLOW}Installing to /Applications...${NC}"
rm -rf "$APPS_PATH"
cp -r "$APP_PATH" "$APPS_PATH"
echo -e "${GREEN}✅ Installed to $APPS_PATH${NC}"

# Create desktop shortcut
DESKTOP_SHORTCUT="$HOME/Desktop/$APP_NAME.app"
if [ ! -L "$DESKTOP_SHORTCUT" ]; then
    ln -s "$APPS_PATH" "$DESKTOP_SHORTCUT"
    echo -e "${GREEN}✅ Created desktop shortcut${NC}"
fi

echo ""
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${GREEN}Done! Launch with:${NC}"
echo -e "  ${BLUE}open /Applications/$APP_NAME.app${NC}"
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
