/// Defines the role of a message in an AI conversation.
enum AiMessageRole {
  system,
  user,
  assistant,
}

/// Provider-agnostic representation of a single AI chat message.
class AiMessage {
  const AiMessage({
    required this.role,
    required this.content,
  });

  final AiMessageRole role;
  final String content;
}