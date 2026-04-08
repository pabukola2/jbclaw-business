#!/bin/bash

# ============================================================================
# JB CLAW - Interactive Setup for Communication Channels
# ============================================================================
# This script prompts for API keys and communication preferences
# Run this AFTER setup.sh completes
# ============================================================================

set -e

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

WORKSPACE_DIR="$HOME/.openclaw/workspace"

print_header() {
    echo -e "\n${BLUE}╔═══════════════════════════════════════════╗${NC}"
    echo -e "${BLUE}║ $1${NC}"
    echo -e "${BLUE}╚═══════════════════════════════════════════╝${NC}\n"
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

# ============================================================================
# Step 1: Agent Customization
# ============================================================================

configure_agent() {
    print_header "Step 1: Configure Your Agent"
    
    echo "What's your agent's name?"
    echo "Examples: 'Sales Bot', 'Support Pro', 'Growth Partner', 'Content Creator'"
    read -p "Agent name: " AGENT_NAME
    
    echo -e "\nDescribe your agent's personality in 1-2 sentences:"
    echo "Examples:"
    echo "  - 'Energetic sales professional who closes deals and builds relationships'"
    echo "  - 'Patient support expert who solves customer problems instantly'"
    echo "  - 'Creative content strategist who finds viral trends'"
    read -p "Personality: " AGENT_PERSONALITY
    
    # Update IDENTITY.md
    cat > "$WORKSPACE_DIR/IDENTITY.md" << EOF
# IDENTITY.md - Who I Am

- **Name:** $AGENT_NAME
- **Creature:** AI agent
- **Personality:** $AGENT_PERSONALITY
- **Emoji:** 🤖
EOF
    
    print_success "Agent configured: $AGENT_NAME"
}

# ============================================================================
# Step 2: Communication Channel Selection
# ============================================================================

select_communication() {
    print_header "Step 2: Choose Communication Channel"
    
    echo "Which platform(s) will you use to chat with your agent?"
    echo ""
    echo "1) Telegram (recommended for testing)"
    echo "2) Discord"
    echo "3) Slack"
    echo "4) WhatsApp"
    echo "5) Multiple channels"
    echo ""
    read -p "Select (1-5): " CHANNEL_CHOICE
    
    case $CHANNEL_CHOICE in
        1)
            setup_telegram
            ;;
        2)
            setup_discord
            ;;
        3)
            setup_slack
            ;;
        4)
            setup_whatsapp
            ;;
        5)
            echo -e "\n${YELLOW}Multi-channel setup${NC}"
            echo "You can add multiple channels to .env"
            echo "See docs/API-KEYS.md for each channel setup"
            ;;
    esac
}

# ============================================================================
# Telegram Setup
# ============================================================================

setup_telegram() {
    print_header "Telegram Bot Setup"
    
    echo "Getting a Telegram bot token:"
    echo ""
    echo "1. Open Telegram and search for: @BotFather"
    echo "2. Type /start"
    echo "3. Type /newbot"
    echo "4. Follow the prompts"
    echo "5. Copy the bot token (format: 123456:ABC-DEF...)"
    echo ""
    read -p "Paste your Telegram bot token: " TELEGRAM_TOKEN
    
    if [ -z "$TELEGRAM_TOKEN" ]; then
        print_warning "Telegram token empty, skipping"
        return
    fi
    
    # Add to .env
    echo "TELEGRAM_BOT_TOKEN=$TELEGRAM_TOKEN" >> "$WORKSPACE_DIR/.env"
    print_success "Telegram configured"
}

# ============================================================================
# Discord Setup
# ============================================================================

setup_discord() {
    print_header "Discord Bot Setup"
    
    echo "Getting a Discord bot token:"
    echo ""
    echo "1. Go to: https://discord.com/developers/applications"
    echo "2. Click 'New Application'"
    echo "3. Name it: $AGENT_NAME"
    echo "4. Go to 'Bot' tab"
    echo "5. Click 'Add Bot'"
    echo "6. Copy the token under 'TOKEN'"
    echo ""
    read -p "Paste your Discord bot token: " DISCORD_TOKEN
    
    if [ -z "$DISCORD_TOKEN" ]; then
        print_warning "Discord token empty, skipping"
        return
    fi
    
    echo ""
    echo "To add your bot to a server:"
    echo "1. Go to OAuth2 → URL Generator"
    echo "2. Select scopes: 'bot'"
    echo "3. Select permissions: 'Send Messages', 'Read Messages'"
    echo "4. Copy the generated URL and open it in browser"
    echo ""
    read -p "Have you added the bot to your server? (y/n): " -n 1 -r
    echo
    
    echo "DISCORD_BOT_TOKEN=$DISCORD_TOKEN" >> "$WORKSPACE_DIR/.env"
    print_success "Discord configured"
}

# ============================================================================
# Slack Setup
# ============================================================================

