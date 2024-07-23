// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:flutter_coder/features/converter/components/info_tab.dart';

class CodeTabBar extends StatelessWidget {
  final int currentIndex;
  final List<String> tabNames;
  final void Function(int index) onTabChange;
  const CodeTabBar({
    super.key,
    required this.tabNames,
    required this.onTabChange,
    required this.currentIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        children: List.generate(tabNames.length, (index) {
          final tabName = tabNames[index];
          return Expanded(
            child: InfoTab(
                tabName: tabName,
                selected: currentIndex == index,
                isLast: index == tabNames.length - 1,
                onTap: () {
                  onTabChange(index);
                }),
          );
        }),
      ),
    );
  }
}
