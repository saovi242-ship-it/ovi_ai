import 'ai_message.dart';

/// Provider-agnostic representation of an AI request.
///
/// This model keeps the core AI request independent from OpenAI,
/// Gemini, Claude, or any other provider-specific API format.
class AiRequest {
  const AiRequest({
    required this.messages,
    this.model,
    this.temperature,
    this.maxTokens,
  });

  /// Conversation messages included in the request.
  final List<AiMessage> messages;

  /// Optional provider-specific model name.
  final String? model;

  /// Optional generation temperature.
  final double? temperature;

  /// Optional maximum output token limit.
  final int? maxTokens;
}