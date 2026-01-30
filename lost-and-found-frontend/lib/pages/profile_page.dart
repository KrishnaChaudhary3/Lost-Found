import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../widgets/bottom_nav.dart';
import '../models/report_model.dart';

class ProfilePage extends StatefulWidget {
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late Future<List<ReportModel>> futureUserReports;

  @override
  void initState() {
    super.initState();
    futureUserReports = fetchUserReports();
  }

  Future<List<ReportModel>> fetchUserReports() async {
    try {
      final response = await http.get(Uri.parse('http://172.16.92.205:5000/api/reports'));

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((jsonItem) => ReportModel.fromJson(jsonItem)).toList();
      } else {
        throw Exception('Failed to load reports');
      }
    } catch (e) {
      throw Exception('Error fetching data: $e');
    }
  }

  Future<void> _deleteReport(String? id) async {
    if (id == null) return;

    final confirm = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Delete Report'),
        content: Text('Are you sure you want to delete this report?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: Text('Cancel')),
          TextButton(onPressed: () => Navigator.pop(context, true), child: Text('Delete')),
        ],
      ),
    );

    if (confirm != true) return;

    final url = Uri.parse('http://172.16.92.205:5000/api/reports/$id');
    final response = await http.delete(url);

    if (response.statusCode == 200) {
      setState(() {
        futureUserReports = fetchUserReports();
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Report deleted')));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to delete')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("My Profile")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            CircleAvatar(
              radius: 40,
              child: const Icon(Icons.person, size: 40),
              backgroundColor: Colors.teal.shade200,
            ),
            const SizedBox(height: 10),
            const Text("krishna", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const Text("krishna.kumari_cs23@gla.ac.in", style: TextStyle(color: Colors.grey)),
            const SizedBox(height: 20),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text("My Reports", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: FutureBuilder<List<ReportModel>>(
                future: futureUserReports,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(child: Text('No reports yet.'));
                  }

                  final reports = snapshot.data!;

                  return ListView.builder(
                    itemCount: reports.length,
                    itemBuilder: (context, index) {
                      final report = reports[index];
                      return Card(
                        child: ListTile(
                          title: Text(report.title ?? '', overflow: TextOverflow.ellipsis),
                          subtitle: Text(report.description ?? '', overflow: TextOverflow.ellipsis),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                (report.type ?? '').toUpperCase(),
                                style: TextStyle(
                                  color: (report.type ?? '') == 'lost'
                                      ? Colors.red
                                      : Colors.green,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              IconButton(
                                icon: Icon(Icons.delete, color: Colors.grey),
                                onPressed: () => _deleteReport(report.id),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNav(
        currentIndex: 2,
        onTap: (index) {
          if (index == 0) Navigator.pushReplacementNamed(context, '/home');
          if (index == 1) Navigator.pushReplacementNamed(context, '/search');
          if (index == 2) return;
          if (index == 3) Navigator.pushReplacementNamed(context, '/settings');
        },
      ),
    );
  }
}



// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
//
// import '../widgets/bottom_nav.dart';
// import '../models/report_model.dart';
//
// class ProfilePage extends StatefulWidget {
//   @override
//   State<ProfilePage> createState() => _ProfilePageState();
// }
//
// class _ProfilePageState extends State<ProfilePage> {
//   late Future<List<ReportModel>> futureUserReports;
//
//   @override
//   void initState() {
//     super.initState();
//     futureUserReports = fetchUserReports();
//   }
//
//   Future<List<ReportModel>> fetchUserReports() async {
//     try {
//       final response = await http.get(Uri.parse('http://10.68.88.51:5000/api/reports'));
//
//       if (response.statusCode == 200) {
//         final List<dynamic> data = json.decode(response.body);
//         return data.map((jsonItem) => ReportModel.fromJson(jsonItem)).toList();
//       } else {
//         throw Exception('Failed to load reports');
//       }
//     } catch (e) {
//       throw Exception('Error fetching data: $e');
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("My Profile")),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             CircleAvatar(
//               radius: 40,
//               child: const Icon(Icons.person, size: 40),
//               backgroundColor: Colors.teal.shade200,
//             ),
//             const SizedBox(height: 10),
//             const Text("krishna", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//             const Text("krishna.kumari_cs23@gla.ac.in", style: TextStyle(color: Colors.grey)),
//             const SizedBox(height: 20),
//             const Align(
//               alignment: Alignment.centerLeft,
//               child: Text("My Reports", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
//             ),
//             const SizedBox(height: 10),
//             Expanded(
//               child: FutureBuilder<List<ReportModel>>(
//                 future: futureUserReports,
//                 builder: (context, snapshot) {
//                   if (snapshot.connectionState == ConnectionState.waiting) {
//                     return const Center(child: CircularProgressIndicator());
//                   } else if (snapshot.hasError) {
//                     return Center(child: Text('Error: ${snapshot.error}'));
//                   } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
//                     return const Center(child: Text('No reports yet.'));
//                   }
//
//                   final reports = snapshot.data!;
//
//                   return ListView.builder(
//                     itemCount: reports.length,
//                     itemBuilder: (context, index) {
//                       final report = reports[index];
//                       return Card(
//                         child: ListTile(
//                           title: Text(report.title ?? '', overflow: TextOverflow.ellipsis),
//                           subtitle: Text(report.description ?? '', overflow: TextOverflow.ellipsis),
//                           trailing: Text(
//                             (report.type ?? '').toUpperCase(),
//                             style: TextStyle(
//                               color: (report.type ?? '') == 'lost' ? Colors.red : Colors.green,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                         ),
//                       );
//                     },
//                   );
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//       bottomNavigationBar: BottomNav(
//         currentIndex: 2,
//         onTap: (index) {
//           if (index == 0) Navigator.pushReplacementNamed(context, '/home');
//           if (index == 1) Navigator.pushReplacementNamed(context, '/search');
//           if (index == 2) return;
//           if (index == 3) Navigator.pushReplacementNamed(context, '/settings');
//         },
//       ),
//     );
//   }
// }



// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
//
// //import '../models/item_models.dart'; // ✅ Use backend-compatible model
// import '../widgets/bottom_nav.dart';
// import '../models/report_model.dart';
//
//
// class ProfilePage extends StatefulWidget {
//   @override
//   State<ProfilePage> createState() => _ProfilePageState();
// }
//
// class _ProfilePageState extends State<ProfilePage> {
//    late Future<List<ItemModel>> futureUserItems;
//   //  late FutureBuilder<List<ReportModel>> future: futureUserReports;
//
//   @override
//   void initState() {
//     super.initState();
//     futureUserReports = fetchUserReports();
//
//   }
//
//   // Future<List<ItemModel>> fetchUserItems() async {
//   //   try {
//   //     final response = await http.get(Uri.parse('http://10.68.88.51:5000/api/items'));
//   //
//   //     if (response.statusCode == 200) {
//   //       final List<dynamic> data = json.decode(response.body);
//   //       return data.map((jsonItem) => ItemModel.fromJson(jsonItem)).toList();
//   //     } else {
//   //       throw Exception('Failed to load items');
//   //     }
//   //   } catch (e) {
//   //     throw Exception('Error fetching data: $e');
//   //   }
//   // }
//
//
//
//   Future<List<ReportModel>> fetchUserReports() async {
//     try {
//       final response = await http.get(Uri.parse('http://10.68.88.51:5000/api/reports'));
//
//       if (response.statusCode == 200) {
//         final List<dynamic> data = json.decode(response.body);
//         return data.map((jsonItem) => ReportModel.fromJson(jsonItem)).toList();
//       } else {
//         throw Exception('Failed to load reports');
//       }
//     } catch (e) {
//       throw Exception('Error fetching data: $e');
//     }
//   }
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("My Profile")),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             CircleAvatar(
//               radius: 40,
//               child: const Icon(Icons.person, size: 40),
//               backgroundColor: Colors.teal.shade200,
//             ),
//             const SizedBox(height: 10),
//             const Text("krishna", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//             const Text("krishna.kumari_cs23@gla.ac.in", style: TextStyle(color: Colors.grey)),
//             const SizedBox(height: 20),
//             const Align(
//               alignment: Alignment.centerLeft,
//               child: Text("My Reports", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
//             ),
//             const SizedBox(height: 10),
//             Expanded(
//                child:FutureBuilder<List<ItemModel>>(
//                         future: futureUserItems,
//
//                 builder: (context, snapshot) {
//                   if (snapshot.connectionState == ConnectionState.waiting) {
//                     return const Center(child: CircularProgressIndicator());
//                   } else if (snapshot.hasError) {
//                     return Center(child: Text('Error: ${snapshot.error}'));
//                   } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
//                     return const Center(child: Text('No reports yet.'));
//                   }
//
//                   final userItems = snapshot.data!;
//
//                   return ListView.builder(
//                     itemCount: userItems.length,
//                     itemBuilder: (context, index) {
//                       final item = userItems[index];
//                       return Card(
//                         child: ListTile(
//                           title: Text(item.title ?? '', overflow: TextOverflow.ellipsis),
//                           subtitle: Text(item.description ?? '', overflow: TextOverflow.ellipsis),
//                           trailing: Text(
//                             (item.status ?? '').toUpperCase(),
//                             style: TextStyle(
//                               color: (item.status ?? '') == 'lost' ? Colors.red : Colors.green,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                           onTap: () {
//                             Navigator.pushNamed(context, '/item-details', arguments: item);
//                           },
//                         ),
//                       );
//                     },
//                   );
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//       bottomNavigationBar: BottomNav(
//         currentIndex: 2,
//         onTap: (index) {
//           if (index == 0) Navigator.pushReplacementNamed(context, '/home');
//           if (index == 1) Navigator.pushReplacementNamed(context, '/search');
//           if (index == 2) return;
//           if (index == 3) Navigator.pushReplacementNamed(context, '/settings');
//         },
//       ),
//     );
//   }
// }
//

// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'package:shared_preferences/shared_preferences.dart';
//
// import '../models/item_models.dart';
// import '../widgets/bottom_nav.dart';
//
// class ProfilePage extends StatefulWidget {
//   @override
//   State<ProfilePage> createState() => _ProfilePageState();
// }
//
// class _ProfilePageState extends State<ProfilePage> {
//   String email = "";
//   List<ItemModel> items = [];
//
//   @override
//   void initState() {
//     super.initState();
//     fetchProfileData();
//   }
//
//   Future<void> fetchProfileData() async {
//     final prefs = await SharedPreferences.getInstance();
//     final token = prefs.getString('token');
//
//     if (token == null) {
//       ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("No token found")));
//       return;
//     }
//
//     try {
//       final response = await http.get(
//         Uri.parse('http://10.68.88.51:5000/api/users/profile'),
//         headers: {'Authorization': 'Bearer $token'},
//       );
//
//       if (response.statusCode == 200) {
//         final data = json.decode(response.body);
//         setState(() {
//           email = data['email'] ?? '';
//           items = (data['items'] as List).map((e) => ItemModel.fromJson(e)).toList();
//         });
//       } else {
//         throw Exception('Failed to load profile');
//       }
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $e')));
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("My Profile")),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             CircleAvatar(
//               radius: 40,
//               child: const Icon(Icons.person, size: 40),
//               backgroundColor: Colors.teal.shade200,
//             ),
//             const SizedBox(height: 10),
//             Text(email, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//             const SizedBox(height: 20),
//             const Align(
//               alignment: Alignment.centerLeft,
//               child: Text("My Reports", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
//             ),
//             const SizedBox(height: 10),
//             Expanded(
//               child: items.isEmpty
//                   ? const Center(child: Text('No reports yet.'))
//                   : ListView.builder(
//                 itemCount: items.length,
//                 itemBuilder: (context, index) {
//                   final item = items[index];
//                   return Card(
//                     child: ListTile(
//                       title: Text(item.title ?? '', overflow: TextOverflow.ellipsis),
//                       subtitle: Text(item.description ?? '', overflow: TextOverflow.ellipsis),
//                       trailing: Text(
//                         (item.status ?? '').toUpperCase(),
//                         style: TextStyle(
//                           color: (item.status ?? '') == 'lost' ? Colors.red : Colors.green,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       onTap: () {
//                         Navigator.pushNamed(context, '/item-details', arguments: item);
//                       },
//                     ),
//                   );
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//       bottomNavigationBar: BottomNav(
//         currentIndex: 2,
//         onTap: (index) {
//           if (index == 0) Navigator.pushReplacementNamed(context, '/home');
//           if (index == 1) Navigator.pushReplacementNamed(context, '/search');
//           if (index == 2) return;
//           if (index == 3) Navigator.pushReplacementNamed(context, '/settings');
//         },
//       ),
//     );
//   }
// }
