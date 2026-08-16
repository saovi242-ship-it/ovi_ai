import 'ai_api_service.dart';
import 'ai_provider_definition.dart';
import 'ai_request.dart';
import 'ai_request_mapper_factory.dart';

/// High-level, provider-agnostic service for preparing AI requests.
///
/// Provider selection is based on the dynamic provider definition rather
/// than the fixed AiProvider enum.
class AiService {
  AiService({
    required AiProviderDefinition provider,
    required AiApiService apiService,
    AiRequestMapperFactory? mapperFactory,
  })  : _provider = provider,
        _apiService = apiService,
        _mapperFactory = mapperFactory ?? AiRequestMapperFactory();

  final AiProviderDefinition _provider;
  final AiApiService _apiService;
  final AiRequestMapperFactory _mapperFactory;

  /// Returns the current provider definition.
  AiProviderDefinition get provider => _provider;

  /// Builds a provider-specific request payload.
  ///
  /// No network request is performed here.
  Map<String, dynamic> buildPayload(AiRequest request) {
    final mapper = _mapperFactory.create(_provider.compatibilityType);
    return mapper.map(request);
  }

  /// Exposes the shared API service for the future execution layer.
  AiApiService get apiService => _apiService;
}