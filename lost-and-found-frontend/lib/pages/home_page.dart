// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
//
//
// import 'dart:convert';
//
// import '../models/item_models.dart';
// import '../widgets/bottom_nav.dart';
//
// class HomePage extends StatefulWidget {
//   const HomePage({super.key});
//
//   @override
//   State<HomePage> createState() => _HomePageState();
// }
//
// class _HomePageState extends State<HomePage> {
//   String selectedFilter = 'all';
//   bool isLoading = true;
//   String? errorMessage;
//   List<ItemModel> items = [];
//
//   @override
//   void initState() {
//     super.initState();
//     fetchItems();
//   }
//
//   Future<void> fetchItems() async {
//     setState(() {
//       isLoading = true;
//       errorMessage = null;
//     });
//
//     try {
//       String url = 'http://10.68.88.51:5000/api/items';
//           //'http://10.104.6.51:5000/api/items';
//
//       if (selectedFilter != 'all') {
//         url += '?status=$selectedFilter';
//       }
//
//       //final response = await http.get(Uri.parse('http://10.104.6.51:5000/api/items'));
//       final response = await http.get(Uri.parse('http://10.68.88.51:5000/api/items'));
//
//       if (response.statusCode == 200) {
//         final List decoded = json.decode(response.body);
//         setState(() {
//           items = decoded.map((item) => ItemModel.fromJson(item)).toList();
//           isLoading = false;
//         });
//       } else {
//         setState(() {
//           errorMessage = 'Failed to fetch items: ${response.statusCode}';
//           isLoading = false;
//         });
//       }
//     } catch (e) {
//       setState(() {
//         errorMessage = 'Error: $e';
//         isLoading = false;
//       });
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Lost & Found"),
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.message),
//             onPressed: () => Navigator.pushNamed(context, '/messages'),
//           )
//         ],
//       ),
//       body: Stack(
//         children: [
//           // Background
//           Positioned.fill(
//             child: Image.asset(
//               'assets/bg_home.jpg',
//               fit: BoxFit.cover,
//             ),
//           ),
//
//           // Foreground content
//           Column(
//             children: [
//               const SizedBox(height: 10),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   _buildFilterButton("Lost Items", "lost"),
//                   const SizedBox(width: 10),
//                   _buildFilterButton("Found Items", "found"),
//                   const SizedBox(width: 10),
//                   _buildFilterButton("All", "all"),
//                 ],
//               ),
//               const SizedBox(height: 10),
//
//               // Loading, Error or List
//               Expanded(
//                 child: isLoading
//                     ? const Center(child: CircularProgressIndicator())
//                     : errorMessage != null
//                     ? Center(child: Text(errorMessage!))
//                     : items.isEmpty
//                     ? const Center(child: Text('No items found.'))
//                     : ListView.builder(
//                   itemCount: items.length,
//                   itemBuilder: (context, index) {
//                     final item = items[index];
//                     return GestureDetector(
//                       onTap: () {
//                         Navigator.pushNamed(
//                           context,
//                           '/viewItem',
//                           arguments: item,
//                         );
//                       },
//                       child: Card(
//                         color: Colors.white.withOpacity(0.9),
//                         margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//                         child: Padding(
//                           padding: const EdgeInsets.all(12.0),
//                           child: Row(
//                             children: [
//                               ClipRRect(
//                                 borderRadius: BorderRadius.circular(8),
//                                 child: Image.network(
//                                   item.imageUrl ?? '',
//                                   width: 80,
//                                   height: 80,
//                                   fit: BoxFit.cover,
//                                   errorBuilder: (context, error, stackTrace) {
//                                     return Container(
//                                       width: 80,
//                                       height: 80,
//                                       color: Colors.grey.shade300,
//                                       child: const Icon(Icons.image_not_supported),
//                                     );
//                                   },
//                                 ),
//                               ),
//                               const SizedBox(width: 12),
//                               Expanded(
//                                 child: Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Text(
//                                       item.title ?? '',
//                                       style: const TextStyle(
//                                         fontSize: 16,
//                                         fontWeight: FontWeight.bold,
//                                       ),
//                                       overflow: TextOverflow.ellipsis,
//                                     ),
//                                     const SizedBox(height: 4),
//                                     Text(
//                                       item.description ?? '',
//                                       maxLines: 2,
//                                       overflow: TextOverflow.ellipsis,
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                               const SizedBox(width: 8),
//                               Text(
//                                 item.status?.toUpperCase() ?? '',
//                                 style: TextStyle(
//                                   color: item.status == 'lost' ? Colors.red : Colors.green,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               )
//                             ],
//                           ),
//                         ),
//                       ),
//                     );
//                   },
//                 ),
//               ),
//             ],
//           )
//         ],
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           Navigator.pushNamed(context, '/report');
//         },
//         backgroundColor: Colors.teal,
//         child: const Icon(Icons.add),
//       ),
//       bottomNavigationBar: BottomNav(currentIndex: 0, onTap: _onTabTapped),
//     );
//   }
//
//   void _onTabTapped(int index) {
//     if (index == 0) return;
//     final routes = ['/home', '/search', '/profile', '/settings'];
//     Navigator.pushReplacementNamed(context, routes[index]);
//   }
//
//   Widget _buildFilterButton(String label, String value) {
//     final isSelected = selectedFilter == value;
//     return ElevatedButton(
//       onPressed: () {
//         setState(() {
//           selectedFilter = value;
//         });
//         fetchItems(); // Refetch with filter
//       },
//       style: ElevatedButton.styleFrom(
//         backgroundColor: isSelected ? Colors.teal : Colors.grey.shade200,
//         foregroundColor: isSelected ? Colors.white : Colors.black,
//       ),
//       child: Text(label),
//     );
//   }
// }



