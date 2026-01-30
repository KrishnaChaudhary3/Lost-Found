// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import '../models/item_models.dart';
// import '../models/message_model.dart'; // Make sure you create this model
//
// class ApiService {
//   // ✅ Use correct baseUrl for Android Emulator
//   //static const String baseUrl = 'http://localhost:5000/api';
//    //static const String baseUrl = 'http://192.168.1.10:5000/api/items'; // Example: your local server IP
//   static const String baseUrl = 'http://10.0.2.2:5000/api';
//
//
//   // ------------------------- ITEM APIs -------------------------
//
//   // Fetch all items
//   static Future<List<ItemModel>> fetchItems() async {
//     final url = Uri.parse('$baseUrl/items');
//     print('[GET] $url');
//     try {
//       final response = await http.get(url);
//       print('Status Code: ${response.statusCode}');
//       print('Response Body: ${response.body}');
//       if (response.statusCode == 200) {
//         final List<dynamic> data = jsonDecode(response.body);
//         return data.map((json) => ItemModel.fromJson(json)).toList();
//       } else {
//         throw Exception('Failed to load items');
//       }

















//     } catch (e) {
//       print('Error fetching items: $e');
//       throw e;
//     }
//   }
//
//   // Add a new item
//   static Future<bool> addItem(ItemModel item) async {
//     final url = Uri.parse('$baseUrl/items');
//     print('[POST] $url');
//     print('Request Body: ${jsonEncode(item.toJson())}');
//     try {
//       final response = await http.post(
//         url,
//         headers: {'Content-Type': 'application/json'},
//         body: jsonEncode(item.toJson()),
//       );
//       print('Status Code: ${response.statusCode}');
//       print('Response Body: ${response.body}');
//       return response.statusCode == 201 || response.statusCode == 200;
//     } catch (e) {
//       print('Error adding item: $e');
//       return false;
//     }
//   }
//
//   // Delete item by id
//   static Future<bool> deleteItem(String? id) async {
//     if (id == null) return false;
//     final url = Uri.parse('$baseUrl/items/$id');
//     print('[DELETE] $url');
//     try {
//       final response = await http.delete(url);
//       print('Status Code: ${response.statusCode}');
//       print('Response Body: ${response.body}');
//       return response.statusCode == 200 || response.statusCode == 204;
//     } catch (e) {
//       print('Error deleting item: $e');
//       return false;
//     }
//   }
//
//   // ------------------------- MESSAGE APIs -------------------------
//
//   // ✅ Send a message
//   static Future<bool> sendMessage(String sender, String receiver, String content) async {
//     final url = Uri.parse('$baseUrl/messages/send');
//     final body = {
//       'sender': sender,
//       'receiver': receiver,
//       'content': content,
//     };
//     print('[POST] $url');
//     print('Request Body: ${jsonEncode(body)}');
//     try {
//       final response = await http.post(
//         url,
//         headers: {'Content-Type': 'application/json'},
//         body: jsonEncode(body),
//       );
//       print('Status Code: ${response.statusCode}');
//       print('Response Body: ${response.body}');
//       return response.statusCode == 201;
//     } catch (e) {
//       print('Error sending message: $e');
//       return false;
//     }
//   }
//
//   // ✅ Get chat messages between 2 users
//   static Future<List<MessageModel>> getMessages(String sender, String receiver) async {
//     final url = Uri.parse('$baseUrl/messages/chat?sender=$sender&receiver=$receiver');
//     print('[GET] $url');
//     try {
//       final response = await http.get(url);
//       print('Status Code: ${response.statusCode}');
//       print('Response Body: ${response.body}');
//       if (response.statusCode == 200) {
//         final List<dynamic> data = jsonDecode(response.body);
//         return data.map((json) => MessageModel.fromJson(json)).toList();
//       } else {
//         throw Exception('Failed to load messages');
//       }
//     } catch (e) {
//       print('Error fetching messages: $e');
//       return [];
//     }
//   }
// }
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/item_models.dart';
import '../models/message_model.dart';

class ApiService {

  static const String baseUrl = 'http://172.16.92.205:5000/api/items';




  static Future<List<ItemModel>> fetchItems() async {
    final url = Uri.parse('http://172.16.92.205:5000/api/items');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        return data.map((json) => ItemModel.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load items');
      }
    } catch (e) {
      print('Error fetching items: $e');
      rethrow;
    }
  }


  static Future<bool> addItem(ItemModel item) async {
    final url = Uri.parse('http://172.16.92.205:5000/api/items');
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(item.toJson()),
      );
      return response.statusCode == 201 || response.statusCode == 200;
    } catch (e) {
      print('Error adding item: $e');
      return false;
    }
  }

  // Delete
  static Future<bool> deleteItem(String? id) async {
    if (id == null) return false;
    final url = Uri.parse('http://172.16.92.205:5000/api/items/$id');
    try {
      final response = await http.delete(url);
      return response.statusCode == 200 || response.statusCode == 204;
    } catch (e) {
      print('Error deleting item: $e');
      return false;
    }
  }



  static Future<bool> sendMessage(String sender, String receiver, String content) async {
    final url = Uri.parse('http://172.16.92.205:5000/api/messages/send');
    final body = {
      'sender': sender,
      'receiver': receiver,
      'content': content,
    };
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(body),
      );
      return response.statusCode == 201;
    } catch (e) {
      print('Error sending message: $e');
      return false;
    }
  }

  static Future<List<MessageModel>> getMessages(String sender, String receiver) async {
    final url = Uri.parse('http://172.16.92.205:5000/api/messages/chat?sender=$sender&receiver=$receiver');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        return data.map((json) => MessageModel.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load messages');
      }
    } catch (e) {
      print('Error fetching messages: $e');
      return [];
    }
  }
}