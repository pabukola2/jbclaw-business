# API Keys Setup Guide

Complete guide to obtaining all required API keys for your jbclaw-business agent.

---

## Overview

Your agent needs API keys for:

| Service | Purpose | Cost | Required |
|---------|---------|------|----------|
| **OpenRouter** | AI models (Claude, GPT) | Pay-as-you-go | ✅ YES |
| **GitHub** | Version control & backups | Free | ✅ YES |
| **Telegram** | Chat via Telegram | Free | If using Telegram |
| **Discord** | Chat via Discord | Free | If using Discord |
| **Slack** | Chat via Slack | Free | If using Slack |
| **Twilio/WhatsApp** | Chat via WhatsApp | $0.005-0.02/msg | If using WhatsApp |

---

## 1. OpenRouter API Key (AI Models)

**Purpose:** Access Claude, GPT, and other AI models
**Cost:** Pay-as-you-go ($0.001-0.02 per 1K tokens)
**Status:** REQUIRED

### 1.1 Go to OpenRouter

Visit: https://openrouter.ai

### 1.2 Sign Up

Click **"Sign in"** (top right)

Choose **"Continue with Google"** or **"Create Account"**

Complete signup.

### 1.3 Get API Key

After login, go to: https://openrouter.ai/keys

Click **"Create Key"**

Give it a name: "jbclaw-business"

Copy the API key:
```
sk-or-v1-abc123def456...
```

### 1.4 Add Credits

To use the API, add payment:

1. Click **"Billing"** (top right)
2. Click **"Add Credit"**
3. Add $5-20 to test
4. Confirm payment method

### 1.5 Save to .env

```bash
echo "OPENROUTER_API_KEY=sk-or-v1-abc123def456..." >> ~/.openclaw/workspace/.env
```

### 1.6 Test It Works

```bash
curl https://openrouter.ai/api/v1/models \
  -H "Authorization: Bearer sk-or-v1-abc123def456..."
```

Should return list of available models.

---

## 2. GitHub Personal Access Token

**Purpose:** Version control & automatic backups
**Cost:** Free
**Status:** REQUIRED

### 2.1 Go to GitHub

Visit: https://github.com/settings/tokens

### 2.2 Generate New Token

Click **"Generate new token"** (classic)

### 2.3 Configure Token

**Token name:** jbclaw-business

**Expiration:** 90 days (or No expiration)

**Scopes:** Select only:
- ✅ repo (Full control of private repositories)

### 2.4 Generate & Copy

Click **"Generate token"**

Copy your token:
```
ghp_abc123def456...
```

### 2.5 Save to .env

```bash
echo "GITHUB_TOKEN=ghp_abc123def456..." >> ~/.openclaw/workspace/.env
```

### 2.6 Test It Works

```bash
curl -H "Authorization: token ghp_abc123def456..." \
  https://api.github.com/user
```

Should return your GitHub profile info.

---

## 3. Telegram Bot Token

**Purpose:** Chat via Telegram
**Cost:** Free
**Status:** Optional (if using Telegram)

### 3.1 Open Telegram

Download Telegram: https://telegram.org

### 3.2 Find @BotFather

In Telegram search: `@BotFather`

### 3.3 Create Bot

Send `/newbot` to BotFather

Respond to prompts:
- **Name:** Your Agent Name
- **Username:** your_agent_bot (must end with 'bot')

### 3.4 Get Token

BotFather responds with:

```
Token: 123456:ABC-DEF-GHI-JKL-MNO-PQR
```

Copy the token.

### 3.5 Save to .env

```bash
echo "TELEGRAM_BOT_TOKEN=123456:ABC-DEF-GHI-JKL-MNO-PQR" >> ~/.openclaw/workspace/.env
```

### 3.6 Test It Works

Open Telegram and search for your bot username.

Send `/start`

Your bot should respond!

---

## 4. Discord Bot Token

**Purpose:** Chat via Discord
**Cost:** Free
**Status:** Optional (if using Discord)

### 4.1 Go to Discord Developer Portal

Visit: https://discord.com/developers/applications

### 4.2 Create Application

Click **"New Application"**

Name: Your Agent Name

Click **"Create"**

### 4.3 Create Bot

Go to **"Bot"** tab

Click **"Add Bot"**

### 4.4 Get Token

Under **TOKEN**, click **"Copy"**

Your token:
```
MzI4OTk2MzcyNDc1MDMyMTI.abc123def...
```

### 4.5 Set Permissions

Go to **OAuth2** → **URL Generator**

**Scopes:**
- ✅ bot

**Permissions:**
- ✅ Send Messages
- ✅ Read Messages/View Channels
- ✅ Read Message History

Copy the generated URL.

### 4.6 Add Bot to Server

Paste the URL in browser → Select server → Authorize

### 4.7 Save to .env

```bash
echo "DISCORD_BOT_TOKEN=MzI4OTk2MzcyNDc1MDMyMTI.abc123def..." >> ~/.openclaw/workspace/.env
```

### 4.8 Test It Works

Go to Discord server where bot is added.

Send: `@YourBotName Hello test`

Bot should respond!

---

## 5. Slack Bot Token

**Purpose:** Chat via Slack
**Cost:** Free
**Status:** Optional (if using Slack)

### 5.1 Go to Slack API

Visit: https://api.slack.com/apps

### 5.2 Create App

Click **"Create New App"**

Select **"From scratch"**

**App Name:** Your Agent Name

**Workspace:** Select your workspace

Click **"Create App"**

