# Telegram Bot Setup & Activation Guide

Complete step-by-step guide to set up and activate your agent on Telegram.

---

## What You'll Get

✅ Your agent responds to messages on Telegram
✅ Works in DMs, group chats, and channels
✅ Encrypted end-to-end (with Signal-like privacy)
✅ Always available, instant responses

---

## Step 1: Create a Telegram Bot

### 1.1 Open Telegram

Download Telegram if you don't have it:
- https://telegram.org/

### 1.2 Find BotFather

In Telegram search bar, type: `@BotFather`

Click on the official BotFather account (verified checkmark).

### 1.3 Start BotFather

Send `/start` to BotFather.

### 1.4 Create New Bot

Send `/newbot` to BotFather.

**Respond to prompts:**

```
BotFather: Alright, a new bot. How are we going to call it?
YOU: My Sales Bot
(Can be anything, visible to users)

BotFather: Good. Now let's choose a username for your bot.
YOU: my_sales_bot_123
(Must end with 'bot', unique, lowercase)
```

### 1.5 Get Your Bot Token

BotFather will respond with:

```
Done! Congratulations on your new bot. Here you'll find the main information:

Name: My Sales Bot
@my_sales_bot_123
Token: 123456:ABC-DEF-GHI-JKL-MNO-PQR-STU-VWX-YZ0

[Bot Link] [Edit Commands] [Edit Bot] [Delete Bot]
```

**Copy the token** (the part after "Token: ")

```
123456:ABC-DEF-GHI-JKL-MNO-PQR-STU-VWX-YZ0
```

---

## Step 2: Configure Your Agent

### 2.1 Paste Token into setup-interactive.sh

When you run `./setup-interactive.sh`, you'll be asked:

```
Paste your Telegram bot token: 
```

Paste your token here.

### 2.2 Verify Token Saved

The script saves it to `.env`:

```bash
cat ~/.openclaw/workspace/.env | grep TELEGRAM
```

Should output:
```
TELEGRAM_BOT_TOKEN=123456:ABC-DEF-GHI-JKL-MNO-PQR-STU-VWX-YZ0
```

---

## Step 3: Start Services

### 3.1 Start Ollama

```bash
ollama serve &
```

Wait for it to be ready (you'll see "Listening on...").

### 3.2 Start OpenClaw Gateway

```bash
openclaw gateway start
```

Verify it's running:
```bash
openclaw status
```

---

## Step 4: Test Your Bot

### 4.1 Find Your Bot on Telegram

In Telegram search bar, type: `@my_sales_bot_123` (your bot username)

Click on it.

### 4.2 Start the Chat

Send `/start`

You should see a response from your agent!

### 4.3 Send a Test Message

```
Hello, test message
```

Your agent should respond within 5-10 seconds.

---

## Step 5: Customize Responses

### 5.1 Edit Your Agent's Personality

Edit `~/.openclaw/workspace/SOUL.md`:

```markdown
# SOUL.md - Your Agent's Personality

Be a sales professional. Your job is to:
- Qualify leads
- Answer product questions  
- Schedule demos
- Build relationships
```

### 5.2 Restart to Apply Changes

```bash
openclaw gateway restart
```

Send a test message. Your agent should reflect the new personality.

---

## Step 6: Advanced Options

### 6.1 Add to Group Chat

1. Create a Telegram group
2. Add your bot: Search `@my_sales_bot_123`
3. Add bot to group
4. Send a message in group

Bot responds in groups too!

### 6.2 Create Telegram Channel

1. Create a Telegram channel
2. Add bot as admin
3. Post in channel

Bot can post to channels automatically.

### 6.3 Set Commands

In Telegram, BotFather allows custom commands.

Send `/setcommands` to BotFather to add:
- help — Get help
- status — Check agent status
- settings — Change settings

---

## Troubleshooting

### Bot doesn't respond

1. Check token is correct
2. Check gateway is running: `openclaw status`
3. Check logs: `openclaw gateway logs`
4. Restart: `openclaw gateway restart`

### Bot only responds sometimes

1. Check Ollama is running: `ollama list`
2. Check API keys are valid: `cat ~/.openclaw/workspace/.env`
3. Restart all services

### Bot takes too long to respond

- First response takes 10-15 seconds (model loading)
- Subsequent responses are faster (3-5 seconds)
- If consistently slow, check your internet connection

---

## Best Practices

✅ **DO:**
- Send test messages to verify it's working
- Add context to your agent (edit MEMORY.md)
- Use in group chats for team collaboration
- Keep bot running 24/7 for production

❌ **DON'T:**
- Share your bot token publicly
- Leave bot running on a shared computer
- Use free tier for production
- Abuse the bot (avoid spam/flooding)

---

## Keep It Running

### Option 1: Local Machine (Development)
```bash
# Terminal 1
ollama serve &

# Terminal 2
openclaw gateway start
```

### Option 2: Server (Production)
Deploy to VPS and keep running with tmux:
```bash
tmux new-session -d -s jbclaw "openclaw gateway start"
```

### Option 3: Always-On Service

Create systemd service (Linux):

```bash
sudo systemctl enable jbclaw
sudo systemctl start jbclaw
```

---

## Next Steps

1. ✅ Customize SOUL.md (personality)
2. ✅ Add memory (MEMORY.md with context)
3. ✅ Create group chats for team use
4. ✅ Set up automation (cron jobs)
5. ✅ Monitor with `openclaw status --watch`

---

Your Telegram bot is now live! 🚀
