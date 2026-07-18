


import '../models/item_models.dart';

final List<ItemModel> mockItems = [
  ItemModel(
    id: '1',
    name: 'Alice',
    title: 'Black Wallet',
    description: 'Lost near the canteen. Contains ID and credit cards.',
    location: 'Canteen',
    type: 'lost',
    imageUrl: 'https://via.placeholder.com/150/000000/FFFFFF?text=Wallet',
    date: DateTime(2025, 7, 18, 10, 30),
  ),
  ItemModel(
    id: '2',
    name: 'Bob',
    title: 'Silver Ring',
    description: 'Found near the main gate, looks expensive.',
    location: 'Main Gate',
    type: 'found',
    imageUrl: 'https://via.placeholder.com/150/C0C0C0/000000?text=Ring',
    date: DateTime(2025, 7, 19, 14, 45),
  ),
  ItemModel(
    id: '3',
    name: 'Charlie',
    title: 'Blue Backpack',
    description: 'Lost in library, contains books and laptop charger.',
    location: 'Library',
    type: 'lost',
    imageUrl: 'https://via.placeholder.com/150/0000FF/FFFFFF?text=Backpack',
    date: DateTime(2025, 7, 16, 9, 0),
  ),
];
