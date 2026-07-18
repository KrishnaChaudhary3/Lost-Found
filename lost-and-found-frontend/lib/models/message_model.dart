class MessageModel {
  final String id;
  final String sender;
  final String receiver;
  final String message;
  final DateTime timestamp;

  MessageModel({
    required this.id,
    required this.sender,
    required this.receiver,
    required this.message,
    required this.timestamp,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      id: json['_id'] ?? '',
      sender: json['sender'] ?? '',
      receiver: json['receiver'] ?? '',
      message: json['content'] ?? json['message'] ?? '', // ✅ FIX: backend uses 'content'
      timestamp: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'])
          : (json['timestamp'] != null ? DateTime.parse(json['timestamp']) : DateTime.now()),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'sender': sender,
      'receiver': receiver,
      'content': message,
    };
  }
}
