import 'ai_request_mapper.dart';
import 'claude_request_mapper.dart';
import 'gemini_request_mapper.dart';
import 'openai_request_mapper.dart';

class AiRequestMapperFactory {
  AiRequestMapperFactory({
    Map<String, AiRequestMapper>? mappers,
  }) : _mappers = {
          'openai': const OpenAiRequestMapper(),
          'openrouter': const OpenAiRequestMapper(),
          'gemini': const GeminiRequestMapper(),
          'claude': const ClaudeRequestMapper(),
          ...?mappers,
        };

  final Map<String, AiRequestMapper> _mappers;

  /// Registers or replaces a mapper for a compatibility type.
  void register(String compatibilityType, AiRequestMapper mapper) {
    _mappers[compatibilityType] = mapper;
  }

  /// Returns the mapper registered for the given compatibility type.
  AiRequestMapper create(String compatibilityType) {
    final mapper = _mappers[compatibilityType];

    if (mapper == null) {
      throw ArgumentError(
        'No AI request mapper registered for '
        'compatibility type: $compatibilityType',
      );
    }

    return mapper;
  }

  /// Returns all registered compatibility types.
  List<String> get compatibilityTypes {
    return List.unmodifiable(_mappers.keys);
  }
}