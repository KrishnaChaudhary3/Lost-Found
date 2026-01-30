import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../models/item_models.dart';
import '../widgets/bottom_nav.dart';

class SearchPage extends StatefulWidget {
  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<ItemModel> items = [];
  String searchQuery = '';
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchItemsFromBackend();
  }

  Future<void> fetchItemsFromBackend() async {
    try {
      final response = await http.get(Uri.parse('http://172.16.92.205:5000/api/items'));
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        setState(() {
          items = data.map((json) => ItemModel.fromJson(json)).toList();
          isLoading = false;
        });
      } else {
        throw Exception('Failed to load items');
      }
    } catch (e) {
      print('Error fetching items: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    List<ItemModel> filteredItems = items.where((item) {
      final title = item.title ?? '';
      final desc = item.description ?? '';
      return title.toLowerCase().contains(searchQuery.toLowerCase()) ||
          desc.toLowerCase().contains(searchQuery.toLowerCase());
    }).toList();

    return Scaffold(
      appBar: AppBar(title: Text("Search Items")),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            TextField(
              onChanged: (val) => setState(() => searchQuery = val),
              decoration: InputDecoration(
                hintText: "Search by title or description...",
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.search),
              ),
            ),
            const SizedBox(height: 12),
            isLoading
                ? CircularProgressIndicator()
                : Expanded(
              child: filteredItems.isEmpty
                  ? Center(child: Text("No items found."))
                  : ListView.builder(
                itemCount: filteredItems.length,
                itemBuilder: (context, index) {
                  final item = filteredItems[index];
                  return Card(
                    child: ListTile(
                      title: Text(item.title ?? '', overflow: TextOverflow.ellipsis),
                      subtitle: Text(item.description ?? '', overflow: TextOverflow.ellipsis),
                      trailing: Text(
                        (item.status ?? '').toUpperCase(),
                        style: TextStyle(
                          color: item.status == 'lost' ? Colors.red : Colors.green,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      onTap: () {
                        Navigator.pushNamed(context, '/viewItem', arguments: item);
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNav(
        currentIndex: 1,
        onTap: (index) {
          if (index == 0) Navigator.pushReplacementNamed(context, '/home');
          if (index == 1) return;
          if (index == 2) Navigator.pushReplacementNamed(context, '/profile');
          if (index == 3) Navigator.pushReplacementNamed(context, '/settings');
        },
      ),
    );
  }
}
