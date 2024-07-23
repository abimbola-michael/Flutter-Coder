import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_coder/features/converter/components/info_item.dart';
import 'package:flutter_coder/features/converter/components/code_tab_bar.dart';

class InfoView extends StatefulWidget {
  final void Function(String type, String code) onGenerateCode;

  const InfoView({super.key, required this.onGenerateCode});

  @override
  State<InfoView> createState() => _InfoViewState();
}

class _InfoViewState extends State<InfoView> {
  List<String> containerItems = ["Layout", "Colors", "Borders", "Shadows"];
  List<String> textItems = ["Layout", "Content", "Typography", "Colors"];
  String currentTab = "Container";

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // InfoTabBar(onTabChange: (tabName) {
        //   setState(() {
        //     currentTab = tabName;
        //   });
        // }),
        const Divider(),
        Expanded(
          child: ListView(
            children: List.generate(
                currentTab == "Container"
                    ? containerItems.length
                    : textItems.length, (index) {
              final item = currentTab == "Container"
                  ? containerItems[index]
                  : textItems[index];

              return InfoItem(
                  type: item,
                  onGenerateCode: (text) {
                    widget.onGenerateCode(item, text);
                  });
            }),
          ),
        ),
      ],
    );
  }
}
