# 💬 Simple-Chatt-App

A professional, real-time chat application built with **Flutter** and **Firebase**. This app provides secure user authentication, persistent login, real-time messaging, light/dark theme switching, and a homepage displaying all users. Designed for a seamless and responsive user experience.

## ✨ Features

- **🔐 Firebase Authentication**: Secure login with Google Sign-In.
- **🔄 Persistent Login**: Users remain logged in across sessions.
- **💬 Real-Time Messaging**: Send and receive messages instantly using Cloud Firestore.
- **🌗 Theme Switching**: Toggle between light and dark themes.
- **👥 User Homepage**: Displays a list of all registered users.
- **📱 Responsive Design**: Optimized for mobile devices.

## 🛠️ Tech Stack

- **Flutter**: Cross-platform framework for building the UI.
- **Firebase**: Authentication, Cloud Firestore for data and chat storage.
- **Dart**: Programming language for app logic.

## 🚀 Getting Started

### Prerequisites

- Flutter SDK (v3.0 or higher)
- Firebase account and project
- Git

### Installation

1. **Clone the Repository**:
   ```bash
   git clone https://github.com/adeel797/simple-chatt-app.git
   cd simple-chatt-app
   ```

2. **Install Dependencies**:
   ```bash
   flutter pub get
   ```

3. **Set Up Firebase Project**:
   - Create a Firebase project in the [Firebase Console](https://console.firebase.google.com/).
   - Enable **Google Sign-In** in the Authentication section.
   - Set up **Cloud Firestore** for storing user data and chats:
     - Go to the Firestore Database section and create a new database in test mode (or production mode as needed).
     - Define a collection structure (e.g., `users` for user data and `chats` for messages).
   - Add Firebase configuration to `firebase_options.dart` by following the FlutterFire setup instructions.
   - Initialize Firebase in your app using the configured `firebase_options.dart`.

4. **Run the App**:
   ```bash
   flutter run
   ```

## 📂 Project Structure

```
├── lib
│   ├── auth
│   │   ├── auth_gate.dart
│   │   ├── auth_service.dart
│   │   └── login_or_register.dart
│   ├── model
│   │   └── message_model.dart
│   ├── screens
│   │   ├── chat_screen.dart
│   │   ├── home_screen.dart
│   │   ├── login_screen.dart
│   │   ├── register_screen.dart
│   │   └── settings_screen.dart
│   ├── services
│   │   └── chat_service.dart
│   ├── theme
│   │   ├── dark_mode.dart
│   │   ├── light_mode.dart
│   │   └── theme_provider.dart
│   ├── widgets
│   │   └── firebase_options.dart
│   ├── main.dart
│   └── test
│       └── widget_test.dart
```

## 🛠️ Usage

1. **Sign In**: Log in using Email and Password via the login screen.
2. **View Users**: Access the homepage to see all registered users.
3. **Chat**: Navigate to the chat screen to send/receive messages in real-time, stored in Cloud Firestore.
4. **Switch Themes**: Use the settings screen to toggle between light and dark modes.

## 🤝 Contributing
Feel free to submit issues or pull requests for improvements or bug fixes. Your contributions are welcome! 😊

## 🙏 Acknowledgments

- [Firebase](https://firebase.google.com/) for backend services.
- [Flutter](https://flutter.dev/) for the cross-platform framework.
