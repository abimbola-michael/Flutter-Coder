import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_coder/features/emulator/utils/extensions.dart';
import '../models/input.dart';
import 'data.dart';

List<List<T>> getCombinations<T>(List<T> items, int length) {
  final List<List<T>> result = [];

  if (items.length < length) {
    return result;
  }

  final combinations = <T>[];
  void generate(int start, int depth) {
    if (depth == length) {
      result.add(List.from(combinations));
      return;
    }

    for (int i = start; i < items.length; i++) {
      combinations.add(items[i]);
      generate(i + 1, depth + 1);
      combinations.removeLast();
    }
  }

  generate(0, 0);
  return result;
}

List<String> getModifiers(List<String> texts) {
  List<String> modifiers = [];
  for (int i = 0; i < texts.length; i++) {
    final text = texts[i].trim();
    if (text == "const" ||
        text == "final" ||
        text == "var" ||
        text == "abstract" ||
        text == "static" ||
        text == "factory" ||
        text == "late" ||
        text == "external" ||
        text == "sealed" ||
        text.startsWith("@")) {
      modifiers.add(text);
    } else {
      break;
    }
  }
  return modifiers;
}

String getOfType(List<String> parameters) {
  String type = "";
  if (!parameters.first.contains("<")) return "";
  if (parameters.first.endsWith(">")) {
    return "";
  }
  for (int i = 0; i < parameters.length; i++) {
    final parameter = parameters[i];
    if (parameter.endsWith(">")) {
      type = parameter.substring(0, parameter.length - 1);
      break;
    }
  }
  return type;
}

String getType(Input input) {
  String type = "";
  String inputType = input.inputType;
  final parameters = input.parameters;
  if (parameters.isEmpty) return "";

  if (inputType == "variable") {
    if (input.modifiers.isNotEmpty) {
      type =
          parameters.isNotEmpty && parameters.isNotEmpty ? parameters[0] : "";
    } else {
      type = parameters[0];
    }
  } else if (inputType == "function") {
    type = parameters.first.contains("(") ? "" : parameters.first;
  } else if (inputType == "class") {
    final extendsIndex = parameters.indexOf("extends");
    if (extendsIndex != -1 && (extendsIndex + 1) < parameters.length) {
      final secondParameter = parameters[extendsIndex + 1];
      if (secondParameter.contains("<") && secondParameter.contains(">")) {
        type = secondParameter.substring(0, secondParameter.indexOf("<"));
      } else {
        type = secondParameter;
      }
    }
  }

  return type;
}

String getInputValue(Input input) {
  String inputValue = "";
  String inputType = input.inputType;
  final parameters = input.parameters;
  if (parameters.isEmpty) return "";
  if (inputType == "variable") {
    final fullString = parameters.join(" ");
    List<String> variables = [];
    if (fullString.contains(",")) {
      variables = fullString.splitUseStringIfEmpty(",");
    } else {
      variables.add(fullString);
    }
    if (variables.isNotEmpty) {
      for (int i = 0; i < variables.length; i++) {
        final variable = variables[i];
        final equalsIndex = variable.indexOf("=");
        String value = "";
        if (equalsIndex != -1) {
          value = variable.substring(equalsIndex + 1).trim();
          if (value.contains(";")) {
            final semicolonIndex = variable.lastIndexOf(";");
            value = value.substring(0, semicolonIndex);
          }
        } else {
          value = " ";
        }
        inputValue += value;
      }
    }
  } else if (inputType == "function") {
    final fullString = parameters.join(" ");
    int index = -1;
    int increment = 0;
    if (fullString.contains("=>")) {
      index = fullString.lastIndexOf("=>");
      increment = 2;
    } else if (fullString.contains("return")) {
      index = fullString.lastIndexOf("return");
      increment = 6;
    }
    if (index != -1) {
      inputValue = fullString.substring(index + increment).trim();
      if (inputValue.contains(";")) {
        final semicolonIndex = inputValue.lastIndexOf(";");
        inputValue = inputValue.substring(0, semicolonIndex);
      }
    }
  }
  return inputValue;
}

