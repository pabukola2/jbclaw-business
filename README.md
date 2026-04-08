# jbclaw-business

**White-label AI agent platform for enterprises, agencies, and businesses.**

Deploy a fully-configured AI agent to your infrastructure in 20 minutes. Customize branding, memory, and workflows. Scale to unlimited agents.

---

## What You Get

✅ **Pre-configured AI agent system** — Instantly ready for deployment
✅ **Full memory management** — QMD-backed context that grows with your business
✅ **Multi-channel support** — Telegram, Discord, Slack, Teams, etc.
✅ **Automation frameworks** — Playwright, Python scripts, webhooks
✅ **Version control** — Full git history, audit trail, rollback capability
✅ **One-command deployment** — `./setup.sh` handles everything

---

## Quick Start

```bash
# 1. Clone repo
git clone https://github.com/pabukola2/jbclaw-business.git my-agent
cd my-agent

# 2. Run setup (prompts for your credentials)
./setup.sh

# 3. Agent is live
# Send a message and it's ready!
```

**That's it.** 20 minutes from clone to production.

---

## Pricing Tiers

| Plan | Price | Features | SLA |
|------|-------|----------|-----|
| **Starter** | $299/mo | Basic agent, 1 channel, email support | 99.5% |
| **Professional** | $699/mo | Advanced agent, 5 channels, chat support, quarterly calls | 99.9% |
| **Enterprise** | $1,999/mo | Custom agent, unlimited channels, dedicated support, weekly calls | 99.99% |

---

## Use Cases

**Sales Agent** ($499/mo)
- Lead research & qualification
- Email outreach automation
- CRM integration
- Sales playbook memory

**Support Agent** ($399/mo)
- Ticket routing & escalation
- FAQ database
- Customer communication
- Multi-channel support

**Business Development Agent** ($699/mo)
- Partnership research
- Outreach campaigns
- Deal tracking
- Market intelligence

**Content Agent** ($599/mo)
- Content planning & scheduling
- Multi-platform posting
- Engagement tracking
- Analytics reporting

---

## Getting Started

### 1. Prerequisites
- Linux/macOS/Windows (WSL)
- ~15GB disk space
- API keys (we help you get them):
  - OpenRouter (for LLM models)
  - Telegram/Discord/Slack (pick your channels)
  - GitHub (for version control)

### 2. Installation
Follow **BUSINESS_SETUP_GUIDE.md** for complete setup instructions.

### 3. Configuration
- Customize `SOUL.md` with your agent's personality
- Update `IDENTITY.md` with your branding
- Load pre-built templates from `examples/`

### 4. Launch
Agent auto-syncs to GitHub. Ready for production.

---

## Documentation

| Doc | Purpose |
|-----|---------|
| **BUSINESS_SETUP_GUIDE.md** | End-to-end setup for customers |
| **docs/API-KEYS.md** | How to get each required API key |
| **docs/CUSTOMIZATION.md** | Branding, memory, workflows |
| **docs/TROUBLESHOOTING.md** | Common issues & fixes |
| **PRICING.md** | Detailed pricing & ROI |

---

## Examples

Pre-built templates for common use cases:

```bash
# Sales agent
cp examples/SOUL-sales-agent.md SOUL.md
cp examples/IDENTITY-sales-agent.md IDENTITY.md

# Support agent
cp examples/SOUL-support-agent.md SOUL.md
cp examples/IDENTITY-support-agent.md IDENTITY.md

# Business dev
cp examples/SOUL-business-dev.md SOUL.md
cp examples/IDENTITY-business-dev.md IDENTITY.md
```

---

## Support

**Starter ($299/mo):** Email support (48h response)
**Professional ($699/mo):** Email + Slack (24h response)
**Enterprise ($1,999/mo):** Dedicated Slack + weekly calls

---

## Features

- 🧠 **Persistent Memory** — Grows over time, never forgets context
- 🔄 **Multi-Channel** — Telegram, Discord, Slack, Teams, Signal, etc.
- 🤖 **AI Models** — Claude, GPT, open-source (your choice)
- 🔌 **Integrations** — Webhooks, APIs, automation
- 📊 **Analytics** — Usage tracking, performance metrics
- 🔐 **Security** — Encrypted secrets, self-hosted option
- 📈 **Scalable** — From startup to enterprise
- 🔄 **Version Control** — Full git history, rollback capability

---

## Technical Architecture

- **Agent Runtime:** OpenClaw (self-hosted, open-source)
- **Memory Backend:** QMD (markdown-based, embedded)
- **Models:** Ollama local + OpenRouter cloud
- **Automation:** Playwright, Python, webhooks
- **Infrastructure:** Your machine, cloud, or our hosting

---

## FAQ

**Q: Can I use my own LLM?**
A: Yes. supports Claude, GPT, Llama, Mistral, and more.

**Q: Where does data live?**
A: Your infrastructure. We never see your data.

**Q: Can I rebrand it?**
A: Completely. Change name, personality, memory, everything.

**Q: What if I need help?**
A: Professional & Enterprise tiers include support & customization.

**Q: Can I resell this?**
A: Yes. Agency pricing available for white-label partners.

---

## Get Started

1. Read **BUSINESS_SETUP_GUIDE.md**
2. Run `./setup.sh`
3. Follow the prompts
4. Send a message

Done. Your agent is live. 🚀

---

## License

MIT — Use, modify, resell freely.

---

**Built with ❤️ by Jb Claw**

Questions? Check the docs or open an issue.
