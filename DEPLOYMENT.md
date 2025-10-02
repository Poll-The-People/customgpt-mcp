# 🚀 CustomGPT MCP Server Deployment Guide

Complete deployment guide for hosting your CustomGPT MCP Server across different platforms.

## 📋 Prerequisites

- **CustomGPT.ai Account**: Get your API key from [CustomGPT.ai Dashboard](https://app.customgpt.ai)
- **Python 3.8+**: For local development and testing
- **Git**: For cloning and version control

## 🎯 Quick Deployment Options

### Option 1: Railway (🌟 Recommended for Production)

**Why Railway?**
- ✅ Built for persistent services (perfect for MCP servers)
- ✅ Free tier with generous limits
- ✅ Custom domains included
- ✅ Automatic HTTPS
- ✅ Easy scaling
- ✅ Great for WebSocket connections

**Deploy in 3 minutes:**

1. **Fork this repository** to your GitHub account

2. **Deploy to Railway**
   ```bash
   # Option A: Use Railway CLI
   npm install -g @railway/cli
   railway login
   railway init
   railway up

   # Option B: Connect GitHub repo in Railway dashboard
   # Visit: https://railway.app/new
   # Connect your forked repository
   ```

3. **Set Environment Variables** in Railway dashboard:
   ```env
   CUSTOMGPT_API_BASE=https://app.customgpt.ai
   PORT=8000
   PYTHONPATH=.
   DEBUG=false
   ```

4. **Add Custom Domain** (Optional):
   ```bash
   railway domain add mcp.yourdomain.com
   ```

**Your MCP URL**: `https://your-app-name.railway.app`

### Option 2: Vercel (Serverless)

**Good for:** Light usage, cost optimization, edge deployment

1. **Install Vercel CLI**
   ```bash
   npm i -g vercel
   ```

2. **Deploy**
   ```bash
   vercel --prod
   ```

3. **Configure Environment Variables** in Vercel dashboard:
   ```env
   CUSTOMGPT_API_BASE=https://app.customgpt.ai
   ```

**Your MCP URL**: `https://your-project.vercel.app/mcp`

### Option 3: Docker (Self-Hosted)

**Good for:** Full control, on-premises deployment, Kubernetes

1. **Using Docker Compose** (Simplest):
   ```bash
   git clone https://github.com/customgpt-ai/customgpt-mcp-server.git
   cd customgpt-mcp-server

   # Configure environment
   cp .env.example .env
   # Edit .env with your settings

   # Start server
   docker-compose up -d
   ```

2. **Manual Docker**:
   ```bash
   # Build image
   docker build -t customgpt-mcp-server .

   # Run container
   docker run -d \
     --name customgpt-mcp \
     -p 8000:8000 \
     -e CUSTOMGPT_API_BASE=https://app.customgpt.ai \
     customgpt-mcp-server
   ```

**Your MCP URL**: `https://your-domain.com:8000` or `http://localhost:8000`

### Option 4: Local Development

**Good for:** Testing, development, local-only usage

```bash
# Clone repository
git clone https://github.com/customgpt-ai/customgpt-mcp-server.git
cd customgpt-mcp-server

# Setup Python environment
python -m venv venv
source venv/bin/activate  # Windows: venv\Scripts\activate

# Install dependencies
pip install -r requirements.txt

# Configure environment
cp .env.example .env
# Edit .env with your settings

# Run server
python server.py
```

**Your MCP URL**: `http://localhost:8000`

## 🔧 Environment Configuration

### Required Environment Variables

```env
# API Settings
CUSTOMGPT_API_BASE=https://app.customgpt.ai
API_VERSION=v1

# Server Settings
HOST=0.0.0.0
PORT=8000
DEBUG=false

# CORS Settings (Production)
CORS_ORIGINS=https://claude.ai,https://chatgpt.com,https://your-domain.com

# Security
API_KEY_MASK_CHARS=4
```

### Optional Environment Variables

```env
# Rate Limiting
DEFAULT_REQUESTS_PER_MINUTE=60
DEFAULT_REQUESTS_PER_HOUR=1000
DEFAULT_REQUESTS_PER_DAY=10000

# Caching
CACHE_TTL_SECONDS=300
MEMORY_CACHE_SIZE=1000

# Analytics
ANALYTICS_RETENTION_DAYS=90
ENABLE_ANALYTICS=true

# Webhooks
WEBHOOK_TIMEOUT_SECONDS=30
WEBHOOK_RETRY_COUNT=3
```

## 🌐 Custom Domain Setup

### Railway Custom Domain
1. Go to Railway dashboard → Your project → Settings
2. Click "Custom Domain"
3. Add your domain: `mcp.yourdomain.com`
4. Update your DNS with the provided CNAME record

### Cloudflare Setup (Optional)
```yaml
# Add to your DNS records
Type: CNAME
Name: mcp
Target: your-app-name.railway.app
Proxy: Enabled (for additional security)
```

## 🔐 SSL/HTTPS Configuration

### Railway/Vercel
- ✅ **Automatic HTTPS** - Nothing to configure!

### Docker/Self-Hosted
Use a reverse proxy like Nginx:

```nginx
# /etc/nginx/sites-available/customgpt-mcp
server {
    listen 443 ssl;
    server_name mcp.yourdomain.com;

    ssl_certificate /path/to/your/certificate.crt;
    ssl_certificate_key /path/to/your/private.key;

    location / {
        proxy_pass http://localhost:8000;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
    }
}
```

## 🎯 MCP Client Configuration

### Claude Code Configuration

Add to your `~/.config/claude-code/mcp.json`:

```json
{
  "mcpServers": {
    "customgpt": {
      "command": "python",
      "args": ["/path/to/customgpt-mcp-server/server.py"],
      "env": {
        "PYTHONPATH": "/path/to/customgpt-mcp-server"
      }
    }
  }
}
```

Or for hosted server:
```json
{
  "mcpServers": {
    "customgpt": {
      "url": "https://mcp.yourdomain.com",
      "type": "stdio"
    }
  }
}
```

### Claude Web Configuration

1. **Open Claude Web Settings**
2. **Navigate to MCP Servers**
3. **Add New Server**:
   - Name: `CustomGPT`
   - URL: `https://mcp.yourdomain.com`
   - Type: `HTTP`

### ChatGPT Configuration

1. **Open ChatGPT Settings**
2. **Go to Beta Features**
3. **Enable MCP Support**
4. **Add Server**: `https://mcp.yourdomain.com`

## 📊 Monitoring & Observability

### Health Checks

```bash
# Basic health check
curl https://mcp.yourdomain.com/health

# Detailed status
curl https://mcp.yourdomain.com/status
```

### Logs Monitoring

**Railway**: View logs in Railway dashboard
**Docker**: `docker logs customgpt-mcp`
**Local**: Check console output

### Analytics Dashboard

Access built-in analytics:
```bash
# Get system metrics
curl -X POST https://mcp.yourdomain.com/tools \
  -H "Content-Type: application/json" \
  -d '{"name": "get_usage_analytics", "arguments": {"api_key": "your_key"}}'
```

## ⚡ Performance Optimization

### Production Settings

```env
# Enable all optimizations
DEBUG=false
CACHE_TTL_SECONDS=600
MEMORY_CACHE_SIZE=2000
ENABLE_ANALYTICS=true

# Conservative rate limits for production
DEFAULT_REQUESTS_PER_MINUTE=30
DEFAULT_REQUESTS_PER_HOUR=500
DEFAULT_REQUESTS_PER_DAY=5000
```

### Scaling Options

**Railway**: Upgrade to Pro plan for better performance
**Docker**: Use docker-compose with multiple replicas
**Load Balancer**: Use nginx or cloud load balancer for high traffic

### Caching Strategy

The server includes intelligent multi-layer caching:
- **Memory Cache**: Fast access for recent data
- **Persistent Cache**: SQLite-based for longer storage
- **API Response Caching**: Reduces CustomGPT API calls

## 🛡️ Security Best Practices

### Production Security Checklist

- [ ] **HTTPS Only**: Ensure all connections use HTTPS
- [ ] **API Key Protection**: Never log or expose full API keys
- [ ] **CORS Configuration**: Set specific origins, avoid `*` in production
- [ ] **Rate Limiting**: Configure appropriate limits for your use case
- [ ] **Monitoring**: Set up alerts for unusual activity
- [ ] **Updates**: Keep dependencies updated regularly

### Webhook Security

```env
# Use webhook secrets for verification
WEBHOOK_SECRET=your-secret-key-here

# Limit webhook retries
WEBHOOK_RETRY_COUNT=3
WEBHOOK_TIMEOUT_SECONDS=10
```

### Network Security

```bash
# Firewall rules (if self-hosting)
ufw allow 443/tcp
ufw allow 80/tcp
ufw deny 8000/tcp  # Only allow through reverse proxy
```

## 🔧 Troubleshooting

### Common Deployment Issues

#### "Module not found" errors
```bash
# Ensure PYTHONPATH is set correctly
export PYTHONPATH=/path/to/customgpt-mcp-server
```

#### Port binding issues
```bash
# Check if port is available
lsof -i :8000
```

#### Memory issues
```bash
# Reduce cache size
MEMORY_CACHE_SIZE=500
```

### Debug Mode

Enable comprehensive debugging:
```env
DEBUG=true
LOG_LEVEL=DEBUG
```

### Health Check Endpoints

- `/health` - Basic server health
- `/metrics` - Prometheus-style metrics
- `/cache/stats` - Cache performance stats
- `/webhooks/status` - Webhook endpoint status

## 📈 Performance Tuning

### Database Optimization (SQLite)

```sql
-- Add to analytics.db for better performance
PRAGMA journal_mode=WAL;
PRAGMA synchronous=NORMAL;
PRAGMA temp_store=memory;
PRAGMA mmap_size=268435456;  -- 256MB
```

### Memory Optimization

```env
# Tune cache sizes based on available memory
MEMORY_CACHE_SIZE=1000      # ~10MB RAM
PERSISTENT_CACHE_SIZE=5000  # ~50MB disk
```

### Concurrency Tuning

```env
# Adjust based on your server capacity
MAX_CONCURRENT_REQUESTS=10
BATCH_OPERATION_CONCURRENCY=5
```

## 🔄 Backup & Recovery

### Data Backup

```bash
# Backup analytics database
cp analytics.db analytics_backup_$(date +%Y%m%d).db

# Backup cache database
cp cache.db cache_backup_$(date +%Y%m%d).db
```

### Automated Backups

```bash
# Add to crontab for daily backups
0 2 * * * /path/to/backup_script.sh
```

## 🎉 Go Live Checklist

- [ ] **Environment Variables**: All required variables set
- [ ] **SSL Certificate**: HTTPS working properly
- [ ] **Custom Domain**: Domain pointing to your server
- [ ] **Health Checks**: All endpoints responding correctly
- [ ] **Rate Limits**: Configured appropriately
- [ ] **Monitoring**: Logs and alerts set up
- [ ] **Backup**: Backup strategy in place
- [ ] **Documentation**: Team knows how to use the server
- [ ] **Testing**: End-to-end testing completed

## 🆘 Support

Need help with deployment?

- **Documentation**: [https://docs.customgpt.ai/mcp](https://docs.customgpt.ai/mcp)
- **GitHub Issues**: [Report deployment issues](https://github.com/customgpt-ai/customgpt-mcp-server/issues)
- **Email Support**: [hello@customgpt.ai](mailto:hello@customgpt.ai)
- **Community Discord**: [Join our Discord](https://discord.gg/customgpt)

---

**🎯 Recommended Production Setup:**
1. **Railway** for hosting (automatic HTTPS, scaling)
2. **Custom domain** for professional appearance
3. **Webhook monitoring** for real-time insights
4. **Rate limiting** for API protection
5. **Analytics enabled** for usage insights

[![Deploy on Railway](https://railway.app/button.svg)](https://railway.app/template/your-template-id)