#!/bin/bash
# Start script for CustomGPT MCP Server
# This handles environment setup for Claude Code

cd "$(dirname "$0")"

# Set environment variables
export PYTHONPATH="/Users/zriyansh/Desktop/Projects/customgpt/customgpt-mcp"
export CUSTOMGPT_API_BASE="https://app.customgpt.ai"
export CUSTOMGPT_API_KEY="YOUR_CUSTOMGPT_API_KEY"

# Activate virtual environment and run server
source venv/bin/activate
exec python server.py