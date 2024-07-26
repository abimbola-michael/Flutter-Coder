// ignore_for_file: unnecessary_string_interpolations

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_coder/features/converter/models/details_result.dart';
import 'package:flutter_coder/features/emulator/utils/widgets_data.dart';
import 'package:flutter_coder/features/shared/utils/extensions.dart';
import '../models/code_detail.dart';
import 'tailwind_data.dart';

enum ReactType { native, tailwind, normal }

extension ReactTypeExtensions on ReactType {
  bool get isReactNative => this == ReactType.native;
  bool get isTailwind => this == ReactType.tailwind;
  bool get isNormal => this == ReactType.normal;
}

Map<String, dynamic> getTailwindDataMap() {
  Map<String, dynamic> tailwindDataMap = {};
  for (int i = 0; i < tailwindDatas.length; i++) {
    final tailwindData = tailwindDatas[i];
    final strings = tailwindData.split("\n");
    for (int j = 0; j < strings.length; j++) {
      final string = strings[j];
      final spaceIndex = getFirstMatchIndex(string);
      if (spaceIndex == -1) continue;
      String left = string.substring(0, spaceIndex).trim();
      String right = string.substring(spaceIndex + 1).trim();
      if (right.contains("/*") && right.contains("*/")) {
        final innerValue = right
            .substring(right.indexOf("/*") + 2, right.indexOf("*/"))
            .trim();
        final semicolonIndex = right.indexOf(";");
        final colonIndex = right.indexOf(":");
        tailwindDataMap[
            right.substring(0, semicolonIndex).replaceAll(" ", "")] = left;
        tailwindDataMap["${right.substring(0, colonIndex + 1)}$innerValue"
            .replaceAll(" ", "")] = left;
      } else {
        tailwindDataMap[right.replaceAll(" ", "")] = left;
      }
    }
  }
  return tailwindDataMap;
}

String cssToTailwind(String key, String value) {
  // value.replaceAll(" ", "");
  if (value.startsWith("rgb")) {
    value = value.toHex;
  }
  //print("key=$key, value= $value");
  String foundTailwindStart = "";
  String foundTailwindUnit = "";
  for (int i = 0; i < tailwindDatas.length; i++) {
    final tailwindData = tailwindDatas[i];
    final strings = tailwindData.split("\n");
    //print("strings = $strings");

    for (int j = 0; j < strings.length; j++) {
      final string = strings[j];

      final spaceIndex = getFirstMatchIndex(string);

      if (spaceIndex == -1) continue;
      String left = string.substring(0, spaceIndex).trim();
      String right = string.substring(spaceIndex + 1).trim();

      final colonIndex = right.indexOf(":");
      final semicolonIndex = right.indexOf(";");
      if (colonIndex == -1 || semicolonIndex == -1) {
        //print("Empty at $left $right");
        continue;
      }

      final cssKey = right.substring(0, colonIndex);
      String cssValue = right.substring(colonIndex + 1, semicolonIndex).trim();
      cssValue.replaceAll("px", "");
      if (cssValue.startsWith("rgb")) {
        cssValue = cssValue.toHex;
      }
      String extraValue = "";

      if (!cssKey.startsWith(key)) {
        if (foundTailwindStart.isNotEmpty) {
          return "$foundTailwindStart-[$value$foundTailwindUnit]";
        }
        continue;
      }
      if (right.contains("/*") && right.contains("*/")) {
        extraValue = right
            .substring(right.indexOf("/*") + 2, right.indexOf("*/"))
            .trim();
        extraValue.replaceAll(" ", "");
        if (extraValue.startsWith("rgb")) {
          extraValue = extraValue.toHex;
        }
      }

      //print("value = $value, cssValue = $cssValue, extraValue = $extraValue");
      if (value.replaceAll("", " ") == cssValue.replaceAll("", " ") ||
          value.replaceAll("", " ") ==
              extraValue.replaceAll("px", "").replaceAll("", " ")) {
        return left;
      } else {
        final hyphenIndex = left.lastIndexOf("-");

        if (foundTailwindStart.isEmpty && hyphenIndex != -1) {
          final resultValue = extraValue.isNotEmpty ? extraValue : cssValue;
          String unit = resultValue.endsWith("px") ? "px" : "";
          foundTailwindStart = left.substring(0, hyphenIndex);
          foundTailwindUnit = unit;
        }
      }
    }
  }
  return "";
}

int getFirstMatchIndex(String string, [String charToMatch = ""]) {
  for (int i = 0; i < string.length; i++) {
    final char = string[i];
    if (charToMatch.isEmpty) {
      if (char.trim().isEmpty) return i;
    } else {
      if (char == charToMatch) return i;
    }
  }
  return -1;
}

