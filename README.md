# CustomGPT MCP Server

A **full-featured** Model Context Protocol (MCP) server that provides seamless access to CustomGPT.ai APIs. Interact with your CustomGPT agents directly through Claude Code, Claude Web, and any MCP-compatible client.

## Features

### Agent Management
- **List Agents**: Browse all your CustomGPT agents with pagination
- **Get Agent Details**: Retrieve detailed information about specific agents
- **Create Agents**: Create new agents from sitemaps or files
- **Agent Statistics**: Get usage stats, page counts, and conversation metrics
- **Agent Settings**: View and configure agent behavior and appearance

### Conversation Management
- **Send Messages**: Chat with your agents using OpenAI-compatible format
- **List Conversations**: Browse conversation history for any agent
- **Message History**: Retrieve full conversation transcripts

### Content Management
- **List Pages**: View all pages/sources for your agents
- **Page Status**: Check crawl and indexing status
- **Content Sources**: Manage sitemaps and uploaded files

### API Documentation Integration
- **Search Documentation**: Find relevant API endpoints and documentation
- **Endpoint Details**: Get comprehensive information about specific API endpoints
- **Interactive Help**: Built-in API reference with examples

### Security & Privacy
- **API Key Masking**: Secure API key handling with automatic masking in logs
- **Validation**: Built-in API key validation and format checking
- **No Storage**: Stateless design - API keys are never stored permanently

## Quick Start