String getInputName(Input input) {
  String inputName = "";
  String inputType = input.inputType;
  final parameters = input.parameters;
  if (parameters.isEmpty) return "";
  if (inputType == "variable") {
    if (input.modifiers.isNotEmpty) {
      inputName = parameters.length > 1
          ? parameters[1].contains("=")
              ? parameters[0]
              : parameters[1]
          : "";
    } else {
      inputName = parameters.length > 1 ? parameters[1] : "";
    }
    if (inputName.endsWith(";")) {
      inputName = inputName.substring(0, inputName.length - 1);
    }
  } else if (inputType == "function" || inputType == "constructor") {
    final index = parameters.containsIndex("(");
    if (index != -1) {
      inputName = parameters[index].split("(").first;
    }
    if (inputType == "function" && parameters.containsChar("=>")) {
      final index = parameters.containsIndex("=>");
      if (index != -1) {
        inputName = parameters[index - 1];
      }
    }
  } else {
    inputName = parameters.first;
  }
  if (inputName.contains("<")) {
    inputName = inputName.split("<").first;
  }
  //IntProperty
  return inputName;
}

String getInputType(String className, List<String> texts) {
  String inputType = "";

  if (texts.length > 2 && texts.first == "static" && texts[2].contains("(")) {
    return "function";
  }
  for (int i = 0; i < texts.length; i++) {
    final text = texts[i].trim();
    if (text == "class" ||
        text == "enum" ||
        text == "mixin" ||
        text == "import" ||
        text == "export") {
      inputType = text;
      break;
    } else if ((text == "late" && i == 0) ||
        (((text == "const" &&
                    (i + 1) < texts.length &&
                    !texts[i + 1].contains(className) &&
                    !texts[i + 1].contains("(")) ||
                text == "final" ||
                text == "var") &&
            i < 2) ||
        (text.endsWith("=") && text.length != 2 && (i + 1) < texts.length)) {
      inputType = "variable";
      break;
    } else if (text == "get") {
      inputType = "function";
      break;
    } else if ((text.contains("(") && i < 2) || text.endsWith("=>")) {
      inputType =
          text.contains("(") && className != "" && text.startsWith(className)
              ? "constructor"
              : "function";
      break;
    }
    int index = 0;
    if (texts.first == "late") {
      index = 1;
    }
    if (texts.length == 2 && texts[index].endsWith("?")) {
      inputType = "variable";
    }
    if (i > 6) {
      break;
    }
  }
  return inputType;
}

// List<Input> getInputsParameters(String string, String filePath) {
//   List<Input> inputs = [];
//   List<String> linesStrings = string.splitUseStringIfEmpty("\n");
//   bool inClass = false,
//       inBlock = false,
//       inConstructor = false,
//       inComma = false,
//       startedCommenting = false,
//       isDeprecation = false;

//   String className = "", currentType = "";
//   int classCurlyBraces = 0;
//   int blockCurlyBraces = 0;
//   int openedComment = 0;
//   List<String> atModifiers = [];

//   if (linesStrings.isNotEmpty) {
//     for (int i = 0; i < linesStrings.length; i++) {
//       final lineString = linesStrings[i];
//       List<String> words = lineString.trim().splitUseStringIfEmpty(" ");
//       if (words.isNotEmpty) {
//         if (!isDeprecation && words.first.startsWith("@Deprecated(")) {
//           isDeprecation = true;
//         }
//         if (isDeprecation && words.last.endsWith(")")) {
//           isDeprecation = false;
//         }
//         if (isDeprecation) {
//           continue;
//         }
//         if (words.length == 1 &&
//             words.first.startsWith("@") &&
//             words.first.length > 1) {
//           atModifiers.add(words.first);
//           continue;
//         }

