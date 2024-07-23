import 'package:flutter/material.dart';
import 'package:flutter_coder/features/emulator/utils/utils.dart';

import '../models/input.dart';
import 'alpha.dart';
import 'widgets_data.dart';

extension ContextExtensions on BuildContext {
  bool get isDarkMode {
    return MediaQuery.of(this).platformBrightness == Brightness.dark;
  }

  bool get isMobile => MediaQuery.of(this).size.width < 730;
  bool get isTablet {
    var width = MediaQuery.of(this).size.width;
    return width < 1190 && width >= 730;
  }

  bool get isWeb => MediaQuery.of(this).size.width >= 1190;
  bool get isPortrait =>
      MediaQuery.of(this).orientation == Orientation.portrait;
  //bool get isPortrait => screenWidth < screenHeight;
  double get screenWidth => MediaQuery.of(this).size.width;
  double get screenHeight => MediaQuery.of(this).size.height;
  double get lowestSize =>
      screenWidth < screenHeight ? screenWidth : screenHeight;
  double get highestSize =>
      screenWidth > screenHeight ? screenWidth : screenHeight;
  // Size get screenSize => MediaQuery.of(this).size;
  double get statusBarHeight => MediaQuery.of(this).padding.top;

  double screenHeightPercentage(int percent) => screenHeight * percent / 100;
  double screenWidthPercentage(int percent) => screenWidth * percent / 100;
  double adaptiveTextSize(double size) => (size / 720) * screenHeight;
}

extension DoubleExtensions on double {
  int get toDegrees => (this * (180.0 / 3.14159265)).toInt();
  double percentValue(int percent) => this * percent / 100;
}

extension StringExtensions on String {
  String removeCommentsAndTrim() {
    String string = this;
    String newString = "";
    List<String> strings = string.splitUseStringIfEmpty("\n");
    int commentsCount = 0;
    bool isDeprecated = false, containsString = false;
    int depricatedBracketCount = 0;
    //String startString = "";
    for (int i = 0; i < strings.length; i++) {
      String string = strings[i].trim();

      if (string.contains("@Deprecated")) {
        isDeprecated = true;
        final index = string.indexOf("@Deprecated");
        if (index > 0) {
          string = string.substring(0, index);
          containsString = true;
        }
      }
      if (isDeprecated) {
        depricatedBracketCount += string.containsCount("(");
        depricatedBracketCount -= string.containsCount(")");
      }

      if (string.contains("//")) {
        final index = string.indexOf("//");
        if (index == 0) {
          continue;
        } else {
          string = string.substring(0, index);
          containsString = true;
        }
      }
      if (string.contains("/*") &&
          string.contains("*/") &&
          commentsCount == 0) {
        final prevIndex = string.indexOf("/*");
        final nextIndex = string.indexOf("*/");
        final prevString = string.substring(0, prevIndex);
        final nextString = string.substring(nextIndex + 2);
        string = "$prevString$nextString";
        if (string.isNotEmpty) {
          containsString = true;
        }
      } else if (string.contains("/*")) {
        final index = string.indexOf("/*");
        if (index > 0) {
          string = string.substring(0, index);
          containsString = true;
        }
        commentsCount++;
      } else if (string.contains("*/")) {
        final index = string.indexOf("*/");
        if (index < string.length - 2) {
          string = string.substring(index + 2);
          containsString = true;
        }
        commentsCount--;
      }
      if (string.isEmpty ||
          (!containsString && (commentsCount > 0 || isDeprecated))) {
        if (depricatedBracketCount == 0) {
          isDeprecated = false;
        }
        continue;
      }
      if (containsString) {
        containsString = false;
      }
      newString += "$string ";
    }
    return newString.trim();
  }

  int containsCount(String pattern) {
    int count = 0;
    bool inString = false;
    for (int i = 0; i < length; i++) {
      final char = this[i];
      if (pattern != "" && pattern == char) {
        count++;
      }
      // if ((pattern != "'" && pattern != '"') && (char == "'" || char == '"')) {
      //   inString = !inString;
      // }
      // if (inString) {
      //   continue;
      // } else {
      //   if (pattern == char) {
      //     count++;
      //   }
      // }
    }
    return count;
  }

  String get first {
    String string = "";
    for (int i = 0; i < length; i++) {
      final char = this[i];
      if (char != " " && char != "\n") {
        string += char;
      } else {
        break;
      }
    }
    return string;
  }

  // List<String> firstSplit(String pattern) {
  //   String string = "";
  //   for (int i = 0; i < length; i++) {
  //     final char = this[i];
  //     if (char == pattern) {
  //       string += char;
  //     } else {
  //       break;
  //     }
  //   }
  //   return string;
  // }

  bool isASubClassOfWidget(Map<String, List<Input>> classesInputs) {
    Input? currentInput;
    String type = this;
    while (type != "") {
      if (type == "StatelessWidget" ||
          type == "StatefulWidget" ||
          type == "InheritedWidget" ||
          type == "Widget") {
        return true;
      }
      currentInput = classesInputs[type]?.first;
      type = currentInput == null ? "" : getType(currentInput);
    }
    return false;
  }

