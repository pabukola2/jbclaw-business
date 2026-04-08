# Setup New Machine - Full Clone with All Config

This guide lets you clone the jbclaw setup to a new machine with all configuration, context, and dependencies.

---

## Prerequisites

- Linux/macOS/Windows (with WSL)
- Git installed
- Administrator access (for `sudo`)
- ~15 GB disk space (for Ollama models)

---

## Step 1: Clone Repository

```bash
git clone https://github.com/Jbgabreal/jbclaw.git ~/jbclaw
cd ~/jbclaw
```

---

## Step 2: System Dependencies

### macOS
```bash
brew install node npm ollama python3 git gh
```

### Linux (Debian/Ubuntu/Kali)
```bash
sudo apt update && sudo apt install -y \
  nodejs npm ollama python3 python3-pip python3-venv \
  git curl wget build-essential
```

### Linux (RHEL/CentOS/Fedora)
```bash
sudo yum install -y \
  nodejs npm python3 python3-pip git curl wget \
  gcc gcc-c++ make
```

---

## Step 3: Node Global Tools

```bash
npm install -g @tobilu/qmd
npm install -g openclaw  # If needed
```

---

## Step 4: Python Environment & Dependencies

```bash
# Create virtual environment
python3 -m venv ~/.venv/jbclaw
source ~/.venv/jbclaw/bin/activate  # Linux/macOS
# or
~\.venv\jbclaw\Scripts\activate  # Windows

# Install dependencies
pip install --upgrade pip
pip install -r ~/jbclaw/requirements.txt

# Install Playwright browsers
playwright install chromium
```

---

## Step 5: Ollama Setup

```bash
# Start Ollama daemon
ollama serve &

# Pull models (in another terminal, after daemon starts)
sleep 5
ollama pull qwen2.5:7b
ollama pull minimax-m2.5:cloud

# Verify
ollama list
```

---

## Step 6: QMD Setup & Memory Initialization

```bash
# Verify QMD is installed
qmd --version

# Create workspace memory directory
mkdir -p ~/.openclaw/workspace/memory

# Initialize QMD collection
qmd collection add memory --pattern "**/*.md" --path ~/.openclaw/workspace/memory

# Copy memory files from cloned repo
cp -r ~/jbclaw/memory/* ~/.openclaw/workspace/memory/
cp ~/jbclaw/MEMORY.md ~/.openclaw/workspace/

# Build embeddings (takes 2-5 minutes first time)
echo "Building QMD embeddings..."
qmd embed --collection memory --force

# Verify everything is set up
qmd collection list

# Test search functionality
qmd search "YouTube" --collection memory
```

**Expected output from `qmd collection list`:**
```
Collections (1):

memory (qmd://memory/)
  Pattern:  **/*.md
  Files:    23
  Updated:  just now
```

---

## Step 7: OpenClaw Configuration

```bash
# Option A: Copy from original machine (best)
scp user@original-machine:~/.openclaw/openclaw.json ~/.openclaw/

# Option B: Create new from template (if no access to original)
cp ~/jbclaw/openclaw.json.template ~/.openclaw/openclaw.json

# Then edit with your details:
# - Change workspace path to: /path/to/your/workspace
# - Replace YOUR_TELEGRAM_ID with actual ID
# - Replace YOUR_TELEGRAM_BOT_TOKEN
# - Replace YOUR_GATEWAY_TOKEN
# - Update qmd command path if different

nano ~/.openclaw/openclaw.json  # Edit as needed
```

**Critical fields to update:**
```json
{
  "agents": {
    "defaults": {
      "workspace": "/full/path/to/your/workspace"
    }
  },
  "channels": {
    "telegram": {
      "allowFrom": ["YOUR_USER_ID"],
      "botToken": "YOUR_BOT_TOKEN"
    }
  },
  "gateway": {
    "auth": {
      "token": "YOUR_GATEWAY_TOKEN"
    }
  },
  "memory": {
    "qmd": {
      "command": "/path/to/qmd"
    }
  }
}
```

---

## Step 8: GitHub Authentication

```bash
# Install GitHub CLI (if not already installed)
# macOS
brew install gh

# Linux - download binary directly
wget https://github.com/cli/cli/releases/download/v2.50.0/gh_2.50.0_linux_amd64.tar.gz
tar xzf gh_2.50.0_linux_amd64.tar.gz
sudo mv gh_2.50.0_linux_amd64/bin/gh /usr/local/bin/
rm -rf gh_2.50.0_linux_amd64*

# Authenticate
gh auth login
# Follow prompts in browser

# Verify
gh auth status
```

---

## Step 9: Git Configuration