setup_slack() {
    print_header "Slack Bot Setup"
    
    echo "Getting a Slack bot token:"
    echo ""
    echo "1. Go to: https://api.slack.com/apps"
    echo "2. Click 'Create New App'"
    echo "3. Choose 'From scratch'"
    echo "4. Name: $AGENT_NAME"
    echo "5. Go to 'Bot Token Scopes'"
    echo "6. Add scopes: 'chat:write', 'commands'"
    echo "7. Go to 'Install App'"
    echo "8. Copy the 'Bot User OAuth Token'"
    echo ""
    read -p "Paste your Slack bot token: " SLACK_TOKEN
    
    if [ -z "$SLACK_TOKEN" ]; then
        print_warning "Slack token empty, skipping"
        return
    fi
    
    echo "SLACK_BOT_TOKEN=$SLACK_TOKEN" >> "$WORKSPACE_DIR/.env"
    print_success "Slack configured"
}

# ============================================================================
# WhatsApp Setup
# ============================================================================

setup_whatsapp() {
    print_header "WhatsApp Bot Setup"
    
    echo "WhatsApp requires Twilio integration (paid service)"
    echo ""
    echo "1. Go to: https://www.twilio.com"
    echo "2. Sign up for Twilio account"
    echo "3. Get WhatsApp Sandbox credentials"
    echo "4. Copy your Twilio phone number and auth token"
    echo ""
    read -p "Paste your Twilio phone number: " TWILIO_PHONE
    read -p "Paste your Twilio auth token: " TWILIO_AUTH
    
    if [ -z "$TWILIO_PHONE" ] || [ -z "$TWILIO_AUTH" ]; then
        print_warning "Twilio credentials incomplete, skipping"
        return
    fi
    
    echo "TWILIO_PHONE=$TWILIO_PHONE" >> "$WORKSPACE_DIR/.env"
    echo "TWILIO_AUTH=$TWILIO_AUTH" >> "$WORKSPACE_DIR/.env"
    print_success "WhatsApp configured"
}

# ============================================================================
# Step 3: API Keys
# ============================================================================

get_api_keys() {
    print_header "Step 3: API Keys"
    
    echo "Your agent needs 2 main API keys:"
    echo ""
    
    # OpenRouter
    echo "1. OPENROUTER API KEY (for AI models)"
    echo "   Get from: https://openrouter.ai/keys"
    echo "   Add $5+ credits for testing"
    read -p "OpenRouter API key: " OPENROUTER_KEY
    
    if [ ! -z "$OPENROUTER_KEY" ]; then
        echo "OPENROUTER_API_KEY=$OPENROUTER_KEY" >> "$WORKSPACE_DIR/.env"
        print_success "OpenRouter configured"
    fi
    
    echo ""
    
    # GitHub
    echo "2. GITHUB TOKEN (for version control & backups)"
    echo "   Get from: https://github.com/settings/tokens"
    echo "   Scopes needed: repo"
    read -p "GitHub token: " GITHUB_TOKEN
    
    if [ ! -z "$GITHUB_TOKEN" ]; then
        echo "GITHUB_TOKEN=$GITHUB_TOKEN" >> "$WORKSPACE_DIR/.env"
        print_success "GitHub configured"
    fi
}

# ============================================================================
# Step 4: Verify Setup
# ============================================================================

verify_setup() {
    print_header "Step 4: Verifying Setup"
    
    print_step "Checking .env file"
    if [ -f "$WORKSPACE_DIR/.env" ]; then
        print_success ".env file created"
        echo ""
        echo "Configured:"
        grep -E "AGENT|TOKEN|KEY" "$WORKSPACE_DIR/.env" | sed 's/=.*/=***/' || true
    fi
    
    print_step "Checking OpenClaw"
    if command -v openclaw &> /dev/null; then
        print_success "OpenClaw is installed"
    else
        print_warning "OpenClaw not found in PATH"
    fi
}

# ============================================================================
# Main Execution
# ============================================================================

main() {
    print_header "JB CLAW - INTERACTIVE SETUP"
    
    echo "This will configure your AI agent's:"
    echo "  • Name & personality"
    echo "  • Communication channel (Telegram/Discord/Slack/WhatsApp)"
    echo "  • API keys"
    echo ""
    
    read -p "Continue? (y/n): " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        echo "Setup cancelled"
        exit 1
    fi
    
    # Ensure .env exists
    touch "$WORKSPACE_DIR/.env"
    chmod 600 "$WORKSPACE_DIR/.env"
    
    configure_agent
    select_communication
    get_api_keys
    verify_setup
    
    print_header "SETUP COMPLETE ✓"
    
    echo "Next steps:"
    echo "1. Start Ollama: ollama serve &"
    echo "2. Start OpenClaw: openclaw gateway start"
    echo "3. Send your bot a test message!"
    echo ""
    echo "Your agent is ready to go! 🚀"
}

main "$@"