String tailwindToCss(String tailwindString) {
  String key = "";
  String value = "";
  final hyphenIndex = tailwindString.lastIndexOf("-");
  String foundTailwindStart = "";
  String foundTailwindUnit = "";

  if (hyphenIndex != -1) {
    key = tailwindString.substring(0, hyphenIndex);
    value = tailwindString.substring(hyphenIndex + 1).trim();
  } else {
    key = tailwindString;
  }
  for (int i = 0; i < tailwindDatas.length; i++) {
    final tailwindData = tailwindDatas[i];
    final strings = tailwindData.split("\n");
    for (int j = 0; j < strings.length; j++) {
      final string = strings[j];
      final spaceIndex = getFirstMatchIndex(string);
      if (spaceIndex == -1) continue;
      String left = string.substring(0, spaceIndex);
      String right = string.substring(spaceIndex + 1);

      final colonIndex = right.indexOf(":");
      final semicolonIndex = right.indexOf(";");
      final cssKey = right.substring(0, colonIndex);
      final cssValue = right.substring(colonIndex + 1, semicolonIndex).trim();
      String extraValue = "";

      if (right.contains("/*") && right.contains("*/")) {
        extraValue = right
            .substring(right.indexOf("/*") + 2, right.indexOf("*/"))
            .trim();
      }

      String tailwindCssKey = "";
      String tailwindCssValue = "";

      final hyphenIndex = left.lastIndexOf("-");

      if (hyphenIndex != -1) {
        tailwindCssKey = left.substring(0, hyphenIndex);
        tailwindCssValue = left.substring(hyphenIndex + 1);
      } else {
        tailwindCssKey = left;
      }
      if (!tailwindCssKey.startsWith(key)) {
        if (foundTailwindStart.isNotEmpty) {
          final bracketStartIndex = tailwindString.indexOf("[");
          final bracketEndIndex = tailwindString.indexOf("]");
          if (bracketStartIndex != -1 && bracketEndIndex != -1) {
            return "$foundTailwindStart: ${tailwindString.substring(bracketStartIndex + 1, bracketEndIndex).trim()};";
          } else {
            return "";
          }
        }
        continue;
      }
      if (tailwindCssKey == key) {
        if ((tailwindCssValue.replaceAll(" ", "") ==
                value.replaceAll(" ", "") ||
            tailwindCssValue.replaceAll(" ", "") ==
                extraValue.replaceAll("px", ""))) {
          final resultValue = extraValue.isNotEmpty ? extraValue : cssValue;
          return "$tailwindCssKey: $resultValue;";
        } else {
          if (foundTailwindStart.isEmpty) {
            final resultValue = extraValue.isNotEmpty ? extraValue : cssValue;
            String unit = resultValue.endsWith("px") ? "px" : "";
            foundTailwindStart = tailwindCssKey;
            foundTailwindUnit = unit;
          }
        }
      }
    }
  }
  return "";
}

String styleMapToTailwindCssString(Map<String, dynamic> stylesMap) {
  String tailwindCss = "";
  for (var entry in stylesMap.entries) {
    final key = entry.key.toSnakeCase;
    final value = entry.value;
    tailwindCss += cssToTailwind(key, value);
    tailwindCss += " ";
  }
  return tailwindCss.trim();
}

Map<String, dynamic> getStylesMap(String styles) {
  final values = customBracedSplitting(styles, ",");

  Map<String, dynamic> stylesMap = {};
  for (int i = 0; i < values.length; i++) {
    final value = values[i];
    if (!value.contains(":")) continue;
    final strings = value.split(":");
    final key = strings[0].trim();
    final keyValue = strings[1].trim();
    stylesMap[key] = keyValue;
  }
  return stylesMap;
}

String styleMapToCssString(Map<String, dynamic> stylesMap) {
  return stylesMap.entries
      .map((entry) => "${entry.key.toSnakeCase}: ${entry.value}")
      .join(";\n");
}

String transformToHtmlAndCSS(String input) {
  String output = "";
  while (true) {
    final startIndex = input.indexOf("style={");
    final endIndex = input.indexOf("}", startIndex != -1 ? startIndex + 7 : 0);
    if (startIndex == -1 || endIndex == -1) return input;
    final styles = input.substring(startIndex + 7, endIndex);
    final stylesMap = getStylesMap(styles);
    final stylesCss = styleMapToCssString(stylesMap);
    output += input.substring(0, startIndex);
    output += "className=\"name\"";
    output += input.substring(endIndex + 1);
    output += "\n\n\n";
    output += ".name {\n";
    output += stylesCss;
    output += "\n}\n";
    input = output;
    output = "";
  }

  //return output;
}

String transformToTailwindCss(String input) {
  String output = "";
  while (true) {
    final startIndex = input.indexOf("style={");
    final endIndex = input.indexOf("}", startIndex != -1 ? startIndex + 7 : 0);
    if (startIndex == -1 || endIndex == -1) return input;
    final styles = input.substring(startIndex + 7, endIndex);
    final stylesMap = getStylesMap(styles);
    final tailwindCss = styleMapToTailwindCssString(stylesMap);
    output += input.substring(0, startIndex);
    output += " className=\"$tailwindCss\"";
    output += input.substring(endIndex + 1);
    input = output;
    output = "";
  }

  // return output;
}

String reformatReactString(String string) {
  String formattedString = "";
  int tabs = 0;
  bool needsTab = false;
  bool foundComma = false;

  bool inSingleQuote = false;
  bool inDoubleQuote = false;
  bool inBackTick = false;

  for (int i = 0; i < string.length; i++) {
    String char = string[i];

    if (char == "'") {
      inSingleQuote = !inSingleQuote;
    }
    if (char == '"') {
      inDoubleQuote = !inDoubleQuote;
    }
    if (char == '`') {
      inBackTick = !inBackTick;
    }
    if (inSingleQuote || inDoubleQuote || inBackTick) {
      if (needsTab) {
        formattedString += "\t" * tabs * 2;
        needsTab = false;
      }
      formattedString += char;
      continue;
    }

    char = char.trim();
    if (char.isEmpty) {
      if (tabs == 0) {
        tabs++;
        formattedString += "\n\t\t";
      }
      continue;
    }

    if (char == "{" || char == ">") {
      // final endChar = char == "(" ? ")" : ["]"];
      // while (i < string.length && char != endChar) {
      //   i++;
      //   char = string[i];
      //   foundComma = char == ",";
      // }
      // if (foundComma) {}
      tabs++;
    } else if (char == "}" || char == "<") {
      if (tabs > 0) tabs--;
    }

    if (needsTab) {
      // if (char == ",") {
      //   String nextChar = "";

      //   formattedString += "";
      // } else {}
      formattedString += "\t" * tabs * 2;
    }

    // if (char == ")" && !foundComma) {
    //   formattedString += ", ${"\t" * tabs * 2}";
    // }

    if (char == "{" || char == ">" || char == ",") {
      if (foundComma && char == ",") {
        char = "";
      }
      formattedString += "$char\n";
    } else if (char == ":") {
      formattedString += "$char ";
    } else {
      formattedString += char;
    }
    needsTab = char == "{" || char == ">" || char == ",";
    foundComma = char == ",";

    if (formattedString.endsWith("const")) {
      formattedString += " ";
    }
  }
  return formattedString;
}

