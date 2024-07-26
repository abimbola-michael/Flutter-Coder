import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_coder/features/converter/models/details_result.dart';
import 'package:flutter_coder/features/shared/utils/extensions.dart';
import '../models/code_detail.dart';

String reformatFlutterString(String string) {
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
    if (char.isEmpty) continue;

    if (char == "(" || char == "[") {
      // final endChar = char == "(" ? ")" : ["]"];
      // while (i < string.length && char != endChar) {
      //   i++;
      //   char = string[i];
      //   foundComma = char == ",";
      // }
      // if (foundComma) {}
      tabs++;
    } else if (char == ")" || char == "]") {
      tabs--;
    }

    if (needsTab) {
      // if (char == ",") {
      //   String nextChar = "";

      //   formattedString += "";
      // } else {}
      formattedString += "\t" * tabs * 2;
    }

    // if (char == ")" && !foundComma) {
    //   formattedString += ",\n${"\t" * tabs * 2}";
    // }

    if (char == "(" || char == "[" || char == ",") {
      if (foundComma && char == ",") {
        char = "";
      }
      formattedString += "$char\n";
    } else if (char == ":") {
      formattedString += "$char ";
    } else {
      formattedString += char;
    }
    needsTab = char == "(" || char == "[" || char == ",";
    foundComma = char == ",";

    if (formattedString.endsWith("const")) {
      formattedString += " ";
    }
  }
  return formattedString;
}