### 5.3 Add Scopes

Go to **OAuth & Permissions**

Under **Bot Token Scopes**, add:
- ✅ app_mentions:read
- ✅ channels:history
- ✅ chat:write
- ✅ commands
- ✅ groups:history
- ✅ im:history
- ✅ mpim:history

### 5.4 Install App

Scroll up to **OAuth Tokens**

Click **"Install to Workspace"**

Click **"Allow"**

### 5.5 Get Token

Copy **Bot User OAuth Token**:
```
xoxb-YOUR-BOT-TOKEN
```

### 5.6 Add Bot to Channels

In Slack, type in any channel:

```
/invite @YourBotName
```

### 5.7 Save to .env

```bash
echo "SLACK_BOT_TOKEN=xoxb-YOUR-BOT-TOKEN" >> ~/.openclaw/workspace/.env
```

### 5.8 Test It Works

Send message: `@YourBotName Hello test`

Bot should respond!

---

## 6. WhatsApp via Twilio

**Purpose:** Chat via WhatsApp
**Cost:** $0.005-0.02 per message
**Status:** Optional (if using WhatsApp)

### 6.1 Go to Twilio

Visit: https://www.twilio.com

### 6.2 Sign Up

Create account:
- Email
- Password
- Phone number
- Verify identity

Get **$15 free credit** for testing!

### 6.3 Set Up WhatsApp

In Twilio Console: **Messaging** → **WhatsApp** → **Try it out**

### 6.4 Get Credentials

You'll receive:

**Twilio SID:**
```
ACxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
```

**Auth Token:**
```
your_auth_token_here
```

**WhatsApp Number:**
```
+1 415-523-8886
```

### 6.5 Activate Sandbox

Send WhatsApp message to your **Twilio WhatsApp Number**:

```
join rapid-lion
(or whatever code your sandbox shows)
```

### 6.6 Save to .env

```bash
echo "TWILIO_SID=ACxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx" >> ~/.openclaw/workspace/.env
echo "TWILIO_AUTH=your_auth_token_here" >> ~/.openclaw/workspace/.env
echo "TWILIO_PHONE=+1 415-523-8886" >> ~/.openclaw/workspace/.env
```

### 6.7 Test It Works

Send WhatsApp message: `Hello test`

Bot should respond!

---

## How to Use These Keys

### In setup-interactive.sh

When running setup:

```bash
./setup-interactive.sh
```

The script will prompt you for each API key.

Paste them when asked.

### Manually in .env

Edit `~/.openclaw/workspace/.env`:

```bash
nano ~/.openclaw/workspace/.env
```

Add your keys:

```
OPENROUTER_API_KEY=sk-or-v1-...
GITHUB_TOKEN=ghp_...
TELEGRAM_BOT_TOKEN=123456:ABC-...
DISCORD_BOT_TOKEN=MzI4...
SLACK_BOT_TOKEN=xoxb-...
TWILIO_SID=ACxx...
TWILIO_AUTH=...
TWILIO_PHONE=+1...
```

Save and restart:

```bash
openclaw gateway restart
```

---

## Security Best Practices

✅ **DO:**
- Keep .env file private (already git-ignored)
- Rotate keys every 90 days
- Use different keys per environment (dev/prod)
- Store in password manager as backup
- Enable key expiration

❌ **DON'T:**
- Commit .env to git
- Share keys via email/chat
- Hardcode keys in code
- Use same key for multiple services
- Leave unused keys active

---

## Verify All Keys Work

After setting up, test all keys:

```bash
# Test OpenRouter
curl -H "Authorization: Bearer $OPENROUTER_API_KEY" \
  https://openrouter.ai/api/v1/models

# Test GitHub
curl -H "Authorization: token $GITHUB_TOKEN" \
  https://api.github.com/user

# Test Telegram (send test message)
# Your bot will respond

# Test Discord (send message in channel)
# Your bot will respond
```

---

## Costs Breakdown

| Service | Monthly Cost | Usage |
|---------|--------------|-------|
| OpenRouter | $10-50 | Depends on model usage |
| GitHub | Free | Unlimited |
| Telegram | Free | Unlimited |
| Discord | Free | Unlimited |
| Slack | Free | Unlimited |
| Twilio/WhatsApp | $0-50+ | $0.005-0.02 per message |

**Total minimum:** $10-50/month for a working agent

**Can be much less** if using free tier models (local Ollama)

---

## Troubleshooting

### "Invalid API Key" error

1. Check key is correct: `cat ~/.openclaw/workspace/.env`
2. Re-copy from source (no extra spaces)
3. Restart gateway: `openclaw gateway restart`

### "Rate limit exceeded" error

For OpenRouter:
1. Reduce message frequency
2. Upgrade OpenRouter credits
3. Switch to cheaper model

For WhatsApp:
1. Check Twilio balance
2. Add more credits
3. Request production access for better rates

### Bot not responding to messages

1. Verify token is saved: `cat ~/.openclaw/workspace/.env`
2. Check gateway is running: `openclaw status`
3. Check logs: `openclaw gateway logs`
4. Make sure bot is in channel/group (for Discord/Slack/Telegram groups)

---

## Next Steps

1. ✅ Get OpenRouter key (REQUIRED)
2. ✅ Get GitHub token (REQUIRED)
3. ✅ Get communication platform key (Telegram/Discord/Slack/WhatsApp)
4. ✅ Add all to .env
5. ✅ Run setup-interactive.sh
6. ✅ Test bot responds

---

Your agent is ready to go! 🚀
