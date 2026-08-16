/// Describes an AI provider independently of a fixed enum.
class AiProviderDefinition {
  const AiProviderDefinition({
    required this.id,
    required this.displayName,
    required this.baseUrl,
    required this.apiKey,
    required this.defaultModel,
    required this.compatibilityType,
  });

  final String id;
  final String displayName;
  final String baseUrl;
  final String apiKey;
  final String defaultModel;
  final String compatibilityType;
}