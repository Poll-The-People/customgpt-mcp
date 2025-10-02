# server.py
from mcp.server.fastmcp import FastMCP
from customgpt_client import CustomGPT
from dotenv import load_dotenv
import os
import uuid
import time
import json

load_dotenv()

# Initialize MCP server
mcp = FastMCP("CustomGPT-Integration", dependencies=["mcp", "customgpt-client"])
CustomGPT.api_key = os.getenv("CUSTOMGPT_API_KEY")
CustomGPT.base_url = os.getenv("CUSTOMGPT_BASE_URL")

@mcp.tool()
def stream_to_claude(project_id: int, prompt: str) -> str:
    """Stream conversation to Claude via CustomGPT with timeout prevention"""
    session_id = str(uuid.uuid4())
    
    try:
        response = CustomGPT.Conversation.send(
            project_id=project_id,
            prompt=prompt,
            session_id=session_id,
            stream=True
        )
        
        # Stream handling with keep-alive
        for chunk in response.events():
            data = chunk.data
            data_json = json.loads(data)
            
            if(data_json['status'] == 'progress'):
                message = data_json['message']
                yield message
                
    except Exception as e:
        raise e

@mcp.resource("context://{context_id}")
def get_context(context_id: str) -> str:
    """Retrieve stored context for Claude"""
    # Add your context retrieval logic here
    return f"Context for {context_id}"
