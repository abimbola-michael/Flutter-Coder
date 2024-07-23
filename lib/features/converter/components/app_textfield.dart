import 'package:flutter/material.dart';
import 'package:flutter_coder/features/shared/utils/extensions.dart';

class AppTextField extends StatelessWidget {
  final TextEditingController controller;
  final Function(String value)? onChanged;
  final String title;
  const AppTextField(
      {super.key,
      required this.controller,
      this.onChanged,
      required this.title});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          title,
          style: context.bodyLarge,
        ),
        const SizedBox(
          width: 10,
        ),
        SizedBox(
          width: 60,
          height: 40,
          child: TextField(
            controller: controller,
            decoration: InputDecoration(
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
                hintText: title,
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 0)),
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
            maxLines: 1,
            onChanged: onChanged,
          ),
        ),
      ],
    );
  }
}