//         List<String> uncommentedWords = [];
//         if (words.containsChar("/*")) {
//           openedComment++;
//           if (openedComment == 1) {
//             final newWords = words.getListWithoutChar("/*");
//             if (newWords.isNotEmpty) {
//               uncommentedWords.addAll(newWords);
//               if (!startedCommenting) {
//                 startedCommenting = true;
//               }
//             } else {
//               continue;
//             }
//           }
//         }
//         if (startedCommenting) {
//           if (words.containsChar("*/")) {
//             openedComment--;
//             if (openedComment == 0) {
//               final newWords = words.getListWithoutChar("*/", true);
//               if (newWords.isNotEmpty) {
//                 uncommentedWords.addAll(newWords);
//                 startedCommenting = false;
//               } else {
//                 continue;
//               }
//             }
//           }
//         }
//         if (uncommentedWords.isNotEmpty) {
//           words = uncommentedWords;
//         }

//         if (words.first.startsWith("//")) {
//           continue;
//         }
//         words = words.trimList();
//         if (!inConstructor &&
//             currentType == "constructor" &&
//             words.containsChar(":")) {
//           inConstructor = true;
//           words = words.getListWithoutChar(":");
//         }

//         if (words.isEmpty) continue;
//         List<String> parameters = [];
//         parameters.addAll(words);
//         List<String> modifiers = getModifiers(words);
//         parameters.removeItems(modifiers);
//         String inputType = "";
//         if (!inComma && !inConstructor && !inBlock) {
//           inputType = getInputType(inClass ? className : "", words);
//         }
//         if (parameters.isNotEmpty && parameters.first == inputType) {
//           parameters.removeAt(0);
//         }
//         if (inputType != "" && !inComma && !inConstructor && !inBlock) {
//           currentType = inputType;
//           if (inputType == "class" || inputType == "mixin") {
//             inputs.add(Input(
//                 inputType: inputType,
//                 filePath: filePath,
//                 parameters: parameters,
//                 modifiers: modifiers,
//                 subInputs: []));
//             inClass = true;
//             className = parameters.first;
//             atModifiers = [];
//           } else {
//             final input = Input(
//               filePath: filePath,
//               inputType: inputType,
//               parameters: parameters,
//               modifiers: modifiers,
//               atModifiers: atModifiers.isNotEmpty ? atModifiers : null,
//             );
//             if (inClass) {
//               if (inputs.isNotEmpty) {
//                 inputs.last.subInputs?.add(input);
//               }
//             } else {
//               inputs.add(input);
//             }
//             atModifiers = [];
//           }
//         } else {
//           if (currentType == "function" && inBlock) {
//             if (inputs.isNotEmpty) {
//               if (inClass) {
//                 if (inputs.last.subInputs?.isNotEmpty ?? false) {
//                   if (inputs.last.subInputs?.last.codeLines != null) {
//                     inputs.last.subInputs?.last.codeLines!.add(lineString);
//                   } else {
//                     inputs.last.subInputs?.last.codeLines = [lineString];
//                   }
//                 }
//               } else {
//                 if (inputs.last.codeLines != null) {
//                   inputs.last.codeLines!.add(lineString);
//                 } else {
//                   inputs.last.codeLines = [lineString];
//                 }
//               }
//             }
//           }
//           if (currentType != "" && !inBlock && !inConstructor) {
//             if (inputs.isNotEmpty) {
//               if (inClass) {
//                 if (inputs.last.subInputs?.isNotEmpty ?? false) {
//                   inputs.last.subInputs?.last.parameters.addAll(parameters);
//                 }
//               } else {
//                 inputs.last.parameters.addAll(parameters);
//               }
//             }
//           }
//         }

//         if (inConstructor && words.last.endsWith(";")) {
//           inConstructor = false;
//         }
//         if (!inComma && words.last.endsWith(",") && !inConstructor) {
//           inComma = true;
//         }
//         if (inComma && (words.last.endsWith(";") || words.last.endsWith("}"))) {
//           inComma = false;
//         }
//         final bracesCount = words.getClosedOrOpenedBracesCount();

