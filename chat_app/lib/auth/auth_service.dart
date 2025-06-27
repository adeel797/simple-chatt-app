import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

// Service class to handle authentication-related operations
class AuthService {
  // Instance of FirebaseAuth for authentication operations
  final FirebaseAuth auth = FirebaseAuth.instance;
  // Instance of FirebaseFirestore for database operations
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  // Get the currently authenticated user, returns null if no user is signed in
  User? getCurrentUser() {
    return auth.currentUser;
  }

  // Login with email and password
  Future<UserCredential> signInWithEmailPassword(String email, String password) async {
    // Validate that email and password are not empty
    if (email.isEmpty || password.isEmpty) {
      throw Exception('Email and password cannot be empty');
    }
    try {
      // Attempt to sign in with Firebase Authentication
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );
      return userCredential;
    } on FirebaseAuthException catch (e) {
      // Handle Firebase-specific authentication errors
      throw Exception('Sign-in failed: ${e.code} - ${e.message}');
    } catch (e) {
      // Handle any other unexpected errors
      throw Exception('Unexpected error during sign-in: $e');
    }
  }

  // Sign up with email and password
  Future<UserCredential> signUpWithEmailPassword(String email, String password) async {
    // Validate that email and password are not empty
    if (email.isEmpty || password.isEmpty) {
      throw Exception('Email and password cannot be empty');
    }
    // Ensure password meets minimum length requirement
    if (password.length < 6) {
      throw Exception('Password must be at least 6 characters');
    }
    try {

      // Create a new user with Firebase Authentication
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );

      // Store user data in Firestore under the 'users' collection
      await firestore.collection('users').doc(userCredential.user!.uid).set({
        'uid': userCredential.user!.uid,
        'email': email.trim(),
        'createdAt': FieldValue.serverTimestamp(),
      });
      return userCredential;
    } on FirebaseAuthException catch (e) {
      // Handle Firebase-specific authentication errors
      throw Exception('Sign-up failed: ${e.code} - ${e.message}');
    } catch (e) {
      // Handle any other unexpected errors
      throw Exception('Unexpected error during sign-up: $e');
    }
  }

  // Logout the current user
  Future<void> logout() async {
    try {
      // Sign out the user from Firebase Authentication
      await auth.signOut();
    } catch (e) {
      // Handle any errors during logout
      throw Exception('Logout failed: $e');
    }
  }
}