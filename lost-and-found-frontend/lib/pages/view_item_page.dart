import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/report_model.dart';
import '../services/api_service.dart';
import '../services/auth_service.dart';

class ViewItemPage extends StatefulWidget {
  const ViewItemPage({super.key});

  @override
  State<ViewItemPage> createState() => _ViewItemPageState();
}

class _ViewItemPageState extends State<ViewItemPage> {
  String? currentUserId;

  @override
  void initState() {
    super.initState();
    _loadCurrentUser();
  }

  Future<void> _loadCurrentUser() async {
    final user = await AuthService.getUser();
    setState(() => currentUserId = user['id']);
  }

  Future<void> _openInMaps(double lat, double lng) async {
    final uri = Uri.parse('https://www.google.com/maps/search/?api=1&query=$lat,$lng');
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Could not open maps")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final ReportModel item = ModalRoute.of(context)!.settings.arguments as ReportModel;
    final bool isOwnReport = currentUserId != null && currentUserId == item.user;

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
                child: item.imageUrl != null && item.imageUrl!.isNotEmpty
                    ? Image.network(
                  item.imageUrl!,
                  height: 180,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    height: 180,
                    width: double.infinity,
                    color: Colors.grey[300],
                    child: const Icon(Icons.image_not_supported, size: 40),
                  ),
                )
                    : Container(
                  height: 180,
                  width: double.infinity,
                  color: Colors.grey[300],
                  child: const Icon(Icons.image_not_supported, size: 40),
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
                Expanded(
                  child: Text(item.location ?? 'No location provided', style: const TextStyle(fontSize: 15)),
                ),
              ],
            ),

            // 🗺️ Open in Maps — only shows if GPS coordinates were saved with this report
            if (item.lat != null && item.lng != null)
              Padding(
                padding: const EdgeInsets.only(top: 4, left: 24),
                child: TextButton.icon(
                  onPressed: () => _openInMaps(item.lat!, item.lng!),
                  icon: const Icon(Icons.map_outlined, size: 18),
                  label: const Text("Open in Maps"),
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                    minimumSize: const Size(0, 0),
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                ),
              ),

            const SizedBox(height: 10),
            Row(
              children: [
                const Icon(Icons.person_outline, size: 18, color: Colors.teal),
                const SizedBox(width: 6),
                Text(item.reporterName ?? 'Unknown reporter', style: const TextStyle(fontSize: 15)),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                const Icon(Icons.info, size: 18, color: Colors.teal),
                const SizedBox(width: 6),
                Text(
                  (item.type ?? '').toUpperCase(),
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: item.type == 'lost' ? Colors.red : Colors.green,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Message the reporter — hidden if it's your own report
            if (!isOwnReport && item.user != null)
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      '/chat',
                      arguments: {
                        'userId': item.user!,
                        'name': item.reporterName ?? 'Reporter',
                      },
                    );
                  },
                  icon: const Icon(Icons.message),
                  label: const Text("Message Reporter"),
                ),
              ),

            const SizedBox(height: 12),
            if (isOwnReport)
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
                      final success = await ApiService.deleteReport(item.id);
                      if (context.mounted) {
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
