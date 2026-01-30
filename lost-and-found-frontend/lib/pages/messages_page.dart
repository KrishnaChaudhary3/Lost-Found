import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MessagesPage extends StatefulWidget {
  const MessagesPage({super.key});

  @override
  State<MessagesPage> createState() => _MessagesPageState();
}

class _MessagesPageState extends State<MessagesPage> {
  List<Map<String, dynamic>> messages = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchMessages();
  }

  Future<void> fetchMessages() async {
    try {
      final response = await http.get(Uri.parse('http://172.16.92.205:5000/api/messages'));

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        setState(() {
          messages = List<Map<String, dynamic>>.from(data);
          isLoading = false;
        });
      } else {
        throw Exception("Failed to load messages");
      }
    } catch (e) {
      print("Backend not reachable. Showing mock messages. Error: $e");
      setState(() {
        messages = [
          {'name': 'Aman', 'lastMsg': 'Hi, did you find your bag?', 'image': ''},
          {'name': 'Riya', 'lastMsg': 'I found a phone, is it yours?', 'image': ''},
          {'name': 'John', 'lastMsg': 'Thanks! Got my wallet back.', 'image': ''},
        ];
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Messages")),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
        itemCount: messages.length,
        itemBuilder: (context, index) {
          final msg = messages[index];
          return ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.teal.shade200,
              child: msg['image'] != null && msg['image'] != ''
                  ? ClipOval(child: Image.network(msg['image'], fit: BoxFit.cover))
                  : Icon(Icons.person),
            ),
            title: Text(msg['name'] ?? '', overflow: TextOverflow.ellipsis),
            subtitle: Text(msg['lastMsg'] ?? '', overflow: TextOverflow.ellipsis),
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("Chat with ${msg['name']} coming soon!")),
              );
            },
          );
        },
      ),
    );
  }
}
