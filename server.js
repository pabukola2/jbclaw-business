// Simple Express server to serve the setup wizard
const express = require('express');
const path = require('path');

const app = express();
const PORT = process.env.PORT || 3000;

// Serve static files
app.use(express.static(path.join(__dirname)));

// Serve setup wizard as root
app.get('/', (req, res) => {
    res.sendFile(path.join(__dirname, 'setup-wizard.html'));
});

// Serve interactive channel setup guides
app.get('/setup/:channel', (req, res) => {
    const channel = req.params.channel.toLowerCase();
    const file = channel + '-setup-guide.html';
    res.sendFile(path.join(__dirname, file));
});

// Serve API keys guide
app.get('/api-keys', (req, res) => {
    res.sendFile(path.join(__dirname, 'docs', 'API-KEYS.md'));
});

// Serve markdown channel guides
app.get('/guides/:channel', (req, res) => {
    const channel = req.params.channel.toUpperCase();
    res.sendFile(path.join(__dirname, 'docs', 'channel-guides', `${channel}.md`));
});

// Health check
app.get('/health', (req, res) => {
    res.json({ status: 'ok', message: 'JB Claw Business Setup Wizard is running!' });
});

app.listen(PORT, () => {
    console.log(`🚀 JB Claw Setup Wizard running on http://localhost:${PORT}`);
});
