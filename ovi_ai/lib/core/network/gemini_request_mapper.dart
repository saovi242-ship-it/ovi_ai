import 'ai_request.dart';
import 'ai_request_mapper.dart';

class GeminiRequestMapper implements AiRequestMapper {
  const GeminiRequestMapper();

  @override
  Map<String, dynamic> map(AiRequest request) {
    final payload = <String, dynamic>{
      'contents': request.messages
          .where((message) => message.role.name != 'system')
          .map((message) {
        return {
          'role': message.role.name == 'assistant' ? 'model' : 'user',
          'parts': [
            {
              'text': message.content,
            },
          ],
        };
      }).toList(),
    };

    final systemMessages = request.messages
        .where((message) => message.role.name == 'system')
        .map((message) => message.content)
        .toList();

    if (systemMessages.isNotEmpty) {
      payload['systemInstruction'] = {
        'parts': [
          {
            'text': systemMessages.join('\n'),
          },
        ],
      };
    }

    if (request.temperature != null) {
      payload['generationConfig'] = {
        'temperature': request.temperature,
      };
    }

    if (request.maxTokens != null) {
      final generationConfig =
          payload['generationConfig'] as Map<String, dynamic>? ??
              <String, dynamic>{};

      generationConfig['maxOutputTokens'] = request.maxTokens;
      payload['generationConfig'] = generationConfig;
    }

    return payload;
  }
}