//         if (inClass && !inBlock) {
//           if (bracesCount < 0) {
//             if (classCurlyBraces > 0) {
//               classCurlyBraces += bracesCount;
//               if (classCurlyBraces == 0) {
//                 inClass = false;
//                 className = "";
//               }
//             }
//           }
//         }
//         if (!inBlock &&
//             currentType != "class" &&
//             currentType != "mixin" &&
//             currentType != "enum" &&
//             currentType != "constructor" &&
//             bracesCount > 0 &&
//             !words.startsOrEndsWith("({")) {
//           inBlock = true;
//         }
//         if (inClass && !inBlock) {
//           if (bracesCount > 0) {
//             classCurlyBraces += bracesCount;
//           }
//         }
//         if (inBlock) {
//           if (bracesCount > 0) {
//             blockCurlyBraces += bracesCount;
//           }
//           if (bracesCount < 0) {
//             if (blockCurlyBraces > 0) {
//               blockCurlyBraces += bracesCount;
//               if (blockCurlyBraces == 0) {
//                 inBlock = false;
//               }
//             }
//           }
//         }
//       }
//     }
//   }
//   return inputs;
// }

List<String> addListPart(List<String> list, int from, [int? end]) {
  List<String> newList = [];
  end ??= list.length;
  for (int i = from; i < end; i++) {
    final item = list[i];
    newList.add(item);
  }
  return newList;
}

List<String> getWidgetProperties(
    Map<String, List<Input>> allInputs, String string) {
  String name = "";
  if (string.contains("(")) {
    name = string.split("(").first;
  } else {
    name = string;
  }
  final inputs =
      name.contains(".") ? allInputs[name.split(".").first] : allInputs[name];
  if (inputs == null) return [];
  final inputIndex = inputs.indexWhere((input) => input.inputType == "class");
  if (inputIndex == -1) return [];
  Input input = inputs[inputIndex];
  List<String> properties = [];
  List<String> argsParameters = [];
  if (input.subInputs != null && input.subInputs!.isNotEmpty) {
    final constructorIndex = input.subInputs!.indexWhere((element) =>
        element.inputType == "constructor" &&
        element.parameters.first.splitUseStringIfEmpty("(").first == name);
    if (constructorIndex != -1) {
      argsParameters.addAll(input.subInputs![constructorIndex].parameters);
    }
  }
  if (argsParameters.isNotEmpty) {
    argsParameters.removeAt(0);
  }
  if (argsParameters.isNotEmpty) {
    final String string = argsParameters.join(" ");
    argsParameters = string.splitUseStringIfEmpty(",").trimList();
    for (int i = 0; i < argsParameters.length; i++) {
      final parameter = argsParameters[i].trim();
      final parameters = parameter.splitUseStringIfEmpty(" ").trimList();
      String name = "";
      if (parameters.length == 1) {
        if (parameter.startsWith("this.") || parameter.startsWith("super.")) {
          name = parameters.first.split(".")[1];
        } else {
          name = parameters.first;
        }
      } else {
        if (parameter.startsWith("this.")) {
          name = parameters.first.split(".")[1];
        } else {
          name = parameters[1];
        }
      }
      if (name.isNotEmpty) {
        properties.add(name);
      }
    }
  }
  return properties;
}

