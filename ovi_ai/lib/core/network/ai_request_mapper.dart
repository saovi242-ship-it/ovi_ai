import 'ai_request.dart';

/// Contract for converting a provider-agnostic [AiRequest]
/// into a provider-specific request payload.
abstract interface class AiRequestMapper {
  dynamic map(AiRequest request);
}