 #!/bin/bash

echo "🛠️ Installing LazyCLI..."

INSTALL_DIR="$HOME/.lazycli"
LAZY_BINARY="$INSTALL_DIR/lazy"

# Ensure install dir is writable
if ! mkdir -p "$INSTALL_DIR" 2>/dev/null; then
  echo "❌ Failed to create install directory: $INSTALL_DIR"
  echo "👉 Try running this command instead:"
  echo "   curl -s https://lazycli.xyz/install.sh | sudo HOME=$HOME bash"
  exit 1
fi

# Download the latest CLI script
curl -fsSL https://lazycli.xyz/scripts/lazy.sh -o "$LAZY_BINARY" || {
  echo "❌ Failed to download LazyCLI."
  exit 1
}

# Make it executable
chmod +x "$LAZY_BINARY"

# Add to PATH if not already added
PROFILE_FILE="$HOME/.bashrc"
if [[ "$OSTYPE" == "darwin"* ]]; then
  PROFILE_FILE="$HOME/.zshrc"
fi

if ! grep -q 'export PATH="$HOME/.lazycli:$PATH"' "$PROFILE_FILE"; then
  echo 'export PATH="$HOME/.lazycli:$PATH"' >> "$PROFILE_FILE"
  echo "📎 Updated $PROFILE_FILE with LazyCLI path."
fi

# Apply to current session
export PATH="$HOME/.lazycli:$PATH"

echo "✅ LazyCLI installed! Run 'lazy --help' to begin. 😎"
