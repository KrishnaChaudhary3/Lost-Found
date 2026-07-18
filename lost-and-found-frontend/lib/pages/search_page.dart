


import 'package:flutter/material.dart';
import '../models/report_model.dart';
import '../services/api_service.dart';
import '../widgets/bottom_nav.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<ReportModel> items = [];
  String searchQuery = '';
  bool isLoading = true;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    fetchItemsFromBackend();
  }

  Future<void> fetchItemsFromBackend() async {
    setState(() {
      isLoading = true;
      errorMessage = null;
    });
    try {
      final fetched = await ApiService.fetchReports();
      setState(() {
        items = fetched;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        errorMessage = 'Could not load items: $e';
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    List<ReportModel> filteredItems = items.where((item) {
      final title = item.title ?? '';
      final desc = item.description ?? '';
      return title.toLowerCase().contains(searchQuery.toLowerCase()) ||
          desc.toLowerCase().contains(searchQuery.toLowerCase());
    }).toList();

    return Scaffold(
      appBar: AppBar(title: const Text("Search Items")),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            TextField(
              onChanged: (val) => setState(() => searchQuery = val),
              decoration: const InputDecoration(
                hintText: "Search by title or description...",
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.search),
              ),
            ),
            const SizedBox(height: 12),
            if (isLoading)
              const Expanded(child: Center(child: CircularProgressIndicator()))
            else if (errorMessage != null)
              Expanded(
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(errorMessage!, textAlign: TextAlign.center),
                      const SizedBox(height: 12),
                      ElevatedButton(onPressed: fetchItemsFromBackend, child: const Text("Retry")),
                    ],
                  ),
                ),
              )
            else
              Expanded(
                child: filteredItems.isEmpty
                    ? const Center(child: Text("No items found."))
                    : ListView.builder(
                  itemCount: filteredItems.length,
                  itemBuilder: (context, index) {
                    final item = filteredItems[index];
                    return Card(
                      child: ListTile(
                        leading: item.imageUrl != null && item.imageUrl!.isNotEmpty
                            ? ClipRRect(
                          borderRadius: BorderRadius.circular(6),
                          child: Image.network(
                            item.imageUrl!,
                            width: 48,
                            height: 48,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) =>
                            const Icon(Icons.image_not_supported),
                          ),
                        )
                            : null,
                        title: Text(item.title ?? '', overflow: TextOverflow.ellipsis),
                        subtitle: Text(item.description ?? '', overflow: TextOverflow.ellipsis),
                        trailing: Text(
                          (item.type ?? '').toUpperCase(),
                          style: TextStyle(
                            color: item.type == 'lost' ? Colors.red : Colors.green,
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
