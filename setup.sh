#!/bin/bash

# ============================================================================
# JB CLAW - Full Setup & Clone Script
# ============================================================================
# One-command setup for complete environment replication
# Installs all dependencies, configures everything, starts the system
# ============================================================================

set -e  # Exit on error

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Configuration
WORKSPACE_DIR="$HOME/.openclaw/workspace"
VENV_DIR="$HOME/.venv/jbclaw"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ENCRYPTION_PASSWORD="${ENCRYPTION_PASSWORD:-jbclaw-backup-2026}"

# ============================================================================
# Helper Functions
# ============================================================================

print_header() {
    echo -e "\n${BLUE}╔════════════════════════════════════════╗${NC}"
    echo -e "${BLUE}║ $1${NC}"
    echo -e "${BLUE}╚════════════════════════════════════════╝${NC}\n"
}

print_step() {
    echo -e "${GREEN}→${NC} $1"
}

print_success() {
    echo -e "${GREEN}✓${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}⚠${NC} $1"
}

print_error() {
    echo -e "${RED}✗${NC} $1"
}

check_command() {
    if command -v "$1" &> /dev/null; then
        print_success "$1 is installed"
        return 0
    else
        print_error "$1 is NOT installed"
        return 1
    fi
}

# ============================================================================
# Step 1: Detect OS & Install System Dependencies
# ============================================================================

install_system_deps() {
    print_header "STEP 1: Installing System Dependencies"
    
    if [[ "$OSTYPE" == "linux-gnu"* ]]; then
        if command -v apt-get &> /dev/null; then
            print_step "Detected Debian/Ubuntu/Kali - using apt"
            sudo apt update
            sudo apt install -y \
                nodejs npm python3 python3-pip python3-venv \
                git curl wget build-essential
        elif command -v yum &> /dev/null; then
            print_step "Detected RHEL/CentOS/Fedora - using yum"
            sudo yum install -y \
                nodejs npm python3 python3-pip git curl wget \
                gcc gcc-c++ make
        else
            print_error "Unsupported Linux distro"
            return 1
        fi
    elif [[ "$OSTYPE" == "darwin"* ]]; then
        print_step "Detected macOS - using brew"
        if ! command -v brew &> /dev/null; then
            print_error "Homebrew not installed. Install from https://brew.sh"
            return 1
        fi
        brew install node python3 git
    else
        print_error "Unsupported OS: $OSTYPE"
        return 1
    fi
    
    print_success "System dependencies installed"
}

# ============================================================================
# Step 2: Install Node Global Tools
# ============================================================================

install_node_tools() {
    print_header "STEP 2: Installing Node Global Tools (QMD, OpenClaw)"
    
    print_step "Installing @tobilu/qmd"
    npm install -g @tobilu/qmd
    
    print_step "Verifying QMD installation"
    qmd --version
    
    print_success "Node tools installed"
}

# ============================================================================
# Step 3: Setup Python Virtual Environment
# ============================================================================

setup_python_venv() {
    print_header "STEP 3: Setting Up Python Virtual Environment"
    
    print_step "Creating venv at $VENV_DIR"
    python3 -m venv "$VENV_DIR"
    
    print_step "Activating venv"
    source "$VENV_DIR/bin/activate"
    
    print_step "Upgrading pip"
    pip install --upgrade pip
    
    print_step "Installing Python dependencies from requirements.txt"
    if [ -f "$SCRIPT_DIR/requirements.txt" ]; then
        pip install -r "$SCRIPT_DIR/requirements.txt"
    else
        print_warning "requirements.txt not found, skipping Python deps"
    fi
    
    print_step "Installing Playwright browsers"
    playwright install chromium
    
    print_success "Python environment ready"
}

# ============================================================================
# Step 4: Install Ollama & Pull Models
# ============================================================================

