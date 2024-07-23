// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class InfoTab extends StatelessWidget {
  final String tabName;
  final bool selected;
  final bool isLast;
  final void Function() onTap;
  const InfoTab({
    Key? key,
    required this.tabName,
    required this.selected,
    required this.isLast,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(tabName,
              style: TextStyle(color: selected ? Colors.deepPurple : null)),
          if (!isLast)
            const SizedBox(
              width: 20,
            )
        ],
      ),
    );
  }
}
