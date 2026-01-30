















class ItemModel {
  final String? id;           // MongoDB ID (optional for POST)
  final String? name;         // User name
  final String? title;        // Item title
  final String? description;  // Item description
  final String? location;     // Where it was lost/found
  final String? status;       // 'lost' or 'found'
  final String? imageUrl;     // Optional image
  final DateTime? date;       // Report date
  final String? type;



  ItemModel({
    this.id,
    this.name,
    this.title,
    this.description,
    this.location,
    this.status,
    this.imageUrl,
    this.date,
    this.type
  });

  // 🔁 From JSON (backend → app)
  factory ItemModel.fromJson(Map<String, dynamic> json) {
    return ItemModel(
      id: json['_id'],
      name: json['name'],
      title: json['title'],
      description: json['description'],
      location: json['location'],
      status: json['status'],
      imageUrl: json['imageUrl'],
      date: json['date'] != null ? DateTime.parse(json['date']) : null,
    );
  }

  // 🔁 To JSON (app → backend)
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'title': title,
      'description': description,
      'location': location,
      'status': status,
      'imageUrl': imageUrl,
      'date': date?.toIso8601String(),
    };
  }
}
