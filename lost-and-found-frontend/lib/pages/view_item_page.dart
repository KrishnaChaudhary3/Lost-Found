import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/item_models.dart';
import '../services/api_service.dart'; // ✅ Use this instead of http_service.dart

class ViewItemPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ItemModel item = ModalRoute.of(context)!.settings.arguments as ItemModel;

    return Scaffold(
      appBar: AppBar(title: const Text("Item Details")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  item.imageUrl ?? '',
                  height: 180,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    height: 180,
                    width: double.infinity,
                    color: Colors.grey[300],
                    child: const Icon(Icons.image_not_supported, size: 40),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              item.title ?? '',
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(item.description ?? '', style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 10),
            Row(
              children: [
                const Icon(Icons.location_on, size: 18, color: Colors.teal),
                const SizedBox(width: 6),
                Text(item.location ?? '', style: const TextStyle(fontSize: 15)),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                const Icon(Icons.calendar_today, size: 18, color: Colors.teal),
                const SizedBox(width: 6),
                Text(
                  item.date != null
                      ? DateFormat.yMMMd().format(item.date!)
                      : 'No date provided',
                  style: const TextStyle(fontSize: 15),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                const Icon(Icons.info, size: 18, color: Colors.teal),
                const SizedBox(width: 6),
                Text(
                  item.status?.toUpperCase() ?? '',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: item.status == 'lost' ? Colors.red : Colors.green,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),
            Center(
              child: ElevatedButton.icon(
                onPressed: () async {
                  final confirm = await showDialog<bool>(
                    context: context,
                    builder: (_) => AlertDialog(
                      title: const Text("Delete Item"),
                      content: const Text("Are you sure you want to delete this item?"),
                      actions: [
                        TextButton(onPressed: () => Navigator.pop(context, false), child: const Text("Cancel")),
                        TextButton(onPressed: () => Navigator.pop(context, true), child: const Text("Delete")),
                      ],
                    ),
                  );

                  if (confirm == true) {
                    final success = await ApiService.deleteItem(item.id);
                    if (success) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Item deleted successfully")),
                      );
                      Navigator.pop(context);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Failed to delete item")),
                      );
                    }
                  }
                },
                icon: const Icon(Icons.delete),
                label: const Text("Delete"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.redAccent,
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