List<Line> getInputLines(List<Line> allLines, int lineNumber,
    Map<String, List<Input>> allInputs, String name, String type,
    [String? ofType]) {
  final line = allLines[lineNumber];
  final inputs =
      name.contains(".") ? allInputs[name.split(".").first] : allInputs[name];
  if (inputs == null) return [];
  final inputIndex = inputs.indexWhere((input) => input.inputType == type);
  if (inputIndex == -1) return [];
  Input input = inputs[inputIndex];

  List<Line> lines = [];
  print("input = $input");
  if (type == "class") {
    List<String> argsParameters = [];
    if (input.subInputs != null && input.subInputs!.isNotEmpty) {
      final constructorIndex = input.subInputs!.indexWhere((element) =>
          element.inputType == "constructor" &&
          element.parameters.first.splitUseStringIfEmpty("(").first == name);
      if (constructorIndex != -1) {
        argsParameters.addAll(input.subInputs![constructorIndex].parameters);
      }
    }
    bool isCurlyBraces =
        argsParameters.isNotEmpty && argsParameters.first.endsWith("{");
    bool isBracketBraces =
        argsParameters.isNotEmpty && argsParameters.first.endsWith("[");
    bool hasOptionalInFirst = isCurlyBraces || isBracketBraces;
    argsParameters.removeAt(0);
    final endChar = line.texts.isEmpty
        ? ""
        : line.texts.last.trim() == "return"
            ? ";"
            : line.texts.last.trim() == ":"
                ? ","
                : "";
    if (argsParameters.isEmpty) {
      lines.add(Line(texts: [
        if (line.texts.isNotEmpty) ...line.texts,
        "($name)$endChar"
      ]));
    } else {
      lines.add(
          Line(texts: [if (line.texts.isNotEmpty) ...line.texts, "($name"]));
      final argsString = argsParameters.join(" ");
      List<String> optSeperation = [];
      List<String> optArgs = [];
      List<String> nonOptArgs = [];
      print("argString = $argsString");
      if (!isCurlyBraces) {
        isCurlyBraces = argsString.contains("{");
      }
      if (!isBracketBraces) {
        isBracketBraces = argsString.contains("[");
      }
      if (isCurlyBraces || isBracketBraces) {
        if (hasOptionalInFirst) {
          optArgs.addAll(argsString.splitUseStringIfEmpty(",").trimList());
        } else {
          optSeperation =
              argsString.splitUseStringIfEmpty(isCurlyBraces ? "{" : "[");
          if (optSeperation.first.isNotEmpty) {
            nonOptArgs.addAll(
                optSeperation.first.splitUseStringIfEmpty(",").trimList());
          }
          if (optSeperation.length > 1 && optSeperation[1].isNotEmpty) {
            optArgs
                .addAll(optSeperation[1].splitUseStringIfEmpty(",").trimList());
          }
        }
      } else {
        nonOptArgs.addAll(argsString.splitUseStringIfEmpty(",").trimList());
      }
      if (nonOptArgs.isNotEmpty) {
        for (int i = 0; i < nonOptArgs.length; i++) {
          final arg = nonOptArgs[i];
          final argList = arg.splitUseStringIfEmpty(" ");
          String argName = argList.length > 1 ? argList[1] : argList[0];
          String name =
              argName.replaceAll("this.", "").replaceAll("super.", "");
          lines.add(Line(texts: ["$name,"]));
        }
      }
      if (optArgs.isNotEmpty) {
        for (int i = 0; i < optArgs.length; i++) {
          final arg = optArgs[i];
          final argList = arg.split(" ");
          final required = isCurlyBraces && argList.first == "required";
          if (required) {
            final argName = argList[1];
            String name =
                argName.replaceAll("this.", "").replaceAll("super.", "");
            lines.add(Line(texts: ["$name:", "$name,"]));
          }
        }
      }

      lines.add(Line(texts: [")$endChar"]));
    }
  }
  return lines.joinWithRightSpacing();
}

