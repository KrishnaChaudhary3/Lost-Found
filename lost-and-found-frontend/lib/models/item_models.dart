class ItemModel {
  final String? id;
  final String? name;
  final String? title;
  final String? description;
  final String? location;
  final double? lat;
  final double? lng;
  final String? status;      // 'lost' or 'found'
  final String? imageUrl;
  final DateTime? date;
  final String? type;

  ItemModel({
    this.id,
    this.name,
    this.title,
    this.description,
    this.location,
    this.lat,
    this.lng,
    this.status,
    this.imageUrl,
    this.date,
    this.type,
  });

  factory ItemModel.fromJson(Map<String, dynamic> json) {
    return ItemModel(
      id: json['_id'],
      name: json['name'],
      title: json['title'],
      description: json['description'],
      location: json['location'],
      lat: (json['lat'] as num?)?.toDouble(),
      lng: (json['lng'] as num?)?.toDouble(),
      status: json['status'] ?? json['type'],
      imageUrl: json['imageUrl'],
      date: json['date'] != null ? DateTime.tryParse(json['date']) : null,
      type: json['type'], // ✅ FIX: this was missing before, always came back null
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'title': title,
      'description': description,
      'location': location,
      'lat': lat,
      'lng': lng,
      'type': type ?? status,
      'imageUrl': imageUrl,
      'date': date?.toIso8601String(),
    };
  }
}