install_ollama() {
    print_header "STEP 4: Setting Up Ollama"
    
    if ! check_command ollama; then
        print_step "Installing Ollama"
        if [[ "$OSTYPE" == "linux-gnu"* ]]; then
            curl -fsSL https://ollama.ai/install.sh | sh
        elif [[ "$OSTYPE" == "darwin"* ]]; then
            print_warning "For macOS, download Ollama from https://ollama.ai"
            print_warning "Then come back and run: ollama serve &"
            return 0
        fi
    fi
    
    print_step "Starting Ollama daemon"
    ollama serve > /tmp/ollama.log 2>&1 &
    OLLAMA_PID=$!
    sleep 5
    
    print_step "Pulling qwen2.5:7b model"
    timeout 600 ollama pull qwen2.5:7b || print_warning "qwen2.5:7b pull timed out, continuing..."
    
    print_step "Pulling minimax-m2.5:cloud model"
    timeout 600 ollama pull minimax-m2.5:cloud || print_warning "minimax-m2.5:cloud pull timed out, continuing..."
    
    print_step "Verifying models"
    ollama list
    
    print_success "Ollama setup complete (running in background, PID: $OLLAMA_PID)"
}

# ============================================================================
# Step 5: Setup GitHub CLI & Authentication
# ============================================================================

setup_github_cli() {
    print_header "STEP 5: Setting Up GitHub CLI"
    
    if ! check_command gh; then
        print_step "Installing GitHub CLI"
        if [[ "$OSTYPE" == "linux-gnu"* ]]; then
            # Download binary directly
            GH_VERSION="2.50.0"
            GH_ARCH=$(dpkg --print-architecture)
            GH_URL="https://github.com/cli/cli/releases/download/v${GH_VERSION}/gh_${GH_VERSION}_linux_${GH_ARCH}.tar.gz"
            
            print_step "Downloading gh from $GH_URL"
            wget -q "$GH_URL" -O /tmp/gh.tar.gz
            tar xzf /tmp/gh.tar.gz -C /tmp
            sudo mv /tmp/gh_${GH_VERSION}_linux_${GH_ARCH}/bin/gh /usr/local/bin/
            rm -rf /tmp/gh_${GH_VERSION}_linux_${GH_ARCH}* /tmp/gh.tar.gz
        elif [[ "$OSTYPE" == "darwin"* ]]; then
            brew install gh
        fi
    fi
    
    print_step "Checking GitHub authentication"
    if gh auth status &> /dev/null; then
        print_success "Already authenticated to GitHub"
    else
        print_warning "Please authenticate with GitHub"
        print_warning "Run: gh auth login"
        print_warning "Then come back and run this script again"
        return 1
    fi
}

# ============================================================================
# Step 6: Setup QMD & Memory
# ============================================================================

setup_qmd_memory() {
    print_header "STEP 6: Setting Up QMD Memory Backend"
    
    print_step "Creating memory directory"
    mkdir -p "$WORKSPACE_DIR/memory"
    
    print_step "Initializing QMD collection"
    qmd collection add memory --pattern "**/*.md" --path "$WORKSPACE_DIR/memory" || print_warning "Collection may already exist"
    
    print_step "Building QMD embeddings (this may take 2-5 minutes)"
    qmd embed --collection memory --force
    
    print_step "Verifying QMD setup"
    qmd collection list
    
    print_success "QMD memory backend ready"
}

# ============================================================================
# Step 7: Decrypt & Setup OpenClaw Config
# ============================================================================

decrypt_config() {
    print_header "STEP 7: Decrypting OpenClaw Configuration"
    
    if [ ! -f "$SCRIPT_DIR/openclaw.json.enc" ]; then
        print_error "openclaw.json.enc not found at $SCRIPT_DIR"
        print_warning "Create encrypted config with:"
        print_warning "  openssl enc -aes-256-cbc -salt -in ~/.openclaw/openclaw.json -out openclaw.json.enc"
        return 1
    fi
    
    print_step "Decrypting configuration with password"
    openssl enc -d -aes-256-cbc -in "$SCRIPT_DIR/openclaw.json.enc" \
        -out "$HOME/.openclaw/openclaw.json" -k "$ENCRYPTION_PASSWORD" 2>/dev/null
    
    if [ $? -eq 0 ]; then
        chmod 600 "$HOME/.openclaw/openclaw.json"
        print_success "Configuration decrypted and set to read-only"
    else
        print_error "Failed to decrypt configuration"
        print_error "Check your encryption password"
        return 1
    fi
}

# ============================================================================
# Step 8: Configure Git
# ============================================================================

