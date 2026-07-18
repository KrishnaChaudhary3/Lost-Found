import 'package:flutter/material.dart';
import '../services/api_service.dart';

class MessagesPage extends StatefulWidget {
  const MessagesPage({super.key});

  @override
  State<MessagesPage> createState() => _MessagesPageState();
}

class _MessagesPageState extends State<MessagesPage> {
  List<Map<String, dynamic>> conversations = [];
  bool isLoading = true;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    fetchInbox();
  }

  Future<void> fetchInbox() async {
    setState(() {
      isLoading = true;
      errorMessage = null;
    });
    try {
      final inbox = await ApiService.fetchInbox();
      setState(() {
        conversations = inbox;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        errorMessage = 'Could not load messages: $e';
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Messages")),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : errorMessage != null
          ? Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(errorMessage!, textAlign: TextAlign.center),
              const SizedBox(height: 12),
              ElevatedButton(onPressed: fetchInbox, child: const Text("Retry")),
            ],
          ),
        ),
      )
          : conversations.isEmpty
          ? const Center(child: Text("No conversations yet."))
          : RefreshIndicator(
        onRefresh: fetchInbox,
        child: ListView.builder(
          itemCount: conversations.length,
          itemBuilder: (context, index) {
            final convo = conversations[index];
            return ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.teal.shade200,
                child: const Icon(Icons.person, color: Colors.white),
              ),
              title: Text(convo['name'] ?? '', overflow: TextOverflow.ellipsis),
              subtitle: Text(convo['lastMsg'] ?? '', overflow: TextOverflow.ellipsis),
              onTap: () {
                Navigator.pushNamed(
                  context,
                  '/chat',
                  arguments: {
                    'userId': convo['userId'].toString(),
                    'name': convo['name'].toString(),
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }
}
