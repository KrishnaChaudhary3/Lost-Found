import 'package:flutter/material.dart';
import '../models/report_model.dart';
import '../services/api_service.dart';
import '../widgets/bottom_nav.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String selectedFilter = 'all';
  bool isLoading = true;
  String? errorMessage;
  List<ReportModel> items = [];

  @override
  void initState() {
    super.initState();
    fetchItems();
  }

  Future<void> fetchItems() async {
    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    try {
      final reports = await ApiService.fetchReports(type: selectedFilter);
      setState(() {
        items = reports;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        errorMessage = 'Error: $e';
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Lost & Found"),
        actions: [
          IconButton(
            icon: const Icon(Icons.message),
            onPressed: () => Navigator.pushNamed(context, '/messages'),
          )
        ],
      ),
      body: Stack(
        children: [
          // 🔒 Background image untouched, as requested
          Positioned.fill(
            child: Image.asset(
              'assets/bg_home.jpg',
              fit: BoxFit.cover,
            ),
          ),
          Column(
            children: [
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildFilterButton("Lost Items", "lost"),
                  const SizedBox(width: 10),
                  _buildFilterButton("Found Items", "found"),
                  const SizedBox(width: 10),
                  _buildFilterButton("All", "all"),
                ],
              ),
              const SizedBox(height: 10),
              Expanded(
                child: isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : errorMessage != null
                    ? Center(child: Text(errorMessage!))
                    : items.isEmpty
                    ? const Center(child: Text('No items found.'))
                    : ListView.builder(
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    final item = items[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, '/viewItem', arguments: item);
                      },
                      child: Card(
                        color: Colors.white.withOpacity(0.9),
                        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: item.imageUrl != null && item.imageUrl!.isNotEmpty
                                    ? Image.network(
                                  item.imageUrl!,
                                  width: 80,
                                  height: 80,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) => Container(
                                    width: 80,
                                    height: 80,
                                    color: Colors.grey.shade300,
                                    child: const Icon(Icons.image_not_supported),
                                  ),
                                )
                                    : Container(
                                  width: 80,
                                  height: 80,
                                  color: Colors.grey.shade300,
                                  child: const Icon(Icons.image_not_supported),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      item.title ?? '',
                                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      item.description ?? '',
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 8),
                              Text(
                                (item.type ?? '').toUpperCase(),
                                style: TextStyle(
                                  color: item.type == 'lost' ? Colors.red : Colors.green,
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, '/report'),
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: BottomNav(currentIndex: 0, onTap: _onTabTapped),
    );
  }

  void _onTabTapped(int index) {
    if (index == 0) return;
    final routes = ['/home', '/search', '/profile', '/settings'];
    Navigator.pushReplacementNamed(context, routes[index]);
  }

  Widget _buildFilterButton(String label, String value) {
    final isSelected = selectedFilter == value;
    return ElevatedButton(
      onPressed: () {
        setState(() => selectedFilter = value);
        fetchItems();
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: isSelected ? const Color(0xFF0F766E) : Colors.grey.shade200,
        foregroundColor: isSelected ? Colors.white : Colors.black,
      ),
      child: Text(label),
    );
  }
}
