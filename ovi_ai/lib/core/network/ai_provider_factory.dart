import 'ai_provider.dart';
import 'ai_provider_config.dart';

class AiProviderFactory {
  const AiProviderFactory(this._config);

  final AiProviderConfig _config;

  AiProvider get provider => _config.provider;

  AiProviderConfig get config => _config;
}