Map<String, String> getReactDefaults(String string) {
  Map<String, String> properties = {};

  final strings = string.customSplit('\n');
  for (int i = 0; i < strings.length; i++) {
    String string = strings[i].trim();
    final values = string.customSplit(':');
    if (values.length == 2) {
      final key = values[0].trim();
      final value = values[1].trim().replaceAll(";", "");
      properties[key] = value;
    }
  }
  return properties;
}

DetailsResult getTailwindDetailsResult(
    CodeDetail detail, double? totalWidth, double? totalHeight) {
  final result = getReactDetailsResult(detail, totalWidth, totalHeight, false);
  final tailwindOutput = transformToTailwindCss(result.output);
  return result.copyWith(output: tailwindOutput);
}

DetailsResult getHtmlAndCssDetailsResult(
    CodeDetail detail, double? totalWidth, double? totalHeight) {
  final result = getReactDetailsResult(detail, totalWidth, totalHeight, false);
  final htmlAndCssOutput = transformToHtmlAndCSS(result.output);
  return result.copyWith(output: htmlAndCssOutput);
}

DetailsResult getReactDetailsResult(CodeDetail detail, double? totalWidth,
    double? totalHeight, bool isReactNative) {
  String string = detail.string;
  String type = detail.type;
  double? radius = detail.radius;
  bool circular = detail.circular;
  bool clickable = detail.clickable;
  String output = "";

  final strings = string.split('\n');

  Map<String, List<String>> properties = {};
  List<String> contents = [];
  for (int i = 0; i < strings.length; i++) {
    String string = strings[i].trim();
    if (string.isEmpty) continue;

    if (string.startsWith("// On click") && !clickable) {
      clickable = true;
    }
    if (!string.endsWith(";") &&
        !string.startsWith("/") &&
        !string.startsWith("border:")) {
      contents.add(string);
      continue;
    }
    final values = string.split(':');
    if (values.length < 2) continue;
    final key = values[0].trim();
    final value = values[1].trim().replaceAll(";", "");

    if (properties[key] != null) {
      properties[key]!.add(value);
    } else {
      properties[key] = [value];
    }
  }

  String attributes = "";
  String decorationAttributes = "";
  List<String> textStyleAttributes = [];
  //List<String> textAttributes = [];

  final width = properties["width"].toDoubleValue;
  final height = properties["height"].toDoubleValue;
  final top = properties["top"].toDoubleValue;
  final left = properties["left"].toDoubleValue;
  final gap = properties["gap"].toDoubleValue;
  final opacity = properties["opacity"].toDoubleValue;
  final justify = properties["justify"].toStringValue;
  final align = properties["align"].toStringValue;

  double right = (totalWidth ?? 0) - (left + width);
  bool isWidthInfinity = (left - right).abs() <= 5;

  if (width > 0) {
    if (totalWidth == null || !isWidthInfinity) {
      attributes += width.toString().setAttribute("width", "", "1");
    } else {
      attributes += "width: 100%, ";
    }
  }

  double bottom = (totalHeight ?? 0) - (top + height);
  bool isHeightInfinity = (top - bottom).abs() <= 5;

  if (height > 0) {
    if (totalHeight == null || !isHeightInfinity) {
      attributes += height.toString().setAttribute("height");
    } else {
      attributes += "height: 100%, ";
    }
  }
  //justify != "flex-start"
  if (justify.isNotEmpty) {
    attributes += "justifyContent: ${justify.toSnakeCase},";
  }
  //&& align != "flex-center"
  if (align.isNotEmpty) {
    attributes += "alignItems: ${align.toSnakeCase},";
  }

  final padding = properties["padding"].toValues.toTopRightBottomLeft;
  if (padding.isNotEmpty) {
    bool isSame = padding.every((element) => element == padding[0]);
    if (isSame) {
      attributes += "padding: ${padding[0]}, ";
    } else if (isReactNative &&
        padding[0] == padding[2] &&
        padding[1] == padding[3]) {
      attributes +=
          "${padding[0].setAttribute("paddingVertical")}${padding[1].setAttribute("paddingHorizontal")}";
    } else {
      attributes +=
          "${padding[0].setAttribute("paddingTop")}${padding[1].setAttribute("paddingRight")}${padding[2].setAttribute("paddingBottom")}${padding[3].setAttribute("paddingLeft")}";
    }
  }
  final margin = properties["margin"].toValues.toTopRightBottomLeft;
  if (margin.isNotEmpty) {
    bool isSame = margin.every((element) => element == margin[0]);
    if (isSame) {
      attributes += "margin: ${margin[0]}, ";
    } else if (isReactNative &&
        margin[0] == margin[2] &&
        margin[1] == margin[3]) {
      attributes +=
          "${margin[0].setAttribute("marginVertical")}${margin[1].setAttribute("marginHorizontal")}";
    } else {
      attributes +=
          "${margin[0].setAttribute("marginTop")}${margin[1].setAttribute("marginRight")}${margin[2].setAttribute("marginBottom")}${margin[3].setAttribute("marginLeft")}";
    }
  }

  ///Text

  // final fontFamilies = properties["font-family"] ?? [];
  // if (fontFamilies.isNotEmpty) {
  //   for (int i = 0; i < fontFamilies.length; i++) {
  //     final fontFamily = fontFamilies[i];
  //     final isSame = i > 0 && fontFamilies[0] == fontFamily;
  //     final value = isSame ? "" : "fontFamily: $fontFamily, ";
  //     if (textStyleAttributes.isEmpty) {
  //       textStyleAttributes.add(value);
  //     } else {
  //       textStyleAttributes[i] += value;
  //     }
  //   }
  // }

  final fontSizes = properties["font-size"] ?? [];
  if (fontSizes.isNotEmpty) {
    for (int i = 0; i < fontSizes.length; i++) {
      final isSame = i > 0 && fontSizes[0] == fontSizes[i];
      final fontSize = fontSizes[i].toValues[0];
      final value = isSame ? "" : "fontSize: $fontSize, ";
      if (i < textStyleAttributes.length) {
        textStyleAttributes[i] += value;
      } else {
        textStyleAttributes.add(value);
      }
    }
  }

  final fontWeights = properties["font-weight"] ?? [];
  if (fontWeights.isNotEmpty) {
    for (int i = 0; i < fontWeights.length; i++) {
      final fontWeight = fontWeights[i];
      final isSame = i > 0 && fontWeights[0] == fontWeight;

      final value = isSame ? "" : "fontWeight: $fontWeight, ";
      if (i < textStyleAttributes.length) {
        textStyleAttributes[i] += value;
      } else {
        textStyleAttributes.add(value);
      }
    }
  }
  final textAligns = properties["text-align"] ?? [];
  for (int i = 0; i < textAligns.length; i++) {
    final isSame = i > 0 && textAligns[0] == textAligns[i];
    final textAlign = textAligns[i];

    final value =
        isSame || textAlign == "left" ? "" : "textAlign: $textAlign, ";

    //attributes += value;
    if (i < textStyleAttributes.length) {
      textStyleAttributes[i] += value;
    } else {
      textStyleAttributes.add(value);
    }
  }

  final colors = (properties["background"] ?? properties["color"]) ?? [];
  List<String> allColors = [];
  if (colors.isNotEmpty) {
    for (int i = 0; i < colors.length; i++) {
      final isSame = i > 0 && colors[0] == colors[i];
      List<String> color = isSame ? [] : colors[i].toValues;
      if (color.isEmpty) {
        allColors.add("");
        continue;
      }

      String value = "";
      if (color.length == 1) {
        //final actualColor = color.first.toReactColor;
        value = "color: ${color.first}, ";
      } else {
        value = "backgroundImage: ${color.join(" ")}, ";
      }
      allColors.add(value);
    }
  }

  if (allColors.isNotEmpty) {
    if (textStyleAttributes.isNotEmpty) {
      for (int i = 0; i < textStyleAttributes.length; i++) {
        //final color = i < allColors.length ? allColors[i] : allColors[0];
        final color = i < allColors.length ? allColors[i] : "";
        textStyleAttributes[i] += color;
      }
    } else {
      decorationAttributes +=
          allColors[0].replaceAll("color", "backgroundColor");
    }
  }

  final borderRadius = radius != null && radius > 0
      ? ["$radius"].toTopRightBottomLeft
      : properties["border-radius"].toValues.toTopRightBottomLeft;
  if (borderRadius.isNotEmpty && !circular) {
    bool isSame = borderRadius.every((element) => element == borderRadius[0]);
    if (isSame) {
      decorationAttributes += "borderRadius: ${borderRadius[0]}, ";
    } else if (isReactNative &&
        borderRadius[0] == borderRadius[2] &&
        borderRadius[1] == borderRadius[3]) {
      decorationAttributes +=
          "${borderRadius[0].setAttribute("borderVerticalRadius", borderRadius[0])}${borderRadius[1].setAttribute("borderHorizontalRadius", "${borderRadius[1]}")}";
    } else {
      decorationAttributes +=
          "${borderRadius[0].setAttribute("borderTopLeftRadius", "${borderRadius[0]}")}${borderRadius[1].setAttribute("borderTopRightRadius", "${borderRadius[1]}")}${borderRadius[2].setAttribute("borderBottomRightRadius", "${borderRadius[2]}")}${borderRadius[3].setAttribute("borderBottomLeftRadius", "${borderRadius[3]}")}";
    }
  }

  var border = properties["border"] ?? [];

  if (border.isNotEmpty) {
    final index = border
        .indexWhere((value) => value.contains("#") || value.contains("rgb"));
    if (index != -1) {
      border = border[index].toValues;
    } else {
      border = [];
    }
  }
  final borderTop = properties["border-top"].toValues;
  final borderRight = properties["border-right"].toValues;
  final borderBottom = properties["border-bottom"].toValues;
  final borderLeft = properties["border-left"].toValues;

  String attr = "";
  String topAttr = "";
  String bottomAttr = "";
  String leftAttr = "";
  String rightAttr = "";

  List<String> allBorders = [];

  if (border.length == 3 && border[0].isFinite) {
    attr =
        " borderColor: ${border[2].toReactColor}, ${border[1] != "solid" ? "borderstyle=${border[1]}," : ""}";
  }

  if (borderTop.length == 3 && borderTop[0].isFinite) {
    topAttr =
        " borderTopColor: ${borderTop[2].toReactColor}, ${borderTop[1] != "solid" ? "borderTopstyle=${borderTop[1]}," : ""}";
    allBorders.add(borderTop[0]);
  } else {
    if (border.isNotEmpty) {
      allBorders.add(border[0]);
    } else {
      allBorders.add("0");
    }
  }

  if (borderRight.length == 3 && borderRight[0].isFinite) {
    rightAttr =
        " borderRightColor: ${borderRight[2].toReactColor}, ${borderRight[1] != "solid" ? "borderRightstyle=${borderRight[1]}," : ""}";
    allBorders.add(borderRight[0]);
  } else {
    if (border.isNotEmpty) {
      allBorders.add(border[0]);
    } else {
      allBorders.add("0");
    }
  }

  if (borderBottom.length == 3 && borderBottom[0].isFinite) {
    bottomAttr =
        " borderBottomColor: ${borderBottom[2].toReactColor}, ${borderBottom[1] != "solid" ? "borderBottomstyle=${borderBottom[1]}," : ""}";

    allBorders.add(borderBottom[0]);
    // decorationAttributes +=
    //     "border: Border(bottom: BorderSide(${borderBottom[0].setAttribute("width", "", "1")},$bottomAttr)";
  } else {
    if (border.isNotEmpty) {
      allBorders.add(border[0]);
    } else {
      allBorders.add("0");
    }
  }

  if (borderLeft.length == 3 && borderLeft[0].isFinite) {
    leftAttr =
        " borderLeftColor: ${borderLeft[2].toReactColor}, ${borderLeft[1] != "solid" ? "borderLeftstyle=${borderLeft[1]}," : ""}";
    allBorders.add(borderLeft[0]);
  } else {
    if (border.isNotEmpty) {
      allBorders.add(border[0]);
    } else {
      allBorders.add("0");
    }
  }

  allBorders.removeEndZeros();

  bool isSame = allBorders.isEmpty
      ? false
      : allBorders.every((element) => element == allBorders[0]);
  if (allBorders.isNotEmpty) {
    if (isSame) {
      decorationAttributes +=
          "${allBorders[0].setAttribute("borderWidth", "", "1")}$attr\n";
    } else if (isReactNative &&
        allBorders[0] == allBorders[2] &&
        allBorders[1] == allBorders[3]) {
      decorationAttributes +=
          "${allBorders[0].setAttribute("borderVerticalWidth", "")}$topAttr${allBorders[1].setAttribute("borderHorizontalWidth", "")}$leftAttr";
    } else {
      decorationAttributes +=
          "${allBorders[0].setAttribute("borderTopWidth", "")}$topAttr${allBorders[1].setAttribute("borderRightWidth", "")}$rightAttr${allBorders[2].setAttribute("borderBottomWidth", "")}$bottomAttr${allBorders[3].setAttribute("borderLeftWidth", "")}$leftAttr";
    }
  }

  final boxShadows = properties["box-shadow"] ?? [];
  if (boxShadows.isNotEmpty) {
    decorationAttributes += "boxShadow: ${boxShadows.join(" ")}\n";

    // decorationAttributes += "boxShadow: [\n";

    // for (int j = 0; j < boxShadows.length; j++) {
    //   final boxShadow = boxShadows[j].toValues;

    //   String boxShadowString = "BoxShadow(";
    //   boxShadowString += "offset: Offset(${boxShadow[0]}, ${boxShadow[1]}), ";
    //   if (boxShadow.length > 4) {
    //     boxShadowString += "color: ${boxShadow[4].toReactColor}, ";
    //   }
    //   boxShadowString += boxShadow[2].setAttribute("blurRadius");
    //   boxShadowString += boxShadow[3].setAttribute("spreadRadius");

    //   boxShadowString += ")";
    //   decorationAttributes += "$boxShadowString, ";
    // }
    // decorationAttributes += "], ";
  }
  //final content = contents.isEmpty ? "" : [contents[0]];
  if (type == "Image") {
    decorationAttributes +=
        "backgroundImage: url(${contents.isEmpty ? "" : contents[0]})";
    // decorationAttributes +=
    //     "image: DecorationImage(image: AssetImage(\"${contents.isEmpty ? "" : [
    //         contents[0]
    //       ]}\".toPng), fit: BoxFit.cover,),";
  }
  if (circular && width != 0) {
    decorationAttributes += "borderRadius: ${width / 2},";
    //decorationAttributes += "shape: BoxShape.circle,";
  }

  String childAttributes = "";
  final content = contents.isNotEmpty ? contents[0] : "";
  final textAttr = textStyleAttributes.isNotEmpty ? textStyleAttributes[0] : "";

  if (type == "Image") {
    if (decorationAttributes.isNotEmpty) {
      decorationAttributes += "backgroundImage: url(\"$content\".toPng),";
    } else {
      final element = isReactNative ? "Image" : "img";
      childAttributes =
          "<$element style={ $attributes}>{\"$content\".toPng}</$element>";
    }
  } else if (type == "Svg") {
    final element = isReactNative ? "Svg" : "svg";
    childAttributes =
        "<$element style={ $attributes}>{\"$content\".toSvg}</$element>";
  } else if (type == "Icon") {
    final element = isReactNative ? "Icon" : "Icon";
    childAttributes =
        "<$element style={ $attributes}>{\"$content\".toPng}</$element>";
  } else {
    if (textStyleAttributes.isNotEmpty) {
      if (textStyleAttributes.length == 1) {
        //attributes = "style=const TextStyle(\n$textAttr),";
        final element = isReactNative ? "Text" : "p";
        childAttributes =
            "<$element style={ $textAttr}>{\"$content\"}</$element>";
      } else {
        String styleAttributes = "";
        for (int i = 1; i < textStyleAttributes.length; i++) {
          final attr = textStyleAttributes[i];
          final content = i < contents.length ? contents[i] : "";
          final element = isReactNative ? "Text" : "span";
          styleAttributes +=
              "<$element style={ $attr}>{\"$content\"}</$element>";
        }
        final element = isReactNative ? "Text" : "p";
        childAttributes =
            "<$element style={ $textAttr}>{\"$content\"}$styleAttributes</$element>";
      }
    }
  }
  //print("beforeOutput = $output, childAttributes = $childAttributes");

  bool addBracket = true;

  if (decorationAttributes.isNotEmpty) {
    if (decorationAttributes.length == 1 &&
        decorationAttributes[0].startsWith("backgroundColor:")) {
      attributes += decorationAttributes[0];
    } else {
      attributes += decorationAttributes;

      //attributes += "decoration: BoxDecoration(\n$decorationAttributes),";
    }
    final element = isReactNative ? "View" : "div";
    if (childAttributes.isNotEmpty) {
      output = "<$element style={ $attributes}>$childAttributes";
    } else {
      if (properties["height"] != null || properties["width"] != null) {
        output = "<$element style={ $attributes}>";
      } else {
        output += attributes;
        addBracket = false;
      }
    }
  } else {
    if (childAttributes.isNotEmpty) {
      output += childAttributes;
      addBracket = false;
    } else {
      if (attributes.isNotEmpty &&
          (properties["height"] != null || properties["width"] != null)) {
        final bool isHeightOrWidth = (attributes.length == 1 &&
                (properties["height"] != null ||
                    properties["width"] != null)) ||
            (attributes.length == 2 &&
                (properties["height"] != null && properties["width"] != null));
        // if (isHeightOrWidth) {
        //   output = "SizedBox(\n$attributes";
        // } else {
        //   output = "Container(\n$attributes";
        // }
        final element = isReactNative ? "View" : "div";
        output = "<$element style={ $attributes}>";
      } else {
        output += attributes;
        addBracket = false;
      }
    }
  }

  List<DetailsResult> results = [];

  if (detail.childrenCodeDetails.isNotEmpty) {
    for (int i = 0; i < detail.childrenCodeDetails.length; i++) {
      final childDetail = detail.childrenCodeDetails[i];
      final result =
          getReactDetailsResult(childDetail, width, height, isReactNative);
      results.add(result);
    }
  } else {}
  if (results.isNotEmpty) {
    if (results.length == 1) {
      output += "${results[0].output}\n";
    } else {
      final layoutOutput = getLayoutAlignmentOutput(top, left, height, width,
          results, justify, align, gap, "", isReactNative);
      output += "$layoutOutput\n";
    }
  }
  if (addBracket) {
    final element = isReactNative ? "View" : "div";
    output += "</$element>\n";
  }

  // if (clickable) {
  //   output = """GestureDetector(
  //       onTap: (){},
  //       child: $output,
  //     )""";
  // }
  return DetailsResult(
      output: output,
      height: height,
      width: width,
      left: left,
      top: top,
      expanded: detail.expanded,
      childrenDetailsResults: results);
}

