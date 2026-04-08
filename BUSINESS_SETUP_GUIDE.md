# Business Agent Setup Guide

Complete guide for deploying a jbclaw-business agent to your infrastructure.

---

## What You'll Get

After setup:
- ✅ AI agent running on your machine
- ✅ Telegram/Discord/Slack integration (your choice)
- ✅ Persistent memory with embeddings
- ✅ Automated version control & backups
- ✅ Customizable branding & personality
- ✅ Production-ready with monitoring

---

## Prerequisites

1. **Operating System**
   - Linux (Ubuntu, Kali, CentOS)
   - macOS
   - Windows (WSL2)

2. **Resources**
   - 2+ CPU cores
   - 4GB+ RAM
   - 15GB disk space (for models)
   - Internet connection

3. **API Keys** (you'll get these during setup)
   - OpenRouter API key (for LLM)
   - Telegram bot token (or Discord/Slack)
   - GitHub personal access token (for version control)

---

## Setup Instructions

### Step 1: Clone Repository

```bash
git clone https://github.com/pabukola2/jbclaw-business.git my-agent
cd my-agent
```

### Step 2: Run Setup Script

```bash
chmod +x setup.sh
./setup.sh
```

The script will:
1. Check system dependencies
2. Ask for your API credentials
3. Install/configure everything
4. Start the agent
5. Verify it's working

### Step 3: Follow Prompts

When setup.sh runs, you'll be asked:

```
1. What's your agent's name?
   Example: "Sales Bot", "Support Pro", "Growth Agent"

2. What's its personality? (brief description)
   Example: "Energetic sales professional, closes deals"

3. OpenRouter API key?
   Get from: https://openrouter.ai/keys

4. Which communication channel?
   - Telegram (recommended for testing)
   - Discord
   - Slack
   - Multiple channels

5. Channel credentials?
   - Telegram: Bot token from BotFather
   - Discord: Bot token from Developer Portal
   - Slack: App token from Slack API

6. GitHub token?
   Get from: https://github.com/settings/tokens
```

### Step 4: Verify Setup

After setup completes, test:

```bash
# Check status
openclaw status

# View logs
openclaw gateway logs

# Send test message to your bot
# Your agent should respond!
```

---

## Getting API Keys

### OpenRouter

1. Go to https://openrouter.ai/keys
2. Create account
3. Copy your API key
4. Add $5+ credits for testing

### Telegram

1. Open Telegram app
2. Search for `@BotFather`
3. Type `/start`
4. Type `/newbot`
5. Follow prompts
6. Copy the bot token

### Discord

1. Go to https://discord.com/developers/applications
2. New Application
3. Copy Application ID
4. Go to "Bot" tab
5. Add Bot
6. Copy Bot Token

### GitHub

1. Go to https://github.com/settings/tokens
2. Generate new token
3. Select `repo` scope
4. Copy token

---

## Customization

### Change Agent Personality

Edit `SOUL.md`:
```markdown
# Your Agent's Personality

Be [your description]. Your goals are [goals]. 
```

### Change Agent Identity

Edit `IDENTITY.md`:
```markdown
- Name: Your Agent Name
- Creature: AI assistant
- Vibe: [your vibe]
- Emoji: [emoji]
```

### Load Pre-built Template

```bash
# Sales agent template
cp examples/SOUL-sales-agent.md SOUL.md
cp examples/IDENTITY-sales-agent.md IDENTITY.md

# Support agent template
cp examples/SOUL-support-agent.md SOUL.md
cp examples/IDENTITY-support-agent.md IDENTITY.md

# Business dev template
cp examples/SOUL-business-dev.md SOUL.md
cp examples/IDENTITY-business-dev.md IDENTITY.md
```

---

## Troubleshooting

### Agent not responding

1. Check status: `openclaw status`
2. Check logs: `openclaw gateway logs`
3. Verify API keys work: `./scripts/validate-config.sh`
4. Restart: `openclaw gateway restart`

### Models not downloading

Ollama downloads are slow. Be patient or:
```bash
# Download in background
tmux new-session -d -s models "ollama pull minimax-m2.5:cloud"
```

### Memory not working

```bash
# Rebuild QMD embeddings
qmd embed --collection memory --force

# Test search
qmd search "test" --collection memory
```

### GitHub not syncing

```bash
# Check git status
cd ~/.openclaw/workspace
git log --oneline | head -5

# Manually push
git push origin main
```

---

## Daily Operations

### Start Services

```bash
# Terminal 1: Start Ollama
ollama serve &

# Terminal 2: Start OpenClaw
openclaw gateway start

# Terminal 3: Monitor
openclaw status --watch
```

### Update Agent Memory

Edit `memory/YYYY-MM-DD.md` with notes:
```markdown
# Today's Context

## Conversations
- Customer asked about pricing

## Decisions
- Implemented feature X

## Learnings
- Users prefer email over SMS
```

Auto-syncs to GitHub.

### Backup

Everything is automatically versioned in git:
```bash
cd ~/.openclaw/workspace
git log --oneline  # See all history
git push           # Sync to GitHub
```

---

## Support

### Starter Tier ($299/mo)
- Email support (48h response)
- Access to documentation
- Community Discord

### Professional Tier ($699/mo)
- Email + Slack support (24h response)
- Quarterly strategy calls
- Custom memory templates
- Priority updates

### Enterprise Tier ($1,999+/mo)
- Dedicated Slack channel
- 2-hour response SLA
- Weekly strategy calls
- Custom integrations
- Your own infrastructure

---

## Next Steps

1. ✅ Run `./setup.sh`
2. ✅ Test with a message
3. ✅ Customize SOUL.md & IDENTITY.md
4. ✅ Add your memory/context
5. ✅ Deploy to production

Your agent is ready! 🚀