### Prerequisites
- **Python 3.10+** (required for FastMCP)
- A valid CustomGPT.ai API key from [CustomGPT Dashboard](https://app.customgpt.ai)
- MCP-compatible client (Claude Code, Claude Web, etc.)

### Installation

#### **Recommended Setup**
```bash
# Clone repository
git clone https://github.com/Poll-The-People/customgpt-mcp.git
cd customgpt-mcp

# Create Python 3.11 virtual environment (required for FastMCP)
python3.11 -m venv venv
source venv/bin/activate

# Install dependencies (includes FastMCP + CustomGPT SDK)
pip install -r requirements.txt

# Configure with your API key
cp .env.example .env
# Edit .env and add: CUSTOMGPT_API_KEY=your_actual_key

# Test the server
python server.py
```

#### Option 2: Using Docker
```bash
git clone https://github.com/customgpt-ai/customgpt-mcp.git
cd customgpt-mcp
docker-compose up -d
```

#### Option 3: Deploy to Railway (Recommended for Production)
[![Deploy on Railway](https://railway.app/button.svg)](https://railway.app/template/your-template-id)

1. Click the Railway button above
2. Set your environment variables
3. Deploy with one click

### Local Development
```bash
# Clone the repository
git clone https://github.com/customgpt-ai/customgpt-mcp.git
cd customgpt-mcp

# Create virtual environment
python -m venv venv
source venv/bin/activate  # On Windows: venv\\Scripts\\activate

# Install dependencies
pip install -r requirements.txt

# Copy environment file and configure
cp .env.example .env
# Edit .env with your settings

# Run the server
python server.py
```

## 🔧 Configuration

### Environment Variables

Create a `.env` file in the project root:

```env
# API Settings
CUSTOMGPT_API_BASE=https://app.customgpt.ai
API_VERSION=v1

# Server Settings
HOST=0.0.0.0
PORT=8000
DEBUG=false

# CORS Settings
CORS_ORIGINS=https://claude.ai,https://chatgpt.com

# Security
API_KEY_MASK_CHARS=4
```

### MCP Client Configuration

#### Claude Code
Add to your MCP settings:
```json
{
  "mcpServers": {
    "customgpt": {
      "command": "python",
      "args": ["/path/to/customgpt-mcp/server.py"],
      "env": {
        "PYTHONPATH": "/path/to/customgpt-mcp"
      }
    }
  }
}
```

#### Claude Web
1. Go to Claude Web Settings
2. Add MCP Server: `https://your-deployed-server.railway.app`
3. Configure with your CustomGPT API key

## 🛠️ Available Tools

### Agent Management

#### `list_agents`
List all your CustomGPT agents with pagination support.
```json
{
  "api_key": "your_customgpt_api_key",
  "page": 1,
  "name": "filter_by_name",
  "order": "desc"
}
```

#### `get_agent`
Get detailed information about a specific agent.
```json
{
  "api_key": "your_customgpt_api_key",
  "project_id": 123
}
```

#### `create_agent`
Create a new agent from a sitemap or files.
```json
{
  "api_key": "your_customgpt_api_key",
  "project_name": "My New Agent",
  "sitemap_path": "https://example.com/sitemap.xml",
  "file_data_retention": true,
  "is_ocr_enabled": false,
  "is_anonymized": false
}
```

### Conversation Tools

#### `send_message`
Send a message to any of your agents.
```json
{
  "api_key": "your_customgpt_api_key",
  "project_id": 123,
  "message": "Hello, how can you help me?",
  "lang": "en",
  "stream": false,
  "is_inline_citation": false
}
```

#### `list_conversations`
List all conversations for a specific agent.
```json
{
  "api_key": "your_customgpt_api_key",
  "project_id": 123,
  "page": 1,
  "order": "desc"
}
```

### Content Management

#### `list_pages`
List all pages/sources for an agent.
```json
{
  "api_key": "your_customgpt_api_key",
  "project_id": 123,
  "page": 1,
  "limit": 20,
  "crawl_status": "all",
  "index_status": "all"
}
```

#### `get_agent_stats`
Get statistics for an agent.
```json
{
  "api_key": "your_customgpt_api_key",
  "project_id": 123
}
```

#### `get_agent_settings`
Get configuration settings for an agent.
```json
{
  "api_key": "your_customgpt_api_key",
  "project_id": 123
}
```

### Documentation Tools

#### `search_api_documentation`
Search the CustomGPT API documentation.
```json
{
  "query": "create agent",
  "category": "Agents"
}
```

#### `get_api_endpoint_details`
Get detailed information about a specific API endpoint.
```json
{
  "endpoint_path": "/api/v1/projects",
  "method": "POST"
}
```

### Utility Tools

#### `validate_api_key`
Validate your CustomGPT API key.
```json
{
  "api_key": "your_customgpt_api_key"
}
```

## 📊 Usage Examples

### Basic Agent Interaction
```python
# 1. Validate your API key
validate_api_key({"api_key": "your_key"})

# 2. List your agents
agents = list_agents({"api_key": "your_key", "page": 1})

# 3. Send a message to an agent
response = send_message({
    "api_key": "your_key",
    "project_id": 123,
    "message": "What can you help me with?"
})
```

### Creating and Managing Agents
```python
# Create a new agent from a sitemap
new_agent = create_agent({
    "api_key": "your_key",
    "project_name": "Customer Support Bot",
    "sitemap_path": "https://mycompany.com/sitemap.xml"
})

# Get agent statistics
stats = get_agent_stats({
    "api_key": "your_key",
    "project_id": new_agent["agent"]["id"]
})

# List the agent's content pages
pages = list_pages({
    "api_key": "your_key",
    "project_id": new_agent["agent"]["id"]
})
```

## 🚀 Deployment Options

### Railway (Recommended)
Railway provides the best hosting experience for MCP servers with automatic HTTPS, custom domains, and easy scaling.

1. Fork this repository
2. Connect to Railway
3. Set environment variables
4. Deploy with automatic builds

**Environment Variables for Railway:**
```env
CUSTOMGPT_API_BASE=https://app.customgpt.ai
PORT=8000
PYTHONPATH=.
```

### Vercel
Serverless deployment option for lighter workloads.

1. Install Vercel CLI: `npm i -g vercel`
2. Deploy: `vercel`
3. Set environment variables in Vercel dashboard

### Docker
For containerized deployment on any platform.

```bash
# Build and run
docker-compose up -d

# Or build manually
docker build -t customgpt-mcp .
docker run -p 8000:8000 -e CUSTOMGPT_API_BASE=https://app.customgpt.ai customgpt-mcp
```

### Self-Hosted
For complete control over your deployment.

```bash
# Install dependencies
pip install -r requirements.txt

# Run with Gunicorn (production)
gunicorn -w 4 -k uvicorn.workers.UvicornWorker server:app

# Or run directly (development)
python server.py
```

## 🔍 API Reference

The server provides comprehensive API documentation integration. Use the following tools to explore:

- `search_api_documentation` - Search for specific functionality
- `get_api_endpoint_details` - Get detailed endpoint information
- Access the built-in resource: `customgpt://api-documentation`

## Security Considerations

### API Key Management
- API keys are masked in all logs (only last 4 characters shown)
- Keys are never stored persistently on the server
- Each request validates the API key independently
- Failed authentication attempts are logged for monitoring

### Network Security
- CORS configuration for production environments
- HTTPS enforcement in production
- Request rate limiting (when deployed with proper infrastructure)
- Input validation for all parameters

### Best Practices
1. Use environment variables for configuration
2. Deploy with HTTPS enabled
3. Configure CORS appropriately for your use case
4. Monitor logs for unusual activity
5. Regularly rotate API keys

## Troubleshooting

### Common Issues

#### "Invalid API key format"
- Ensure your API key is correctly formatted
- Check that there are no extra spaces or characters
- Verify the key is from CustomGPT.ai dashboard

#### "Authentication failed"
- API key may be invalid or expired
- Check API key permissions in CustomGPT.ai dashboard
- Try regenerating your API key

#### "Connection timeout"
- Check internet connectivity
- Verify CustomGPT.ai service status
- Ensure firewall isn't blocking requests

#### "API documentation not available"
- Ensure `docs/openapi.json` exists in the project
- Check file permissions
- Verify the JSON file is valid

### Debug Mode
Enable debug logging by setting `DEBUG=true` in your environment:

```bash
DEBUG=true python server.py
```

### Health Checks
The server provides health check endpoints:
- `/health` - Basic server health
- `/api/v1/health` - API health with version info

## Contributing

We welcome contributions! Please see our [Contributing Guide](CONTRIBUTING.md) for details.

### Development Setup
```bash
# Clone and setup
git clone https://github.com/customgpt-ai/customgpt-mcp.git
cd customgpt-mcp

# Install development dependencies
pip install -r requirements.txt
pip install -e ".[dev]"

# Run tests
pytest

# Format code
black .
ruff --fix .

# Type checking
mypy .
```

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Support

- **Documentation**: [https://docs.customgpt.ai/mcp](https://docs.customgpt.ai/)
- **Email**: [hello@customgpt.ai](mailto:hello@customgpt.ai)
- **Slack**: [Join our community](https://customgpt.ai/slack)

## Roadmap

- [ ] **Streaming Support**: Real-time message streaming
- [ ] **File Upload**: Direct file upload to agents
- [ ] **Webhook Integration**: Real-time notifications and events
- [ ] **Multi-tenancy**: Support for multiple organizations
- [ ] **Rate Limiting**: Built-in rate limiting and quota management
- [ ] **Caching**: Intelligent response caching for better performance


*this is still in beta.