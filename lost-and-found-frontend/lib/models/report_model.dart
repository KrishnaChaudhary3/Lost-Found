// lib/models/report_model.dart
class ReportModel {
  final String? id;
  final String? title;
  final String? description;
  final String? type;
  final String? location;
  final String? category;
  final String? reporterName;
  final String? reporterEmail;

  ReportModel({
    this.id,
    this.title,
    this.description,
    this.type,
    this.location,
    this.category,
    this.reporterName,
    this.reporterEmail,
  });

  factory ReportModel.fromJson(Map<String, dynamic> json) {
    return ReportModel(
      id: json['_id'],
      title: json['title'],
      description: json['description'],
      type: json['type'],
      location: json['location'],
      category: json['category'],
      reporterName: json['reporterName'],
      reporterEmail: json['reporterEmail'],
    );
  }
}
