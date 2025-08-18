import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../constants/app_constants.dart';

class ApiClient {
  final FlutterSecureStorage _secureStorage;
  late final http.Client _client;
  late final String _baseUrl;

  ApiClient(this._secureStorage) {
    _client = http.Client();
    _baseUrl = AppConstants.baseUrl;
  }

  Future<Map<String, String>> _getHeaders() async {
    final headers = {'Content-Type': 'application/json'};

    // Check for anonymous token first, then regular token
    final anonymousToken = await _secureStorage.read(key: 'anonymousToken');
    final regularToken = await _secureStorage.read(key: 'accessToken');
    
    final token = anonymousToken ?? regularToken;
    if (token != null) {
      headers['Authorization'] = 'Bearer $token';
    }

    return headers;
  }

  Future<http.Response> get(String endpoint) async {
    final headers = await _getHeaders();
    final uri = Uri.parse('$_baseUrl$endpoint');
    return await _client.get(uri, headers: headers);
  }

  Future<http.Response> post(String endpoint, Map<String, dynamic> body) async {
    final headers = await _getHeaders();
    final uri = Uri.parse('$_baseUrl$endpoint');
    return await _client.post(uri, headers: headers, body: jsonEncode(body));
  }

  Future<http.Response> put(String endpoint, Map<String, dynamic> body) async {
    final headers = await _getHeaders();
    final uri = Uri.parse('$_baseUrl$endpoint');
    return await _client.put(uri, headers: headers, body: jsonEncode(body));
  }

  Future<http.Response> delete(String endpoint) async {
    final headers = await _getHeaders();
    final uri = Uri.parse('$_baseUrl$endpoint');
    return await _client.delete(uri, headers: headers);
  }

  void dispose() {
    _client.close();
  }
}