String getLayoutAlignmentOutput(
    double layoutTop,
    double layoutLeft,
    double layoutHeight,
    double layoutWidth,
    List<DetailsResult> detailsResults,
    String justify,
    String align,
    double gap,
    String prevOutput,
    bool isReactNative,
    [String layout = "column"]) {
  String output = "";

  if (detailsResults.isEmpty) return "";

  final layoutRight = layoutLeft + layoutWidth;
  final layoutBottom = layoutTop + layoutHeight;

  List<double> lefts = [];
  List<double> rights = [];
  List<double> tops = [];
  List<double> bottoms = [];

  List<DetailsResult> allResults = List<DetailsResult>.from(detailsResults);
  List<List<DetailsResult>> results = [];
  final element = isReactNative ? "View" : "div";
  // print("justify = $justify, results = ${allResults.length}");

  if (gap != -1) {
    final firstResult = allResults[0];
    final widthDiff = layoutWidth - firstResult.width;
    final heightDiff = layoutHeight - firstResult.height;
    if (widthDiff > heightDiff) {
      layout = "row";
    } else {
      layout = "column";
    }
    if (justify.isEmpty) {
      justify = "start";
    }
    // if (align.isEmpty) {
    //   align = "start";
    // }

    for (int i = 0; i < allResults.length; i++) {
      final result = allResults[i];
      results.add([result]);

      tops.add(result.top);
      bottoms.add(result.top + result.height);
      lefts.add(result.left);
      rights.add(result.left + result.width);
    }
  } else {
    if (layout == "column") {
      allResults.sort((a, b) => a.top.compareTo(b.top));
    } else if (layout == "row") {
      allResults.sort((a, b) => a.left.compareTo(b.left));
    }
    List<DetailsResult> copiedResults = List<DetailsResult>.from(allResults);

    double currentFirst = -1;
    double currentLast = -1;

    for (int i = 0; i < allResults.length; i++) {
      final result = allResults[i];

      final first = layout == "column" ? result.top : result.left;
      final last = layout == "column"
          ? result.top + result.height
          : result.left + result.width;

      if (currentFirst == -1 && currentLast == -1) {
        currentFirst = first;
        currentLast = last;
        results.add([result]);

        tops.add(result.top);
        bottoms.add(result.top + result.height);
        lefts.add(result.left);
        rights.add(result.left + result.width);
      } else {
        if (first >= currentFirst && first <= currentLast) {
          results[results.length - 1].add(result);

          final lastTop = tops[tops.length - 1];
          if (result.top < lastTop) {
            tops[tops.length - 1] = result.top;
          }

          final lastBottom = bottoms[bottoms.length - 1];
          if (result.top + result.height > lastBottom) {
            bottoms[bottoms.length - 1] = result.top + result.height;
          }

          final lastLeft = lefts[lefts.length - 1];
          if (result.left < lastLeft) {
            lefts[lefts.length - 1] = result.left;
          }

          final lastRight = rights[rights.length - 1];
          if (result.left + result.width > lastRight) {
            rights[rights.length - 1] = result.left + result.width;
          }

          if (last > currentLast) {
            currentLast = last;
          }
        } else {
          if (copiedResults.isNotEmpty) {
            final nextResult = copiedResults.first;

            final first = layout == "column" ? nextResult.top : nextResult.left;
            final last = layout == "column"
                ? nextResult.top + nextResult.height
                : nextResult.left + nextResult.width;

            currentFirst = first;
            currentLast = last;

            results.add([result]);

            tops.add(nextResult.top);
            bottoms.add(nextResult.top + nextResult.height);
            lefts.add(nextResult.left);
            rights.add(nextResult.left + nextResult.width);
          }
        }
        copiedResults.remove(result);
      }
      // print(
      //     "first = $first, last = $last, currentFirst = $currentFirst, currentLast = $currentLast");
    }

    if (results.length == 1 && results[0].length == 1) {
      return results[0][0].output;
    }

    if (results.length == 1 && results[0].length > 1 && layout == "row") {
      return getLayoutAlignmentOutput(
          layoutTop,
          layoutLeft,
          layoutHeight,
          layoutWidth,
          detailsResults,
          "",
          "",
          0,
          prevOutput,
          isReactNative,
          "stack");
    }
  }
  // print("layout = $layout, layoutResults = ${results.length}");

  List<String> children = [];
  List<double> spacings = [];
  List<double> crossSpacings = [];
  List<String> aligns = [];
  Map<int, double> expandedSizes = {};

  double totalChildrenSize = 0;
  // print("gottenResults = $results");

  for (int i = 0; i < results.length; i++) {
    final subResults = results[i];

    final top = tops[i];
    final bottom = bottoms[i];
    final left = lefts[i];
    final right = rights[i];

    if (layout == "column" && subResults[0].expanded) {
      expandedSizes[i] = bottom - top;
    }
    if (layout == "row" && subResults[0].expanded) {
      expandedSizes[i] = right - left;
    }

    if (subResults.length == 1) {
      children.add(subResults[0].output);
    } else {
      if (layout == "stack") {
        for (int j = 0; j < subResults.length; j++) {
          final result = subResults[j];

          final resultTop = result.top;
          final resultBottom = result.top + result.height;
          final resultLeft = result.left;
          final resultRight = result.left + result.width;

          final stackTop = resultTop - top;
          final stackBottom = bottom - resultBottom;
          final stackLeft = resultLeft - left;
          final stackRight = right - resultRight;

          double topPos = -1;
          double bottomPos = -1;
          double leftPos = -1;
          double rightPos = -1;

          if ((stackRight - stackLeft).abs() <= 5) {
            leftPos = stackLeft;
            rightPos = stackRight;
            align = "center";
          } else if (stackRight > stackLeft) {
            leftPos = stackLeft;
            align = "start";
          } else if (stackRight < stackLeft) {
            rightPos = stackRight;
            align = "end";
          }

          if ((stackBottom - stackTop).abs() <= 5) {
            topPos = stackTop;
            bottomPos = stackBottom;
            align = "center";
          } else if (stackBottom > stackTop) {
            topPos = stackTop;
            align = "start";
          } else if (stackBottom < stackTop) {
            bottomPos = stackBottom;
            align = "end";
          }
          final posSets = {topPos, bottomPos, leftPos, rightPos};

          if (posSets.length == 1 && posSets.first == 0) {
            children.add(
                "<$element style={position: absolute, top: 0, right: 0, bottom: 0, left: 0}>${result.output}</$element>\n");
          } else {
            //&& rightPos > 0 && leftPos > 0
            if (topPos == 0 && leftPos == 0) {
              children.add(
                  "<$element style={position: absolute}>${result.output}</$element>");
            } else {
              String posString = "<$element style={position: absolute,";

              if (topPos != -1) {
                posString += "top: $topPos, ";
              }

              if (rightPos != -1) {
                posString += "right: $rightPos, ";
              }
              if (bottomPos != -1) {
                posString += "bottom: $bottomPos, ";
              }
              if (leftPos != -1) {
                posString += "left: $leftPos, ";
              }

              posString += "}>${result.output}</$element>\n";
              children.add(posString);
            }
          }
        }
      } else {
        final height = bottom - top;
        final width = right - left;
        final nextLayout = layout == "column" ? "row" : "column";

        children.add(getLayoutAlignmentOutput(
            top,
            left,
            height,
            width,
            subResults,
            justify,
            align,
            gap,
            prevOutput,
            isReactNative,
            nextLayout));

        if (layout == "column") {
          totalChildrenSize += (bottom - top);
        } else {
          totalChildrenSize += (right - left);
        }

        if (i > 0) {
          if (layout == "column") {
            spacings.add(tops[i] - bottoms[i - 1]);
          } else {
            spacings.add(lefts[i] - rights[i - 1]);
          }
        } else {
          if (layout == "column") {
            spacings.add(tops[i] - layoutTop);
          } else {
            spacings.add(lefts[i] - layoutLeft);
          }
        }
        if (i == results.length - 1) {
          if (layout == "column") {
            spacings.add(layoutBottom - bottoms[i]);
          } else {
            spacings.add(layoutRight - rights[i]);
          }
        }
        if (gap == 0) {
          totalChildrenSize += spacings[i];
        } else {
          totalChildrenSize += gap;
        }
        if (i == results.length - 1) {
          totalChildrenSize += spacings[i + 1];
        }

        if (layout == "column") {
          final actualRight = layoutRight - right;
          if ((actualRight - left).abs() <= 5) {
            align = actualRight <= 5 ? "stretch" : "center";
            crossSpacings.add((actualRight - left).abs());
          } else if (actualRight > left) {
            align = "start";
            crossSpacings.add(actualRight);
          } else if (actualRight < left) {
            align = "end";
            crossSpacings.add(left);
          } else {
            align = "baseline";
            crossSpacings.add(left);
          }
        } else {
          final actualBottom = layoutBottom - bottom;
          if ((actualBottom - top).abs() <= 5) {
            align = actualBottom <= 5 ? "stretch" : "center";
            crossSpacings.add((actualBottom - top).abs());
          } else if (actualBottom > top) {
            align = "start";
            crossSpacings.add(actualBottom);
          } else if (actualBottom < top) {
            align = "end";
            crossSpacings.add(top);
          } else {
            align = "baseline";
            crossSpacings.add(top);
          }
        }

        aligns.add(align);
      }
    }
  }
  if (layout != "stack" && results.length == 1) {
    if (results.isNotEmpty) {
      output += children[0];
    }
    return output;
  }

  bool isFullSize = false;
  if (layout != "stack") {
    if (justify.isEmpty && spacings.length > 1) {
      // final otherSpacings = spacings.sublist(1, spacings.length - 1);
      // List<List<double>> commonSpacings = [];
      bool sameFirstAndLast = (spacings.first - spacings.last).abs() <= 5;
      bool sameInnerSpacing = true;
      double firstLastSpacing = spacings[0];
      double minSpacing = spacings[1];

      if (spacings.length > 2) {
        for (int i = 0; i < spacings.length; i++) {
          final spacing = spacings[i];
          if (i != 0 &&
              i != spacings.length - 1 &&
              (minSpacing - spacing).abs() > 5) {
            sameInnerSpacing = false;
          }
        }
      }
      if (sameFirstAndLast && sameInnerSpacing) {
        if (spacings.first <= 1 && spacings.last <= 1) {
          justify = "space-between";
        } else if ((firstLastSpacing - minSpacing).abs() <= 5) {
          if (firstLastSpacing > 5) {
            justify = "space-evenly";
          } else {
            justify = "flex-start";
          }
        } else if (firstLastSpacing > minSpacing) {
          justify = "center";
        } else {
          justify = "space-around";
        }
      } else {
        if (!sameFirstAndLast && sameInnerSpacing) {
          if (spacings.first > spacings.last) {
            justify = "flex-end";
          } else if (spacings.last > spacings.first) {
            justify = "flex-start";
          }
        } else {
          if ((layout == "column" &&
                  (totalChildrenSize - layoutHeight).abs() <= 10) ||
              (layout == "row" &&
                  (totalChildrenSize - layoutWidth).abs() <= 10)) {
            justify = "flex-start";
            isFullSize = true;
          } else {}
        }
      }
    }
    if (align.isEmpty && aligns.isNotEmpty) {
      Map<String, List<int>> mappedAligns = {};
      int maxAligns = 0;
      String maxAlign = "";
      int centerCount = 0;
      int stretchCount = 0;
      for (int i = 0; i < aligns.length; i++) {
        final align = aligns[i];
        if (align == "center") {
          centerCount++;
        }
        if (align == "stretch") {
          stretchCount++;
        }
        if (mappedAligns[align] == null) {
          mappedAligns[align] = [i];
        } else {
          mappedAligns[align]!.add(i);
        }
        if (mappedAligns[align]!.length > maxAligns) {
          maxAligns = mappedAligns[align]!.length;
          maxAlign = align;
        }
      }

      align = maxAlign;
      if (align == "center" || align == "stretch") {
        align = centerCount > stretchCount ? "center" : "stretch";
      }
      if (align != maxAlign) {
        mappedAligns[align]!.addAll(mappedAligns[maxAlign]!);
        mappedAligns.remove(maxAlign);
      }
      mappedAligns.remove(align);
      if (mappedAligns.isNotEmpty) {
        for (var entry in mappedAligns.entries) {
          final align = entry.key;
          final values = entry.value;
          for (int i = 0; i < values.length; i++) {
            final index = values[i];
            String alignment = "";
            final spacing = crossSpacings[index];

            switch (align) {
              case "center":
                alignment = "center";
              case "start":
                alignment = layout == "column" ? "centerLeft" : "topCenter";
              case "end":
                alignment = layout == "column" ? "centerRight" : "bottomCenter";
            }
            if (alignment == "stretch") {
              children[index] =
                  "<$element style={${layout == "column" ? "width" : "height"}: 100%}>${children[index]}</$element>\n";
            } else {
              final alignmentFlex = getAligmentFlex(alignment);
              if (spacing > 0) {
                if (alignment == "center") {
                  children[index] =
                      "<$element style={$alignmentFlex}>${children[index]}</$element>\n";
                } else {
                  String paddingPosition = "";
                  if (alignment == "start") {
                    paddingPosition = layout == "column" ? "top" : "left";
                  } else {
                    paddingPosition = layout == "column" ? "bottom" : "right";
                  }
                  children[index] =
                      "<$element style={padding${paddingPosition.capitalize()}: $spacing,$alignmentFlex>${children[index]}</$element>\n";
                }
              } else {
                children[index] =
                    "<$element style={$alignmentFlex}>${children[index]}</$element>\n";
              }
            }
          }
        }
      }
    }
  } else {}

  output += "${layout.capitalize()}(";

  if (justify.isNotEmpty && justify != "flex-start") {
    output += "justifyContent: ${justify.toSnakeCase},";
  }
  //&& align != "center"
  if (align.isNotEmpty) {
    output += "alignItems: ${align.toSnakeCase},";
  }

  String childrenString = "";
  final bool needsGap = layout != "stack" &&
      (justify == "start" || justify == "end" || justify == "center");

  if (needsGap && spacings.isNotEmpty && spacings[0] > 0) {
    childrenString +=
        "<$element style={${layout == "column" ? "height" : "width"}: ${spacings[0]}}></$element>\n";
  }
  double totalExpandedSize = 0;
  for (var value in expandedSizes.values) {
    totalExpandedSize += value;
  }
  print(
      "layout = $layout, expandedSizes = $expandedSizes, totalExpandedSize = $totalExpandedSize");

  for (int i = 0; i < children.length; i++) {
    final child = children[i];
    if (expandedSizes[i] != null) {
      final flex = ((expandedSizes[i]! / totalExpandedSize) * 10).toInt();
      childrenString +=
          "<$element style={${"flex: $flex, "}>$child</$element>\n";
    } else {
      childrenString += child;
    }
    if (gap != 0 || (needsGap && spacings.length > 2 && spacings[i + 1] > 0)) {
      childrenString +=
          "<$element style={${layout == "column" ? "height" : "width"}: ${gap != 0 ? gap : spacings[i + 1]}}></$element>\n";
    }
  }

  if (needsGap && spacings.length > 1 && spacings[spacings.length - 1] > 0) {
    childrenString +=
        "<$element style={${layout == "column" ? "height" : "width"}: ${spacings[spacings.length - 1]}}></$element>\n";
  }

  childrenString += "\n";
  output += childrenString;
  output += "\n";

  return output;
}