List<Line> getLines(
    Map<String, List<Input>> allInputs, String name, String classType,
    [String? ofType]) {
  final inputs = allInputs[classType];
  if (inputs == null) return [];
  final inputIndex = inputs.indexWhere((input) => input.inputType == "class");
  if (inputIndex == -1) return [];
  Input input = inputs[inputIndex];
  //print("input = $input");
  List<Line> lines = [];
  List<String> strings = [];
  List<String> ofTypeClass = [];
  print("name = $name, classType = $classType, ofType = $ofType");

  if (input.inputType == "class") {
    strings.add(
        "class $name extends $classType${ofType != null ? "<$ofType>" : ""} {");
    final constructorIndex = input.subInputs!
        .indexWhere((element) => element.inputType == "constructor");
    if (constructorIndex != -1) {
      final constructorInput = input.subInputs![constructorIndex];
      final parameters = constructorInput.parameters;
      // bool isCurlyBraces =
      //     parameters.isNotEmpty && parameters.first.endsWith("{");
      // bool isBracketBraces =
      //     parameters.isNotEmpty && parameters.first.endsWith("[");
      strings.add("const $name({super.key});");
    }
    if (input.modifiers.isNotEmpty &&
        input.modifiers.first == "abstract" &&
        input.subInputs != null) {
      for (int i = 0; i < input.subInputs!.length; i++) {
        final subInput = input.subInputs![i];
        if (subInput.inputType == "function" &&
            !subInput.parameters.contains("=>") &&
            !subInput.parameters.contains("{")) {
          strings.add("@override");
          List<String> subInputParameters = [];
          subInputParameters.addAll(subInput.parameters);
          if (subInputParameters.isNotEmpty &&
              subInputParameters.last.trim() == "}") {
            subInputParameters.removeLast();
          }
          if (subInputParameters.isNotEmpty &&
              subInputParameters.last.endsWith(";")) {
            subInputParameters.last =
                subInputParameters.last.replaceAll(";", "");
          }
          final returnType = subInputParameters.first;
          List<Input>? classInputs = allInputs[returnType];
          print(
              "subInputParameters = $subInputParameters, classInputs = $classInputs");
          // &&
          //     classInputs.first.parameters.contains(classType)
          if (classInputs != null &&
              classInputs.isNotEmpty &&
              classInputs.first.parameters.length > 1 &&
              classInputs.first.parameters.first.contains("<")) {
            //  final classInput = classInputs.first;
            ofTypeClass.add(returnType);
            strings.add(
                "$returnType<$name> ${subInputParameters[1]} => _$name$returnType();");
          } else {
            strings.add("${subInputParameters.join(" ")} {");
            if (!returnType.contains("void") &&
                !returnType.contains("Future")) {
              strings.add(
                  "return ${getDefaultAbstactClassReturnType(returnType)};");
            }
            strings.add("}");
          }
        }
      }
      strings.add("}");
    }
    lines = strings.isEmpty
        ? []
        : convertStringToLines(strings.join("\n")).joinWithRightSpacing();
    if (ofTypeClass.isNotEmpty) {
      for (int i = 0; i < ofTypeClass.length; i++) {
        final classTypeName = ofTypeClass[i];
        print("classTypeName = $classTypeName");
        lines.addAll(
            getLines(allInputs, "_$name$classTypeName", classTypeName, name));
      }
    }
    // if (classType == "StatefulWidget") {
    //   lines.addAll(getLines(allInputs, "_${name}State", "State", name));
    // }
  }

  return lines;
}

List<Line> convertStringToLines(String? string) {
  if (string == null || string.isEmpty) {
    return [];
  }
  List<Line> lines = [];
  List<String> linesStrings = string.splitUseStringIfEmpty("\n");

  for (int i = 0; i < linesStrings.length; i++) {
    final lineString = linesStrings[i].trim();
    List<String> texts = lineString.splitUseStringIfEmpty(" ").trimList();
    if (texts.isNotEmpty) {
      final line = Line(texts: texts);
      lines.add(line);
    }
  }
  return lines.joinWithRightSpacing();
}

List<String> getProperties(String string) {
  final result =
      string.startsWithUppercase ? widgetsMap[string] : enumsMap[string];
  if (result == null) {
    return [];
  }
  List<String> properties = [];
  if (properties.isEmpty) {
    if (string.isNotEmpty) {
      properties = [string];
    }
  }
  if (properties.isNotEmpty && properties.last == "") {
    properties.removeLast();
  }
  return properties;
}

bool hasString(Line line) {
  for (int i = 0; i < line.texts.length; i++) {
    final text = line.texts[i];
    if (text.trim().isNotEmpty) return true;
  }
  return false;
}

int getLastValidLine(List<Line> allLines, int lineNumber) {
  int lineIndex = lineNumber;
  while (
      (allLines[lineIndex].texts.isEmpty || !hasString(allLines[lineIndex])) &&
          lineIndex > 0) {
    lineIndex--;
  }
  return lineIndex;
}

