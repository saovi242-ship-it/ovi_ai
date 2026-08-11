import 'package:dio/dio.dart';

/// A small, reusable wrapper around [Dio] used as the single network
/// entry point for the app.
///
/// This client is intentionally generic and provider-agnostic so it can
/// later support any backend or AI provider (e.g. our own backend,
/// Gemini, OpenAI, Claude) simply by providing a base URL and/or
/// interceptors at call time or via [configure]. It does not hardcode
/// any real API URL, API key, or provider-specific logic.
class ApiClient {
  ApiClient({Dio? dio}) : _dio = dio ?? Dio(_defaultOptions());

  final Dio _dio;

  /// Exposes the underlying [Dio] instance for cases that need direct
  /// access (e.g. adding interceptors, cancel tokens, or download/upload
  /// progress callbacks).
  Dio get dio => _dio;

  static BaseOptions _defaultOptions() {
    return BaseOptions(
      // No baseUrl set here on purpose — this client is not tied to any
      // single backend or provider. Set it via [configure] or per-request
      // when the target service is known.
      connectTimeout: const Duration(seconds: 15),
      receiveTimeout: const Duration(seconds: 15),
      sendTimeout: const Duration(seconds: 15),
      contentType: 'application/json',
      responseType: ResponseType.json,
      headers: const {
        'Accept': 'application/json',
      },
    );
  }

  /// Updates base configuration (e.g. base URL, default headers) without
  /// replacing the underlying [Dio] instance. Useful once a specific
  /// backend/provider is wired up in a later step.
  void configure({
    String? baseUrl,
    Map<String, dynamic>? headers,
  }) {
    if (baseUrl != null) {
      _dio.options.baseUrl = baseUrl;
    }
    if (headers != null) {
      _dio.options.headers.addAll(headers);
    }
  }

  /// Registers an interceptor (e.g. for auth headers, logging, or
  /// provider-specific request/response shaping added in a future step).
  void addInterceptor(Interceptor interceptor) {
    _dio.interceptors.add(interceptor);
  }

  Future<Response<T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) {
    return _dio.get<T>(
      path,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
    );
  }

  Future<Response<T>> post<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) {
    return _dio.post<T>(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
    );
  }
}