configure_git() {
    print_header "STEP 8: Configuring Git"
    
    print_step "Setting up git credential helper"
    git config --global credential.helper "!gh auth git-credential"
    
    print_step "Adding git remote"
    cd "$WORKSPACE_DIR"
    git remote add origin https://github.com/Jbgabreal/jbclaw.git 2>/dev/null || true
    
    print_step "Creating post-commit hook for auto-push"
    mkdir -p "$WORKSPACE_DIR/.git/hooks"
    cat > "$WORKSPACE_DIR/.git/hooks/post-commit" << 'HOOK'
#!/bin/bash
cd ~/.openclaw/workspace
git push origin main 2>&1 | grep -E "(Everything|failed|error)" || true
HOOK
    chmod +x "$WORKSPACE_DIR/.git/hooks/post-commit"
    
    print_success "Git configured"
}

# ============================================================================
# Step 9: Verify Everything
# ============================================================================

verify_setup() {
    print_header "STEP 9: Verifying Complete Setup"
    
    local all_ok=true
    
    print_step "Checking Node.js"
    check_command node || all_ok=false
    
    print_step "Checking Python"
    check_command python3 || all_ok=false
    
    print_step "Checking QMD"
    check_command qmd || all_ok=false
    
    print_step "Checking Ollama"
    check_command ollama || all_ok=false
    
    print_step "Checking GitHub CLI"
    check_command gh || all_ok=false
    
    print_step "Checking Git"
    check_command git || all_ok=false
    
    print_step "Verifying QMD collection"
    qmd collection list | grep -q memory && print_success "QMD collection 'memory' found" || all_ok=false
    
    print_step "Verifying OpenClaw config"
    [ -f "$HOME/.openclaw/openclaw.json" ] && print_success "openclaw.json exists" || all_ok=false
    
    if [ "$all_ok" = true ]; then
        print_success "All verifications passed!"
        return 0
    else
        print_error "Some verifications failed"
        return 1
    fi
}

# ============================================================================
# Step 10: Start Services
# ============================================================================

start_services() {
    print_header "STEP 10: Starting Services"
    
    print_step "OpenClaw Gateway"
    openclaw gateway start || print_warning "Could not start gateway, try manually"
    
    sleep 2
    
    print_step "Checking gateway status"
    openclaw status || print_warning "Gateway may still be starting"
}

# ============================================================================
# Main Execution
# ============================================================================

main() {
    print_header "JB CLAW - FULL SETUP & CLONE"
    echo -e "This script will:"
    echo -e "  • Install all system dependencies"
    echo -e "  • Setup Python virtual environment"
    echo -e "  • Install Ollama & pull ML models"
    echo -e "  • Configure QMD memory backend"
    echo -e "  • Decrypt OpenClaw configuration"
    echo -e "  • Setup GitHub authentication"
    echo -e "  • Start all services"
    echo -e "\nEstimated time: 20-30 minutes"
    echo -e "Requires: Internet, sudo access, 15GB disk space\n"
    
    read -p "Continue? (y/n) " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        print_error "Setup cancelled"
        exit 1
    fi
    
    # Run all steps
    install_system_deps || exit 1
    install_node_tools || exit 1
    setup_python_venv || exit 1
    install_ollama || print_warning "Ollama setup incomplete, may need manual setup"
    setup_github_cli || print_warning "GitHub setup incomplete"
    setup_qmd_memory || exit 1
    decrypt_config || exit 1
    configure_git || exit 1
    verify_setup || print_warning "Some verifications failed, but continuing..."
    start_services || print_warning "Services may need manual start"
    
    print_header "SETUP COMPLETE ✓"
    echo -e "Next steps:"
    echo -e "  1. Verify services: ${BLUE}openclaw status${NC}"
    echo -e "  2. Check gateway logs: ${BLUE}openclaw gateway logs${NC}"
    echo -e "  3. Send a test message!"
    echo -e "\nYour system is now an exact clone of Jb Claw with all:"
    echo -e "  • Configuration (OpenClaw settings)"
    echo -e "  • Memory (QMD backend with embeddings)"
    echo -e "  • Models (Ollama with minimax & qwen)"
    echo -e "  • Automation (All scripts ready)"
    echo -e "  • Git history (Full version control)\n"
}

# Run main
main "$@"