String getStartSpacing(List<Line> allLines, int lineNumber) {
  String string = "";
  final lineIndex = getLastValidLine(allLines, lineNumber);
  final line = allLines[lineIndex];
  final text = line.texts.join(" ");

  for (int i = 0; i < text.length; i++) {
    final char = text[i];
    if (char == "" || char == "\t") {
      string += char;
    } else {
      break;
    }
  }
  if (text.trim().endsWith("(") ||
      text.trim().endsWith("[") ||
      text.trim().endsWith("{")) {
    string += "\t";
  }
  // int textIndex = line.texts.length - 1;
  // while ((line.texts[textIndex].trim().isEmpty) && textIndex > 0) {
  //   textIndex--;
  // }
  // if (line.texts[textIndex].isNotEmpty &&
  //     (line.texts[textIndex].endsWith("(") ||
  //         line.texts[textIndex].endsWith(","))) {}
  return string;
}

List<Line> getWidgetLines(String name, List<Line> allLines, int lineNumber) {
  List<Line> lines = [];
  final spacing = getStartSpacing(allLines, lineNumber);
  //final lineIndex = getLastValidLine(allLines, lineNumber);
  final line = allLines[lineNumber];
  if (line.texts.isNotEmpty &&
      line.texts.last.isNotEmpty &&
      (line.texts.last.endsWith(");") || line.texts.last.endsWith("),"))) {
    final lastChar = line.texts.last[line.texts.last.length - 1];
    allLines[lineNumber].texts.last = allLines[lineNumber]
        .texts
        .last
        .substring(0, line.texts.last.length - 2);
    lines.add(Line(texts: ["$spacing$name(),"]));
    lines.add(Line(texts: ["$spacing)$lastChar"]));
  } else {
    lines.add(Line(texts: ["$spacing$name(),"]));
    //lines.add(Line(texts: ["$spacing),"]));
  }

  return lines;
}

void addInputKey(String name, List<Line> allLines, int lineNumber) {
  final spacing = getStartSpacing(allLines, lineNumber);
  allLines.insert(lineNumber, Line(texts: ["$spacing$name:"]));
}

void addInputValue(String value, List<Line> allLines, int lineNumber) {
  final line = allLines[lineNumber];
  line.texts.add(value);
}

