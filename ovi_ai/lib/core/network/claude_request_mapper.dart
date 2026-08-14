import 'ai_request.dart';
import 'ai_request_mapper.dart';

class ClaudeRequestMapper implements AiRequestMapper {
  const ClaudeRequestMapper();

  @override
  Map<String, dynamic> map(AiRequest request) {
    final messages = request.messages
        .where((message) => message.role.name != 'system')
        .map((message) {
      return {
        'role': message.role.name == 'assistant' ? 'assistant' : 'user',
        'content': message.content,
      };
    }).toList();

    final payload = <String, dynamic>{
      'messages': messages,
    };

    final systemMessages = request.messages
        .where((message) => message.role.name == 'system')
        .map((message) => message.content)
        .toList();

    if (systemMessages.isNotEmpty) {
      payload['system'] = systemMessages.join('\n');
    }

    if (request.model != null) {
      payload['model'] = request.model;
    }

    if (request.maxTokens != null) {
      payload['max_tokens'] = request.maxTokens;
    }

    if (request.temperature != null) {
      payload['temperature'] = request.temperature;
    }

    return payload;
  }
}