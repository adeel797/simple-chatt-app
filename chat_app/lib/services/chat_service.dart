import 'package:chat_app/model/message_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class ChatService {
  // Instance of Firebase Firestore for database operations
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  // Instance of Firebase Authentication for user data
  final FirebaseAuth auth = FirebaseAuth.instance;

  // Stream to fetch a list of all users from Firestore
  Stream<List<Map<String, dynamic>>> getUsersStream() {
    return firestore.collection('users').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        final user = doc.data();
        return user;
      }).toList();
    });
  }

  // Send a message to another user and trigger a notification
  Future<void> sendMessage(String receiverID, String message) async {
    // Get current user's ID and email
    final String currentUserID = auth.currentUser!.uid;
    final String currentUserEmail = auth.currentUser!.email!;
    final Timestamp timestamp = Timestamp.now();

    // Create a new message instance
    MessageModel newMessage = MessageModel(
      senderID: currentUserID,
      senderEmail: currentUserEmail,
      receiverID: receiverID,
      message: message,
      timestamp: timestamp,
    );

    // Construct a unique chat room ID by sorting user IDs
    List<String> ids = [currentUserID, receiverID];
    ids.sort();
    String chatRoomID = ids.join('_');

    // Add the new message to Firestore
    await firestore
        .collection("chat_rooms")
        .doc(chatRoomID)
        .collection("messages")
        .add(newMessage.toMap());
  }

  // Stream to fetch messages between two users
  Stream<QuerySnapshot> getMessages(String userID, String otherUserID) {
    // Construct a unique chat room ID by sorting user IDs
    List<String> ids = [userID, otherUserID];
    ids.sort();
    String chatRoomID = ids.join('_');

    return firestore
        .collection("chat_rooms")
        .doc(chatRoomID)
        .collection("messages")
        .orderBy("timestamp", descending: true)
        .snapshots();
  }
}