import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../models/item_models.dart';
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
  List<ItemModel> items = [];

  // ✅ Dummy data
  // final List<ItemModel> dummyItems = [
  //   ItemModel(
  //     title: 'Black Wallet',
  //     description: 'Lost near the canteen. Has my ID inside.',
  //     status: 'lost',
  //     location: 'Canteen',
  //     imageUrl: 'https://via.placeholder.com/150',
  //   ),
  //   ItemModel(
  //     title: 'Found Phone',
  //     description: 'iPhone found in library. White color.',
  //     status: 'found',
  //     location: 'Library',
  //     imageUrl: 'https://via.placeholder.com/150',
  //   ),
  //   ItemModel(
  //     title: 'bag',
  //     description: 'black color white lining',
  //     status: 'found',
  //     location: 'kc ground',
  //     imageUrl: 'https://via.placeholder.com/150'
  //   ),
  //   ItemModel(
  //     title: 'file',
  //     description: 'document file',
  //     status: 'lost',
  //     location: 'gd subway',
  //     imageUrl: 'https://via.placeholder.com/150'
  //
  //   ),
  //   ItemModel(
  //     title: 'water bottle',
  //     description: 'white color bottle',
  //     status: 'lost',
  //     location: 'gd subway',
  //     imageUrl: 'https://via.placeholder.com/150'
  //   ),
  //   ItemModel(
  //     title: 'laptop',
  //     description: 'hp pavillion 15 laptop',
  //     status: 'found',
  //     location: 'ab-7 classroom-205',
  //     imageUrl: 'https://via.placeholder.com/150'
  //
  //   ),
  //   ItemModel(
  //     title: 'specticles',
  //     description: 'round black color specs',
  //     status: 'lost',
  //     location: 'ab-6 class-17',
  //     imageUrl: 'https://via.placeholder.com/150',
  //   ),
  //


 // ];

  @override
  void initState() {
    super.initState();
    fetchItems();
  }

  // Future<void> fetchItems() async {
  //   await Future.delayed(Duration(seconds: 1)); // simulate delay
  //   setState(() {
  //     if (selectedFilter == 'all') {
  //       items = dummyItems;
  //     } else {
  //       items = dummyItems.where((item) => item.status == selectedFilter).toList();
  //     }
  //     isLoading = false;
  //     errorMessage = null;
  //   });
  // }




  Future<void> fetchItems() async {
    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    try {
      String url = 'http://172.16.92.205:5000/api/reports';
      final response = await http.get(Uri.parse('http://172.16.92.205:5000/api/reports'));

      if (response.statusCode == 200) {
        final List decoded = json.decode(response.body);

        final filteredReports = selectedFilter == 'all'
            ? decoded
            : decoded.where((item) => item['type'] == selectedFilter).toList();

        setState(() {
          items = filteredReports.map((item) => ItemModel(
            title: item['title'],
            description: item['description'],
            status: item['type'], // 'lost' or 'found'
            location: item['location'],
            imageUrl: 'https://via.placeholder.com/150', // or item['imageUrl'] if supported
          )).toList();
          isLoading = false;
        });
      } else {
        setState(() {
          errorMessage = 'Failed to fetch reports: ${response.statusCode}';
          isLoading = false;
        });
      }
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
                        Navigator.pushNamed(
                          context,
                          '/viewItem',
                          arguments: item,
                        );
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
                                child: Image.network(
                                  item.imageUrl ?? '',
                                  width: 80,
                                  height: 80,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Container(
                                      width: 80,
                                      height: 80,
                                      color: Colors.grey.shade300,
                                      child: const Icon(Icons.image_not_supported),
                                    );
                                  },
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      item.title ?? '',
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
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
                                item.status?.toUpperCase() ?? '',
                                style: TextStyle(
                                  color: item.status == 'lost' ? Colors.red : Colors.green,
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
        onPressed: () {
          Navigator.pushNamed(context, '/report');
        },
        backgroundColor: Colors.teal,
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
        setState(() {
          selectedFilter = value;
        });
        fetchItems();
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: isSelected ? Colors.teal : Colors.grey.shade200,
        foregroundColor: isSelected ? Colors.white : Colors.black,
      ),
      child: Text(label),
    );
  }
}