```bash
# Configure git user
git config --global user.email "your-email@example.com"
git config --global user.name "Your Name"

# Set up credential helper
git config --global credential.helper "!gh auth git-credential"

# Set up auto-push hook in workspace
cd ~/.openclaw/workspace

# Add remote
git remote add origin https://github.com/Jbgabreal/jbclaw.git || true

# Create post-commit hook for auto-push
mkdir -p .git/hooks
cat > .git/hooks/post-commit << 'EOF'
#!/bin/bash
cd ~/.openclaw/workspace
git push origin main 2>&1 | grep -E "(Everything|failed|error)" || true
EOF
chmod +x .git/hooks/post-commit

# Create local git config
cat > .gitconfig-local << 'EOF'
[push]
    default = current
[credential]
    helper = !gh auth git-credential
EOF

git config --local include.path ../.gitconfig-local
```

---

## Step 10: Verify Everything

```bash
# Check all versions
echo "=== System Versions ==="
node --version
npm --version
python3 --version
qmd --version
gh --version
ollama --version

# Check Ollama models
echo "=== Ollama Models ==="
ollama list

# Check QMD setup
echo "=== QMD Setup ==="
qmd collection list
qmd search "config" --collection memory

# Check Git
echo "=== Git Status ==="
cd ~/.openclaw/workspace
git log --oneline | head -5
git remote -v

# Check GitHub auth
echo "=== GitHub Auth ==="
gh auth status
```

---

## Step 11: Start OpenClaw Gateway

```bash
# Start the gateway daemon
openclaw gateway start

# Verify it's running
openclaw status

# View logs if needed
openclaw gateway logs
```

---

## Step 12: Test with a Message

Try sending a test message:
```bash
# Via Telegram (if configured)
# Send a message to your bot

# Or test via CLI
# Your assistant should respond!
```

---

## Environment Variables (Optional)

Create `~/.openclaw/.env` for sensitive data:

```bash
OPENROUTER_API_KEY=your_key_here
OLLAMA_API_KEY=ollama-local
GITHUB_TOKEN=your_gh_token_here
TELEGRAM_BOT_TOKEN=your_bot_token
```

Then reference in openclaw.json:
```json
{
  "channels": {
    "telegram": {
      "botToken": "${TELEGRAM_BOT_TOKEN}"
    }
  }
}
```

---

## Troubleshooting

### Ollama not starting
```bash
# Check if port 11434 is in use
lsof -i :11434

# Start manually in debug mode
ollama serve --debug
```

### QMD collection not found
```bash
# Manually add collection
qmd collection add memory --pattern "**/*.md" --path ~/.openclaw/workspace/memory

# Check config
qmd collection list

# Rebuild embeddings
qmd embed --collection memory --force
```

### Git push fails
```bash
# Check authentication
gh auth status

# Re-authenticate
gh auth logout
gh auth login

# Test push
cd ~/.openclaw/workspace
git push origin main
```

### Playwright installation slow
```bash
# Install in tmux/screen background
tmux new-session -d -s playwright "pip install playwright && playwright install chromium"
tmux attach -t playwright
```

### OpenClaw won't start
```bash
# Check status
openclaw doctor

# View gateway logs
tail -f ~/.openclaw/gateway.log

# Restart gateway
openclaw gateway restart
```

### Memory search not working
```bash
# Verify collection exists
qmd collection list

# Check embeddings
ls -la ~/.openclaw/qmd/collections/memory/

# Rebuild if needed
qmd embed --collection memory --force

# Test search
qmd search "test" --collection memory
```

---

## What's Included

✅ **Full context:** MEMORY.md (23 memory files synced)
✅ **All config:** AGENTS.md, SOUL.md, USER.md, IDENTITY.md, TOOLS.md, HEARTBEAT.md
✅ **Scripts & automation:** All Python scripts, Playwright automation, video generation
✅ **Version history:** Full git log with all commits and decisions
✅ **Memory backend:** QMD configured with embeddings ready
✅ **Documentation:** All setup guides and checklists

❌ **Not included:** API keys (security), large media files (storage), system tokens

---

## Post-Setup: Daily Operations

After setup, just:

```bash
# Terminal 1: Start Ollama
ollama serve &

# Terminal 2: Start OpenClaw
openclaw gateway start

# Terminal 3: Start using
# Send me a message and we're off!
```

All changes auto-commit to GitHub. Context persists. You can switch machines anytime. 🦌

---

## Support

If something breaks:
1. Check `openclaw doctor`
2. View logs: `openclaw gateway logs`
3. Restart everything: `openclaw gateway restart`
4. Check GitHub: Make sure latest code is pulled

Questions? Check MEMORY.md for context on all decisions made.
