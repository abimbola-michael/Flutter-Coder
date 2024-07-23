import 'package:flutter/material.dart';
import 'package:flutter_coder/features/shared/utils/extensions.dart';

class InfoItem extends StatelessWidget {
  final String type;
  final void Function(String code) onGenerateCode;
  const InfoItem({super.key, required this.type, required this.onGenerateCode});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 20,
        ),
        Text(
          type.capitalize(),
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        const SizedBox(
          height: 20,
        ),
        TextField(
          maxLines: 10,
          decoration: InputDecoration(
            hintText: 'Enter the $type details here',
            border: const UnderlineInputBorder(),
          ),
          onChanged: (value) {
            onGenerateCode(value);
          },
        ),
        const SizedBox(
          height: 20,
        ),
        const Divider(),
      ],
    );
  }
}
