import 'package:flutter/material.dart';
import 'package:flutter_coder/features/shared/utils/extensions.dart';

class ActionButton extends StatelessWidget {
  final Color color;
  final String title;
  final VoidCallback onPressed;
  const ActionButton(
      {super.key,
      this.color = Colors.purple,
      required this.title,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        margin: const EdgeInsets.all(6),
        decoration: BoxDecoration(
            color: color, borderRadius: BorderRadius.circular(20)),
        child: Text(
          title,
          style: context.bodySmall?.copyWith(color: Colors.white),
        ),
      ),
    );
  }
}
