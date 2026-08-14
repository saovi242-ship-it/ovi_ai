import 'ai_request.dart';
import 'ai_request_mapper.dart';

class OpenAiRequestMapper implements AiRequestMapper {
  const OpenAiRequestMapper();

  @override
  Map<String, dynamic> map(AiRequest request) {
    final payload = <String, dynamic>{
      'messages': request.messages.map((message) {
        return {
          'role': message.role.name,
          'content': message.content,
        };
      }).toList(),
    };

    if (request.model != null) {
      payload['model'] = request.model;
    }

    if (request.temperature != null) {
      payload['temperature'] = request.temperature;
    }

    if (request.maxTokens != null) {
      payload['max_tokens'] = request.maxTokens;
    }

    return payload;
  }
}