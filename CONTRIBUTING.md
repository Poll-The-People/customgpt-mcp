# Contributing to CustomGPT MCP Server

We welcome contributions to the CustomGPT MCP Server! This document provides guidelines for contributing to the project.

## 🤝 How to Contribute

### Reporting Issues
- Use GitHub Issues to report bugs or suggest features
- Provide clear descriptions and steps to reproduce issues
- Include system information (OS, Python version, etc.)
- Check existing issues before creating new ones

### Submitting Changes
1. Fork the repository
2. Create a feature branch: `git checkout -b feature/your-feature-name`
3. Make your changes
4. Add tests for new functionality
5. Run the test suite: `pytest`
6. Commit your changes: `git commit -am 'Add some feature'`
7. Push to the branch: `git push origin feature/your-feature-name`
8. Create a Pull Request

## 🔧 Development Setup

### Prerequisites
- Python 3.8 or higher
- Git
- A CustomGPT.ai API key for testing

### Setting Up Development Environment
```bash
# Clone your fork
git clone https://github.com/yourusername/customgpt-mcp-server.git
cd customgpt-mcp-server

# Create virtual environment
python -m venv venv
source venv/bin/activate  # On Windows: venv\Scripts\activate

# Install development dependencies
pip install -r requirements.txt
pip install -e ".[dev]"

# Copy environment template
cp .env.example .env
# Edit .env with your test API key
```

### Running Tests
```bash
# Run all tests
pytest

# Run with coverage
pytest --cov=src

# Run specific test file
pytest tests/test_client.py

# Run specific test
pytest tests/test_client.py::test_list_agents
```

### Code Quality
We use several tools to maintain code quality:

```bash
# Format code with black
black .

# Lint with ruff
ruff check .
ruff check --fix .

# Type checking with mypy
mypy .

# Run all quality checks
make quality  # if Makefile exists
```

## 📝 Code Style Guidelines

### Python Code Style
- Follow PEP 8
- Use type hints for all functions
- Maximum line length: 100 characters
- Use meaningful variable and function names
- Add docstrings to all public functions and classes

### Example Function
```python
async def list_agents(
    client: CustomGPTClient,
    page: int = 1,
    name: Optional[str] = None
) -> ProjectsResponse:
    """
    List all agents for the authenticated user.

    Args:
        client: The CustomGPT API client
        page: Page number for pagination (default: 1)
        name: Optional filter by agent name

    Returns:
        ProjectsResponse containing agent data and pagination info

    Raises:
        CustomGPTAuthError: If authentication fails
        CustomGPTAPIError: If API request fails
    """
    return await client.list_agents(page=page, name=name)
```

### Commit Messages
Use clear, descriptive commit messages:

```
feat: add support for streaming responses
fix: handle timeout errors in agent creation
docs: update API documentation for new endpoints
test: add tests for conversation management
refactor: simplify error handling logic
```

## 🧪 Testing Guidelines

### Test Structure
Tests are organized in the `tests/` directory:
```
tests/
├── test_client.py          # API client tests
├── test_server.py          # MCP server tests
├── test_tools.py           # Individual tool tests
├── fixtures/               # Test fixtures
└── conftest.py            # Shared test configuration
```

### Writing Tests
- Write tests for all new functionality
- Use descriptive test names
- Include both positive and negative test cases
- Mock external API calls
- Test error conditions

### Example Test
```python
import pytest
from unittest.mock import patch, MagicMock
from src.customgpt.client import CustomGPTClient, CustomGPTAuthError

class TestCustomGPTClient:
    @pytest.fixture
    def client(self):
        return CustomGPTClient("test_api_key")

    @patch('requests.Session.request')
    def test_list_agents_success(self, mock_request, client):
        # Mock successful response
        mock_response = MagicMock()
        mock_response.status_code = 200
        mock_response.json.return_value = {
            "status": "success",
            "data": {"total": 0, "data": []}
        }
        mock_request.return_value = mock_response

        # Test the method
        result = client.list_agents()

        # Assertions
        assert result.status == "success"
        mock_request.assert_called_once()

    @patch('requests.Session.request')
    def test_list_agents_auth_error(self, mock_request, client):
        # Mock auth error response
        mock_response = MagicMock()
        mock_response.status_code = 401
        mock_request.return_value = mock_response

        # Test that auth error is raised
        with pytest.raises(CustomGPTAuthError):
            client.list_agents()
```

