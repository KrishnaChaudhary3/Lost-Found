import 'dart:convert';
import 'package:http/http.dart' as http;
import 'models/item_models.dart';

const String baseUrl = 'http://localhost:5000/api/items'; // Change to your backend URL

Future<List<ItemModel>> getItems({String? status}) async {
  try {
    final uri = Uri.parse(status == null ? baseUrl : '$baseUrl?status=$status');
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((json) => ItemModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load items');
    }
  } catch (e) {
    throw Exception('Error: $e');
  }
}

Future<ItemModel> addItem(ItemModel item) async {
  try {
    final uri = Uri.parse(baseUrl);
    final response = await http.post(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: json.encode(item.toJson()),
    );

    if (response.statusCode == 201) {
      return ItemModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to add item');
    }
  } catch (e) {
    throw Exception('Error: $e');
  }
}

Future<void> deleteItem(String id) async {
  try {
    final uri = Uri.parse('$baseUrl/$id');
    final response = await http.delete(uri);

    if (response.statusCode != 200) {
      throw Exception('Failed to delete item');
    }
  } catch (e) {
    throw Exception('Error: $e');
  }
}

Future<ItemModel> updateItem(ItemModel item) async {
  try {
    final uri = Uri.parse('$baseUrl/${item.id}');
    final response = await http.put(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: json.encode(item.toJson()),
    );

    if (response.statusCode == 200) {
      return ItemModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to update item');
    }
  } catch (e) {
    throw Exception('Error: $e');
  }
}
