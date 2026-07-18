import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../constants/api_constants.dart';
import '../models/item_models.dart';
import '../models/message_model.dart';
import '../models/report_model.dart';
import 'auth_service.dart';

class ApiService {
  // ---------------- ITEMS ----------------

  static Future<List<ItemModel>> fetchItems({String? type, String? location}) async {
    final params = <String, String>{};
    if (type != null) params['type'] = type;
    if (location != null) params['location'] = location;

    final uri = Uri.parse('${ApiConstants.apiUrl}/items').replace(queryParameters: params.isEmpty ? null : params);

    final response = await http.get(uri, headers: await AuthService.authHeaders());
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => ItemModel.fromJson(json)).toList();
    }
    throw Exception('Failed to load items (${response.statusCode})');
  }

  static Future<bool> addItem(ItemModel item) async {
    final response = await http.post(
      Uri.parse('${ApiConstants.apiUrl}/items'),
      headers: await AuthService.authHeaders(),
      body: jsonEncode(item.toJson()),
    );
    return response.statusCode == 201 || response.statusCode == 200;
  }

  static Future<bool> deleteItem(String? id) async {
    if (id == null) return false;
    final response = await http.delete(
      Uri.parse('${ApiConstants.apiUrl}/items/$id'),
      headers: await AuthService.authHeaders(),
    );
    return response.statusCode == 200 || response.statusCode == 204;
  }

  // ---------------- REPORTS ----------------

  static Future<List<ReportModel>> fetchReports({String? type}) async {
    final uri = Uri.parse('${ApiConstants.apiUrl}/reports${type != null && type != 'all' ? '?type=$type' : ''}');
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => ReportModel.fromJson(json)).toList();
    }
    throw Exception('Failed to load reports (${response.statusCode})');
  }

  static Future<List<ReportModel>> fetchMyReports() async {
    final response = await http.get(
      Uri.parse('${ApiConstants.apiUrl}/reports/my'),
      headers: await AuthService.authHeaders(),
    );
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => ReportModel.fromJson(json)).toList();
    }
    throw Exception('Failed to load your reports (${response.statusCode})');
  }

  static Future<bool> submitReport(Map<String, dynamic> reportData) async {
    final response = await http.post(
      Uri.parse('${ApiConstants.apiUrl}/reports'),
      headers: await AuthService.authHeaders(),
      body: jsonEncode(reportData),
    );
    return response.statusCode == 201;
  }

  static Future<bool> deleteReport(String? id) async {
    if (id == null) return false;
    final response = await http.delete(
      Uri.parse('${ApiConstants.apiUrl}/reports/$id'),
      headers: await AuthService.authHeaders(),
    );
    return response.statusCode == 200;
  }

  // ---------------- MESSAGES ----------------

  static Future<List<Map<String, dynamic>>> fetchInbox() async {
    final response = await http.get(
      Uri.parse('${ApiConstants.apiUrl}/messages'),
      headers: await AuthService.authHeaders(),
    );
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return List<Map<String, dynamic>>.from(data);
    }
    throw Exception('Failed to load messages (${response.statusCode})');
  }

  static Future<List<MessageModel>> getMessages(String otherUserId) async {
    final response = await http.get(
      Uri.parse('${ApiConstants.apiUrl}/messages/$otherUserId'),
      headers: await AuthService.authHeaders(),
    );
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => MessageModel.fromJson(json)).toList();
    }
    throw Exception('Failed to load chat (${response.statusCode})');
  }

  static Future<bool> sendMessage(String receiverId, String content) async {
    final response = await http.post(
      Uri.parse('${ApiConstants.apiUrl}/messages/send'),
      headers: await AuthService.authHeaders(),
      body: jsonEncode({'receiverId': receiverId, 'content': content}),
    );
    return response.statusCode == 201;
  }

  // ---------------- IMAGE UPLOAD ----------------

  static Future<String?> uploadImage(File imageFile) async {
    final uri = Uri.parse('${ApiConstants.apiUrl}/upload');
    final token = await AuthService.getToken();

    final request = http.MultipartRequest('POST', uri);
    if (token != null) request.headers['Authorization'] = 'Bearer $token';
    request.files.add(await http.MultipartFile.fromPath('image', imageFile.path));

    final streamedResponse = await request.send();
    final response = await http.Response.fromStream(streamedResponse);

    if (response.statusCode == 201) {
      final data = jsonDecode(response.body);
      return data['imageUrl'];
    }
    return null;
  }
}
