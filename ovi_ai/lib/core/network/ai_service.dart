import 'ai_api_service.dart';
import 'ai_provider_config.dart';
import 'ai_provider_factory.dart';
import 'ai_request.dart';
import 'ai_request_mapper_factory.dart';

/// High-level, provider-agnostic service that prepares AI requests.
///
/// This layer coordinates provider configuration, request mapping,
/// and the shared API service without performing a real network call yet.
class AiService {
  AiService({
    required AiProviderConfig config,
    required AiApiService apiService,
    AiRequestMapperFactory? mapperFactory,
  })  : _providerFactory = AiProviderFactory(config),
        _apiService = apiService,
        _mapperFactory = mapperFactory ?? const AiRequestMapperFactory();

  final AiProviderFactory _providerFactory;
  final AiApiService _apiService;
  final AiRequestMapperFactory _mapperFactory;

  /// Returns the currently selected AI provider.
  AiProviderConfig get config => _providerFactory.config;

  /// Builds a provider-specific request payload.
  ///
  /// No network request is performed by this method.
  Map<String, dynamic> buildPayload(AiRequest request) {
    final mapper = _mapperFactory.create(_providerFactory.provider);
    return mapper.map(request) as Map<String, dynamic>;
  }

  /// Exposes the underlying API service for the future execution layer.
  AiApiService get apiService => _apiService;
}