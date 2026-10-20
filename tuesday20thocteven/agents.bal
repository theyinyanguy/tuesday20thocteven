import ballerina/ai;
import ballerina/mcp;

final ai:Agent contractReviewAgent = check new (
    systemPrompt = {
        role: string `Contract Review Assistant`,
        instructions: string `You are a contract review assistant. You help users review contracts and share feedback on them.
You have access to a contract store to fetch contract documents and a send email tool to share your feedback or findings with others.
When a user provides a contract number, immediately fetch the corresponding contract from the contract store. Do not ask the user to confirm before fetching it.
When you review a contract, provide clear, specific feedback covering key risks, missing or unusual clauses, ambiguous terms, obligations, and any other concerns relevant to the contract.
When sending an email, always use delivered@resend.dev as the sender's address, and write a clear subject and a well-structured body that summarizes your feedback.
If a requested contract cannot be found, tell the user clearly instead of guessing its contents.`
    }, model = openaiModelprovider, tools = [contractStoreMcp, resendMcpServerMcp]
);

isolated class ContractStoreMcpToolkit {
    *ai:McpBaseToolKit;
    private final mcp:StreamableHttpClient mcpClient;
    private final readonly & ai:ToolConfig[] tools;

    public isolated function init(string serverUrl, mcp:Implementation info = {name: "MCP", version: "1.0.0"},
            *mcp:StreamableHttpClientTransportConfig config) returns ai:Error? {
        do {
            self.mcpClient = check new mcp:StreamableHttpClient(serverUrl, config);
            self.tools = check ai:getPermittedMcpToolConfigs(self.mcpClient, info, self.callTool).cloneReadOnly();
        } on fail error e {
            return error ai:Error("Failed to initialize MCP toolkit", e);
        }
    }

    public isolated function getTools() returns ai:ToolConfig[] => self.tools;

    @ai:AgentTool
    public isolated function callTool(mcp:CallToolParams params) returns mcp:CallToolResult|error {
        return self.mcpClient->callTool(params);
    }
}

isolated class ResendMcpServerMcpToolkit {
    *ai:McpBaseToolKit;
    private final mcp:StreamableHttpClient mcpClient;
    private final readonly & ai:ToolConfig[] tools;

    public isolated function init(string serverUrl, mcp:Implementation info = {name: "MCP", version: "1.0.0"},
            *mcp:StreamableHttpClientTransportConfig config) returns ai:Error? {
        do {
            self.mcpClient = check new mcp:StreamableHttpClient(serverUrl, config);
            self.tools = check ai:getPermittedMcpToolConfigs(self.mcpClient, info, self.callTool).cloneReadOnly();
        } on fail error e {
            return error ai:Error("Failed to initialize MCP toolkit", e);
        }
    }

    public isolated function getTools() returns ai:ToolConfig[] => self.tools;

    @ai:AgentTool
    public isolated function callTool(mcp:CallToolParams params) returns mcp:CallToolResult|error {
        return self.mcpClient->callTool(params);
    }
}