String getAligmentFlex(String alignment) {
  String justifyContent = "";
  String alignItems = "";
  alignment = alignment.toLowerCase();
  if (alignment.contains("top")) {
    justifyContent = "flex-start";
  }
  if (alignment.contains("bottom")) {
    justifyContent = "flex-end";
  }
  if (alignment.contains("left")) {
    alignItems = "flex-start";
  }
  if (alignment.contains("right")) {
    alignItems = "flex-end";
  }
  if (alignment == "center") {
    alignItems = "center";
    justifyContent = "center";
  } else if (alignment.contains("center")) {
    if (alignment.contains("left") || alignment.contains("right")) {
      justifyContent = "center";
    } else {
      alignItems = "center";
    }
  }
  return "display:flex, flexDirection: column, justifyContent: $justifyContent, alignItems: $alignItems";
}

Alignment calculateAlignment(double angleInDegrees) {
  // Convert degrees to radians
  double angleInRadians = angleInDegrees * pi / 180;

  // Calculate the x and y components of the gradient vector
  double x = cos(angleInRadians);
  double y = sin(angleInRadians);

  // Adjust the components to fit into the Alignment range (-1 to 1)
  x = (x + 1) / 2;
  y = (y + 1) / 2;

  // Create Alignment from the calculated components
  return Alignment(x * 2 - 1, y * 2 - 1);
}
