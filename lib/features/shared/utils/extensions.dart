import 'package:flutter/material.dart';
import 'package:flutter_coder/main.dart';

extension ContextExtension on BuildContext {
  double get statusBarHeight => MediaQuery.of(this).padding.top;
  ThemeData get theme => Theme.of(this);
  double get height => MediaQuery.of(this).size.height;
  double get width => MediaQuery.of(this).size.width;
  double heightPercent(double percent, [double? subtract]) =>
      (height - (subtract ?? 0)) * percent / 100;
  double widthPercent(double percent, [double? subtract]) =>
      (width - (subtract ?? 0)) * percent / 100;
  Color? get iconColor => Theme.of(this).iconTheme.color;
  TextStyle? get bodyLarge => Theme.of(this).textTheme.bodyLarge;
  TextStyle? get bodyMedium => Theme.of(this).textTheme.bodyMedium;
  TextStyle? get bodySmall => Theme.of(this).textTheme.bodySmall;
  TextStyle? get headlineLarge => Theme.of(this).textTheme.headlineLarge;
  TextStyle? get headlineMedium => Theme.of(this).textTheme.headlineMedium;
  TextStyle? get headlineSmall => Theme.of(this).textTheme.headlineSmall;
  pushTo(Widget page) =>
      Navigator.of(this).push(MaterialPageRoute(builder: (context) => page));
  pushNamedTo(String routeName) => Navigator.of(this).pushNamed(routeName);
  pushAndPop(Widget page, [result]) => Navigator.of(this)
      .pushReplacement(MaterialPageRoute(builder: (context) => page));
  pushNamedAndPop(String routeName, [result]) =>
      Navigator.of(this).pushReplacementNamed(routeName);
  pop([result]) => Navigator.of(this).pop(result);
  popUntil(String routeName) =>
      Navigator.of(this).popUntil(ModalRoute.withName(routeName));
  pushReplacementTo(Widget page) => Navigator.of(this)
      .pushReplacement(MaterialPageRoute(builder: (context) => page));

  // void showComfirmationSnackbar(String message) {
  //   ScaffoldMessenger.of(this).showSnackBar(
  //     SnackBar(
  //       content: Text(message, style: bodySmall?.copyWith(color: Colors.white)),
  //       //behavior: SnackBarBehavior.floating,
  //       backgroundColor: grey.withOpacity(0.95),
  //       shape: RoundedRectangleBorder(
  //         borderRadius: BorderRadius.circular(10),
  //       ),
  //     ),
  //   );
  // }
}

extension StringExtension on String {
  List<String> customSplit(String splitChar) {
    Map<String, String> braces = {
      "{": "}",
      "[": "]",
      "(": ")",
      "<": ">",
      "'": "'",
      "\"": "\"",
      "`": "`"
    };
    String foundBrace = "";
    int braceCount = 0;
    List<String> strings = [];
    String currentString = "";
    // String currentSplitString = "";
    for (int i = 0; i < length; i++) {
      final char = this[i];

      if (char == splitChar && braceCount == 0) {
        if (currentString.trim().isNotEmpty) {
          strings.add(currentString.trim());
          currentString = "";
        }
      } else {
        currentString += char;
      }

      if (foundBrace.isNotEmpty) {
        final closeBrace = braces[foundBrace];
        if (char == closeBrace) {
          braceCount--;
        } else if (char == foundBrace) {
          braceCount++;
        }
        if (braceCount == 0) {
          foundBrace = "";
        }
      } else {
        final brace = braces[char];
        if (brace != null && splitChar != char) {
          foundBrace = char;
          braceCount++;
        }
      }
    }
    if (currentString.trim().isNotEmpty) {
      strings.add(currentString.trim());
      currentString = "";
    }
    return strings;
  }

  String get toCamelCase {
    if (!contains("-")) return this;
    List<String> strings = split("-");
    String newString = strings[0];
    for (int i = 1; i < strings.length; i++) {
      newString += strings[i].capitalize();
    }
    return newString;
  }

  String capitalize() {
    return isEmpty ? "" : "${this[0].toUpperCase()}${substring(1)}";
  }

  bool get isFinite {
    if ((double.tryParse(this) != null && double.parse(this) == 0) ||
        (int.tryParse(this) != null && int.parse(this) == 0)) {
      return false;
    }
    return true;
  }

  String setAttribute(String name,
      [String value = "", String exceptValue = ""]) {
    if (this == exceptValue ||
        (double.tryParse(this) != null && double.parse(this) == 0) ||
        (int.tryParse(this) != null && int.parse(this) == 0)) {
      return "";
    }
    return "$name: ${value.isEmpty ? this : value},\n";
  }

  double get toDouble {
    final values = toValues;
    if (values.isEmpty) return -1;
    String string = values.last;
    if (double.tryParse(string) != null) {
      return double.parse(string);
    } else if (int.tryParse(string) != null) {
      return int.parse(string).toDouble();
    } else {
      return -1;
    }
  }

