// Import authentication service for user data
import 'package:chat_app/auth/auth_service.dart';
// Import chat service for sending and receiving messages
import 'package:chat_app/services/chat_service.dart';
// Import custom chat bubble widget for displaying messages
import 'package:chat_app/widgets/chat_bubble.dart';
// Import Cloud Firestore for real-time message data
import 'package:cloud_firestore/cloud_firestore.dart';
// Import Flutter's Material Design library for UI components
import 'package:flutter/material.dart';

// Stateless widget for the chat screen to display messages and input field
class ChatScreen extends StatelessWidget {
  // Email of the message receiver
  final String receiverEmail;
  // Unique ID of the message receiver
  final String receiverID;

  // Constructor with required receiver email and ID
  ChatScreen({
    super.key,
    required this.receiverEmail,
    required this.receiverID,
  });

  // Controller for the message input field
  final TextEditingController messageController = TextEditingController();
  // Instance of ChatService for handling message operations
  final ChatService chatService = ChatService();
  // Instance of AuthService for accessing the current user
  final AuthService authService = AuthService();

  // Function to send a message
  void sendMessage() async {
    // Check if the message input is not empty
    if (messageController.text.isNotEmpty) {
      String message = messageController.text; // Store the message
      messageController.clear(); // Clear the input field immediately
      try {
        // Send the message using ChatService
        await chatService.sendMessage(receiverID, message);
      } catch (e) {
        // Log any errors during message sending
        print('Error sending message: $e');
        // Optionally show error to user (not implemented here)
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // Build the main scaffold for the chat screen
    return Scaffold(
      // Set background color based on the current theme
      backgroundColor: Theme.of(context).colorScheme.background,
      // App bar with receiver's email and transparent styling
      appBar: AppBar(
        title: Text(
          receiverEmail,
          style: TextStyle().copyWith(
            color: Theme.of(context).colorScheme.tertiary,
          ),
        ),
        centerTitle: true, // Center the title
        backgroundColor: Colors.transparent, // Transparent background
        surfaceTintColor: Colors.transparent, // Remove surface tint
        shadowColor: Colors.transparent, // Remove shadow
        elevation: 0, // No elevation
        iconTheme: IconThemeData(
          color: Theme.of(context).colorScheme.tertiary, // Icon color
        ),
      ),
      // Column to hold the message list and input field
      body: Column(
        children: [
          // Expanded widget to display the message list
          Expanded(child: _buildMessageList()),
          // Widget for the user input field
          _buildUserInput(context),
        ],
      ),
    );
  }

  // Build the list of messages using a StreamBuilder
  Widget _buildMessageList() {
    // Get the current user's ID
    String senderID = authService.getCurrentUser()!.uid;
    return StreamBuilder(
      // Stream to fetch messages between sender and receiver
      stream: chatService.getMessages(receiverID, senderID),
      builder: (context, snapshot) {
        // Handle errors in the stream
        if (snapshot.hasError) {
          return const Text("Error");
        }
        // Show loading text while waiting for data
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text("Loading");
        }
        // Display messages in a reversed ListView (newest at bottom)
        return ListView(
          reverse: true,
          children: snapshot.data!.docs
              .map((doc) => _buildMessageItem(doc))
              .toList(),
        );
      },
    );
  }

  // Build a single message item from a Firestore document
  Widget _buildMessageItem(DocumentSnapshot doc) {
    // Cast document data to a map
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

    // Check if the message was sent by the current user
    bool isCurrentUser = data['senderID'] == authService.getCurrentUser()!.uid;

    // Align message to the right for the current user, left for others
    var alignment = isCurrentUser ? Alignment.centerRight : Alignment.centerLeft;
    return Container(
      alignment: alignment,
      // Use ChatBubble widget to display the message
      child: ChatBubble(message: data['message'], isCurrentUser: isCurrentUser),
    );
  }

  // Build the user input field for sending messages
  Widget _buildUserInput(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0), // Padding around the input area
      child: Row(
        children: [
          // Expanded TextField for message input
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface, // Background color
                borderRadius: BorderRadius.circular(25.0), // Rounded corners
                border: Border.all(
                  color: Theme.of(context).colorScheme.tertiary.withOpacity(0.3), // Subtle border
                  width: 1.0,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05), // Subtle shadow
                    blurRadius: 8.0,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: TextField(
                controller: messageController, // Bind the controller
                decoration: InputDecoration(
                  hintText: "Type a message...", // Updated hint text for clarity
                  hintStyle: TextStyle().copyWith(
                    color: Theme.of(context).colorScheme.tertiary.withOpacity(0.6), // Subtle hint color
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 20.0,
                    vertical: 15.0,
                  ), // Padding inside the text field
                  border: InputBorder.none, // Remove default border
                ),
              ),
            ),
          ),
          const SizedBox(width: 10.0), // Space between text field and send button
          // Send button with styled icon
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle, // Circular button
              color: Theme.of(context).colorScheme.primary.withOpacity(0.1), // Subtle background
            ),
            child: IconButton(
              onPressed: sendMessage, // Call sendMessage on tap
              icon: Icon(
                Icons.send,
                color: Theme.of(context).colorScheme.tertiary, // Icon color
                size: 28.0, // Slightly larger icon
              ),
              padding: const EdgeInsets.all(12.0), // Padding for the button
            ),
          ),
        ],
      ),
    );
  }
}