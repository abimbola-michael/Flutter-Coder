import 'package:flutter/material.dart';
import 'package:flutter_coder/features/converter/components/svg_asset.dart';
import 'package:flutter_coder/features/shared/utils/colors.dart';

class SwitchThumb extends StatelessWidget {
  final String theme;
  final String currentTheme;
  final VoidCallback onPressed;
  const SwitchThumb(
      {super.key,
      required this.theme,
      required this.onPressed,
      required this.currentTheme});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 34,
        height: 34,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          // color: theme == currentTheme ? Colors.white : Colors.transparent,
          boxShadow: theme == currentTheme
              ? [
                  BoxShadow(
                    blurRadius: 3.33,
                    offset: const Offset(0, 1.6),
                    color: Colors.black.withOpacity(0.06),
                  ),
                  BoxShadow(
                    blurRadius: 5,
                    offset: const Offset(0, 1.6),
                    color: Colors.black.withOpacity(0.01),
                  ),
                ]
              : null,
        ),
        child: SvgAsset(
          name: theme == currentTheme ? "${theme}_fill" : theme,
          size: 18,
          useTint: theme != currentTheme,
          color: theme != currentTheme ? lighterTint : null,
        ),
      ),
    );
  }
}
