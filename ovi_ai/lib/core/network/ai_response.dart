/// Provider-agnostic response returned by an AI provider.
class AiResponse {
  const AiResponse({
    required this.content,
    this.model,
  });

  final String content;
  final String? model;
}