import 'ai_provider.dart';

/// Simple immutable configuration for a given [AiProvider].
///
/// Holds only the provider identity and optional connection details
/// (base URL, API key). No values are set here; they must be supplied
/// by the caller when constructing an instance.
class AiProviderConfig {
  AiProviderConfig({
    required this.provider,
    this.baseUrl,
    this.apiKey,
  });

  final AiProvider provider;
  final String? baseUrl;
  final String? apiKey;
}