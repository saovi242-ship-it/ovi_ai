import 'ai_provider.dart';
import 'ai_request_mapper.dart';
import 'claude_request_mapper.dart';
import 'gemini_request_mapper.dart';
import 'openai_request_mapper.dart';

class AiRequestMapperFactory {
  const AiRequestMapperFactory();

  AiRequestMapper create(AiProvider provider) {
    switch (provider) {
      case AiProvider.openai:
        return const OpenAiRequestMapper();

      case AiProvider.gemini:
        return const GeminiRequestMapper();

      case AiProvider.claude:
        return const ClaudeRequestMapper();
    }
  }
}