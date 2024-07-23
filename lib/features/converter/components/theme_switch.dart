// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'switch_thumb.dart';

class ThemeSwitch extends StatefulWidget {
  final String theme;
  final void Function(String theme) onChange;
  const ThemeSwitch({
    Key? key,
    required this.theme,
    required this.onChange,
  }) : super(key: key);

  @override
  State<ThemeSwitch> createState() => _ThemeSwitchState();
}

class _ThemeSwitchState extends State<ThemeSwitch> {
  String theme = "";
  @override
  void initState() {
    super.initState();
    theme = widget.theme;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: dialogBg,
      padding: const EdgeInsets.all(4),
      margin: const EdgeInsets.symmetric(horizontal: 12),

      decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SwitchThumb(
            currentTheme: theme,
            theme: "dark",
            onPressed: () {
              setState(() {
                theme = "dark";
              });
              widget.onChange(theme);
            },
          ),
          const SizedBox(
            width: 12,
          ),
          SwitchThumb(
            currentTheme: theme,
            theme: "light",
            onPressed: () {
              setState(() {
                theme = "light";
              });
              widget.onChange(theme);
            },
          ),
        ],
      ),
    );
  }
}
