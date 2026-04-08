# How to Get OpenRouter API Key (Complete Visual Guide)

Step-by-step guide to get your OpenRouter API key for AI models.

---

## What is OpenRouter?

**OpenRouter** gives you access to:
- ✅ Claude (Haiku, Sonnet, Opus)
- ✅ GPT-4, GPT-3.5
- ✅ Llama, Mistral
- ✅ 100+ other AI models

**Cost:** You only pay for what you use (~$0.001-0.02 per 1,000 tokens)

---

## Step 1: Go to OpenRouter Website

### 1.1 Open Browser

Go to: https://openrouter.ai

You should see the OpenRouter homepage.

### 1.2 Click Sign In

Top right corner, click **"Sign in"**

---

## Step 2: Create Account

### 2.1 Choose Sign In Method

You have options:
- ✅ **Google** (easiest - one click)
- ✅ **GitHub** 
- ✅ **Email/Password**

Click **"Continue with Google"** (recommended)

### 2.2 Google Sign In

Select your Google account or create new one.

Grant permissions to OpenRouter.

You're logged in!

---

## Step 3: Get Your API Key

### 3.1 Go to API Keys Page

After login, click your profile (top right) or go directly to:

https://openrouter.ai/keys

### 3.2 You Should See

```
API Keys

Create Key
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Name: [your existing keys if any]
```

### 3.3 Click "Create Key"

Blue button that says **"Create Key"**

### 3.4 Name Your Key

A dialog appears asking for a name.

Enter: `jbclaw-business`

Click **"Create"**

### 3.5 Copy Your Key

You'll see your new API key:

```
sk-or-v1-abc123def456ghijklmnopqrstuvwxyz
```

This is your **SECRET API KEY** - keep it safe!

**Click "Copy"** or highlight and Ctrl+C

---

## Step 4: Add Credits (Very Important!)

### 4.1 Go to Billing

Click **"Billing"** in top right

Or go to: https://openrouter.ai/account/billing

### 4.2 View Your Balance

You should see:

```
Balance: $0.00

No payment method
```

### 4.3 Add Payment Method

Click **"Add Payment Method"**

You can use:
- ✅ Credit Card (Visa, Mastercard)
- ✅ Debit Card
- ✅ Google Pay
- ✅ Apple Pay

### 4.4 Add Credit

Click **"Add Credit"** or **"Add Funds"**

Choose amount:
- **$5** (small test)
- **$10** (recommended for testing)
- **$25** (good for production)
- Custom amount

### 4.5 Checkout

Complete payment.

You should now see your balance updated:

```
Balance: $10.00
```

---

## Step 5: Save Your Key

### 5.1 Copy Your API Key Again

Go back to https://openrouter.ai/keys

Copy your key (highlight and Ctrl+C):

```
sk-or-v1-abc123def456ghijklmnopqrstuvwxyz
```

### 5.2 Save to Your Agent's .env

When running setup, paste this key when asked:

```bash
./setup-interactive.sh

Paste your OpenRouter API key: [PASTE HERE]
```

Or manually add to `.env`:

```bash
echo "OPENROUTER_API_KEY=sk-or-v1-abc123def456..." >> ~/.openclaw/workspace/.env
```

---

## Step 6: Test Your Key Works

### 6.1 Test via Command Line

```bash
curl -X GET https://openrouter.ai/api/v1/models \
  -H "Authorization: Bearer sk-or-v1-abc123def456..."
```

You should get a list of available models.

### 6.2 Test with Your Agent

After setup, send your agent a message:

```
What models are available?
```

If it responds, your key works! ✅

---

## Understanding Pricing

### Cost Calculation

**How much does it cost?**

Example with Claude Haiku:

| Task | Tokens | Cost |
|------|--------|------|
| 1 message | 100 | $0.001 |
| 10 messages | 1,000 | $0.01 |
| 100 messages | 10,000 | $0.10 |
| 1,000 messages | 100,000 | $1.00 |

**Very cheap!**

### How Long Does $10 Last?

With $10 credit, you can run approximately:

- **Light use:** 10,000+ messages
- **Active use:** 5,000+ messages  
- **Heavy use:** 1,000+ messages

**Several months for most people!**

---

## Best Practices

### ✅ DO:
- Keep your API key private
- Don't share it publicly
- Use per-project keys
- Monitor your usage
- Set spending limits (optional)

### ❌ DON'T:
- Commit key to GitHub
- Paste in public chats
- Use same key for multiple projects
- Leave unused keys active

---

## Troubleshooting

### "Invalid API Key" Error

**Problem:** Key doesn't work
**Solution:**
1. Copy key again from https://openrouter.ai/keys
2. Make sure no extra spaces
3. Paste exactly: `sk-or-v1-...`
4. Restart agent: `openclaw gateway restart`

### "No balance" or "Billing Failed"

**Problem:** Out of credits
**Solution:**
1. Go to https://openrouter.ai/account/billing
2. Add more credit ($5-50)
3. Complete payment
4. Wait 1-2 minutes
5. Try again

### "Rate limit exceeded"

**Problem:** Too many requests too fast
**Solution:**
1. Wait 1-5 minutes
2. Reduce message frequency
3. Upgrade credit amount (tells OpenRouter you're a real customer)

---

## Advanced: Set Spending Limits

You can set a max monthly spend (optional):

1. Go to https://openrouter.ai/account/billing
2. Click **"Spending Limits"**
3. Set max per month
4. Confirms you won't overspend

---

## Models Available

With OpenRouter, you can use:

**Fastest/Cheapest:**
- Claude Haiku ($0.001 per 1K tokens)
- Llama 2 (free)
- Mistral (very cheap)

**Best Quality:**
- Claude Sonnet ($0.003 per 1K tokens)
- GPT-4 ($0.01 per 1K tokens)
- Claude Opus ($0.015 per 1K tokens)

Your agent automatically picks the best one for the job!

---

## What Happens After You Create Key

1. ✅ Key created successfully
2. ✅ You add payment method
3. ✅ Credits appear in account
4. ✅ You paste key into setup
5. ✅ Agent uses models
6. ✅ Credits decrease as you use
7. ✅ Agent responds to messages

---

## FAQ

**Q: Is OpenRouter free?**
A: No, but you get $0 starting balance. You add credits ($5+ minimum).

**Q: Why do I need an API key?**
A: It authenticates you to OpenRouter so they know who to bill.

**Q: Can I use Claude without OpenRouter?**
A: You could use direct Claude API, but OpenRouter is cheaper and supports many models.

**Q: How do I know if my key works?**
A: Send a message to your agent - if it responds, key works!

**Q: What if I run out of credits?**
A: Agent stops responding. Add more credits and restart.

**Q: Can I use multiple keys?**
A: Yes, you can create multiple keys for different projects.

---

## Next Steps

1. ✅ Go to https://openrouter.ai
2. ✅ Sign in with Google
3. ✅ Create API key
4. ✅ Add $10 credit
5. ✅ Copy key to ~/.openclaw/workspace/.env
6. ✅ Run agent and test

---

**You're ready!** Your API key unlocks access to 100+ AI models. 🚀
