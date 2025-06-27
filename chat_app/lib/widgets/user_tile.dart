import 'package:flutter/material.dart';

class UserTile extends StatelessWidget {
  final String text;
  final void Function()? onTap;
  const UserTile({super.key, required this.text, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.all(10),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Icon(Icons.account_circle, size: 50),

            const SizedBox(width: 10),

            Text(
              text,
              style:
              TextStyle(
                fontSize: 16
              ).copyWith(
                color: Theme.of(context).colorScheme.tertiary,
              ),
            ),

            const SizedBox(width: 80),

            const Icon(Icons.arrow_forward_ios_sharp, size: 20),

          ],
        ),
      ),
    );
  }
}
