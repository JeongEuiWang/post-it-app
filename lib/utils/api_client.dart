import 'package:http/http.dart' as http;

class ApiClient {
  final String baseUrl;

  ApiClient({required this.baseUrl});

  Future<http.Response> get(String endpoint) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl$endpoint'));
      if (response.statusCode == 200) {
        return response;
      } else {
        throw Exception('Failed to load: ${response.statusCode}');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<http.Response> post(String endpoint, Map<String, dynamic> body) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl$endpoint'),
        body: body,
      );
      if (response.statusCode == 200) {
        return response;
      } else {
        throw Exception('Failed to post: ${response.statusCode}');
      }
    } catch (e) {
      rethrow;
    }
  }
}
