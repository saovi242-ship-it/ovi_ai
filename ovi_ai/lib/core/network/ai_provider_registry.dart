import 'ai_provider_definition.dart';

/// Runtime registry for AI provider definitions.
///
/// Providers can be registered, removed, looked up, and listed without
/// changing a fixed enum or switch statement.
class AiProviderRegistry {
  AiProviderRegistry({
    Iterable<AiProviderDefinition> providers = const [],
  }) {
    for (final provider in providers) {
      register(provider);
    }
  }

  final Map<String, AiProviderDefinition> _providers = {};

  /// Registers or replaces a provider definition.
  void register(AiProviderDefinition provider) {
    _providers[provider.id] = provider;
  }

  /// Removes a provider by its unique ID.
  bool remove(String providerId) {
    return _providers.remove(providerId) != null;
  }

  /// Returns a provider by ID, or null if it is not registered.
  AiProviderDefinition? find(String providerId) {
    return _providers[providerId];
  }

  /// Returns all currently registered providers.
  List<AiProviderDefinition> get providers {
    return List.unmodifiable(_providers.values);
  }

  /// Returns whether a provider with the given ID is registered.
  bool contains(String providerId) {
    return _providers.containsKey(providerId);
  }

  /// Removes all registered providers.
  void clear() {
    _providers.clear();
  }
}