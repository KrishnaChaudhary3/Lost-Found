import '../models/item_models.dart';

final List<ItemModel> mockItems = [
  ItemModel(
    id: '1',
    name: 'Alice',
    title: 'Black Wallet',
    description: 'Lost near the canteen. Contains ID and credit cards.',
    location: 'Canteen',
    status: 'lost',
    imageUrl: 'https://via.placeholder.com/150/000000/FFFFFF?text=Wallet',
    date: DateTime(2025, 7, 18, 10, 30),
    type: 'Wallet',
  ),
  ItemModel(
    id: '2',
    name: 'Bob',
    title: 'Silver Ring',
    description: 'Found near the main gate, looks expensive.',
    location: 'Main Gate',
    status: 'found',
    imageUrl: 'https://via.placeholder.com/150/C0C0C0/000000?text=Ring',
    date: DateTime(2025, 7, 19, 14, 45),
    type: 'Jewelry',
  ),
  ItemModel(
    id: '3',
    name: 'Charlie',
    title: 'Blue Backpack',
    description: 'Lost in library, contains books and laptop charger.',
    location: 'Library',
    status: 'lost',
    imageUrl: 'https://via.placeholder.com/150/0000FF/FFFFFF?text=Backpack',
    date: DateTime(2025, 7, 16, 9, 0),
    type: 'Bag',
  ),
  ItemModel(
    id: '4',
    name: 'Diana',
    title: 'iPhone 12',
    description: 'Found on 3rd floor corridor, unlocked screen.',
    location: '3rd Floor Corridor',
    status: 'found',
    imageUrl: 'https://via.placeholder.com/150/FF0000/FFFFFF?text=Phone',
    date: DateTime(2025, 7, 21, 17, 15),
    type: 'Electronics',
  ),
  ItemModel(
    id: '5',
    name: 'Ethan',
    title: 'Keys with Red Keychain',
    description: 'Lost near parking lot, with multiple keys.',
    location: 'Parking Lot',
    status: 'lost',
    imageUrl: 'https://via.placeholder.com/150/FF4500/FFFFFF?text=Keys',
    date: DateTime(2025, 7, 17, 12, 0),
    type: 'Keys',
  ),
];






// import '../models/item_models.dart';
//
// final List<ItemModel> mockItems = [
//   ItemModel(
//     title: 'Black Wallet',
//     description: 'Lost near the canteen. Has ID inside.',
//     status: 'lost',
//     imageUrl: 'https://via.placeholder.com/150',
//   ),
//   ItemModel(
//     title: 'Phone Found',
//     description: 'Found a phone at the library table.',
//     status: 'found',
//     imageUrl: 'https://via.placeholder.com/150',
//   ),
//   ItemModel(
//     title: 'Umbrella',
//     description: 'Black umbrella left in the lab.',
//     status: 'lost',
//     imageUrl: 'https://via.placeholder.com/150',
//   ),
// ];
