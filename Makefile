# CustomGPT MCP Server Makefile

.PHONY: help install test lint format check dev clean deploy-railway deploy-vercel docker

# Default target
help:
	@echo "🤖 CustomGPT MCP Server - Available Commands"
	@echo "================================================"
	@echo "📦 Setup & Installation:"
	@echo "  make install     - Install dependencies and setup environment"
	@echo "  make setup       - Run interactive setup script"
	@echo ""
	@echo "🏃 Development:"
	@echo "  make dev         - Run development server with hot reload"
	@echo "  make test        - Run test suite"
	@echo "  make lint        - Run linting checks"
	@echo "  make format      - Format code with black and ruff"
	@echo "  make check       - Run all quality checks"
	@echo ""
	@echo "🚀 Deployment:"
	@echo "  make deploy-railway  - Deploy to Railway"
	@echo "  make deploy-vercel   - Deploy to Vercel"
	@echo "  make docker         - Build and run with Docker"
	@echo ""
	@echo "🧹 Maintenance:"
	@echo "  make clean       - Clean build artifacts and cache"
	@echo "  make update      - Update dependencies"

# Setup and Installation
install:
	@echo "📦 Installing CustomGPT MCP Server..."
	python -m venv venv
	@echo "Activating virtual environment..."
	( \
		. venv/bin/activate && \
		pip install --upgrade pip && \
		pip install -r requirements.txt \
	)
	@echo "✅ Installation complete! Run 'make setup' to configure."

setup:
	@echo "🔧 Running interactive setup..."
	python setup.py

# Development
dev:
	@echo "🏃 Starting development server..."
	@echo "Press Ctrl+C to stop"
	python server.py

test:
	@echo "🧪 Running test suite..."
	python -m pytest tests/ -v --cov=src --cov-report=term-missing

lint:
	@echo "🔍 Running linting checks..."
	python -m ruff check .
	python -m mypy src/

format:
	@echo "🎨 Formatting code..."
	python -m black .
	python -m ruff check --fix .

check: lint test
	@echo "✅ All quality checks passed!"

# Deployment
deploy-railway:
	@echo "🚂 Deploying to Railway..."
	@command -v railway >/dev/null 2>&1 || { echo "❌ Railway CLI not installed. Run: npm i -g @railway/cli"; exit 1; }
	railway up

deploy-vercel:
	@echo "▲ Deploying to Vercel..."
	@command -v vercel >/dev/null 2>&1 || { echo "❌ Vercel CLI not installed. Run: npm i -g vercel"; exit 1; }
	vercel --prod

docker:
	@echo "🐳 Building and running with Docker..."
	docker-compose up -d --build
	@echo "✅ Server running at http://localhost:8000"
	@echo "View logs: docker-compose logs -f"

# Maintenance
clean:
	@echo "🧹 Cleaning build artifacts..."
	find . -type d -name "__pycache__" -exec rm -rf {} + 2>/dev/null || true
	find . -type f -name "*.pyc" -delete 2>/dev/null || true
	find . -type d -name "*.egg-info" -exec rm -rf {} + 2>/dev/null || true
	rm -rf .coverage htmlcov/ .pytest_cache/ dist/ build/
	rm -f analytics.db cache.db
	@echo "✅ Cleanup complete"

update:
	@echo "🔄 Updating dependencies..."
	pip install --upgrade pip
	pip install -r requirements.txt --upgrade
	@echo "✅ Dependencies updated"

# Health checks
health:
	@echo "🏥 Running health checks..."
	curl -f http://localhost:8000/health || echo "❌ Server not responding"

status:
	@echo "📊 Server status..."
	curl -s http://localhost:8000/status | python -m json.tool || echo "❌ Status endpoint not available"

# Database management
backup-db:
	@echo "💾 Backing up databases..."
	@if [ -f analytics.db ]; then cp analytics.db analytics_backup_$$(date +%Y%m%d_%H%M%S).db; echo "✅ Analytics DB backed up"; fi
	@if [ -f cache.db ]; then cp cache.db cache_backup_$$(date +%Y%m%d_%H%M%S).db; echo "✅ Cache DB backed up"; fi

restore-db:
	@echo "🔄 Database restore options:"
	@ls -la *_backup_*.db 2>/dev/null || echo "No backup files found"

# Security checks
security-check:
	@echo "🛡️ Running security checks..."
	@echo "Checking for exposed secrets..."
	@grep -r "sk-" . --exclude-dir=venv --exclude="*.pyc" || echo "✅ No exposed API keys found"
	@echo "Checking file permissions..."
	@find . -name "*.py" -perm /o+w | head -5 | while read file; do echo "⚠️ World-writable: $$file"; done
	@echo "✅ Security check complete"

# Logs and monitoring
logs:
	@echo "📝 Recent server logs..."
	@if [ -f server.log ]; then tail -n 50 server.log; else echo "No log file found"; fi

monitor:
	@echo "📊 Starting monitoring dashboard..."
	@echo "Analytics: http://localhost:8000/analytics"
	@echo "Cache Stats: http://localhost:8000/cache/stats"
	@echo "Webhooks: http://localhost:8000/webhooks/status"

# Development utilities
dev-install:
	@echo "👨‍💻 Installing development dependencies..."
	pip install pytest pytest-asyncio pytest-cov black mypy ruff

validate-config:
	@echo "✅ Validating configuration..."
	@python -c "from src.config import settings; print('Configuration valid'); print(f'API Base: {settings.customgpt_api_base}')"

# Production deployment helpers
pre-deploy: clean check
	@echo "🚀 Pre-deployment checks complete"

deploy-status:
	@echo "📊 Deployment status..."
	@echo "Available deployment commands:"
	@echo "  make deploy-railway  - Deploy to Railway"
	@echo "  make deploy-vercel   - Deploy to Vercel"
	@echo "  make docker         - Run with Docker"

# Quick commands
quick-start: install setup dev

production-setup: install setup check deploy-railway

# Help with common tasks
docs:
	@echo "📚 Documentation:"
	@echo "• README.md - Main documentation"
	@echo "• DEPLOYMENT.md - Deployment guide"
	@echo "• CONTRIBUTING.md - Development guide"
	@echo "• CHANGELOG.md - Version history"

examples:
	@echo "💡 Usage Examples:"
	@echo ""
	@echo "🏃 Quick Development Start:"
	@echo "  make quick-start"
	@echo ""
	@echo "🚀 Production Deployment:"
	@echo "  make production-setup"
	@echo ""
	@echo "🔧 Development Workflow:"
	@echo "  make dev-install"
	@echo "  make format"
	@echo "  make test"
	@echo "  make deploy-railway"