import 'package:chat_app/theme/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatBubble extends StatelessWidget {
  final String message;
  final bool isCurrentUser;

  const ChatBubble({
    super.key,
    required this.message,
    required this.isCurrentUser,
  });

  @override
  Widget build(BuildContext context) {
    // Get 75% of screen width
    final maxBubbleWidth = MediaQuery.of(context).size.width * 0.75;

    bool isDarkMode = Provider.of<ThemeProvider>(context,listen: false).isDarkMode;

    return Align(
      alignment:
      isCurrentUser ? Alignment.centerRight : Alignment.centerLeft,
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: maxBubbleWidth),
        child: Container(
          decoration: BoxDecoration(
            color: isCurrentUser
                ? (isDarkMode ? Colors.grey.shade600 : Colors.black)
                : (isDarkMode ? Colors.grey : Colors.grey.shade300),
            borderRadius: BorderRadius.only(
              topLeft: const Radius.circular(12),
              topRight: const Radius.circular(12),
              bottomLeft:
              isCurrentUser ? const Radius.circular(12) : Radius.zero,
              bottomRight:
              isCurrentUser ? Radius.zero : const Radius.circular(12),
            ),
          ),
          padding: const EdgeInsets.all(12),
          margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
          child: Text(
            message,
            style: TextStyle(
              color: isCurrentUser ? Colors.white : Colors.black,
              fontSize: 16,
            ),
            softWrap: true,
          ),
        ),
      ),
    );
  }
}