  List<String> splitUseStringIfEmpty(String pattern) {
    return contains(pattern) ? split(pattern) : [this];
  }

  bool get startsWithUppercase {
    if (isEmpty) return false;
    return upperCases.contains(this[0]);
  }

  bool startsWithLetter([List<String> exceptions = const []]) {
    if (isEmpty) return false;
    return (upperCases.contains(this[0]) ||
        lowerCases.contains(this[0]) ||
        exceptions.contains(this[0]));
  }
}

extension ListAnyTypeExtensions on List<Line> {
  List<Line> joinWithRightSpacing([String startingSpace = ""]) {
    List<Line> newLines = [];
    newLines.addAll(this);
    int bracesCount = 0;
    String space = startingSpace;
    for (int i = 0; i < newLines.length; i++) {
      final line = newLines[i];
      final texts = line.texts.trimList();
      if (texts.isEmpty) continue;
      final string = texts.join(" ").trim();
      if (string.isEmpty) continue;
      final count = texts.getClosedOrOpenedLineCount();
      if (count == 0) {
        line.texts.insert(0, space);
      } else if (count > 0) {
        line.texts.insert(0, space);
        space += "\t";
      } else {
        space = space.isNotEmpty ? space.replaceFirst("\t", "") : "";
        line.texts.insert(0, space);
      }
      if (string.contains("{")) {
        bracesCount++;
      }
      if (string.contains("}")) {
        bracesCount--;
      }
      //print("bracesCount = $bracesCount");
      if (bracesCount == 0) {
        //line.texts.add("\n");
        line.texts.last = "${line.texts.last}\n";
      }
    }
    return newLines;
  }
}

extension ListOfAnyTypeExtensions<T> on List<T> {
  List<T> get withoutNull {
    List<T> newList = [];
    for (int i = 0; i < length; i++) {
      final value = this[i];
      if (value != null) {
        newList.add(value);
      }
    }
    return newList;
  }

  void sortList(dynamic Function(T) callback, bool dsc) => sort((i, j) => dsc
      ? callback(i).compareTo(callback(j))
      : callback(j).compareTo(callback(i)));
  void sortAsc(dynamic Function(T) callback) =>
      sort((i, j) => callback(i).compareTo(callback(j)));
  void sortDsc(dynamic Function(T) callback) =>
      sort((i, j) => callback(j).compareTo(callback(i)));
  List<T> sortedAsc(dynamic Function(T) callback) {
    final List<T> list = [];
    list.addAll(this);
    list.sort((i, j) => callback(i).compareTo(callback(j)));
    return list;
  }

  List<T> from(int start, [int? end]) {
    List<T> newList = [];
    final size = end != null && end < length ? end : length;
    for (int i = start; i < size; i++) {
      final item = this[i];
      newList.add(item);
    }
    return newList;
  }
}

extension ListStringExtensions on List<String> {
  List<String> from(int start, [int? end]) {
    List<String> newList = [];
    final size = end != null && end < length ? end : length;
    for (int i = start; i < size; i++) {
      final string = this[i];
      newList.add(string);
    }
    return newList;
  }

  int getClosedOrOpenedLineCount() {
    int count = 0;
    for (int i = 0; i < length; i++) {
      final string = this[i];
      if (string.contains("(")) {
        count++;
      }
      if (string.contains("[")) {
        count++;
      }
      if (string.contains("{")) {
        count++;
      }
      if (string.contains(")")) {
        count--;
      }
      if (string.contains("]")) {
        count--;
      }
      if (string.contains("}")) {
        count--;
      }
    }
    return count;
  }

  int getClosedOrOpenedBracesCount([String type = "{"]) {
    int count = 0;
    for (int i = 0; i < length; i++) {
      final string = this[i];
      if (string.contains(type)) {
        count++;
      }
      if (string.contains(type == "{"
          ? "}"
          : type == "("
              ? ")"
              : type == "["
                  ? "]"
                  : "")) {
        count--;
      }
    }
    return count;
  }

  void removeItems(List<String> items) {
    for (int i = 0; i < items.length; i++) {
      final item = items[i];
      remove(item);
    }
  }

  bool containsBraces(String brace) {
    bool contain = false;
    for (int i = 0; i < length; i++) {
      if (!this[i].contains(brace == "{" ? "({" : "})") &&
          this[i].contains(brace)) {
        contain = true;
        break;
      }
    }
    return contain;
  }

  int equalsIndex(String char) {
    int index = -1;
    for (int i = 0; i < length; i++) {
      if (this[i].trim() == char) {
        index = i;
        break;
      }
    }
    return index;
  }

  int equalsCount(String char) {
    int count = 0;
    for (int i = 0; i < length; i++) {
      if (this[i] == char) {
        count++;
      }
    }
    return count;
  }

