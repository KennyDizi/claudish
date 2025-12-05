#!/bin/bash
#
# install-npm-global.sh
# Install claudish as a global npm package
#

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Helper functions
info() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

warn() {
    echo -e "${YELLOW}[WARN]${NC} $1"
}

error() {
    echo -e "${RED}[ERROR]${NC} $1"
    exit 1
}

# Check if a command exists
check_command() {
    if ! command -v "$1" &> /dev/null; then
        return 1
    fi
    return 0
}

echo ""
echo "========================================"
echo "  Claudish Global Installation Script"
echo "========================================"
echo ""

# Step 1: Check prerequisites
info "Checking prerequisites..."

# Check Node.js
if ! check_command node; then
    error "Node.js is not installed. Please install Node.js >= 18.0.0"
fi

NODE_VERSION=$(node -v | sed 's/v//' | cut -d. -f1)
if [ "$NODE_VERSION" -lt 18 ]; then
    error "Node.js version must be >= 18.0.0 (found: $(node -v))"
fi
success "Node.js $(node -v) found"

# Check npm
if ! check_command npm; then
    error "npm is not installed. Please install npm"
fi
success "npm $(npm -v) found"

# Check bun (required for building)
if ! check_command bun; then
    warn "Bun is not installed. Attempting to install..."

    # Try to install bun
    if check_command curl; then
        curl -fsSL https://bun.sh/install | bash
        export BUN_INSTALL="$HOME/.bun"
        export PATH="$BUN_INSTALL/bin:$PATH"

        if ! check_command bun; then
            error "Failed to install Bun. Please install manually: https://bun.sh"
        fi
    else
        error "Bun is required for building. Please install: https://bun.sh"
    fi
fi
success "Bun $(bun -v) found"

# Step 2: Get script directory (where the project is)
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR"

info "Working directory: $SCRIPT_DIR"

# Step 3: Install dependencies
info "Installing dependencies..."
if [ -f "package-lock.json" ]; then
    npm ci --silent 2>/dev/null || npm install --silent
else
    npm install --silent
fi
success "Dependencies installed"

# Step 4: Build the project
info "Building project..."

# Create dist directory if it doesn't exist
mkdir -p dist

# Build with bun (skip extract-models since models are defined in source)
bun build src/index.ts --outdir dist --target node

# Make the output executable
chmod +x dist/index.js

success "Build completed"

# Step 5: Unlink previous version (if exists)
info "Removing previous global installation (if any)..."
npm unlink -g claudish 2>/dev/null || true

# Step 6: Link globally
info "Installing globally via npm link..."
npm link

success "Claudish installed globally!"

# Step 7: Verify installation
echo ""
info "Verifying installation..."

if check_command claudish; then
    INSTALLED_PATH=$(which claudish)
    success "claudish is available at: $INSTALLED_PATH"

    echo ""
    echo "========================================"
    echo "  Installation Complete!"
    echo "========================================"
    echo ""
    echo "Usage:"
    echo "  claudish --help                    Show help"
    echo "  claudish --list-models             List available models"
    echo "  claudish --model x-ai/grok-4.1-fast \"your prompt\""
    echo ""
    echo "Quick start:"
    echo "  1. Get an API key from https://openrouter.ai/keys"
    echo "  2. Run: export OPENROUTER_API_KEY=sk-or-..."
    echo "  3. Run: claudish \"Hello, world!\""
    echo ""
else
    warn "claudish command not found in PATH"
    warn "You may need to restart your terminal or add npm global bin to PATH"
    echo ""
    echo "Try running:"
    echo "  export PATH=\"\$(npm prefix -g)/bin:\$PATH\""
    echo ""
fi
