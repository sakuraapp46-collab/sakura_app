#!/bin/bash

# --- CONFIGURATION ---
# specific version: Ladybug Feature Drop (2024.2.1.12)
DOWNLOAD_URL="https://redirector.gvt1.com/edgedl/android/studio/ide-zips/2024.2.1.12/android-studio-2024.2.1.12-linux.tar.gz"
FILE_NAME="android-studio.tar.gz"
INSTALL_DIR="/usr/local/android-studio"

# --- STEP 1: DOWNLOAD ---
echo "⬇️  1. Downloading Android Studio..."
if [ -f "$FILE_NAME" ]; then
    echo "   ⚠️  File '$FILE_NAME' already exists. Skipping download."
else
    # -O renames the file to android-studio.tar.gz automatically
    wget -O "$FILE_NAME" "$DOWNLOAD_URL"
    
    # Check if download succeeded
    if [ $? -ne 0 ]; then
        echo "❌ Error: Download failed. Please check your internet connection or the URL."
        exit 1
    fi
fi

# --- STEP 2: UNZIP ---
echo "📦 2. Unzipping $FILE_NAME..."
tar -xf "$FILE_NAME"

# --- STEP 3: INSTALL ---
echo "mv 3. Moving to /usr/local/..."

# Check if a previous installation exists
if [ -d "$INSTALL_DIR" ]; then
    echo "   ⚠️  Found existing Android Studio installation. Removing old version..."
    sudo rm -rf "$INSTALL_DIR"
fi

# Move the new folder (sudo is required here)
sudo mv android-studio /usr/local/

# --- STEP 4: CLEANUP ---
echo "🧹 4. Cleaning up the zip file..."
rm "$FILE_NAME"

# --- STEP 5: POST-INSTALL ---
echo "✅ Installation complete!"
echo ""
echo "👉 To launch Android Studio now, run:"
echo "   /usr/local/android-studio/bin/studio.sh"
echo ""
echo "👉 To make it accessible everywhere, add this to your ~/.bashrc:"
echo "   export PATH=\$PATH:/usr/local/android-studio/bin"
