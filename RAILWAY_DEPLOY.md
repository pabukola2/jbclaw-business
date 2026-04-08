# Deploy to Railway in 2 Minutes

**Railway** is a simple platform to host web apps. Deploy the setup wizard in just 2 minutes!

---

## What You'll Get

✅ Live URL to share with customers
✅ Free tier (includes some free usage)
✅ Auto-deploys on git push
✅ HTTPS included

---

## Step 1: Sign Up for Railway

### 1.1 Go to Railway

Visit: https://railway.app

### 1.2 Sign Up

Click **"Start Free"**

Sign in with:
- ✅ GitHub (recommended - auto-deploys)
- ✅ Google
- ✅ Email

### 1.3 Create Account

Complete signup (takes 1 minute).

---

## Step 2: Deploy jbclaw-business

### 2.1 Connect GitHub

Railway will ask: **"Connect your GitHub"**

Click **"Connect GitHub"**

Authorize Railway to access your repos.

### 2.2 Select Repository

Choose: **jbclaw-business**

### 2.3 Deploy

Railway automatically:
1. Installs dependencies (`npm install`)
2. Starts the server (`npm start`)
3. Assigns a public URL

**That's it!** 🎉

---

## Step 3: Get Your Live URL

### 3.1 View Deployment

After a few seconds, you'll see:

```
Deployment Status: ✓ Success
```

### 3.2 Find Your URL

Railway shows your live URL:

```
https://jbclaw-business-production.up.railway.app
```

**Share this URL with customers!**

---

## How Customers Use It

They visit:

```
https://jbclaw-business-production.up.railway.app
```

See beautiful setup wizard → 5 clicks → Download guide → Done!

---

## Auto-Deploy on Updates

Every time you push to GitHub:

```bash
git push origin main
```

Railway automatically:
1. Detects the change
2. Rebuilds the app
3. Deploys new version
4. URL stays the same

**No manual work!** 🚀

---

## Pricing

**Free tier:**
- 500 hours/month (more than enough)
- 100GB bandwidth
- Perfect for setup wizard

**Then:** $5/month if you go over

---

## Troubleshooting

### App not loading

1. Check deployment status in Railway dashboard
2. Look at build logs
3. Try refreshing page

### Wrong URL displayed

Go to Railway dashboard → Project → Domain

Copy the correct URL (usually .up.railway.app)

### Deployment failed

Check build logs for errors:
- Missing `package.json`? Add it (already included)
- Node version issue? Already configured
- Port issue? Already using PORT env variable

---

## Next Steps

1. ✅ Sign up at railway.app
2. ✅ Connect GitHub
3. ✅ Select jbclaw-business repo
4. ✅ Railway auto-deploys
5. ✅ Share URL with customers
6. ✅ Test it works

---

## Marketing Your URL

Once deployed, you can:

```
Website: jbclaw-business-production.up.railway.app
Send to customers: "Click here to set up your AI agent"
Marketing: "Live setup wizard at [URL]"
Social media: "Get started now: [URL]"
```

---

**Your setup wizard is now live on the internet!** 🌍

Share the URL anywhere. Customers can start setting up immediately. No installation needed—just open the link and click through the wizard.

---

## Alternative Hosting (If Not Using Railway)

Other options:
- **Vercel** (https://vercel.com) - Great for static sites
- **Netlify** (https://netlify.com) - Also great for static
- **Heroku** (https://heroku.com) - Similar to Railway
- **AWS** (https://aws.amazon.com) - More complex

But **Railway is the easiest.** Recommended! ✨