Map<String, String> getInputNamesandTypes(
    Map<String, List<Input>> allInputs, String name,
    [String? ofType]) {
  Map<String, String> map = {};
  String classType = "";
  final inputs =
      name.contains(".") ? allInputs[name.split(".").first] : allInputs[name];
  if (inputs == null) return {};
  final inputIndex = inputs.indexWhere((input) => input.inputType == "class");
  if (inputIndex == -1) return {};
  Input input = inputs[inputIndex];
  classType = getType(input);
  List<String> argsParameters = [];
  List<Input> variableInputs = [];
  if (input.subInputs != null && input.subInputs!.isNotEmpty) {
    final constructorIndex = input.subInputs!.indexWhere((element) =>
        element.inputType == "constructor" &&
        element.parameters.first.splitUseStringIfEmpty("(").first == name);
    if (constructorIndex != -1) {
      final constructorInput = input.subInputs![constructorIndex];
      argsParameters.addAll(constructorInput.parameters);
      if (argsParameters.isNotEmpty && argsParameters.first.contains(name)) {
        final bracketIndex = argsParameters.first.indexOf("(");
        if (bracketIndex != argsParameters.first.length - 1) {
          argsParameters[0] = argsParameters[0].substring(bracketIndex);
        }
        if (argsParameters.isNotEmpty && argsParameters.last.trim() == "{") {
          argsParameters.removeLast();
        }
      }
      //print("constructorInput = $constructorInput");
      //print("argsParameters = $argsParameters");
    }
    variableInputs = input.subInputs!
        .where((element) => element.inputType == "variable")
        .toList();
    //print("variableInputs = $variableInputs");
  }
  bool isCurlyBraces =
      argsParameters.isNotEmpty && argsParameters.first.contains("{");
  bool isBracketBraces =
      argsParameters.isNotEmpty && argsParameters.first.contains("[");
  bool hasOptionalInFirst = isCurlyBraces || isBracketBraces;
  if (argsParameters.isNotEmpty) {
    if (argsParameters.first.contains("(")) {
      final firstList = argsParameters.first.splitUseStringIfEmpty("(");
      final last = firstList.last.trim();
      if (last.isEmpty || (hasOptionalInFirst && last.length == 1)) {
        argsParameters.removeAt(0);
      } else {
        argsParameters.first = hasOptionalInFirst ? last.substring(1) : last;
      }
    }
    if (argsParameters.isNotEmpty) {
      if (argsParameters.last.contains(")")) {
        final lastList = argsParameters.last.splitUseStringIfEmpty(")");
        final first = lastList.first.trim();
        if (first.isEmpty || (hasOptionalInFirst && first.length == 1)) {
          argsParameters.removeLast();
        } else {
          argsParameters.last =
              hasOptionalInFirst ? first.substring(0, first.length - 1) : first;
        }
      }
      //print("argsParameters = $argsParameters");
    }
  }
  if (argsParameters.isEmpty) {
    return {};
  }
  final argsString = argsParameters.join(" ");
  List<String> optSeperation = [];
  List<String> optArgs = [];
  List<String> nonOptArgs = [];
  if (!isCurlyBraces) {
    isCurlyBraces = argsString.contains("{");
  }
  if (!isBracketBraces) {
    isBracketBraces = argsString.contains("[");
  }
  if (isCurlyBraces || isBracketBraces) {
    if (hasOptionalInFirst) {
      optArgs.addAll(argsString.splitUseStringIfEmpty(",").trimList());
    } else {
      optSeperation =
          argsString.splitUseStringIfEmpty(isCurlyBraces ? "{" : "[");
      if (optSeperation.first.isNotEmpty) {
        nonOptArgs
            .addAll(optSeperation.first.splitUseStringIfEmpty(",").trimList());
      }
      if (optSeperation.length > 1 && optSeperation[1].isNotEmpty) {
        optArgs.addAll(optSeperation[1].splitUseStringIfEmpty(",").trimList());
      }
    }
  } else {
    nonOptArgs.addAll(argsString.splitUseStringIfEmpty(",").trimList());
  }
  if (nonOptArgs.isNotEmpty) {
    for (int i = 0; i < nonOptArgs.length; i++) {
      final arg = nonOptArgs[i];
      final argList = arg.splitUseStringIfEmpty(" ");
      String argName = argList.length > 1 && !argList[1].contains("=")
          ? argList[1]
          : argList[0];

      String name = argName.replaceAll("this.", "").replaceAll("super.", "");
      String type =
          argList.length > 1 && !argList[1].contains("=") ? argList[0] : "";
      if (type == "") {
        if (argName.contains("super.")) {
          if (classType != "") {
            final superMap = getInputNamesandTypes(allInputs, classType);
            if (superMap.isNotEmpty) {
              type = superMap[name] ?? "";
            }
          }
        } else {
          final typeIndex = variableInputs.indexWhere((element) =>
              element.parameters.length > 1 &&
              element.parameters[1].contains(name));
          if (typeIndex != -1) {
            type = getType(variableInputs[typeIndex]);
          }
        }
      }
      map[name] = type;
    }
  }
  if (optArgs.isNotEmpty) {
    for (int i = 0; i < optArgs.length; i++) {
      final arg = optArgs[i];
      final argList = arg.split(" ");
      final required = isCurlyBraces && argList.first == "required";
      if (required) {
        argList.removeAt(0);
      }

      String argName = argList.length > 1 && !argList[1].contains("=")
          ? argList[1]
          : argList[0];
      String name = argName.replaceAll("this.", "").replaceAll("super.", "");
      String type =
          argList.length > 1 && !argList[1].contains("=") ? argList[0] : "";
      if (type == "") {
        if (argName.contains("super.")) {
          if (classType != "") {
            final superMap = getInputNamesandTypes(allInputs, classType);
            if (superMap.isNotEmpty) {
              type = superMap[name] ?? "";
            }
          }
        } else {
          final typeIndex = variableInputs.indexWhere((element) =>
              element.parameters.length > 1 &&
              element.parameters[1].contains(name));
          if (typeIndex != -1) {
            type = getType(variableInputs[typeIndex]);
          }
        }
      }
      map[name] = type;
    }
  }
  return map;
}
