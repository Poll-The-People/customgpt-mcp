# Changelog

All notable changes to the CustomGPT MCP Server will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

## [1.0.0] - 2024-01-XX

### Added
- **Initial Release** 🎉
- **Agent Management Tools**
  - `list_agents` - List all CustomGPT agents with pagination and filtering
  - `get_agent` - Get detailed agent information by ID
  - `create_agent` - Create new agents from sitemaps or files
  - `get_agent_stats` - Retrieve agent statistics and metrics
  - `get_agent_settings` - Get agent configuration settings

- **Conversation Management**
  - `send_message` - Send messages to agents using OpenAI-compatible format
  - `list_conversations` - List all conversations for a specific agent

- **Content Management**
  - `list_pages` - List all pages/sources for agents with status filtering
  - Page status monitoring (crawl status, index status)

- **API Documentation Integration**
  - `search_api_documentation` - Search CustomGPT API documentation
  - `get_api_endpoint_details` - Get detailed endpoint information
  - Built-in API reference with comprehensive OpenAPI spec

- **Security Features**
  - API key validation and format checking
  - Automatic API key masking in logs (shows only last 4 characters)
  - Secure, stateless design with no permanent key storage
  - Request validation and error handling

- **MCP Server Features**
  - Full MCP 1.4.1+ compatibility
  - Resource serving (documentation, getting started guide)
  - Comprehensive error handling with custom exceptions
  - Logging and debugging support

- **Deployment Support**
  - Docker containerization with multi-stage builds
  - Railway deployment configuration
  - Vercel serverless deployment support
  - Docker Compose for development
  - Health check endpoints

- **Development Tools**
  - Comprehensive test suite with pytest
  - Code formatting with Black and Ruff
  - Type checking with MyPy
  - Development environment setup
  - Contributing guidelines

### Security
- Implemented secure API key handling with automatic masking
- Added input validation for all endpoints
- CORS configuration for production environments
- No persistent storage of sensitive data

### Documentation
- Comprehensive README with usage examples
- API reference documentation
- Deployment guides for multiple platforms
- Contributing guidelines and development setup
- Troubleshooting guide

## [0.9.0] - 2024-01-XX

### Added
- Beta release for testing
- Core MCP server functionality
- Basic CustomGPT API integration
- Docker support

### Changed
- Improved error handling
- Enhanced API key validation

### Fixed
- Connection timeout issues
- Authentication error handling

## [0.8.0] - 2024-01-XX

### Added
- Alpha release
- Initial MCP integration
- Basic agent listing functionality

---

## Release Notes

### Version 1.0.0 Release Notes

This is the initial stable release of the CustomGPT MCP Server, providing comprehensive integration between MCP-compatible clients and CustomGPT.ai APIs.

**Key Features:**
- 🤖 Complete agent management (list, create, configure)
- 💬 Full conversation support with OpenAI-compatible messaging
- 📄 Content and page management
- 📚 Integrated API documentation search
- 🔐 Secure API key handling
- 🚀 Multiple deployment options (Railway, Vercel, Docker)
- 🧪 Comprehensive testing and development tools

**Supported Clients:**
- Claude Code
- Claude Web
- ChatGPT (with MCP support)
- Any MCP 1.4.1+ compatible client

**Deployment Platforms:**
- Railway (recommended for production)
- Vercel (serverless)
- Docker/Docker Compose
- Self-hosted

**Getting Started:**
1. Get your CustomGPT.ai API key
2. Deploy using Railway button or run locally
3. Connect your MCP client
4. Start managing your CustomGPT agents!

For detailed setup instructions, see the [README.md](README.md).

---

## Migration Guide

### From Pre-1.0 Versions
If you're upgrading from a pre-1.0 version:

1. **Update Dependencies**: Run `pip install -r requirements.txt`
2. **Environment Variables**: Check `.env.example` for new required variables
3. **API Changes**: Review tool schemas - some parameter names may have changed
4. **Configuration**: Update MCP client configuration with new tool names

### Breaking Changes
- Tool parameter names standardized (e.g., `agent_id` → `project_id`)
- Response format improvements for better consistency
- Updated error handling with custom exception types

---

## Planned Features

### Version 1.1.0 (Q2 2024)
- [ ] **Streaming Support**: Real-time message streaming
- [ ] **File Upload**: Direct file upload to agents
- [ ] **Webhook Integration**: Real-time notifications
- [ ] **Enhanced Analytics**: Detailed usage reporting

### Version 1.2.0 (Q3 2024)
- [ ] **Multi-tenancy**: Multiple organization support
- [ ] **Rate Limiting**: Built-in quotas and limits
- [ ] **Caching**: Intelligent response caching
- [ ] **Batch Operations**: Bulk agent operations

### Version 2.0.0 (Q4 2024)
- [ ] **GraphQL API**: Alternative query interface
- [ ] **Plugin System**: Custom tool extensions
- [ ] **Advanced Security**: OAuth integration
- [ ] **Performance Monitoring**: Built-in metrics

---

## Support

For questions about releases or migration:
- **GitHub Issues**: [Report bugs or request features](https://github.com/customgpt-ai/customgpt-mcp-server/issues)
- **Documentation**: [https://docs.customgpt.ai/mcp](https://docs.customgpt.ai/mcp)
- **Email**: [hello@customgpt.ai](mailto:hello@customgpt.ai)
- **Discord**: [Join our community](https://discord.gg/customgpt)