## 📚 Documentation

### Code Documentation
- Add docstrings to all public functions and classes
- Use Google-style docstrings
- Include parameter types and return types
- Document exceptions that may be raised

### API Documentation
- Update README.md when adding new tools
- Include usage examples for new features
- Update the tool schema definitions
- Add troubleshooting information for common issues

## 🏗️ Architecture Guidelines

### Project Structure
```
customgpt-mcp-server/
├── src/
│   ├── __init__.py
│   ├── customgpt/
│   │   ├── __init__.py
│   │   ├── client.py       # API client
│   │   └── models.py       # Data models
│   └── config.py           # Configuration
├── server.py               # Main MCP server
├── tests/                  # Test suite
├── docs/                   # Documentation files
└── deployment/             # Deployment configs
```

### Design Principles
1. **Separation of Concerns**: Keep API client, MCP server, and business logic separate
2. **Error Handling**: Use custom exceptions and proper error propagation
3. **Type Safety**: Use type hints throughout the codebase
4. **Async/Await**: Use async patterns for all I/O operations
5. **Configuration**: Use environment variables for all configuration

### Adding New Tools
When adding a new MCP tool:

1. **Define the tool schema** in `handle_list_tools()`
2. **Implement the handler** in `handle_call_tool()`
3. **Add client method** if needed in `CustomGPTClient`
4. **Add data models** in `models.py` if needed
5. **Write tests** for the new functionality
6. **Update documentation**

### Example New Tool
```python
# 1. Add to handle_list_tools()
types.Tool(
    name="new_tool",
    description="Description of what this tool does",
    inputSchema={
        "type": "object",
        "properties": {
            "api_key": {"type": "string", "description": "API key"},
            "param": {"type": "string", "description": "Parameter description"}
        },
        "required": ["api_key", "param"]
    }
)

# 2. Add to handle_call_tool()
elif name == "new_tool":
    client = get_client_from_arguments(arguments)
    param = arguments.get("param")

    result = client.new_method(param)

    return [types.TextContent(
        type="text",
        text=json.dumps(result, indent=2)
    )]

# 3. Add to CustomGPTClient
def new_method(self, param: str) -> Dict[str, Any]:
    """New method description."""
    return self._make_request("GET", f"/new-endpoint/{param}")
```

## 🚀 Release Process

### Version Management
- Use semantic versioning (MAJOR.MINOR.PATCH)
- Update version in `pyproject.toml`
- Create git tags for releases

### Release Checklist
- [ ] All tests pass
- [ ] Documentation updated
- [ ] CHANGELOG.md updated
- [ ] Version bumped
- [ ] Create GitHub release
- [ ] Update deployment configurations

## ❓ Getting Help

If you need help with contributing:

1. **Check existing issues** and discussions
2. **Read the documentation** thoroughly
3. **Ask questions** in GitHub Issues with the "question" label
4. **Join our Discord** for real-time help
5. **Email us** at hello@customgpt.ai

## 📋 Code Review Process

### What We Look For
- Code quality and style adherence
- Proper error handling
- Test coverage
- Documentation updates
- Security considerations
- Performance implications

### Review Timeline
- Initial review within 2-3 business days
- Follow-up reviews within 1 business day
- Merge after approval from maintainers

## 🙏 Recognition

Contributors will be:
- Listed in the README.md contributors section
- Acknowledged in release notes
- Given credit in relevant documentation

Thank you for contributing to CustomGPT MCP Server!