  int get toInt {
    if (int.tryParse(this) != null) {
      return int.parse(this);
    } else if (double.tryParse(this) != null) {
      return double.parse(this).toInt();
    } else {
      return 0;
    }
  }

  String get toColor {
    if (isEmpty) return "";
    String string = this;
    if (startsWith("rgb")) {
      string = toHex;
    }
    if (string == "#FFFFFF") {
      return "Colors.white";
    }
    if (string == "#000000") {
      return "Colors.black";
    }
    if (string == "#00000000") {
      return "Colors.transparent";
    }

    final color = "Color(0xFF${string.substring(1)})";
    return constants[color] ?? color;
  }

  String get toHex {
    final openIndex = indexOf("(");
    final closeIndex = indexOf(")");
    if (openIndex == -1 || closeIndex == -1) return "";
    final detailsString = substring(openIndex + 1, closeIndex);
    final details = detailsString.split(",");
    int r = details[0].trim().toInt;
    int g = details[1].trim().toInt;
    int b = details[2].trim().toInt;
    if (details.length < 4) {
      return '#${r.toRadixString(16).padLeft(2, '0')}${g.toRadixString(16).padLeft(2, '0')}${b.toRadixString(16).padLeft(2, '0')}';
    } else {
      double opacity = details.length < 4 ? 0 : details[3].toDouble;
      int opacityHex = (opacity * 255).round();
      return '#${r.toRadixString(16).padLeft(2, '0')}${g.toRadixString(16).padLeft(2, '0')}${b.toRadixString(16).padLeft(2, '0')}${opacityHex.toRadixString(16).padLeft(2, '0')}';
    }
  }

  // List<String> get toValues {
  //   List<String> outputs = [];
  //   List<String> values = split(" ");
  //   String currentString = "";
  //   for (int i = 0; i < values.length; i++) {
  //     final value = values[i];
  //     if (value.contains("px")) {
  //       String doubleString = "";
  //       for (int j = 0; j < value.length; j++) {
  //         final char = value[j];
  //         if (char == "." || int.tryParse(char) != null) {
  //           doubleString += char;
  //         }
  //       }
  //       if (currentString.isNotEmpty) {
  //         outputs.add(currentString);
  //       }
  //       // outputs.add(doubleString);
  //       currentString = doubleString;
  //     } else {
  //       currentString += " $value";
  //     }
  //   }
  //   if (currentString.isNotEmpty) {
  //     outputs.add(currentString);
  //   }
  //   outputs.removeEndZeros();
  //   return outputs.toTopRightBottomLeft;
  // }

  List<String> get toValues {
    List<String> outputs = [];
    List<String> values = contains(" ") ? split(" ") : [this];

    for (int i = 0; i < values.length; i++) {
      var value = values[i];
      if (value.startsWith("rgb")) {
        while (i < values.length && !value.endsWith(")")) {
          i++;
          value += values[i];
        }
        value = value.toHex;
      }
      if (value.contains("px")) {
        String doubleString = "";
        for (int j = 0; j < value.length; j++) {
          final char = value[j];
          if (char == "." || int.tryParse(char) != null) {
            doubleString += char;
          }
        }
        outputs.add(doubleString);
      } else {
        outputs.add(value);
      }
    }
    outputs.removeEndZeros();
    // return outputs.toTopRightBottomLeft;
    return outputs;
  }
}

extension NullableListStringExtension on List<String>? {
  double get toDoubleValue =>
      this == null || this!.isEmpty ? -1 : this!.last.toDouble;
  String get toStringValue => this == null || this!.isEmpty ? "" : this!.last;
  List<String> get toValues =>
      this == null || this!.isEmpty ? [] : this!.last.toValues;
}

extension ListStringExtension on List<String> {
  double get toDoubleValue => isNotEmpty ? last.toDouble : -1;
  String get toStringValue => isNotEmpty ? last : "";
  List<String> get toValues => isEmpty ? [] : last.toValues;

  List<String> get toTopRightBottomLeft {
    if (isEmpty) return this;
    if (length == 1) {
      return [first, first, first, first];
    }
    if (length == 2) {
      return [first, last, first, last];
    }
    if (length == 3) {
      return [first, this[1], last, this[1]];
    }

    return sublist(0, 4);
  }
  // List<String> get toTopRightBottomLeft {
  //   List<String> newValues = [];
  //   int index = 0;
  //   if (isEmpty) return this;
  //   while (newValues.length < 4) {
  //     final value = this[index];
  //     if (double.tryParse(value) == null && int.tryParse(value) == null) {
  //       return this;
  //     }
  //     newValues.add(value);
  //     if (index == length - 1) {
  //       index = length == 3 ? 1 : 0;
  //     } else {
  //       index++;
  //     }
  //   }
  //   return newValues;
  // }

  void removeEndZeros() {
    while (isNotEmpty &&
        (double.tryParse(last) != null || int.tryParse(last) != null)) {
      if ((double.tryParse(last) != null && double.parse(last) == 0) ||
          (int.tryParse(last) != null && int.parse(last) == 0)) {
        removeLast();
      } else {
        break;
      }
    }
  }
}
