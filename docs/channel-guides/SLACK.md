# Slack Bot Setup & Activation Guide

Complete step-by-step guide to set up and activate your agent on Slack.

---

## What You'll Get

✅ Your agent responds in Slack channels
✅ Works with Direct Messages
✅ Perfect for enterprise teams
✅ Integrates with Slack workflows

---

## Step 1: Create Slack App

### 1.1 Go to Slack API

Visit: https://api.slack.com/apps

### 1.2 Create New App

Click **"Create New App"**

Choose **"From scratch"**

### 1.3 Configure App

**App Name:** Your Agent Name

**Pick a Slack workspace:** Select your workspace

Click **"Create App"**

---

## Step 2: Add Scopes & Permissions

### 2.1 Go to Bot Token Scopes

Left sidebar → **"OAuth & Permissions"**

Under **"Scopes"** → **"Bot Token Scopes"**

Add these scopes:
- ✅ app_mentions:read
- ✅ channels:history
- ✅ chat:write
- ✅ commands
- ✅ groups:history
- ✅ im:history
- ✅ mpim:history

---

## Step 3: Install App to Workspace

### 3.1 Install App

Scroll up to **"OAuth Tokens for Your Workspace"**

Click **"Install to Workspace"**

Click **"Allow"** to authorize

### 3.2 Copy Bot Token

After authorization, you'll see your bot token:

```
xoxb-YOUR-BOT-TOKEN
```

**Copy this token**

---

## Step 4: Configure Your Agent

### 4.1 Paste Token into setup-interactive.sh

When you run `./setup-interactive.sh`, select **Slack** and paste your bot token.

### 4.2 Verify Token Saved

```bash
cat ~/.openclaw/workspace/.env | grep SLACK
```

Should output:
```
SLACK_BOT_TOKEN=xoxb-YOUR-BOT-TOKEN
```

---

## Step 5: Add Bot to Channels

### 5.1 Go to Slack Workspace

Open your Slack workspace.

### 5.2 Add Bot to Channel

In any channel, type:

```
/invite @YourBotName
```

Bot is now in the channel!

### 5.3 Test

Send a message:

```
@YourBotName Hello test
```

Bot should respond!

---

## Step 6: Start Services

### 6.1 Start Ollama

```bash
ollama serve &
```

### 6.2 Start OpenClaw

```bash
openclaw gateway start
```

---

## Step 7: Advanced Options

### 7.1 Create Slash Commands

Make commands in Slack:

Go to **Slash Commands** (in app settings)

Create commands like:
- `/help` - Get help
- `/ask` - Ask a question
- `/status` - Check status

### 7.2 Use with Workflows

Slack Workflows can trigger your bot:

1. Create Slack Workflow
2. Add your bot as an action
3. Automate team processes

### 7.3 Direct Messages

Users can DM your bot directly:

1. Click bot name in Slack
2. Send a message
3. Bot responds in DM

---

## Troubleshooting

### Bot doesn't respond

1. Verify bot is in the channel: `/invite @YourBotName`
2. Check bot token is correct: `cat ~/.openclaw/workspace/.env`
3. Check logs: `openclaw gateway logs`
4. Restart: `openclaw gateway restart`

### Permission denied errors

Go back to **OAuth & Permissions** and ensure all scopes are added.

Then reinstall the app.

### Bot offline

Check OpenClaw: `openclaw status`

Restart services.

---

## Best Practices

✅ **DO:**
- Create a dedicated #bot channel
- Use Slack channels to organize conversations
- Set appropriate permissions per channel
- Keep bot updated with latest scopes

❌ **DON'T:**
- Share your bot token
- Give bot unnecessary permissions
- Use bot in random channels without purpose
- Spam or overload the bot

---

## Keep It Running

### Development
```bash
ollama serve &
openclaw gateway start
```

### Production
Use systemd or tmux:
```bash
tmux new-session -d -s jbclaw "openclaw gateway start"
```

---

## Next Steps

1. ✅ Invite bot to team channels
2. ✅ Create slash commands
3. ✅ Set up Slack workflows
4. ✅ Customize SOUL.md for Slack tone
5. ✅ Add team-specific memory

---

Your Slack bot is live! 🚀