Map<String, String> getDefaults(String string) {
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

DetailsResult getFlutterDetailsResult(
    CodeDetail detail, double? totalWidth, double? totalHeight) {
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
      attributes += "width: double.infinity,\n";
    }
  }

  double bottom = (totalHeight ?? 0) - (top + height);
  bool isHeightInfinity = (top - bottom).abs() <= 5;

  if (height > 0) {
    if (totalHeight == null || !isHeightInfinity) {
      attributes += height.toString().setAttribute("height");
    } else {
      attributes += "height: double.infinity,\n";
    }
  }

  final padding = properties["padding"].toValues.toTopRightBottomLeft;
  if (padding.isNotEmpty) {
    bool isSame = padding.every((element) => element == padding[0]);
    if (isSame) {
      attributes += "padding: const EdgeInsets.all(${padding[0]}),\n";
    } else if (padding[0] == padding[2] && padding[1] == padding[3]) {
      attributes +=
          "padding: const EdgeInsets.symmetric(${padding[0].setAttribute("vertical")}${padding[1].setAttribute("horizontal")}),\n";
    } else {
      attributes +=
          "padding: const EdgeInsets.only(${padding[0].setAttribute("top")}${padding[1].setAttribute("right")}${padding[2].setAttribute("bottom")}${padding[3].setAttribute("left")}),\n";
    }
  }
  final margin = properties["margin"].toValues.toTopRightBottomLeft;
  if (margin.isNotEmpty) {
    bool isSame = margin.every((element) => element == margin[0]);
    if (isSame) {
      attributes += "margin: const EdgeInsets.all(${margin[0]}),\n";
    } else if (margin[0] == margin[2] && margin[1] == margin[3]) {
      attributes +=
          "margin: const EdgeInsets.symmetric(${margin[0].setAttribute("vertical")}${margin[1].setAttribute("horizontal")}),\n";
    } else {
      attributes +=
          "margin: const EdgeInsets.only(${margin[0].setAttribute("top")}${margin[1].setAttribute("right")}${margin[2].setAttribute("bottom")}${margin[3].setAttribute("left")}),\n";
    }
  }

  ///Text

  // final fontFamilies = properties["font-family"] ?? [];
  // if (fontFamilies.isNotEmpty) {
  //   for (int i = 0; i < fontFamilies.length; i++) {
  //     final fontFamily = fontFamilies[i];
  //     final isSame = i > 0 && fontFamilies[0] == fontFamily;
  //     final value = isSame ? "" : "fontFamily: $fontFamily,\n";
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
      final value = isSame ? "" : "fontSize: $fontSize,\n";
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

      final value = isSame ? "" : "fontWeight: FontWeight.w$fontWeight,\n";
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

    final value = isSame || textAlign == "left"
        ? ""
        : "textAlign: TextAlign.$textAlign,\n";

    attributes += value;
    // if (i < textStyleAttributes.length) {
    //   textStyleAttributes[i] += value;
    // } else {
    //   textStyleAttributes.add(value);
    // }
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
        final actualColor = color.first.toColor;

        final addConst = actualColor.startsWith("Color") &&
            (textStyleAttributes.isEmpty ||
                i >= textStyleAttributes.length ||
                textStyleAttributes[i].isEmpty);
        // print("addConst = $addConst");
        // print("color = $color");
        // print("firstColor = ${color.first}");
        // print("color = ${color.first.toColor}");
        value = "color: ${addConst ? "const " : ""}$actualColor,\n";
      } else {
        if (color[0].startsWith("linear-gradient")) {
          String gradientAttr = "gradient: LinearGradient(";
          List<String> colors = [];
          List<String> stops = [];
          String degreeValue = color[0].replaceAll("linear-gradient(", "");
          double angle = double.parse(
              degreeValue.substring(0, degreeValue.indexOf("deg")));
          Alignment beginAlignment = calculateAlignment(angle);
          Alignment endAlignment = calculateAlignment(angle + 180);

          if (beginAlignment != Alignment.centerLeft &&
              beginAlignment != Alignment.centerRight) {
            gradientAttr += "begin: $beginAlignment,\n";
            gradientAttr += "end: $endAlignment,\n";
          }

          for (int i = 1; i < color.length; i++) {
            final colorValue = color[i].replaceAll(")", "");
            if (colorValue.contains("%")) {
              final percentString =
                  colorValue.substring(0, colorValue.indexOf("%"));
              final stopString = double.tryParse(percentString) != null
                  ? (double.parse(percentString) / 100).toString()
                  : percentString;
              stops.add(stopString);
            } else {
              colors.add(colorValue);
            }
          }

          String colorsString = colors.map((col) => col.toColor).join(",\n");

          gradientAttr += "colors: const [\n$colorsString],\n";

          if (stops.isNotEmpty) {
            String stopsString = stops.map((stop) => stop).join(",\n");
            gradientAttr += "stops: const [\n$stopsString]";
          }

          gradientAttr += "),\n";
          value = gradientAttr;
        }
      }
      allColors.add(value);
    }
  }

  if (allColors.isNotEmpty) {
    if (textStyleAttributes.isNotEmpty) {
      for (int i = 0; i < textStyleAttributes.length; i++) {
        final color = i < allColors.length ? allColors[i] : allColors[0];
        textStyleAttributes[i] += color;
      }
    } else {
      decorationAttributes += allColors[0];
    }
  }

  final borderRadius = radius != null && radius > 0
      ? ["$radius"].toTopRightBottomLeft
      : properties["border-radius"].toValues.toTopRightBottomLeft;
  if (borderRadius.isNotEmpty && !circular) {
    bool isSame = borderRadius.every((element) => element == borderRadius[0]);
    if (isSame) {
      decorationAttributes +=
          "borderRadius: BorderRadius.circular(${borderRadius[0]}),\n";
    } else if (borderRadius[0] == borderRadius[2] &&
        borderRadius[1] == borderRadius[3]) {
      decorationAttributes +=
          "borderRadius: BorderRadius.symmetric(${borderRadius[0].setAttribute("vertical", "Radius.circular(${borderRadius[0]})")}${borderRadius[1].setAttribute("horizontal", "Radius.circular(${borderRadius[1]})")})\n";
    } else {
      decorationAttributes +=
          "borderRadius: BorderRadius.only(${borderRadius[0].setAttribute("topLeft", "Radius.circular(${borderRadius[0]})")}${borderRadius[1].setAttribute("topRight", "Radius.circular(${borderRadius[1]})")}${borderRadius[2].setAttribute("bottomRight", "Radius.circular(${borderRadius[2]})")}${borderRadius[3].setAttribute("bottomLeft", "Radius.circular(${borderRadius[3]})")})\n";
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
        " color: const ${border[2].toColor}, ${border[1] != "solid" ? "style: ${border[1]}," : ""}";
  }

  if (borderTop.length == 3 && borderTop[0].isFinite) {
    topAttr =
        " color: const ${borderTop[2].toColor}, ${borderTop[1] != "solid" ? "style: ${borderTop[1]}," : ""}";
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
        " color: const ${borderRight[2].toColor}, ${borderRight[1] != "solid" ? "style: ${borderRight[1]}," : ""}";
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
        " color: const ${borderBottom[2].toColor}, ${borderBottom[1] != "solid" ? "style: ${borderBottom[1]}," : ""}";

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
        " color: const ${borderLeft[2].toColor}, ${borderLeft[1] != "solid" ? "style: ${borderLeft[1]}," : ""}";
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
          "border: Border.all(${allBorders[0].setAttribute("width", "", "1")}$attr),\n";
    } else if (allBorders[0] == allBorders[2] &&
        allBorders[1] == allBorders[3]) {
      decorationAttributes +=
          "border: Border.symmetric(${allBorders[0].setAttribute("vertical", "BorderSide(${allBorders[0].setAttribute("width", "", "1")}$topAttr)")}${allBorders[1].setAttribute("horizontal", "BorderSide(${allBorders[1].setAttribute("width", "", "1")}$leftAttr)")}\n";
    } else {
      decorationAttributes +=
          "border: Border(${allBorders[0].setAttribute("top", "BorderSide(width: ${allBorders[0]},$topAttr)")}${allBorders[1].setAttribute("right", "BorderSide(width: ${allBorders[1]},$rightAttr)")}${allBorders[2].setAttribute("bottom", "BorderSide(width: ${allBorders[2]},$bottomAttr)")}${allBorders[3].setAttribute("left", "BorderSide(width: ${allBorders[3]},$leftAttr)")}),\n";
    }
  }

  final boxShadows = properties["box-shadow"] ?? [];
  if (boxShadows.isNotEmpty) {
    decorationAttributes += "boxShadow: [\n";

    for (int j = 0; j < boxShadows.length; j++) {
      final boxShadow = boxShadows[j].toValues;

      String boxShadowString = "BoxShadow(";
      boxShadowString += "offset: Offset(${boxShadow[0]}, ${boxShadow[1]}),\n";
      if (boxShadow.length > 4) {
        boxShadowString += "color: ${boxShadow[4].toColor},\n";
      }
      boxShadowString += boxShadow[2].setAttribute("blurRadius");
      boxShadowString += boxShadow[3].setAttribute("spreadRadius");

      boxShadowString += ")";
      decorationAttributes += "$boxShadowString,\n";
    }
    decorationAttributes += "],\n";
  }
  //final content = contents.isEmpty ? "" : [contents[0]];
  if (type == "Image") {
    decorationAttributes +=
        "image: DecorationImage(image: AssetImage(\"${contents.isEmpty ? "" : [
            contents[0]
          ]}\".toPng), fit: BoxFit.cover,),";
  }
  if (circular) {
    decorationAttributes += "shape: BoxShape.circle,";
  }

  String childAttributes = "";
  final content = contents.isNotEmpty ? contents[0] : "";
  final textAttr = textStyleAttributes.isNotEmpty ? textStyleAttributes[0] : "";

  if (type == "Image") {
    if (decorationAttributes.isNotEmpty) {
      decorationAttributes +=
          "image: BoxDecoration(image: AssetImage(\"$content\".toPng),),";
    } else {
      childAttributes = "Image.asset(\"$content\".toPng, $attributes";
    }
  } else if (type == "Svg") {
    childAttributes = "SvgPicture.asset(\"$content\".toSvg, $attributes";
  } else if (type == "Icon") {
    childAttributes = "Icon(Icons.$content, $attributes";
  } else {
    if (textStyleAttributes.isNotEmpty) {
      if (textStyleAttributes.length == 1) {
        attributes = "style: const TextStyle(\n$textAttr),";
        childAttributes = "Text(\"$content\",\n$attributes";
      } else {
        String styleAttributes = "";
        for (int i = 1; i < textStyleAttributes.length; i++) {
          final attr = textStyleAttributes[i];
          final content = i < contents.length ? contents[i] : "";
          styleAttributes +=
              "TextSpan(\ntext: \"$content\",\nstyle: const TextStyle(\n$attr),),";
        }
        childAttributes +=
            "RichText(text: TextSpan(\ntext: \"$content\",\nstyle: const TextStyle(\n$textAttr),\nchildren: [\n$styleAttributes],),";
      }
    }
  }
  //print("beforeOutput = $output, childAttributes = $childAttributes");

  bool addBracket = true;

  if (decorationAttributes.isNotEmpty) {
    if (decorationAttributes.length == 1 &&
        decorationAttributes[0].startsWith("color:")) {
      attributes += decorationAttributes[0];
    } else {
      attributes += "decoration: BoxDecoration(\n$decorationAttributes),";
    }
    if (childAttributes.isNotEmpty) {
      output = "Container(\n$attributes\nchild: $childAttributes";
    } else {
      if (properties["height"] != null || properties["width"] != null) {
        output = "Container(\n$attributes";
      } else {
        output += attributes;
        addBracket = false;
      }
    }
  } else {
    if (childAttributes.isNotEmpty) {
      output += childAttributes;
    } else {
      if (attributes.isNotEmpty &&
          (properties["height"] != null || properties["width"] != null)) {
        final bool isHeightOrWidth = (attributes.length == 1 &&
                (properties["height"] != null ||
                    properties["width"] != null)) ||
            (attributes.length == 2 &&
                (properties["height"] != null && properties["width"] != null));
        if (isHeightOrWidth) {
          output = "SizedBox(\n$attributes";
        } else {
          output = "Container(\n$attributes";
        }
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
      final result = getFlutterDetailsResult(childDetail, width, height);
      results.add(result);
    }
  }
  if (results.isNotEmpty) {
    if (results.length == 1) {
      output += "child: ${results[0].output}\n";
    } else {
      final layoutOutput = getLayoutAlignmentOutput(
          top, left, height, width, results, justify, align, gap, "");
      output += "child: $layoutOutput\n";
    }
  }
  if (addBracket) {
    output += "),\n";
  }

  if (clickable) {
    output = """GestureDetector(
        onTap: (){},
        child: $output,
      )""";
  }
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
      return getLayoutAlignmentOutput(layoutTop, layoutLeft, layoutHeight,
          layoutWidth, detailsResults, "", "", 0, prevOutput, "stack");
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
            children.add("Positioned.fill(child: ${result.output}),\n");
          } else {
            //&& rightPos > 0 && leftPos > 0
            if (topPos == 0 && leftPos == 0) {
              children.add(result.output);
            } else {
              String posString = "Positioned(\n";

              if (topPos != -1) {
                posString += "top: $topPos,\n";
              }

              if (rightPos != -1) {
                posString += "right: $rightPos,\n";
              }
              if (bottomPos != -1) {
                posString += "bottom: $bottomPos,\n";
              }
              if (leftPos != -1) {
                posString += "left: $leftPos,\n";
              }

              posString += "child: ${result.output}),\n";
              children.add(posString);
            }
          }
        }
      } else {
        final height = bottom - top;
        final width = right - left;
        final nextLayout = layout == "column" ? "row" : "column";

        children.add(getLayoutAlignmentOutput(top, left, height, width,
            subResults, justify, align, gap, prevOutput, nextLayout));

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
          justify = "spaceBetween";
        } else if ((firstLastSpacing - minSpacing).abs() <= 5) {
          if (firstLastSpacing > 5) {
            justify = "spaceEvenly";
          } else {
            justify = "start";
          }
        } else if (firstLastSpacing > minSpacing) {
          justify = "center";
        } else {
          justify = "spaceAround";
        }
      } else {
        if (!sameFirstAndLast && sameInnerSpacing) {
          if (spacings.first > spacings.last) {
            justify = "end";
          } else if (spacings.last > spacings.first) {
            justify = "start";
          }
        } else {
          if ((layout == "column" &&
                  (totalChildrenSize - layoutHeight).abs() <= 10) ||
              (layout == "row" &&
                  (totalChildrenSize - layoutWidth).abs() <= 10)) {
            justify = "start";
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
                  "SizedBox(${layout == "column" ? "width" : "height"}: double.infinity,\nchild: ${children[index]}),\n";
            } else {
              if (spacing > 0) {
                if (alignment == "center") {
                  children[index] = "Center(child: ${children[index]}),\n";
                } else {
                  String paddingPosition = "";
                  if (alignment == "start") {
                    paddingPosition = layout == "column" ? "top" : "left";
                  } else {
                    paddingPosition = layout == "column" ? "bottom" : "right";
                  }
                  children[index] =
                      "Container(padding: const EdgeInsets.only($paddingPosition: $spacing),\nalignment: $alignment,\nchild: ${children[index]}),\n";
                }
              } else {
                children[index] =
                    "Align(alignment: $alignment,\nchild: ${children[index]}),\n";
              }
            }
          }
        }
      }
    }
  } else {}

  output += "${layout.capitalize()}(";

  if (justify.isNotEmpty && justify != "start") {
    output += "mainAxisAlignment: MainAxisAlignment.${justify.toCamelCase},";
  }
  if (align.isNotEmpty && align != "center") {
    output += "crossAxisAlignment: CrossAxisAlignment.${align.toCamelCase},";
  }

  String childrenString = "children: [";
  final bool needsGap = layout != "stack" &&
      (justify == "start" || justify == "end" || justify == "center");

  if (needsGap && spacings.isNotEmpty && spacings[0] > 0) {
    childrenString +=
        "SizedBox(${layout == "column" ? "height" : "width"}: ${spacings[0]}),\n";
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
          "Expanded(${flex == 1 ? "" : "flex: $flex,\n"}child: $child,),\n";
    } else {
      childrenString += child;
    }
    if (gap != 0 || (needsGap && spacings.length > 2 && spacings[i + 1] > 0)) {
      childrenString +=
          "SizedBox(${layout == "column" ? "height" : "width"}: ${gap != 0 ? gap : spacings[i + 1]}),\n";
    }
  }

  if (needsGap && spacings.length > 1 && spacings[spacings.length - 1] > 0) {
    childrenString +=
        "SizedBox(${layout == "column" ? "height" : "width"}: ${spacings[spacings.length - 1]}),\n";
  }

  childrenString += "],\n";
  output += childrenString;
  output += "),\n";

  return output;
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
