import 'package:cloud_firestore/cloud_firestore.dart';

class MessageModel {
  final String senderID;
  final String senderEmail;
  final String receiverID;
  final String message;
  final Timestamp timestamp;

  // Constructor with required fields for creating a MessageModel instance
  MessageModel({
    required this.senderID,
    required this.senderEmail,
    required this.receiverID,
    required this.message,
    required this.timestamp,
  });

  // Convert the MessageModel instance to a map for Firestore storage
  Map<String, dynamic> toMap() {
    return {
      'senderID': senderID, // Store sender's ID
      'senderEmail': senderEmail, // Store sender's email
      'receiverID': receiverID, // Store receiver's ID
      'message': message, // Store message content
      'timestamp': timestamp, // Store message timestamp
    };
  }
}