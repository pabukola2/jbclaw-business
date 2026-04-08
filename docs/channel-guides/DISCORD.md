# Discord Bot Setup & Activation Guide

Complete step-by-step guide to set up and activate your agent on Discord.

---

## What You'll Get

✅ Your agent responds in Discord servers
✅ Works in channels, DMs, and threads
✅ Perfect for team collaboration
✅ Slash commands for easy interaction

---

## Step 1: Create Discord Application

### 1.1 Go to Developer Portal

Visit: https://discord.com/developers/applications

### 1.2 Create New Application

Click **"New Application"**

Name it: "My Agent Name"

Click **Create**

### 1.3 Create Bot

Go to **"Bot"** tab on left sidebar

Click **"Add Bot"**

---

## Step 2: Get Bot Token

### 2.1 Copy Bot Token

In the **Bot** tab, under **TOKEN** section:

Click **"Copy"**

This is your bot token:
```
MzI4OTk2MzcyNDc1MDMyMTI.DnKTow.q1Ygv0FqkxvkXXXXXXXXXXX
```

---

## Step 3: Configure Permissions

### 3.1 Set Permissions

Go to **OAuth2** → **URL Generator**

**Scopes:**
- ✅ bot

**Permissions:**
- ✅ Send Messages
- ✅ Read Messages/View Channels
- ✅ Read Message History
- ✅ Mention @everyone, @here, and All Roles

Copy the generated URL at the bottom.

---

## Step 4: Add Bot to Server

### 4.1 Open Generated URL

Paste the URL from Step 3.1 into your browser.

### 4.2 Select Server

In the dropdown, select the Discord server where you want to add the bot.

Click **"Authorize"**

Your bot is now in the server!

---

## Step 5: Configure Your Agent

### 5.1 Paste Token into setup-interactive.sh

When you run `./setup-interactive.sh`, select **Discord** and paste your bot token.

### 5.2 Verify Token Saved

```bash
cat ~/.openclaw/workspace/.env | grep DISCORD
```

Should output:
```
DISCORD_BOT_TOKEN=MzI4OTk2MzcyNDc1MDMyMTI.DnKTow.q1Ygv0FqkxvkXXXXXXXXXXX
```

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

## Step 7: Test Your Bot

### 7.1 Go to Discord Server

Open your Discord server.

### 7.2 Send Message

Send a message in any channel where the bot can see it:

```
@YourBotName Hello test
```

Your bot should respond!

### 7.3 Try DMs

You can also DM the bot directly:

```
Hello, test message
```

---

## Step 8: Advanced Options

### 8.1 Create Slash Commands

Slash commands make interaction easier:

```
/help - Get help
/status - Check agent status
/ask - Ask a question
```

Edit `SOUL.md` to define slash commands.

### 8.2 Use Threads

The bot works in Discord threads:

1. Create a thread in a channel
2. @ mention the bot
3. Bot responds in the thread

### 8.3 Configure Channel Restrictions

Go to **Server Settings** → **Channels**

For each channel, set:
- Who can see it
- Who can post
- Bot permissions

---

## Troubleshooting

### Bot doesn't respond

1. Check bot is in the server (check member list)
2. Check bot has permissions in the channel
3. Check logs: `openclaw gateway logs`

### Bot permissions missing

Go back to OAuth2 → URL Generator and ensure all permissions are checked, then re-add the bot.

### Bot is offline

Check OpenClaw status: `openclaw status`

Restart: `openclaw gateway restart`

---

## Best Practices

✅ **DO:**
- Create a dedicated channel for the bot
- Use threads to keep conversations organized
- Give the bot appropriate roles and permissions
- Test in a private server first

❌ **DON'T:**
- Share your bot token
- Use bot on public servers without moderation
- Give bot admin permissions unnecessarily
- Spam or overload the bot

---

## Keep It Running

### Development (Local)
```bash
ollama serve &
openclaw gateway start
```

### Production (Server)
Use tmux to keep running:
```bash
tmux new-session -d -s jbclaw "openclaw gateway start"
```

---

## Next Steps

1. ✅ Customize SOUL.md
2. ✅ Add memory (MEMORY.md)
3. ✅ Create more channels for organization
4. ✅ Invite team members to server
5. ✅ Set up automation

---

Your Discord bot is live! 🚀
