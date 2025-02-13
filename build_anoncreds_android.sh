RELEASE=v0.2.0
ASSET_NAME=library-ios-android.tar.gz
ANONCREDS_URL="https://github.com/hyperledger/anoncreds-rs/releases/download/$RELEASE/$ASSET_NAME"
TARGET_DIR="android/app/src/main/jniLibs"

# Create the target directory if it doesn't exist
mkdir -p "$TARGET_DIR"

# Download the tar.gz file
echo "Downloading $ANONCREDS_URL..."
curl -L "$ANONCREDS_URL" -o "$TARGET_DIR/$ASSET_NAME"

# Extract the contents to a temporary directory
TEMP_DIR=$(mktemp -d)
echo "Extracting contents..."
tar -xzf "$TARGET_DIR/$ASSET_NAME" -C $TEMP_DIR

# Move the mobile/android directory to the target directory
echo "Moving mobile/android to $TARGET_DIR..."
mv $TEMP_DIR/mobile/android/* $TARGET_DIR

# Clean up the temporary directory and the downloaded tar.gz file
rm -rf $TEMP_DIR
rm "$TARGET_DIR/$ASSET_NAME"

echo "Done!"