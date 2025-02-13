RELEASE=v0.2.0
ASSET_NAME=library-linux-x86_64.tar.gz
ANONCREDS_URL="https://github.com/hyperledger/anoncreds-rs/releases/download/$RELEASE/$ASSET_NAME"
TARGET_DIR="linux/lib"

# Create the target directory if it doesn't exist
mkdir -p "$TARGET_DIR"

# Download the tar.gz file
echo "Downloading $ANONCREDS_URL..."
curl -L "$ANONCREDS_URL" -o "$TARGET_DIR/$ASSET_NAME"

# Extract the contents
echo "Extracting contents..."
tar -xzf "$TARGET_DIR/$ASSET_NAME" -C $TARGET_DIR

# Clean up the downloaded tar.gz file
rm -rf $TEMP_DIR
rm "$TARGET_DIR/$ASSET_NAME"

echo "Done!"