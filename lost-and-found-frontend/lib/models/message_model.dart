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

  // From JSON (when receiving from backend)
  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      id: json['_id'],
      sender: json['sender'],
      receiver: json['receiver'],
      message: json['message'],
      timestamp: DateTime.parse(json['timestamp']),
    );
  }

  // To JSON (when sending to backend)
  Map<String, dynamic> toJson() {
    return {
      'sender': sender,
      'receiver': receiver,
      'message': message,
      'timestamp': timestamp.toIso8601String(),
    };
  }
}
