# WhatsApp Bot Setup & Activation Guide

Complete step-by-step guide to set up and activate your agent on WhatsApp.

---

## What You'll Get

✅ Your agent responds to WhatsApp messages
✅ Works globally (100+ countries)
✅ Encrypted end-to-end messaging
✅ Mobile-first communication

---

## Prerequisites

**Note:** WhatsApp requires a paid service (Twilio) to operate.

**Cost:** ~$0.005-0.02 per message (very affordable)

---

## Step 1: Set Up Twilio Account

### 1.1 Go to Twilio

Visit: https://www.twilio.com

### 1.2 Create Account

Sign up for a Twilio account:
- Email
- Password
- Phone number
- Verify your identity

### 1.3 Create Twilio Project

After signup, you'll get a free account with $15 credit.

---

## Step 2: Set Up WhatsApp Sandbox

### 2.1 Go to WhatsApp in Console

In Twilio Console, go to: **Messaging** → **Try it out** → **WhatsApp**

### 2.2 Configure Sandbox

Click **"Try WhatsApp"**

Follow setup wizard:
1. Agree to Twilio WhatsApp terms
2. Create a sandbox
3. Name your sandbox (e.g., "My Sales Bot")

### 2.3 Get Sandbox Credentials

You'll receive:

**Twilio Phone Number:**
```
+1 415-523-8886 (example)
```

**Auth Token:**
```
your_auth_token_here
```

---

## Step 3: Activate WhatsApp for Your Number

### 3.1 Find Setup Instructions

In the sandbox, you'll see instructions like:

"To use WhatsApp, send a test message to +1 415-523-8886"

### 3.2 Send Test Message

Open WhatsApp on your phone.

Send message to the Twilio number:

```
join rapid-lion
```

(The code changes per sandbox)

You'll get a response confirming setup!

---

## Step 4: Get API Credentials

### 4.1 Get Twilio SID

In Twilio Console → **Account**

Copy **Account SID:**
```
ACxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
```

### 4.2 Get Auth Token

Copy **Auth Token:**
```
your_auth_token_here
```

### 4.3 Get WhatsApp Number

From the sandbox setup, note your **Twilio WhatsApp Number:**
```
+1 415-523-8886
```

---

## Step 5: Configure Your Agent

### 5.1 Paste Credentials into setup-interactive.sh

When you run `./setup-interactive.sh`, select **WhatsApp**:

```
Paste your Twilio phone number: +1 415-523-8886
Paste your Twilio auth token: your_auth_token_here
```

### 5.2 Verify Saved

```bash
cat ~/.openclaw/workspace/.env | grep TWILIO
```

Should output:
```
TWILIO_PHONE=+1 415-523-8886
TWILIO_AUTH=your_auth_token_here
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

### 7.1 Send WhatsApp Message

On your phone, open WhatsApp.

Send a message to your **Twilio WhatsApp Number**:

```
Hello test
```

Your agent should respond!

### 7.2 Try Different Messages

Test different types of messages:
- "What's your name?"
- "Help me with sales"
- "Tell me a joke"

---

## Step 8: Scale to Production

### 8.1 Request Full WhatsApp API

Once testing is successful, apply for **WhatsApp Business API**:

1. In Twilio Console → **WhatsApp**
2. Click **"Request Production Access"**
3. Fill out form explaining your use case
4. Twilio reviews (usually 24-48 hours)
5. Get approved for production use

### 8.2 Production Costs

Once approved:
- Messages: $0.005-0.02 each (very cheap)
- No monthly fees
- Pay as you go

### 8.3 Buy More Twilio Credits (Optional)

For testing beyond free $15:

1. Go to Twilio Billing
2. Add payment method
3. Buy credits as needed

---

## Troubleshooting

### Bot doesn't respond

1. Check credentials are correct
2. Verify Twilio account is active
3. Check OpenClaw logs: `openclaw gateway logs`
4. Ensure you joined the sandbox (sent "join" message)

### Message delivery issues

1. Check Twilio account balance (need $$ for production)
2. Verify phone number format: +1234567890
3. Try sending from different phone

### Getting too many messages

Use Twilio Console to adjust:
- Message rate limits
- Blocked numbers
- Sandbox settings

---

## Best Practices

✅ **DO:**
- Keep Twilio credentials private
- Test thoroughly before sending to customers
- Monitor Twilio usage to manage costs
- Use WhatsApp for personal/small business
- Upgrade to Business API for enterprise

❌ **DON'T:**
- Share your Twilio credentials
- Send spam messages (Twilio will ban you)
- Use sandbox indefinitely (request production)
- Send too many messages at once

---

## Upgrade to WhatsApp Business API

For enterprise-scale WhatsApp:

1. Apply for **Meta for Developers** partnership
2. Get official WhatsApp Business account
3. Higher throughput (1,000s of messages/day)
4. Professional support

Visit: https://www.whatsapp.com/business/api

---

## Keep It Running

### Development
```bash
ollama serve &
openclaw gateway start
```

### Production (Server)
```bash
tmux new-session -d -s jbclaw "openclaw gateway start"
```

---

## Pricing

- **Free tier:** $15 credit (test phase)
- **Production:** $0.005-0.02 per message
- **100 messages:** $0.50-2.00

Very cost-effective for small to medium businesses!

---

## Next Steps

1. ✅ Test with sandbox
2. ✅ Customize SOUL.md for WhatsApp tone
3. ✅ Request production access
4. ✅ Launch to customers
5. ✅ Monitor usage & costs

---

Your WhatsApp bot is live! 🚀
