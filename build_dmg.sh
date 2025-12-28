#!/bin/bash

# Cool - Build DMG Installer Script

set -e

PROJECT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "   Cool - DMG Build"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

# Build the app first
echo "Building app..."
cd "$PROJECT_DIR"
make install -q

# Create DMG
echo "Creating DMG installer..."
DMG_PATH="$PROJECT_DIR/Cool.dmg"
rm -f "$DMG_PATH"

hdiutil create \
    -volname "Cool" \
    -srcfolder /Applications/Cool.app \
    -ov \
    -format UDZO \
    "$DMG_PATH"

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "✅ DMG Ready!"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
ls -lh "$DMG_PATH"
echo ""
echo "File: $DMG_PATH"
echo "Ready to distribute!"
