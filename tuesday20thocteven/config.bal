import ballerina/os;

configurable string customopenaiAgentManagerUrl = os:getEnv("CUSTOMOPENAI_URL");
configurable string customopenaiAgentManagerKey = os:getEnv("CUSTOMOPENAI_API_KEY");
configurable string contractStoreMcpUrl = os:getEnv("CONTRACT_STORE_MCP_URL");
configurable string agentIdTokenUrl = os:getEnv("AMP_AGENTID_TOKEN_ENDPOINT");
configurable string agentIdScopes = os:getEnv("AMP_AGENTID_SCOPES");
configurable string agentIdClientId = os:getEnv("AMP_AGENTID_CLIENT_ID");
configurable string agentIdClientSecret = os:getEnv("AMP_AGENTID_CLIENT_SECRET");
configurable string resendMcpServerMcpUrl = os:getEnv("RESEND_MCP_SERVER_MCP_URL");
