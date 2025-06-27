import 'package:chat_app/screens/chat_screen.dart';
import 'package:chat_app/services/chat_service.dart';
import 'package:chat_app/widgets/drawer_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../auth/auth_service.dart';
import '../widgets/user_tile.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  // Get the current authenticated user from Firebase
  final User? user = FirebaseAuth.instance.currentUser;
  // Instance of ChatService for fetching user data
  final ChatService chatService = ChatService();
  // Instance of AuthService for accessing the current user
  final AuthService authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: Text(
          "Home",
          style: TextStyle().copyWith(
            color: Theme.of(context).colorScheme.tertiary,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(
          color: Theme.of(context).colorScheme.tertiary,
        ),
      ),
      body: user == null
          ? const Center(child: Text("No user signed in"))
          : _buildUserData(),
      drawer: DrawerWidget(),
    );
  }

  // Build the user list using a StreamBuilder to fetch real-time user data
  Widget _buildUserData() {
    return StreamBuilder(
      stream: chatService.getUsersStream(),
      builder: (context, snapshot) {

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        // Handle errors in the stream
        if (snapshot.hasError) {
          return const Center(child: Text("Error loading user data"));
        }
        // Handle case where no user data is available
        if (!snapshot.hasData) {
          return const Center(child: Text("User data not found"));
        }

        return ListView(
          children: snapshot.data!
              .map<Widget>((userData) => _buildUserList(userData, context))
              .toList(),
        );
      },
    );
  }

  // Build a single user list item, excluding the current user
  Widget _buildUserList(Map<String, dynamic> userData, BuildContext context) {
    if (userData['email'] != authService.getCurrentUser()!.email) {
      return UserTile(
        text: userData['email'],
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ChatScreen(
                receiverEmail: userData['email'],
                receiverID: userData['uid'],
              ),
            ),
          );
        },
      );
    } else {
      return Container();
    }
  }
}