  int containsCount(String char) {
    int count = 0;
    for (int i = 0; i < length; i++) {
      if (this[i].contains(char)) {
        count++;
      }
    }
    return count;
  }

  int containsIndex(String char) {
    int index = -1;
    for (int i = 0; i < length; i++) {
      if (this[i].contains(char)) {
        index = i;
        break;
      }
    }
    return index;
  }

  bool containsChar(String char) {
    for (int i = 0; i < length; i++) {
      if (this[i].contains(char)) {
        return true;
      }
    }
    return false;
  }

  bool startsOrEndsWith(String char) {
    if (isEmpty) return false;
    return (this[0].startsWith(char) || this[length - 1].endsWith(char));
  }

  bool startsOrEndsWithWithoutLast(String char) {
    if (isEmpty) return false;
    return (this[0].startsWith(char) ||
        this[length - 1].endsWith(char) ||
        (this[length - 1].length > 2 &&
            this[length - 1].substring(
                  this[length - 1].length - 2,
                  this[length - 1].length - 1,
                ) ==
                char));
  }

  List<String> getListWithoutChar(String char, [bool fromEnd = false]) {
    List<String> newList = [];
    bool found = false;
    if (isEmpty) return [];
    for (int i = 0; i < length; i++) {
      if (fromEnd) {
        if (found) {
          newList.add(this[i]);
        } else {
          if (this[i].contains(char)) {
            found = true;
          }
        }
      } else {
        if (!this[i].contains(char)) {
          newList.add(this[i]);
        } else {
          break;
        }
      }
    }
    return newList;
  }

  List<String> trim() {
    List<String> newList = [];
    for (int i = 0; i < length; i++) {
      final string = this[i].trim();
      if (string.isNotEmpty) {
        newList.add(string);
      }
    }
    return newList;
  }

  List<String> get trimmed {
    List<String> newList = [];
    for (int i = 0; i < length; i++) {
      if (this[i].isNotEmpty) {
        newList.add(this[i]);
      }
    }
    return newList;
  }

  List<String> listRange(int start, [int? end]) {
    List<String> newList = [];
    end = end ?? length;
    for (int i = start; i < end; i++) {
      newList.add(this[i]);
    }
    return newList;
  }

  List<String> trimList() {
    List<String> newList = [];
    bool beginComment = false;
    for (int i = 0; i < length; i++) {
      final string = this[i].trim();
      if (string != "") {
        if (string.startsWith("//")) {
          continue;
        } else if (string.startsWith("/*")) {
          beginComment = true;
          continue;
        } else if (string.endsWith("*/")) {
          beginComment = false;
          continue;
        }
        if (!beginComment) {
          newList.add(string);
        }
      }
    }
    return newList;
  }

  List<String> removeComments() {
    List<String> newList = [];
    newList.addAll(this);
    String string = join(" ");
    if (string.contains("/*")) {
      final leftList = string.split("/*");
      final left = leftList.firstOrNull ?? "";
      String right = "";
      final rightList = string.split("*/");
      if (string.contains("*/")) {
        right = string.split("*/").lastOrNull ?? "";
      }
      if (left.isNotEmpty && right.isNotEmpty) {
        string = "$left $right";
        newList = string.split(" ").trimList();
      }
    }
    return newList;
  }
}

extension InputExtension on InputData {
  bool isASubClassOfWidget(Map<String, List<InputData>> classesInputDatas) {
    InputData? currentData = copyWith();
    String type = getInputParameters(currentData).type;
    while (type != "") {
      if (type == "StatelessWidget" ||
          type == "StatefulWidget" ||
          type == "InheritedWidget" ||
          type == "Widget") {
        return true;
      }
      final datas = classesInputDatas[type];
      if (datas != null) {
        final index = datas.indexWhere(
            (element) => getInputParameters(element).inputType == "class");
        if (index != -1) {
          currentData = datas[index];
          type = getInputParameters(currentData).type;
        } else {
          type = "";
        }
      } else {
        type = "";
      }
    }
    return false;
  }
}

extension NullableListFromExtension<T, U> on List<T>? {
  List<U>? customFrom() => this == null ? null : List<U>.from(this!);
}

extension NullableSetFromExtension<T, U> on List<T>? {
  Set<U>? customFrom() => this == null ? null : Set<U>.from(this!);
}

extension NullableMapFromExtension<T, S, U, V> on Map<T, S>? {
  Map<U, V>? customFrom() => this == null ? null : Map<U, V>.from(this!);
}

extension ListFromExtension<T, U> on List<T> {
  List<U>? customFrom() => List<U>.from(this);
}

extension SetFromExtension<T, U> on List<T> {
  Set<U>? customFrom() => Set<U>.from(this);
}

extension MapFromExtension<T, S, U, V> on Map<T, S> {
  Map<U, V>? customFrom() => Map<U, V>.from(this);
}
