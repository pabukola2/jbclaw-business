// Simple Express server to serve the setup wizard
const express = require('express');
const path = require('path');
const fs = require('fs');

const app = express();
const PORT = process.env.PORT || 3000;

// Serve all static files from root directory
app.use(express.static(path.join(__dirname), {
    setHeaders: (res, filePath) => {
        if (filePath.endsWith('.html')) {
            res.setHeader('Content-Type', 'text/html; charset=utf-8');
        }
    }
}));

// Serve setup wizard as root
app.get('/', (req, res) => {
    res.sendFile(path.join(__dirname, 'setup-wizard.html'));
});

// Serve interactive channel setup guides
app.get('/setup/:channel', (req, res) => {
    const channel = req.params.channel.toLowerCase();
    const file = path.join(__dirname, channel + '-setup-guide.html');
    
    if (fs.existsSync(file)) {
        res.sendFile(file);
    } else {
        res.status(404).send('Setup guide not found for: ' + channel);
    }
});

// Direct file access (e.g., /telegram-setup-guide.html)
app.get('/:filename', (req, res) => {
    const filename = req.params.filename;
    if (filename.includes('-setup-guide.html') || filename === 'setup-wizard.html') {
        const file = path.join(__dirname, filename);
        if (fs.existsSync(file)) {
            res.sendFile(file);
        } else {
            res.status(404).send('File not found: ' + filename);
        }
    } else {
        res.status(404).send('Not found');
    }
});

// API keys guide
app.get('/api-keys', (req, res) => {
    res.sendFile(path.join(__dirname, 'docs', 'API-KEYS.md'));
});

// Markdown channel guides
app.get('/guides/:channel', (req, res) => {
    const channel = req.params.channel.toUpperCase();
    res.sendFile(path.join(__dirname, 'docs', 'channel-guides', `${channel}.md`));
});

// Health check
app.get('/health', (req, res) => {
    res.json({ status: 'ok', message: 'JB Claw Business Setup Wizard is running!' });
});

// List available guides
app.get('/api/guides', (req, res) => {
    res.json({
        available: [
            'telegram-setup-guide.html',
            'discord-setup-guide.html',
            'slack-setup-guide.html',
            'whatsapp-setup-guide.html',
            'setup-wizard.html'
        ],
        urls: {
            main: '/',
            telegram: '/setup/telegram',
            discord: '/setup/discord',
            slack: '/setup/slack',
            whatsapp: '/setup/whatsapp'
        }
    });
});

app.listen(PORT, () => {
    console.log(`🚀 JB Claw Setup Wizard running on http://localhost:${PORT}`);
    console.log(`📱 Main wizard: http://localhost:${PORT}/`);
    console.log(`📱 Telegram guide: http://localhost:${PORT}/setup/telegram`);
    console.log(`📱 Discord guide: http://localhost:${PORT}/setup/discord`);
    console.log(`📱 Slack guide: http://localhost:${PORT}/setup/slack`);
    console.log(`📱 WhatsApp guide: http://localhost:${PORT}/setup/whatsapp`);
});
