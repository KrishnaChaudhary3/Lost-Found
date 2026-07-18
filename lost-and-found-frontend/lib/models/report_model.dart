class ReportModel {
  final String? id;
  final String? title;
  final String? description;
  final String? type;
  final String? location;
  final double? lat;
  final double? lng;
  final String? imageUrl;
  final String? category;
  final String? reporterName;
  final String? reporterEmail;
  final String? user; // the reporter's user ID — needed to start a chat with them

  ReportModel({
    this.id,
    this.title,
    this.description,
    this.type,
    this.location,
    this.lat,
    this.lng,
    this.imageUrl,
    this.category,
    this.reporterName,
    this.reporterEmail,
    this.user,
  });

  factory ReportModel.fromJson(Map<String, dynamic> json) {
    return ReportModel(
      id: json['_id'],
      title: json['title'],
      description: json['description'],
      type: json['type'],
      location: json['location'],
      lat: (json['lat'] as num?)?.toDouble(),
      lng: (json['lng'] as num?)?.toDouble(),
      imageUrl: json['imageUrl'],
      category: json['category'],
      reporterName: json['reporterName'],
      reporterEmail: json['reporterEmail'],
      user: json['user'] is Map ? json['user']['_id'] : json['user'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'type': type,
      'location': location,
      'lat': lat,
      'lng': lng,
      'imageUrl': imageUrl,
      'category': category,
    };
  }
}
