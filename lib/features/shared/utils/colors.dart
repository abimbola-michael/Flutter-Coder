import 'package:flutter/material.dart';

import '../../converter/utils/utils.dart';

Color get lightTint => isDarkMode ? Colors.white : const Color(0xFF0C0A0A);
Color get lighterTint => isDarkMode
    ? Colors.white.withOpacity(0.5)
    : const Color(0xFF0C0A0A).withOpacity(0.5);

Color get lightestTint =>
    isDarkMode ? const Color(0xFF232222) : const Color(0xFFE8E8E8);
Color get onBgColor => isDarkMode ? const Color(0xFF1E1E1E) : Colors.white;

Color get bgColor => !isDarkMode ? Colors.white : const Color(0xFF0C0A0A);

Color appColor = Colors.deepPurple;

Color nameColor = Colors.blue;
Color reserveColor = Colors.deepPurple;
Color valueColor = Colors.red;
Color lineNumColor = Colors.orange;

Color white = Colors.white;
Color lightWhite = Colors.white.withOpacity(0.8);
Color lighterWhite = Colors.white.withOpacity(0.5);
Color lightestWhite = Colors.white.withOpacity(0.05);

Color black = Colors.black;
Color lightBlack = Colors.black.withOpacity(0.8);
Color lighterBlack = Colors.black.withOpacity(0.5);
Color lightestBlack = Colors.black.withOpacity(0.05);
