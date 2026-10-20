import ballerinax/ai.openai;

final openai:ModelProvider openaiModelprovider = check new (customopenaiAgentManagerKey, "gpt-5.6-terra", customopenaiAgentManagerUrl, reasoningEffort = "none");
final ContractStoreMcpToolkit contractStoreMcp = check new (contractStoreMcpUrl, auth = {tokenUrl: agentIdTokenUrl, clientId: agentIdClientId, clientSecret: agentIdClientSecret, scopes: agentIdScopes, optionalParams: {"resource": contractStoreMcpUrl}});
final ResendMcpServerMcpToolkit resendMcpServerMcp = check new (resendMcpServerMcpUrl, auth = {tokenUrl: agentIdTokenUrl, clientId: agentIdClientId, clientSecret: agentIdClientSecret, scopes: agentIdScopes, optionalParams: {"resource": resendMcpServerMcpUrl}});
