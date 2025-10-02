#!/bin/bash
# Start script for CustomGPT MCP Server
# This handles environment setup for Claude Code

cd "$(dirname "$0")"

# Set environment variables
export PYTHONPATH="/Users/zriyansh/Desktop/Projects/customgpt/customgpt-mcp"
export CUSTOMGPT_API_BASE="https://app.customgpt.ai"
export CUSTOMGPT_API_KEY="8238|K6I51ucYqz2pJp4v5p0Pg0VmbibDhc0ISi7ebeco62f9c0c6"

# Activate virtual environment and run server
source venv/bin/activate
exec python server.py