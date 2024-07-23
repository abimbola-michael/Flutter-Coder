import 'dart:core';
import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_coder/features/emulator/utils/extensions.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/converted_data.dart';
import '../models/input.dart';
import '../models/text_provider.dart';
import '../models/posittion_info.dart';
import '../models/widgetinfo.dart';
import '../utils/callbacks/function_callbacks.dart';
import 'data/class_properties.dart';
import 'data/constructors.dart';
import 'data/enums_datas.dart';
import 'data/static_classes.dart';
import 'utils.dart';

List<String> customBracedSplitting(String inputString,
    [String char = "", bool allowCondition = false, bool trim = false]) {
  if (inputString.trim().isEmpty) return [];
  char = char.trim();
  List<String> splittedStrings = [];
  String splitString = "";
  int braceCount = 0;
  final strings = inputString.splitUseStringIfEmpty(" ");

  void countBraces(String string, int index, bool contains) {
    braceCount += string.containsCount("(");
    braceCount += string.containsCount("[");
    braceCount += string.containsCount("{");
    if (!allowCondition && (string != "<")) {
      braceCount += string.containsCount("<");
    }
    if (braceCount > 0) braceCount -= string.containsCount(")");
    if (braceCount > 0) braceCount -= string.containsCount("]");
    if (braceCount > 0) braceCount -= string.containsCount("}");
    if (braceCount > 0 && (string != ">")) {
      braceCount -= string.containsCount(">");
    }

    //print("string = $string");

    if (trim) {
      if (string.isNotEmpty) {
        splitString += "$string ";
      }
    } else {
      splitString += "$string ";
    }

    if ((contains && braceCount == 0) || index == strings.length - 1) {
      if (splitString.trim().isNotEmpty) {
        splittedStrings.add(splitString.trim());
      }
      splitString = "";
    }
  }

  for (int i = 0; i < strings.length; i++) {
    String string = strings[i].trim();
    if (char.isNotEmpty && string.contains(char)) {
      int j = 0;
      while (string.isNotEmpty && string.contains(char)) {
        final charIndex = string.indexOf(char);
        final left = "${string.substring(0, charIndex)} ";
        //print("left = $left");
        countBraces(left, i, true);
        if (braceCount > 0) {
          splitString = splitString.trim();
          splitString += "$char ";
        }
        string = "${string.substring(charIndex + char.length)} ";

        if (j > 100) {
          break;
        }
        j++;
      }
      if (string.isNotEmpty) {
        countBraces(string, i, false);
      }
    } else {
      countBraces(string, i, char.isEmpty);
    }
  }

  return splittedStrings;
}

String getBraceString(String string, String charType) {
  string = string.trim();
  if (string.isEmpty || string[0] != charType) return "";
  String newString = charType;
  int braceCount = 1;
  int i = 1;
  String oppositeChar = charType == "("
      ? ")"
      : charType == "["
          ? "]"
          : charType == "{"
              ? "}"
              : charType == "<"
                  ? ">"
                  : "";
  if (oppositeChar == "") return "";
  while (i < string.length && braceCount > 0) {
    final char = string[i];
    if (char == charType &&
        (char != "<" || (i == 0 || string[i - 1].isNotEmpty))) {
      braceCount++;
    } else if (char == oppositeChar) {
      braceCount--;
    }
    newString += char;
    i++;
  }
  return newString;
}

String getValueType(String? input) {
  if (input == null || input.trim().isEmpty) return "";
  String value = input.trim();

  if (value.startsWith("return")) {
    value = value.substring(6);
  }
  while (value.endsWith(";") || value.endsWith(",") || value.endsWith(":")) {
    value = value.substring(0, value.length - 1);
  }
  while (value.startsWith("(") && value.endsWith(")")) {
    value = value.substring(1, value.length - 1);
  }
  value = value.trim();
  if ((value.startsWith('"') && value.endsWith('"')) ||
      (value.startsWith("'") && value.endsWith("'")) ||
      (value.startsWith('"""') && value.endsWith('"""')) ||
      (value.startsWith("'''") && value.endsWith("'''"))) {
    return "String";
  } else if (int.tryParse(value) != null) {
    return "int";
  } else if (double.tryParse(value) != null) {
    return "double";
  } else if (bool.tryParse(value) != null) {
    return "bool";
  } else if (value.startsWith("[") && value.endsWith("]")) {
    return "List";
  } else if (value.startsWith("{") && value.endsWith("}")) {
    if (value.contains(":")) {
      return "Map";
    } else {
      return "Set";
    }
  }
  if (value.contains("(") && value.length > 1) {
    return value.substring(0, value.indexOf("("));
  }

  return "";
}

List<InputInfo> getInputDataInfo(
    Map<String, List<InputData>> allInputDatas, String name,
    [String? ofType, String filePath = ""]) {
  List<InputInfo> infos = [];
  String classType = "";
  if (name.contains("<")) {
    name = name.substring(0, name.indexOf("<"));
  }
  final inputs = name.contains(".")
      ? allInputDatas[name.split(".").first]
      : allInputDatas[name];
  if (inputs == null) return [];

  final inputIndex = inputs.indexWhere((data) =>
      getInputParameters(data).inputType == "class" &&
      (filePath == "" || filePath == data.filePath));
  if (inputIndex == -1) return [];
  InputData data = inputs[inputIndex];
  final inputParameter = getInputParameters(data);
  //classType = getInputDataType(data);
  classType = inputParameter.type;
  List<InputData> variableInputs = [];
  //print("data = $data");

  if (data.blockInputs != null && data.blockInputs!.isNotEmpty) {
    variableInputs = data.blockInputs!
        .where((element) => getInputParameters(element).inputType == "variable")
        .toList();

    //print("variableInputs = $variableInputs");
    final constructorIndex = data.blockInputs!.indexWhere((element) {
      final parameter = getInputParameters(element);
      return parameter.inputType == "function" && parameter.name == name;
    });

    if (constructorIndex != -1) {
      final constructorInput = data.blockInputs![constructorIndex];
      String dataString = constructorInput.data.trim();
      if (dataString.startsWith("@pragma")) {
        final index = dataString.indexOf(")");
        if (index != -1) {
          dataString = dataString.substring(index + 1).trim();
        }
      }
      if (dataString.contains("(")) {
        dataString = dataString.substring(dataString.indexOf("("));
      }

      dataString = getBraceString(dataString, "(");
      //print("bracedString = $dataString");
      if (dataString.contains("(")) {
        dataString = dataString.substring(dataString.indexOf("(") + 1).trim();
      }
      if (dataString.lastIndexOf(")") != -1) {
        dataString = dataString.substring(0, dataString.lastIndexOf(")"));
      }

      String nonOpString = "";
      String opString = "";
      String opChar = "";
      List<String> splittedStrings = [];
      List<String> opStrings = [];
      List<String> nonOpStrings = [];
      List<String> allStrings = [];

      bool isCurlyBraces = false;
      if ((dataString.contains("{") && dataString.contains("}")) ||
          (dataString.contains("[") && dataString.contains("]"))) {
        opChar = dataString.contains("{") ? "{" : "[";
        isCurlyBraces = opChar == "{";
        dataString = dataString.substring(0, dataString.length - 1).trim();

        //splittedStrings = dataString.splitUseStringIfEmpty(opChar);
        final charIndex = dataString.indexOf(opChar);
        if (charIndex > 0) {
          nonOpString = dataString.substring(0, charIndex);
        }
        opString = dataString.substring(charIndex + 1);
        // nonOpString = splittedStrings[0].trim();
        // opString = splittedStrings[1].trim();
        splittedStrings.add(nonOpString);
        splittedStrings.add(opString);
      } else {
        nonOpString = dataString.trim();
      }
      if (nonOpString.isNotEmpty) {
        nonOpStrings = customBracedSplitting(nonOpString, ",");
        //print("nonOpStrings = $nonOpStrings");
        allStrings.addAll(nonOpStrings);
      }
      if (opString.isNotEmpty) {
        opStrings = customBracedSplitting(opString, ",");
        //print("opStrings = $opStrings");
        allStrings.addAll(opStrings);
      }

      if (allStrings.isNotEmpty) {
        //print("allStrings = $allStrings");
        for (int i = 0; i < allStrings.length; i++) {
          final string = allStrings[i];
          String newString = string.trim();
          String infoName = "";
          String type = "";
          String value = "";
          bool required = false;
          if (nonOpStrings.contains(string)) {
            required = true;
          }
          //final parameters = customBracedSplitting(newString);

          if (string.contains("required")) {
            newString = newString.splitUseStringIfEmpty("required")[1].trim();
            required = true;
          }
          if (newString.contains("=")) {
            final equalsIndex = newString.indexOf("=");
            final before = newString.substring(0, equalsIndex).trim();
            String after = newString.substring(equalsIndex + 1).trim();
            if (after.endsWith(";") || after.endsWith(",")) {
              after = after.substring(0, after.length - 1).trim();
            }

            value = after;
            newString = before;
          }

          if (newString.contains("this.")) {
            final values = newString.splitUseStringIfEmpty("this.");
            newString = values[1].trim();
            infoName = newString;
            if (values[0].trim().isNotEmpty && !values[0].startsWith("@")) {
              type = values[0].trim();
            } else {
              //print("infoName = $infoName");
              if (variableInputs.isNotEmpty) {
                final index = variableInputs.indexWhere((element) =>
                    getInputParameters(element).name.contains(infoName));
                if (index != -1) {
                  type = getInputParameters(variableInputs[index]).type;
                }
              }
            }
          } else if (newString.contains("super.")) {
            final values = newString.splitUseStringIfEmpty("super.");
            newString = values[1].trim();
            infoName = newString;
            if (values[0].trim().isNotEmpty) {
              type = values[0].trim();
            }
            if (classType != "") {
              final superInfos = getInputDataInfo(allInputDatas, classType);
              if (superInfos.isNotEmpty) {
                int typeIndex = superInfos
                    .indexWhere((element) => element.name.contains(infoName));
                if (typeIndex != -1) {
                  final subInfo = superInfos[typeIndex];
                  if (type == "" && subInfo.type != "") {
                    type = subInfo.type;
                  }
                  if (value == "" && subInfo.value != "") {
                    value = subInfo.value;
                  }
                }
              }
            }
          } else {
            final parameters = customBracedSplitting(newString);
            final mods = getModifiers(parameters);
            removeModifiers(parameters, mods);
            if (parameters.length > 1) {
              if (newString.isNotEmpty &&
                  newString.contains("(") &&
                  newString.contains(")") &&
                  newString.trim()[0] != "(") {
                if (newString.contains("Function")) {
                  infoName = parameters.last;
                  parameters.removeLast();
                  type = parameters.join(" ");
                } else {
                  String body = "";
                  if (parameters.first.contains("(")) {
                    final name = parameters.first;
                    infoName = name.substring(0, name.indexOf("("));
                    body = name.substring(infoName.length);
                  } else if (parameters.length > 1 &&
                      parameters[1].contains("(")) {
                    final name = parameters[1];
                    infoName = name.substring(0, name.indexOf("("));
                    type = "${parameters.first} ";
                    body = name.substring(infoName.length);
                  }
                  type += "Function$body";
                }
              } else {
                type = parameters.first;
                infoName = parameters[1];
              }
            }
          }
          String key =
              isCurlyBraces && opStrings.contains(string) ? infoName : "$i";

          if (infoName.isNotEmpty) {
            final info = InputInfo(
                name: infoName,
                type: type,
                key: key,
                value: value,
                required: required);
            infos.add(info);
          }
        }
      }
    }
  }
  return infos;
}

List<InputInfo> getFunctionInfo(InputData data) {
  List<InputInfo> infos = [];
  String dataString = data.data.trim();
  if (dataString.startsWith("@pragma")) {
    final index = dataString.indexOf(")");
    if (index != -1) {
      dataString = dataString.substring(index + 1).trim();
    }
  }
  if (dataString.contains("(")) {
    dataString = dataString.substring(dataString.indexOf("("));
  }

  dataString = getBraceString(dataString, "(");
  //print("bracedString = $dataString");
  if (dataString.contains("(")) {
    dataString = dataString.substring(dataString.indexOf("(") + 1).trim();
  }
  if (dataString.lastIndexOf(")") != -1) {
    dataString = dataString.substring(0, dataString.lastIndexOf(")"));
  }

  String nonOpString = "";
  String opString = "";
  String opChar = "";
  List<String> splittedStrings = [];
  List<String> opStrings = [];
  List<String> nonOpStrings = [];
  List<String> allStrings = [];

  bool isCurlyBraces = false;
  if ((dataString.contains("{") && dataString.contains("}")) ||
      (dataString.contains("[") && dataString.contains("]"))) {
    opChar = dataString.contains("{") ? "{" : "[";
    isCurlyBraces = opChar == "{";
    dataString = dataString.substring(0, dataString.length - 1).trim();

    //splittedStrings = dataString.splitUseStringIfEmpty(opChar);
    final charIndex = dataString.indexOf(opChar);
    if (charIndex > 0) {
      nonOpString = dataString.substring(0, charIndex);
    }
    opString = dataString.substring(charIndex + 1);
    // nonOpString = splittedStrings[0].trim();
    // opString = splittedStrings[1].trim();
    splittedStrings.add(nonOpString);
    splittedStrings.add(opString);
  } else {
    nonOpString = dataString.trim();
  }
  if (nonOpString.isNotEmpty) {
    nonOpStrings = customBracedSplitting(nonOpString, ",");
    //print("nonOpStrings = $nonOpStrings");
    allStrings.addAll(nonOpStrings);
  }
  if (opString.isNotEmpty) {
    opStrings = customBracedSplitting(opString, ",");
    //print("opStrings = $opStrings");
    allStrings.addAll(opStrings);
  }

  if (allStrings.isNotEmpty) {
    //print("allStrings = $allStrings");
    for (int i = 0; i < allStrings.length; i++) {
      final string = allStrings[i];
      String newString = string.trim();
      String infoName = "";
      String type = "";
      String value = "";
      bool required = false;
      if (nonOpStrings.contains(string)) {
        required = true;
      }
      //final parameters = customBracedSplitting(newString);

      if (string.contains("required")) {
        newString = newString.splitUseStringIfEmpty("required")[1].trim();
        required = true;
      }
      if (newString.contains("=")) {
        final equalsIndex = newString.indexOf("=");
        final before = newString.substring(0, equalsIndex).trim();
        String after = newString.substring(equalsIndex + 1).trim();
        if (after.endsWith(";") || after.endsWith(",")) {
          after = after.substring(0, after.length - 1).trim();
        }

        value = after;
        newString = before;
      }

      if (newString.contains("this.")) {
        final values = newString.splitUseStringIfEmpty("this.");
        newString = values[1].trim();
        infoName = newString;
        if (values[0].trim().isNotEmpty) {
          type = values[0].trim();
        } else {}
      } else if (newString.contains("super.")) {
        final values = newString.splitUseStringIfEmpty("super.");
        newString = values[1].trim();
        infoName = newString;
        if (values[0].trim().isNotEmpty) {
          type = values[0].trim();
        }
      } else {
        final parameters = customBracedSplitting(newString);
        final mods = getModifiers(parameters);
        removeModifiers(parameters, mods);

        if (parameters.isNotEmpty) {
          if (newString.isNotEmpty &&
              newString.contains("(") &&
              newString.contains(")") &&
              newString.trim()[0] != "(") {
            if (newString.contains("Function")) {
              infoName = parameters.last;
              parameters.removeLast();
              type = parameters.join(" ");
            } else {
              String body = "";
              if (parameters.first.contains("(")) {
                final name = parameters.first;
                infoName = name.substring(0, name.indexOf("("));
                body = name.substring(infoName.length);
              } else if (parameters.length > 1 && parameters[1].contains("(")) {
                final name = parameters[1];
                infoName = name.substring(0, name.indexOf("("));
                type = "${parameters.first} ";
                body = name.substring(infoName.length);
              }
              type += "Function$body";
            }
          } else {
            if (parameters.length == 1) {
              infoName = parameters.first;
            } else {
              type = parameters.first;
              infoName = parameters[1];
            }
          }
        }
      }
      String key =
          isCurlyBraces && opStrings.contains(string) ? infoName : "$i";

      if (infoName.isNotEmpty) {
        final info = InputInfo(
            name: infoName,
            type: type,
            key: key,
            value: value,
            required: required);
        infos.add(info);
      }
    }
  }
  return infos;
}

void removeModifiers(List<String> parameters, List<String> modifiers) {
  for (int i = 0; i < modifiers.length; i++) {
    final modifier = modifiers[i];
    parameters.remove(modifier);
  }
}

InputParameter getInputParameters(InputData data, [int index = 0]) {
  String inputType = "", type = "", name = "", value = "";
  String string = data.data;
  final blockInputs = data.blockInputs;
  final parameters = customBracedSplitting(string);
  final modifiers = getModifiers(parameters);
  // if (modifiers.contains("factory")) {
  //   inputType = "function";
  // }
  // if (modifiers.contains("late") ||
  //     modifiers.contains("final") ||
  //     modifiers.contains("var")) {
  //   inputType = "variable";
  // }
  //print("parameters = $parameters");

  void getFunctionValue() {
    if (string.contains("(")) {
      value = string.substring(string.indexOf("(")).trim();
    } else if (string.contains("get")) {
      value = string.substring(string.indexOf("get") + 3).trim();
    }

    if (string.endsWith(";")) {
      value = value.substring(0, value.length - 1);
    }
    final bracedList = customBracedSplitting(value);
    if (bracedList.length == 1) {
      //inputType == ""
    }
    // if (blockInputs != null && blockInputs.isNotEmpty) {
    //   final lastInput = blockInputs.last;
    //   if (lastInput.data.startsWith("return")) {
    //     final data = lastInput.data.trim();
    //     value = data.substring(6);
    //     if (value.endsWith(";")) {
    //       value = value.substring(0, value.length - 1);
    //     }
    //   }
    // } else if (parameters.containsIndex("=>") != -1) {
    //   final index = parameters.containsIndex("=>");
    //   if (index + 1 < parameters.length) {
    //     value = parameters[index + 1].trim();
    //     if (value.endsWith(";")) {
    //       value = value.substring(0, value.length - 1);
    //     }
    //   }
    // }
  }

  removeModifiers(parameters, modifiers);
  if (parameters.isNotEmpty && parameters.first.isNotEmpty) {
    if (parameters.contains("operator")) {
      modifiers.add("operator");
      parameters.remove("operator");
    }
    final first = parameters.first;

    if (first == "return") {
      value = parameters.join(" ").trim();
      if (value.endsWith(";")) {
        value = value.substring(0, value.length - 1);
      }
      parameters.removeAt(0);
      return InputParameter(
          inputType: "return",
          type: first,
          name: first,
          value: value,
          modifiers: modifiers);
    }
    if (first == "for" || first == "while") {
      parameters.removeAt(0);
      return InputParameter(
          inputType: "loop",
          type: first,
          name: first,
          value: parameters.join(" ").trim(),
          modifiers: modifiers);
    }
    if (first == "if" || first == "else" || first == "switch") {
      if (first == "else" && parameters.length > 1 && parameters[1] == "if") {
        name = "else if";
        parameters.removeAt(0);
      } else {
        name = first;
      }
      parameters.removeAt(0);
      return InputParameter(
          inputType: "condition",
          type: name,
          name: name,
          value: parameters.join(" ").trim(),
          modifiers: modifiers);
    }
    if (first == "extension" && parameters.length >= 4) {
      return InputParameter(
          inputType: "extension",
          type: parameters[3],
          name: parameters[1],
          value: "",
          modifiers: modifiers);
    }

    if (first == "class" ||
        first == "enum" ||
        first == "mixin" ||
        first == "import" ||
        first == "export") {
      //print("type = $first");
      if (first == "mixin" &&
          parameters.length > 1 &&
          parameters[1] == "class") {
        inputType = "mixin class";
        name = parameters.length > 2 ? parameters[2] : "";
      } else {
        inputType = first;
        name = parameters.length > 1 ? parameters[1] : "";
      }

      if (inputType == "class") {
        if (parameters.length > 3 && parameters[2] == "extends") {
          type = parameters[3];
        }
      } else if (inputType == "mixin class") {
        if (parameters.length > 4 && parameters[3] == "extends") {
          type = parameters[4];
        }
      }
    } else if ((first.contains("(") &&
            first.contains(")") &&
            !first.trim().startsWith("Function")) ||
        (parameters.length > 1 &&
            parameters[1].contains("(") &&
            parameters[1].contains(")") &&
            !parameters[1].trim().startsWith("Function"))) {
      inputType = "function";
      //print("type = function braced");

      bool isFirst = (first.contains("(") && first.contains(")"));
      if (isFirst) {
        name = first.substring(0, first.indexOf("("));
      } else {
        final second = parameters[1];
        name = second.substring(0, second.indexOf("("));
        type = first;
      }

      getFunctionValue();
    } else if ((parameters.length > 1 && (first == "get" || first == "set")) ||
        (parameters.length > 2 &&
            (parameters[1] == "get" || parameters[1] == "set"))) {
      inputType = "function";
      bool isFirst = (first == "get" || first == "set");

      //print("type = function get or set");

      if (isFirst) {
        final second = parameters[1];
        if (first == "get") {
          name = second;
        } else {
          if (second.contains("(")) {
            name = second.substring(0, second.indexOf("("));
          } else {
            name = second;
          }
        }
        modifiers.add(first);
      } else {
        final second = parameters[1];
        final third = parameters[2];
        if (second == "get") {
          name = third;
        } else {
          if (third.contains("(")) {
            name = third.substring(0, third.indexOf("("));
          } else {
            name = third;
          }
        }
        type = first;
        modifiers.add(second);
      }
      getFunctionValue();
    } else if ((parameters.length > 1 &&
            (parameters[1].contains(";") ||
                parameters[1].contains(",") ||
                parameters[1].endsWith("="))) ||
        (parameters.length > 2 && parameters[2].endsWith("="))) {
      inputType = "variable";
      if (parameters[1].contains(";") ||
          parameters[1].contains(",") ||
          parameters.length > 2 && parameters[2].endsWith("=")) {
        if (parameters[0].contains("Function") ||
            parameters[1].contains("Function")) {
          if (parameters[0].contains("Function")) {
            type = parameters.first;
            parameters.removeAt(0);
          } else {
            type = "${parameters[0]} ${parameters[1]}";
            parameters.removeAt(0);
            parameters.removeAt(0);
          }
        } else {
          type = first;
          parameters.removeAt(0);
        }
      }
      String string = parameters.join(" ").trim();
      if (string.endsWith(";")) {
        string = string.substring(0, string.length - 1);
      }
      final commaParameters = customBracedSplitting(string, ",");
      for (int i = 0; i < commaParameters.length; i++) {
        final parameter = commaParameters[i];

        final subParameters = customBracedSplitting(parameter);
        if (subParameters.isNotEmpty) {
          final parameterName = subParameters.first;
          name += parameterName;
          if (i != commaParameters.length - 1) {
            name += ",";
          }
          if (subParameters.equalsIndex("=") != -1) {
            int index = subParameters.equalsIndex("=");
            while (index + 1 < subParameters.length) {
              value += subParameters[index + 1];
              value += " ";
              index++;
            }
            value = value.trim();
            if (value.endsWith(";") || value.endsWith(",")) {
              value = value.substring(0, value.length - 1);
            }
          }
          if (i != commaParameters.length - 1) {
            value += ",";
          }
        }
      }
    }
    if (name.contains("<")) {
      name = name.substring(0, name.indexOf('<'));
    }
    // if (type.contains("<")) {
    //   type = type.substring(0, type.indexOf('<'));
    // }
    if (value == "" && name == "") {
      value = string.trim();
    }
    if (value.endsWith(";")) {
      value = value.substring(0, value.length - 1);
    }
  }
  return InputParameter(
      inputType: inputType,
      type: type,
      name: name,
      value: value,
      modifiers: modifiers);
}

// String getInputDataInputType(InputData data) {
//   String string = data.data;
//   //final parameters = string.splitUseStringIfEmpty(" ").trim();
//   final parameters = customBracedSplitting(string);
//   final modifiers = getModifiers(parameters);
//   if (modifiers.contains("factory")) {
//     return "function";
//   }
//   if (modifiers.contains("late") ||
//       modifiers.contains("final") ||
//       modifiers.contains("var")) {
//     return "variable";
//   }
//   removeModifiers(parameters, modifiers);
//   String inputType = "";
//   if (parameters.isEmpty) return "";
//   final first = parameters.first;
//   if (first == "class" ||
//       first == "enum" ||
//       first == "mixin" ||
//       first == "import" ||
//       first == "export") {
//     return first;
//   }
//   if (first.contains("(") ||
//       (parameters.length > 1 &&
//           (parameters[1].contains("(") || parameters[1] == "get")) ||
//       (parameters.length > 2 && parameters[2].contains("(")) ||
//       first == "set") {
//     return "function";
//   }
//   if ((parameters.length > 1 &&
//           (parameters[1].endsWith(";") ||
//               parameters[1].endsWith(",") ||
//               parameters[1].contains("="))) ||
//       (parameters.length > 2 &&
//           (parameters[2].endsWith(";") ||
//               parameters[2].endsWith(",") ||
//               parameters[2].contains("=")))) {
//     return "variable";
//   }

//   string = parameters.join(" ");
//   return inputType;
// }

// String getInputDataType(InputData data) {
//   String type = "";
//   String string = data.data;
//   String inputType = getInputDataInputType(data);
//   if (inputType == "deprecation") return "";
//   final parameters = string.splitUseStringIfEmpty(" ").trim();

//   List<String> modifiers = getModifiers(parameters);
//   if (parameters.isEmpty) return "";
//   removeModifiers(parameters, modifiers);

//   if (inputType == "variable") {
//     if (modifiers.isNotEmpty) {
//       if (parameters.isNotEmpty) {
//         if (parameters.first.contains("=") ||
//             (parameters.length > 1 && parameters[1].contains("="))) {
//           final value = parameters.first.contains("=")
//               ? parameters[1]
//               : parameters[1].trim().length == 1 && parameters.length > 2
//                   ? parameters[2]
//                   : parameters[1].trim().length > 1
//                       ? parameters[1].substring(parameters[1].indexOf("=") + 1)
//                       : "";
//           type = getValueType(value);
//         } else {
//           type = parameters[0];
//         }
//       }
//     } else {
//       type = parameters[0];
//     }
//   } else if (inputType == "function") {
//     if (parameters.isNotEmpty && !parameters.first.contains("(")) {
//       type = parameters.first;
//     }
//     // if (parameters.first.contains("(")) {
//     //   type = parameters.first.contains("(") ? "" : parameters.first;
//     // } else if (parameters.length > 1 && parameters[1] == ("get")) {
//     //   type = parameters.first;
//     // } else if (parameters.first == ("set")) {
//     //   type = "";
//     // }
//   } else if (inputType == "class") {
//     final extendsIndex = parameters.lastIndexOf("extends");
//     if (extendsIndex != -1 && (extendsIndex + 1) < parameters.length) {
//       type = parameters[extendsIndex + 1];
//     }
//   }
//   // if (type.contains("<")) {
//   //   type = type.substring(0, type.indexOf("<"));
//   // }
//   return type;
// }

// String getInputDataName(InputData data) {
//   String inputName = "";
//   String string = data.data;
//   String inputType = getInputDataInputType(data);
//   if (inputType == "deprecation") return "";

//   List<String> parameters = string.splitUseStringIfEmpty(" ").trim();
//   List<String> modifiers = getModifiers(parameters);
//   //print("modifiers = $modifiers, parameters = $parameters");

//   if (parameters.isEmpty) return "";
//   removeModifiers(parameters, modifiers);
//   if (inputType == "variable") {
//     final newString = parameters.join(" ");
//     parameters = newString.splitUseStringIfEmpty(",");
//     for (int i = 0; i < parameters.length; i++) {
//       final parameter = parameters[i];
//       String newParameter = "";
//       if (parameter.contains("=")) {
//         newParameter = parameter.substring(0, parameter.indexOf("=")).trim();
//       } else {
//         newParameter = parameter.trim();
//       }
//       if (newParameter.contains(" ")) {
//         newParameter = newParameter.splitUseStringIfEmpty(" ")[1].trim();
//       }
//       inputName += newParameter;
//       if (i != parameters.length - 1) {
//         if (!inputName.endsWith(",")) {
//           inputName += ",";
//         }
//       }
//     }
//     inputName = inputName.replaceAll(";", "").trim();

//     if (inputName.endsWith(";")) {
//       inputName = inputName.substring(0, inputName.length - 1);
//     }
//   } else if (inputType == "function") {
//     final index = parameters.containsIndex("(");
//     if (index != -1) {
//       inputName = parameters[index].split("(").first;
//     } else if (parameters.length > 2 && parameters[1] == "get") {
//       inputName = parameters[2];
//     }
//     // if (parameters.containsChar("=>")) {
//     //   final index = parameters.containsIndex("=>");
//     //   if (index != -1) {
//     //     inputName = parameters[index - 1];
//     //   }
//     // }
//   } else {
//     inputName = parameters.length > 1 ? parameters[1] : "";
//   }
//   if (inputName.contains("<")) {
//     inputName = inputName.split("<").first;
//   }
//   return inputName;
// }

// String getInputDataValue(InputData data) {
//   String inputValue = "";
//   String string = data.data;
//   String inputType = getInputDataInputType(data);
//   if (inputType == "deprecation") return "";

//   final parameters = string.splitUseStringIfEmpty(" ").trim();
//   List<String> modifiers = getModifiers(parameters);

//   if (parameters.isEmpty) return "";
//   removeModifiers(parameters, modifiers);
//   if (inputType == "variable") {
//     final fullString = parameters.join(" ");
//     final variables = fullString.splitUseStringIfEmpty(",");
//     if (variables.isNotEmpty) {
//       for (int i = 0; i < variables.length; i++) {
//         final variable = variables[i];
//         final equalsIndex = variable.indexOf("=");
//         String value = "";
//         if (equalsIndex != -1) {
//           value = variable.substring(equalsIndex + 1).trim();
//           if (value.contains(";")) {
//             final semicolonIndex = value.lastIndexOf(";");
//             value = value.substring(0, semicolonIndex);
//           }
//         } else {
//           value = ",";
//         }
//         inputValue += value;
//         if (i != parameters.length - 1) {
//           if (!inputValue.endsWith(",")) {
//             inputValue += ",";
//           }
//         }
//       }
//     }
//     inputValue = inputValue.trim();
//   } else if (inputType == "function") {
//     final fullString = parameters.join(" ");
//     int index = -1;
//     int increment = 0;
//     if (fullString.contains("=>")) {
//       index = fullString.lastIndexOf("=>");
//       increment = 2;
//     } else if (fullString.contains("return")) {
//       index = fullString.lastIndexOf("return");
//       increment = 6;
//     }
//     if (index != -1) {
//       inputValue = fullString.substring(index + increment).trim();
//       if (inputValue.contains(";")) {
//         final semicolonIndex = inputValue.lastIndexOf(";");
//         inputValue = inputValue.substring(0, semicolonIndex);
//       }
//     }
//   }
//   return inputValue;
// }

List<InputData> getInputDatas(String string, String filePath) {
  if (string.trim().isEmpty) return [];
  List<InputData> datas = [];
  String data = "";
  String blockData = "";
  int curlyBracesCount = 0, bracketsCount = 0;
  bool inBlock = false;
  final refinedString = string.removeCommentsAndTrim();
  //print("refinedString = $refinedString");
  List<String> strings = refinedString.splitUseStringIfEmpty(" ");

  for (int i = 0; i < strings.length; i++) {
    String string = strings[i].trim();
    if (string.isEmpty) {
      continue;
    }

    if (inBlock) {
      curlyBracesCount += string.containsCount("{");
      if (curlyBracesCount > 0) {
        curlyBracesCount -= string.containsCount("}");
      }
      if (curlyBracesCount == 0) {
        inBlock = false;
      }
      if (!inBlock) {
        final index = string.lastIndexOf("}");
        final before = string.substring(0, index);
        final after = string.substring(index + 1);
        if (before != "") {
          blockData += "$before ";
        }
        List<InputData>? blockInputs;
        data.trim();
        blockData.trim();
        if (blockData != "" && data != "") {
          blockInputs = getInputDatas(blockData, filePath);
        }
        datas.add(InputData(
            data: data, blockInputs: blockInputs, filePath: filePath));
        data = "";
        blockData = "";
      } else {
        blockData += "$string ";
      }
    } else {
      bracketsCount += string.containsCount("(");
      if (bracketsCount > 0) {
        bracketsCount -= string.containsCount(")");
      }
      if (bracketsCount == 0) {
        curlyBracesCount += string.containsCount("{");
        if (curlyBracesCount > 0) {
          curlyBracesCount -= string.containsCount("}");
        }
        if (curlyBracesCount > 0) {
          inBlock = true;
        }
      }
      if (inBlock) {
        final index = string.indexOf("{");
        final before = string.substring(0, index);
        String after = string.substring(index + 1);

        if (before != "") {
          data += "$before ";
        }
        if (after != "") {
          blockData += "$after ";
        }
      } else {
        bool endString = false;
        if (string.contains("{}") &&
            !string.endsWith(";") &&
            !string.endsWith(",")) {
          final index = string.indexOf("{}");
          final before = string.substring(0, index);
          if (before != "") {
            data += "$before ";
          }
          endString = true;
        } else {
          data += "$string ";
        }

        if ((string.endsWith(";") && bracketsCount == 0 && !inBlock) ||
            (i == strings.length - 1) ||
            endString) {
          data.trim();
          blockData.trim();
          if (data != "") {
            datas.add(
                InputData(data: data, blockInputs: null, filePath: filePath));
          }
          data = "";
          blockData = "";
        }
      }
    }
    //print("i = $i string = $string data = $data, inBlock = $inBlock");
  }
  return datas;
}

List<String> customSplitting(String string) {
  final splittedList = string.splitUseStringIfEmpty(",").trimList();
  List<String> newList = [];
  int count = 0;
  Map<String, String> charMap = {
    "(": ")",
    "[": "]",
    "{": "}",
    "'''": "'''",
    '"""': '"""',
    "'": "'",
    '"': '"'
  };
  String newString = "";
  for (int i = 0; i < splittedList.length; i++) {
    String splittedString = splittedList[i];
    String char = "";
    String endChar = "";

    List<String> chars = [];
    if (char.isEmpty) {
      newString += splittedString;
      for (int j = 0; j < splittedString.length; j++) {
        final splittedChar = splittedString[j];
        if (charMap.containsKey(splittedChar) &&
            chars.indexWhere((element) => element == splittedChar) == -1) {
          chars.add(splittedChar);
        } else if (charMap.containsValue(splittedChar)) {
          final firstMap = charMap.entries
              .firstWhere((element) => element.value == splittedChar);
          if (chars.indexWhere((element) => element == firstMap.key) == -1) {
            continue;
          } else {
            chars.removeWhere((element) => element == firstMap.key);
          }
        }
      }
      if (chars.isEmpty) {
        newList.add(newString);
        newString = "";
      } else {
        char = chars.first;
        endChar = charMap[char] ?? "";
      }
    } else {
      if (splittedString.contains(char)) {
        count++;
      }
      if (splittedString.contains(endChar) && count > 0) {
        count--;
      }
      if (count == 0 && char.isNotEmpty && endChar.isNotEmpty) {
        splittedString = splittedString.splitUseStringIfEmpty(endChar).first;
        chars.clear();
        char = "";
        endChar = "";
      }
      newString += splittedString;
      if (count == 0) {
        newList.add(newString);
        newString = "";
      }
    }
  }
  return newList;
}

String getParameterValue(String inputName, String parameterValue,
    Map<String, List<InputData>> datas) {
  String value = "";
  final possibleDatas = datas[inputName];
  print("inputName = $inputName parameterValue = $parameterValue");

  if (possibleDatas != null) {
    for (int i = 0; i < possibleDatas.length; i++) {
      final data = possibleDatas[i];
      final parameter = getInputParameters(data);

      if (parameterValue != "" &&
          data.blockInputs != null &&
          data.blockInputs!.isNotEmpty) {
        for (int j = 0; j < data.blockInputs!.length; j++) {
          final subData = data.blockInputs![j];

          final subParameter = getInputParameters(subData);
          //print("subData = ${subData.data} parameter = $subParameter");

          if (subParameter.name == parameterValue) {
            return subParameter.value;
          }
        }
      } else {
        if (parameter.type != "class") {
          return parameter.value;
        }
      }
    }
    return getParameterValue(parameterValue, "", datas);
  }
  return value;
}

int add(int left, int right) {
  final leftValue = left * 2;
  final rightValue = right * 2;
  return leftValue + rightValue;
}

void getMapFromOtherMap(
    String string, Map<String, dynamic> funcMap, Map<String, dynamic> map) {
  final parameters = customBracedSplitting(string);
  for (int k = 0; k < parameters.length; k++) {
    final parameter = parameters[k].trim();
    if (funcMap[parameter] != null) {
      map[parameter] = funcMap[parameter];
    }
  }
}

String getStringFromMap(String string, List<Map<String, dynamic>> vars) {
  final parameters = customBracedSplitting(string);
  String newString = "";
  if (parameters.length == 3) {
    final firstParamter = parameters[0];
    final opr = parameters[1];
    final secondParamter = parameters[2];
    for (int i = 0; i < vars.length; i++) {
      final map = vars[i];
      if (opr == "+=" ||
          opr == "-=" ||
          opr == "*=" ||
          opr == "/=" ||
          opr == "%=" ||
          opr == "~/=") {
        if (map[firstParamter] != null && map[secondParamter] != null) {
          if (opr == "+=") {
            map[firstParamter] = map[firstParamter] += map[secondParamter];
          } else if (opr == "-=") {
            map[firstParamter] = map[firstParamter] -= map[secondParamter];
          } else if (opr == "*=") {
            map[firstParamter] = map[firstParamter] *= map[secondParamter];
          } else if (opr == "/=") {
            map[firstParamter] = map[firstParamter] /= map[secondParamter];
          } else if (opr == "%=") {
            map[firstParamter] = map[firstParamter] %= map[secondParamter];
          } else if (opr == "~/=") {
            map[firstParamter] = map[firstParamter] ~/= map[secondParamter];
          }
        }
        return newString;
      }
    }
  }
  for (int k = 0; k < parameters.length; k++) {
    final parameter = parameters[k].trim();

    for (int i = 0; i < vars.length; i++) {
      final map = vars[i];
      String newParameter = parameter;

      if (newParameter.endsWith("!")) {
        newParameter = newParameter.substring(0, newParameter.length - 1);
        if (map[newParameter] != null) {
          map[newParameter] = map[newParameter]!;
          newString += map[newParameter].toString();
        }
      }
      if (newParameter.startsWith("++")) {
        newParameter = newParameter.substring(2);
        if (map[newParameter] != null) {
          ++map[newParameter];
          newString += map[newParameter].toString();
          break;
        }
      } else if (newParameter.startsWith("--")) {
        newParameter = newParameter.substring(2);
        if (map[newParameter] != null) {
          --map[newParameter];
          newString += map[newParameter].toString();
          break;
        }
      } else if (newParameter.endsWith("++")) {
        newParameter = parameter.substring(0, newParameter.length - 2);
        if (map[newParameter] != null) {
          map[newParameter]++;
          newString += map[newParameter].toString();
          break;
        }
      } else if (newParameter.endsWith("--")) {
        newParameter = parameter.substring(0, newParameter.length - 2);
        if (map[newParameter] != null) {
          map[newParameter]--;
          newString += map[newParameter].toString();
          break;
        }
      } else if (newParameter.startsWith("!")) {
        newParameter = newParameter.substring(1);
        if (map[newParameter] != null) {
          map[newParameter] = !map[newParameter];
          newString += map[newParameter].toString();
          break;
        }
      } else {
        if (map[parameter] != null) {
          newString += map[parameter].toString();
          break;
        } else {
          if (i == vars.length - 1) {
            newString += parameter;
          }
          //print("parameter = $parameter");
        }
      }
    }
    if (k != parameters.length - 1) {
      newString += " ";
    }
  }
  return newString;
}

String modifedString(String string, List<Map<String, dynamic>> vars) {
  String newString = string;
  for (int k = 0; k < vars.length; k++) {
    final map = vars[k];
    for (final entry in map.entries) {
      if (string.contains(entry.key)) {
        string.replaceAll(entry.key, entry.value);
      }
    }
  }
  return newString;
}

// List<dynamic> solveTenary(String input, Map<String, List<InputData>> datas) {}

List<dynamic> solveCondition(InputData data, List<Map<String, dynamic>> vars,
    List<Map<String, String>> props, Map<String, List<InputData>> datas) {
  Map<String, dynamic> map = {};
  vars.insert(0, map);
  final blockInputs = data.blockInputs;
  final parameter = getInputParameters(data);
  print("condparameter = $parameter");
  final name = parameter.name;
  String realValue = parameter.value;
  List<String> conditions = [];
  List<List<InputData>> inputs = [];

  if (name == "if") {
    //final ifValues = customBracedSplitting(data.data, "`");
    final ifValues = data.data.splitUseStringIfEmpty("`");
    print("ifValues = $ifValues");
    for (int j = 0; j < ifValues.length; j++) {
      String ifValue = ifValues[j].trim();

      final ifCondParameter =
          getInputParameters(InputData(data: ifValue, filePath: ""));
      String realValue = ifCondParameter.value;
      while (realValue.startsWith("(") && realValue.endsWith(")")) {
        realValue = realValue.substring(1, realValue.length - 1);
      }
      conditions.add(realValue);
      print("ifCondParameter = $ifCondParameter");
    }
    if (blockInputs != null && blockInputs.isNotEmpty) {
      inputs = getMergedInputDatas(blockInputs);
    } else {
      inputs.add([]);
    }
  } else if (name == "switch") {
    while (realValue.startsWith("(") && realValue.endsWith(")")) {
      realValue = realValue.substring(1, realValue.length - 1);
    }
    if (blockInputs != null && blockInputs.isNotEmpty) {
      final blockData = blockInputs.first.data;
      final cases = blockData.splitUseStringIfEmpty("case");
      for (int j = 0; j < cases.length; j++) {
        final caseValue = cases[j];
        final caseName = caseValue.splitUseStringIfEmpty(":").first;
        final body = caseValue.substring(caseName.length + 1);
        final condition = "$realValue == ${getValue(caseName, datas)}";
        conditions.add(condition);
        final blockDatas = getInputDatas(body, "");
        inputs.add(blockDatas);
      }
    }
  }

  for (int i = 0; i < conditions.length; i++) {
    final condition = conditions[i];
    final blockInputs = inputs[i];
    if (condition.isEmpty ||
        getValue(getStringFromMap(condition, vars), datas)) {
      if (blockInputs.isNotEmpty) {
        for (int j = 0; j < blockInputs.length; j++) {
          final blockData = blockInputs[j];
          final parameter = getInputParameters(blockData);
          print("blockparameter = $parameter");
          if (parameter.inputType == "loop") {
            solveLoop(data, vars, props, datas);
          } else {
            if (parameter.name != "") {
              map[parameter.name] = getValue(parameter.value, datas);
              print("conditionMap = $vars");
            } else {
              final result =
                  getStringFromMap(blockData.data.replaceAll(";", ""), vars);
              print("conditionMap = $vars, result = $result");
            }
          }
        }
      }
      break;
    }
  }

  return [null, false];
}

List<dynamic> solveLoop(InputData data, List<Map<String, dynamic>> vars,
    List<Map<String, String>> props, Map<String, List<InputData>> datas) {
  Map<String, dynamic> map = {};
  vars.insert(0, map);
  final blockInputs = data.blockInputs;
  final parameter = getInputParameters(data);
  print("loopparameter = $parameter");
  final name = parameter.name;
  String realValue = parameter.value;
  List<String> forExecs = [];

  while (realValue.startsWith("(") && realValue.endsWith(")")) {
    realValue = realValue.substring(1, realValue.length - 1);
  }
  if (name == "for") {
    final forValues = customBracedSplitting(realValue, ";");
    print("forValues = $forValues");
    if (forValues.length == 3) {
      final first = forValues[0].trim();
      final second = forValues[1].trim();
      final third = forValues[2].trim();
      if (first.isNotEmpty) {
        final values = customBracedSplitting(first, ",");
        for (int j = 0; j < values.length; j++) {
          final value = values[j];
          final parameter =
              getInputParameters(InputData(data: value, filePath: ""));
          if (parameter.type != "") {
            map[parameter.name] = getValue(parameter.value, datas);
          } else {
            final index =
                vars.indexWhere((element) => element[parameter.name] != null);
            if (index != -1) {
              vars[index][parameter.name] = getValue(parameter.value, datas);
            }
          }
          print(
              "type = ${parameter.type}, name = ${parameter.name}, value = ${parameter.value}");
        }
      }
      if (second.isNotEmpty) {
        realValue = second;
        print("second = $second");
      }
      if (third.isNotEmpty) {
        final values = customBracedSplitting(third, ",");
        for (int j = 0; j < values.length; j++) {
          final value = values[j];
          forExecs.add(value);
        }
        print("third = $forExecs");
      }
    }
  } else if (name == "while") {}

  int f = 0;
  while (getValue(getStringFromMap(realValue, vars), datas) && f < 100) {
    if (blockInputs != null && blockInputs.isNotEmpty) {
      for (int j = 0; j < blockInputs.length; j++) {
        final blockData = blockInputs[j];
        final parameter = getInputParameters(blockData);
        print("blockparameter = $parameter");
        if (name == "for") {
        } else {
          if (parameter.name != "") {
            map[parameter.name] = getValue(parameter.value, datas);
          } else {
            final result =
                getStringFromMap(blockData.data.replaceAll(";", ""), vars);
            print("whileMap = $vars, result = $result");
          }
        }
      }
    }
    if (forExecs.isNotEmpty) {
      for (int i = 0; i < forExecs.length; i++) {
        final value = forExecs[i];
        final result = getStringFromMap(value, vars);
        print("forMap = $map, result = $result");
      }
    }
    f++;
  }

  return [null, false];
}

List<List<InputData>> getMergedInputDatas(List<InputData> inputDatas) {
  List<List<InputData>> allDatas = [];
  List<InputData> datas = [];
  for (int i = 0; i < inputDatas.length; i++) {
    final data = inputDatas[i];
    //print("data = $data");
    if (data.data != "`") {
      datas.add(data);
    }
    if (data.data == "`" || i == inputDatas.length - 1) {
      allDatas.add(datas);
      datas = [];
    }
  }
  return allDatas;
}

List<InputData> mergeInputDatas(List<InputData> inputDatas) {
  List<InputData> newInputDatas = [];
  InputData? ifData;
  for (int i = 0; i < inputDatas.length; i++) {
    final data = inputDatas[i];
    final parameter = getInputParameters(data);
    if (parameter.name == "if") {
      if (ifData != null) {
        newInputDatas.add(ifData);
      }
      ifData = data;
      if (i == inputDatas.length - 1) {
        newInputDatas.add(ifData);
      }
    } else if (parameter.name == "else if" || parameter.name == "else") {
      if (ifData != null && data.blockInputs != null) {
        List<InputData> datas = [];
        datas.addAll(ifData.blockInputs!);
        datas.add(InputData(data: "`", filePath: ""));
        datas.addAll(data.blockInputs!);
        final dataString = "${ifData.data}`${data.data}";
        ifData = InputData(data: dataString, filePath: "", blockInputs: datas);
      }
      if (i == inputDatas.length - 1) {
        newInputDatas.add(ifData!);
      }
    } else {
      if (ifData != null) {
        newInputDatas.add(ifData);
        ifData = null;
      }
      newInputDatas.add(data);
    }
  }
  return newInputDatas;
}

dynamic solveFunction(String callInput, List<Map<String, dynamic>> vars,
    List<Map<String, String>> props, Map<String, List<InputData>> datas,
    {Map<String, dynamic>? callMap, String? functionString}) {
  List<InputInfo> infos = [];
  Map<String, dynamic> map = {};
  String input = "";
  if (callMap != null && functionString != null) {
    map = callMap;
    print("callMap = $callMap, functionString = $functionString");
    // if (props.isEmpty || props[0].isEmpty) {
    //   return;
    // }
    // final prop = props[0];
    // final inputString = prop[""];
    // if (inputString == null) return;
    // input = inputString;
    input = functionString;
  } else {
    callInput = callInput.trim();
    if (!callInput.contains("(") && !callInput.contains(")")) {
      return;
    }
    String name = callInput.substring(0, callInput.indexOf("("));
    if (name == "") return;
    final propertyIndex = props.indexWhere((element) => element[name] != null);

    if (propertyIndex == -1) {
      return;
    }
    final prop = props[propertyIndex];
    final inputString = prop[name];

    if (inputString == null) return;

    if (inputString.startsWith("const")) {
      inputString.replaceAll("const", "");
    }
    input = inputString;
  }

  if (!input.contains("(") && !input.contains(")")) {
    return;
  }
  input = input.substring(input.indexOf("(")).trim();
  final values = customBracedSplitting(input);
  final modifiers = getModifiers(values);
  removeModifiers(values, modifiers);
  //print("values = $values");
  String parametersString = "";
  String returnType = "";
  String bodyString = "";

  if (values.isEmpty) return;
  if (input.contains("(") && input.contains(")")) {
    final openBracketIndex = input.indexOf("(");
    final closeBracketIndex = input.indexOf(")");
    parametersString = input.substring(openBracketIndex, closeBracketIndex + 1);
    bodyString = input.substring(closeBracketIndex + 1).trim();
    //parametersString = values.first.trim();
    //bodyString = values.length > 1 ? values[1].trim() : "";
  }
  // else if (values.length > 1 && values[1].contains("(")) {
  //   returnType = values.first;
  //   parametersString = values[1].trim();
  //   bodyString = values.length > 2 ? values[2].trim() : "";
  // }
  print("parametersString = $parametersString, bodyString = $bodyString");
  if (callInput != "") {
    if (parametersString != "") {
      infos = getFunctionInfo(InputData(data: parametersString, filePath: ""));
      for (int i = 0; i < infos.length; i++) {
        final info = infos[i];
        if (map[info.name] == null) {
          map[info.name] = getValue(info.value, datas);
        }
      }
    }
    if (callInput.startsWith("const")) {
      callInput.replaceAll("const", "");
    }
    callInput =
        callInput.substring(callInput.indexOf("(")).replaceAll(";", "").trim();
    if (callInput.startsWith("(") && callInput.endsWith(")")) {
      callInput = callInput.substring(1, callInput.length - 1).trim();
    }

    if (callInput.isNotEmpty) {
      final callValues = customBracedSplitting(callInput, ",");
      if (callValues.isNotEmpty) {
        for (int i = 0; i < callValues.length; i++) {
          final parameter = callValues[i];
          String key, value;
          if (parameter.isNotEmpty) {
            final strings = customBracedSplitting(parameter, ":");
            if (strings.length > 1) {
              key = strings[0];
              final colIndex = parameter.indexOf(":");
              value = parameter.substring(colIndex + 1).trim();
            } else {
              key = "$i";
              value = parameter;
            }
            final keyIndex = infos.indexWhere((element) => element.key == key);
            if (keyIndex != -1) {
              final keyName = infos[keyIndex].name;
              map[keyName] = getValue(value, datas);
            }
          }
        }
        print("callInput = $callInput, map = $map");
      }
    }
  }
  vars.insert(0, map);
  if (bodyString != "") {
    bool isArrowFunction = false;
    if (bodyString.startsWith("{") && bodyString.endsWith("}")) {
      bodyString = bodyString.substring(1, bodyString.length - 1);
    } else if (bodyString.startsWith("=>") && bodyString.endsWith(";")) {
      bodyString = bodyString.substring(2, bodyString.length - 1);
      isArrowFunction = true;
    }

    List<InputData> inputDatas = getInputDatas(bodyString, "");
    inputDatas = mergeInputDatas(inputDatas);
    //print("inputDatas = $inputDatas");
    for (int i = 0; i < inputDatas.length; i++) {
      final data = inputDatas[i];
      final parameter = getInputParameters(data);
      print("parameter = $parameter");
      final name = parameter.name;
      String realValue = getStringFromMap(parameter.value, [map]);
      if (parameter.inputType == "variable") {
        if (parameter.type != "" ||
            parameter.modifiers.contains("const") ||
            parameter.modifiers.contains("final") ||
            parameter.modifiers.contains("var")) {
          map[name] = getValue(realValue, datas);
        }
      } else if (parameter.inputType == "function") {
      } else if (parameter.inputType == "loop") {
        final result = solveLoop(data, [map], props, datas);
        final resultAction = result.first;
        final resultValue = result[1];
        if (resultAction == "return") {
          return resultValue;
        }
      } else if (parameter.inputType == "condition") {
        final result = solveCondition(data, [map], props, datas);
        final resultAction = result.first;
        final resultValue = result[1];
        if (resultAction == "return") {
          return resultValue;
        }
      }
      if (isArrowFunction || name == "return") {
        print("realValue = $realValue");
        final value = getValue(realValue, datas, "", vars, props);
        vars.removeAt(0);
        return value;
      }
    }
  }
}

dynamic solveClass(
  String callInput,
  String execName,
  List<Map<String, dynamic>> vars,
  List<Map<String, String>> props,
  Map<String, List<InputData>> datas,
) {
  List<InputInfo> infos = [];
  List<String> callValues = [];
  if (!callInput.contains("(") && !callInput.contains(")")) {
    return;
  }
  String name = callInput.substring(0, callInput.indexOf("("));
  if (name == "") return;
  final propertyIndex = props.indexWhere((element) => element[name] != null);
  final prop = props[propertyIndex];
  final input = prop[name];
  if (input == null) return;
  callInput = callInput.trim();
  final classData = getInputDatas(input, "").first;
  final classParameter = getInputParameters(classData);
  final className = classParameter.name;
  Map<String, dynamic> map = {};
  Map<String, String> property = {};
  props.add(property);
  if (className != "") {
    if (callInput.contains("const")) {
      callInput.replaceAll("const", "");
    }
    callInput =
        callInput.substring(className.length).replaceAll(";", "").trim();
    if (callInput.startsWith("(") && callInput.endsWith(")")) {
      callInput = callInput.substring(1, callInput.length - 1).trim();
    }
    if (callInput.isNotEmpty) {
      callValues = customBracedSplitting(callInput, ",");
    }
  }
  if (classData.blockInputs != null && classData.blockInputs!.isNotEmpty) {
    for (int i = 0; i < classData.blockInputs!.length; i++) {
      final data = classData.blockInputs![i];

      final parameter = getInputParameters(data);
      final name = parameter.name;
      String realValue = getStringFromMap(parameter.value, [map]);
      if (parameter.inputType == "function" &&
          (parameter.name == className ||
              parameter.name.startsWith("$className."))) {
        final parametersString = getBraceString(data.data, "(").trim();
        String bodyString = data.data
            .substring(parametersString.length)
            .replaceAll(";", "")
            .trim();
        if (bodyString.isNotEmpty && bodyString.startsWith(":")) {
          bodyString = bodyString.substring(1);
        }
        infos =
            getFunctionInfo(InputData(data: parametersString, filePath: ""));
        if (callValues.isNotEmpty && infos.length == callValues.length) {
          for (int i = 0; i < infos.length; i++) {
            final info = infos[i];
            map[info.name] = getValue(info.value, datas);
          }
          for (int i = 0; i < callValues.length; i++) {
            final parameter = callValues[i];
            String key, value;
            if (parameter.isNotEmpty) {
              final strings = customBracedSplitting(parameter, ":");
              if (strings.length > 1) {
                key = strings[0];
                final colIndex = parameter.indexOf(":");
                value = parameter.substring(colIndex + 1).trim();
              } else {
                key = "$i";
                value = parameter;
              }
              final keyIndex =
                  infos.indexWhere((element) => element.key == key);
              if (keyIndex != -1) {
                final keyName = infos[keyIndex].name;
                map[keyName] = getValue(value, datas);
              }
            }
          }

          if (bodyString != "") {
            List<InputData> inputDatas = getInputDatas(bodyString, "");
            inputDatas = mergeInputDatas(inputDatas);

            //print("inputDatas = $inputDatas");
            for (int i = 0; i < inputDatas.length; i++) {
              final data = inputDatas[i];
              final parameter = getInputParameters(data);
              String realValue = getStringFromMap(parameter.value, [map]);
            }
          }
        }
      } else if (parameter.inputType == "variable") {
        if (parameter.type != "" ||
            parameter.modifiers.contains("const") ||
            parameter.modifiers.contains("final") ||
            parameter.modifiers.contains("var")) {
          map[name] = getValue(realValue, datas);
        }
      } else {
        property[name] = dataToString(data);
      }
    }
  }
}

dynamic solveFile(
    String input, String execName, Map<String, List<InputData>> datas) {
  input = input.trim();
  List<InputData> filesDatas = [];
  Map<String, dynamic> map = {};
  Map<String, String> props = {};
  List<InputData> inputDatas = getInputDatas(input, "");
  print("inputDatas = $inputDatas");
  for (int i = 0; i < inputDatas.length; i++) {
    final data = inputDatas[i];
    final parameter = getInputParameters(data);
    print("parameter = $parameter");
    final name = parameter.name;
    String realValue = getStringFromMap(parameter.value, [map]);
    if (parameter.inputType == "import") {
      final pathName = parameter.name;
      final importDatas = datas.values
          .where((element) => element
              .where((element) => element.filePath == pathName)
              .isNotEmpty)
          .toList();
    } else if (parameter.inputType == "variable") {
      if (parameter.type != "" ||
          parameter.modifiers.contains("const") ||
          parameter.modifiers.contains("final") ||
          parameter.modifiers.contains("var")) {
        map[name] = getValue(realValue, datas);
      }
    } else {
      props[name] = dataToString(data);
    }
  }
}

dynamic solveFileParameters(String input, Map<String, List<InputData>> datas,
    [List<Map<String, String>> vars = const [],
    List<Map<String, String>> props = const []]) {
  List<InputInfo> infos = [];
  input = input.trim();
  List<InputData> filesDatas = [];
  Map<String, dynamic> map = {};
  Map<String, String> property = {};
  List<InputData> inputDatas = getInputDatas(input, "");
  print("inputDatas = $inputDatas");
  for (int i = 0; i < inputDatas.length; i++) {
    final data = inputDatas[i];
    final parameter = getInputParameters(data);
    print("parameter = $parameter");
    final name = parameter.name;
    String realValue = getStringFromMap(parameter.value, [map]);
    if (parameter.inputType == "import") {
      final pathName = parameter.name;
      final importDatas = datas.values
          .where((element) => element
              .where((element) => element.filePath == pathName)
              .isNotEmpty)
          .toList();
    } else if (parameter.inputType == "variable") {
      if (parameter.type != "" ||
          parameter.modifiers.contains("const") ||
          parameter.modifiers.contains("final") ||
          parameter.modifiers.contains("var")) {
        map[name] = getValue(realValue, datas);
      }
    } else {
      property[name] = dataToString(data);
    }
  }
}

String dataToString(InputData data) {
  String string = data.data;
  if (data.blockInputs != null && data.blockInputs!.isNotEmpty) {
    string += " {";
    for (int i = 0; i < data.blockInputs!.length; i++) {
      final blockData = data.blockInputs![i];
      string += blockData.data;
      if (blockData.blockInputs != null && blockData.blockInputs!.isNotEmpty) {
        string += dataToString(blockData);
      }
    }
    string += " }";
  }
  return string;
}

bool evaluateCondition(String input, Map<String, List<InputData>> datas) {
  bool condition = false;
  List<String> values = customBracedSplitting(input, "", true).trimmed;
  while (values.length > 2) {
    final leftValue = values[0].startsWith("(") && values[0].endsWith(")")
        ? evaluateCondition(values[0].substring(1, values[0].length - 1), datas)
        : getValue(values[0], datas);
    final operator = values[1];
    final rightValue = values[2].startsWith("(") && values[2].endsWith(")")
        ? evaluateCondition(values[2].substring(1, values[2].length - 1), datas)
        : getValue(values[2], datas);
    bool result = false;
    if (operator == ">") {
      result = leftValue > rightValue;
    } else if (operator == "<") {
      result = leftValue < rightValue;
    } else if (operator == ">=") {
      result = leftValue >= rightValue;
    } else if (operator == "<=") {
      result = leftValue <= rightValue;
    } else if (operator == "==") {
      result = leftValue == rightValue;
    } else if (operator == "!=") {
      result = leftValue != rightValue;
    }

    values.removeRange(0, 3);
    //values.insert(0, result.toString());
    if (values.length > 1 && (values[0] == "&&" || values[0] == "||")) {
      final operatorString = values[0];
      values.removeAt(0);
      int end = operatorString == "&&"
          ? values.containsIndex("&&")
          : values.containsIndex("||");
      //print("operatorString = $operatorString, end = $end, values = $values");
      String string = values.listRange(0, end != -1 ? end + 1 : null).join(" ");
      //print("string = $string");
      if (string.startsWith("(") && string.endsWith(")")) {
        string = string.substring(1, string.length - 1);
      }
      if (operatorString == "&&") {
        condition = result && evaluateCondition(string, datas);
      } else if (operatorString == "||") {
        condition = result || evaluateCondition(string, datas);
      }
      if (end != -1) {
        values.removeRange(0, end + 1);
      } else {
        values.clear();
      }
      //print("newValues = $values");
    } else {
      condition = result;
    }
  }
  return condition;
}

dynamic evaluateOperation(String input, Map<String, List<InputData>> datas) {
  final values = customBracedSplitting(input).trimmed;
  while (values.length > 2) {
    final leftValue = values[0].startsWith("(") && values[0].endsWith(")")
        ? evaluateOperation(values[0].substring(1, values[0].length - 1), datas)
        : getValue(values[0], datas);
    final operator = values[1];
    final rightValue = values[2].startsWith("(") && values[2].endsWith(")")
        ? evaluateOperation(values[2].substring(1, values[2].length - 1), datas)
        : getValue(values[2], datas);
    dynamic result;
    if (operator == "*") {
      result = leftValue * rightValue;
    } else if (operator == "+") {
      result = leftValue + rightValue;
    } else if (operator == "-") {
      result = leftValue - rightValue;
    } else if (operator == "/") {
      result = leftValue / rightValue;
    } else if (operator == "%") {
      result = leftValue % rightValue;
    } else if (operator == "~/") {
      result = leftValue ~/ rightValue;
    } else if (operator == "*=") {
      result = leftValue * rightValue;
    } else if (operator == "+=") {
      result = leftValue * rightValue;
    } else if (operator == "-=") {
      result = leftValue * rightValue;
    } else if (operator == "/=") {
      result = leftValue * rightValue;
    } else if (operator == "%=") {
      result = leftValue % rightValue;
    } else if (operator == "~/=") {
      result = leftValue ~/ rightValue;
    }
    values.removeRange(0, 3);
    values.insert(0, result.toString());
  }
  return getValue(values.isNotEmpty ? values.first : null, datas);
}

Map<String, dynamic> getVarsFromParameters(
    List<dynamic> parametersValues, List<InputInfo> infos) {
  Map<String, dynamic> vars = {};
  if (parametersValues.isNotEmpty && parametersValues.length == infos.length) {
    for (int i = 0; i < parametersValues.length; i++) {
      final parameterValue = parametersValues[i];
      final info = infos[i];
      //print("info = $info,parameterValue = $parameterValue");
      vars[info.name] = parameterValue;
    }
  }
  return vars;
}

dynamic solveCallbackFunction(
    String string,
    List<Map<String, dynamic>> vars,
    List<Map<String, String>> props,
    Map<String, List<InputData>> datas,
    Map<String, dynamic> callMap) {
  final result = solveFunction("", vars, props, datas,
      callMap: callMap, functionString: string);
  return result;
}

dynamic getMapValue(List<Map<String, dynamic>> vars, String key) {
  for (int i = 0; i < vars.length; i++) {
    final map = vars[i];
    if (map[key] != null) {
      return map[key];
    }
  }
  return null;
}

dynamic getMap(List<Map<String, dynamic>> vars, String key) {
  for (int i = 0; i < vars.length; i++) {
    final map = vars[i];
    if (map[key] != null) {
      return map;
    }
  }
  return null;
}

dynamic solveCode(String? input, Map<String, List<InputData>> datas,
    [String returnType = "",
    List<Map<String, dynamic>> vars = const [],
    List<Map<String, String>> props = const []]) {
  if (input == null || input.trim().isEmpty) return input;
  String inputString = input.trim();
  inputString = inputString.removeCommentsAndTrim();
  final parameters =
      getInputParameters(InputData(data: inputString, filePath: ""));
  final inputType = parameters.inputType;
  String name = parameters.name.trim();
  final value = parameters.value;
  String bracedName = "";
  List<String> names = customBracedSplitting(parameters.name.trim());
  List<String> values = customBracedSplitting(parameters.value.trim());
  for (int i = 0; i < names.length; i++) {
    String name = names[i];
    String value = values[i];
    dynamic realValue;
    if (name.contains("[") && name.endsWith("]") && !name.startsWith("[")) {
      final braceIndex = name.indexOf("[");
      bracedName = name.substring(braceIndex + 1, name.length - 1).trim();
      name = name.substring(0, braceIndex).trim();
    } else if (name.contains(".")) {}
    if (inputType == "variable") {
      if (name != "") {
        final map = getMap(vars, name);
        if (bracedName != "") {
          map[name][getValue(bracedName, datas, "", vars, props)] =
              getValue(value, datas, "", vars, props);
        } else {
          map[name] = getValue(value, datas, "", vars, props);
        }
      } else {
        getValue(value, datas, "", vars, props);
      }
    } else {
      getValue(value, datas, "", vars, props);
    }
  }
}

String getConvertedString(
  String input, [
  double? height,
  double? width,
  List<List<double>> inputPoints = const [],
  List<double> prevPoints = const [],
]) {
  String firstReplace = simplifyString("""
Positioned(
                left: 0,
                top: 0,
                child: Container(
                  width: 375,
                  height: 44,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 375,
                        height: 44,
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 66.66,
                              height: 11.34,
                              child: Stack(
                                children: [
                                  Positioned(
                                    left: 42.33,
                                    top: 0,
                                    child: Container(
                                      width: 24.33,
                                      height: 11.33,
                                      child: Stack(children: [
                                      ,
                                      ]),
                                    ),
                                  ),
                                  Positioned(
                                    left: 22.03,
                                    top: 0,
                                    child: Container(
                                      width: 15.27,
                                      height: 10.97,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: NetworkImage("https://via.placeholder.com/15x11"),
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    left: 0,
                                    top: 0.34,
                                    child: Container(
                                      width: 17,
                                      height: 10.67,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: NetworkImage("https://via.placeholder.com/17x11"),
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
""");
  String secondReplace = simplifyString("""
Positioned(
                left: -1,
                top: 0,
                child: Container(
                  width: 376,
                  height: 245,
                  decoration: BoxDecoration(color: Color(0xFF5DB074)),
                ),
              ),
              Positioned(
                left: 108,
                top: 128,
                child: Container(
                  width: 158,
                  height: 158,
                  decoration: ShapeDecoration(
                    image: DecorationImage(
                      image: NetworkImage("https://via.placeholder.com/158x158"),
                      fit: BoxFit.fill,
                    ),
                    shape: OvalBorder(
                      side: BorderSide(width: 4, color: Colors.white),
                    ),
                    shadows: [
                      BoxShadow(
                        color: Color(0x26646464),
                        blurRadius: 20,
                        offset: Offset(0, 4),
                        spreadRadius: 0,
                      )
                    ],
                  ),
                ),
              ),
""");
  input = simplifyString(input);
  //     .replaceAll(firstReplace, "")
  //     .replaceAll(secondReplace, "");
  // print("firstReplace = $firstReplace");
  // print("secondReplace = $secondReplace");

  //print("input = $input");
  final params = getWidgetParams(input);
  if (params.isEmpty) return "";
  String keyValueString = "";
  String name = params[""]!;
  String initialName = name;
  bool changed = false;
  params.remove("");
  double? inputWidth = width,
      inputHeight = height,
      currentWidth = width,
      currentHeight = height,
      childHeight,
      childWidth;
  bool hasOnlyOneChild = false;
  for (var entry in params.entries) {
    String key = entry.key;
    String value = entry.value;
    if (key == "width") {
      currentWidth = double.parse(value);
    } else if (key == "height") {
      currentHeight = double.parse(value);
    }
    if (double.tryParse(key) == null) {
      keyValueString += "$key: ";
    }
    List<List<double>> mainxPoints = [], mainyPoints = [], sizes = [];
    List<PositionInfo> infos = [];
    List<String> mainchildren = [];
    if (key == "children") {
      List<String> children = customBracedSplitting(
          value.substring(1, value.length - 1).trim(), ",");
      for (int j = 0; j < children.length; j++) {
        String child = children[j].trim();
        String actualChild = "";
        final info = getPositoningInfo(
            name, child, width, height, currentWidth, currentHeight);
        final prevInfo = infos.isNotEmpty && j > 0
            ? infos[j - 1]
            : PositionInfo(
                xPoints: [0, 0], yPoints: [0, 0], sizes: [0, 0], child: "");
        print("info = $info\nprevInfo = $prevInfo");
        actualChild =
            getConvertedString(info.child, currentHeight, currentWidth, [
          info.xPoints,
          info.yPoints
        ], [
          getLowValue(prevInfo.xPoints) + prevInfo.sizes[0],
          getLowValue(prevInfo.yPoints) + prevInfo.sizes[1]
        ]);

        mainxPoints.add(info.xPoints);
        mainyPoints.add(info.yPoints);
        sizes.add(info.sizes);
        infos.add(info);
        // if (name == "Stack") {

        // } else {
        //   actualChild = getConvertedString(
        //       child, currentHeight, currentWidth, [[], []], []);
        // }

        mainchildren.add(actualChild);
      }
      if (children.length == 1) {
        hasOnlyOneChild = true;
      }
      if (name == "Stack" && mainchildren.isNotEmpty) {
        print(
            "inputWidth = $inputWidth, inputHeight = $inputHeight, currentWidth = $currentWidth, currentHeight = $currentHeight");
        final data = getConvertedData(mainxPoints, mainyPoints, sizes,
            mainchildren, currentWidth!, currentHeight!);
        name = data.widgetName;
        mainchildren = data.children;
        final mainAlignment = data.mainAlignment;
        final crossAlignment = data.crossAlignment;

        bool isList =
            mainchildren.length > 1 && mainchildren.toSet().length == 1;
        if (!isList) {
          if (mainAlignment != null) {
            keyValueString += "mainAxisAlignment: MainAlignment.$mainAlignment";
          }
          if (crossAlignment != null) {
            keyValueString +=
                "crossAxisAlignment: CrossAlignment.$crossAlignment";
          }
        }
        String childrenString = "";
        for (int k = 0; k < mainchildren.length; k++) {
          final string = mainchildren[k];
          childrenString += "$string, ";
        }
        if (isList) {
          name = "ListView.builder";
          final length = mainchildren.length;
          keyValueString = "itemCount: $length,";
          keyValueString +=
              "itemBuilder: (context, index) { return ${mainchildren[0]}; }";
        } else {
          keyValueString = "children: [";
          keyValueString += childrenString;
          keyValueString += "],";
        }
        //String allRowString = "";
        // for (int k = 0; k < rowStrings.length; k++) {
        //   final string = rowStrings[k];
        //   allRowString += string;
        // }

        // if (positions.length > 1) {
        //   if (isList) {
        //     name = "ListView.builder";
        //     final length = mainchildren.length;
        //     keyValueString = "itemCount: $length,";
        //     allRowString = allRowString.substring(0, allRowString.length - 1);
        //     keyValueString +=
        //         "itemBuilder: (context, index) { return ${rowStrings[0]}; }";
        //   } else {
        //     name = "Column";
        //     keyValueString = "children: [";
        //     keyValueString += allRowString;
        //     keyValueString += "],";
        //   }
        // } else {
        //   name = "";
        //   keyValueString = rowStrings[0];
        // }
        if (mainchildren.isNotEmpty) {
          children = mainchildren;
        }
        if (children.length == 1) {
          hasOnlyOneChild = true;
        }
      } else {
        keyValueString += "[";
        for (int j = 0; j < mainchildren.length; j++) {
          String child = mainchildren[j].trim();
          keyValueString += child;
          if (j != mainchildren.length - 1) {
            keyValueString += ",";
          }
        }
        keyValueString += "]";
      }
    } else {
      if (inputWidth == null && key == "width") {
        value = "double.infinity";
      }
      if (inputHeight == null && key == "height") {
        value = "double.infinity";
      }
      String marginKey = "";
      double left = 0, right = 0, top = 0, bottom = 0;
      final inputxPoints = inputPoints.isNotEmpty ? inputPoints[0] : <double>[];
      final inputyPoints = inputPoints.length > 1 ? inputPoints[1] : <double>[];

      if (width != null &&
          currentWidth != null &&
          inputxPoints.isNotEmpty &&
          key == "width") {
        double lowX = getLowValue(inputxPoints);
        left = lowX;
        if (prevPoints.isNotEmpty) {
          left = left - prevPoints[0];
        }
        if (((lowX * 2) + currentWidth) >= width) {
          right = lowX;
          value = "double.infinity";
        }
        if (currentWidth == width || (lowX + currentWidth) == width) {
          value = "double.infinity";
        }
        if (inputxPoints.length > 1 &&
            inputxPoints.indexWhere((element) => element != lowX) != -1) {
          final highX = inputxPoints.firstWhere((element) => element != lowX);
          //right = highX;
          if (((lowX + highX) + currentWidth) == width) {
            value = "double.infinity";
          }
        }
      }

      if (height != null &&
          currentHeight != null &&
          inputyPoints.isNotEmpty &&
          key == "height") {
        double lowY = getLowValue(inputyPoints);
        top = lowY;
        if (prevPoints.length > 1) {
          top = top - prevPoints[1];
        }
        if (((lowY * 2) + currentHeight) >= height) {
          bottom = top;
          value = "double.infinity";
        }
        if (currentHeight == height || (lowY + currentHeight) == height) {
          value = "double.infinity";
        }
        if (inputyPoints.length > 1 &&
            inputyPoints.indexWhere((element) => element != lowY) != -1) {
          final highY = inputyPoints.firstWhere((element) => element != lowY);
          //bottom = highY;
          if (((lowY + highY) + currentHeight) == height) {
            value = "double.infinity";
          }
        }
      }
      if (key == "child") {
        keyValueString +=
            getConvertedString(value, currentHeight, currentWidth, [
          [0, 0],
          [0, 0]
        ], [
          0,
          0
        ]);
      } else {
        keyValueString += "$value, ";
      }
      if (top > 0 || bottom > 0 || right > 0 || left > 0) {
        keyValueString += "margin: EdgeInsets.";
        if (top == bottom && left == right && top != left && bottom != right) {
          keyValueString += "symmetric(";
          if (left > 0) {
            keyValueString += "horizontal: $left";
            if (top > 0) {
              keyValueString += ", ";
            }
          }
          if (top > 0) {
            keyValueString += "vertical: $top)";
          }
          keyValueString += "), ";
        } else if (top == bottom &&
            left == right &&
            top == left &&
            bottom == right) {
          keyValueString += "all($top), ";
        } else if (top != bottom || left != right) {
          keyValueString += "only(";
          if (top > 0) {
            keyValueString += "top: $top";
            if (bottom > 0) {
              keyValueString += ", ";
            }
          }
          if (bottom > 0) {
            keyValueString += "bottom: $bottom";
            if (left > 0) {
              keyValueString += ", ";
            }
          }
          if (left > 0) {
            keyValueString += "left: $left";
            if (right > 0) {
              keyValueString += ", ";
            }
          }
          if (right > 0) {
            keyValueString += "right: $right";
          }
          keyValueString += "), ";
        }
      }
    }
  }
  if (hasOnlyOneChild &&
      keyValueString.contains("[") &&
      keyValueString.contains("]")) {
    final innerChild = keyValueString
        .substring(
            keyValueString.indexOf("[") + 1, keyValueString.lastIndexOf("]"))
        .trim();
    return innerChild;
  }
  return name == "" ? keyValueString : "$name($keyValueString)";
}

String simplifyString(String input) {
  String output = "";
  final strings = input.splitUseStringIfEmpty(" ");
  for (int i = 0; i < strings.length; i++) {
    final string = strings[i].trim();
    if (string.isEmpty) {
      continue;
    }
    output += "$string ";
  }
  return output.trim();
}

PositionInfo getPositoningInfo(String name, String child, double? width,
    double? height, double? currentWidth, double? currentHeight) {
  List<double> xPoints = [], yPoints = [], sizes = [];
  double? childWidth = 0, childHeight = 0;
  String actualChild = child;
  final subparams = getWidgetParams(child);
  final subname = subparams[""];
  final substring = subparams["0"];
  if (child.startsWith("Positioned")) {
    final subchild = subparams["child"];
    if (subchild != null) {
      actualChild = subchild;
      final subchildparams = getWidgetParams(subchild);
      if (subchildparams.isNotEmpty) {
        final subchildname = subchildparams[""];
        final subchildstring = subchildparams["0"];

        if (subchildname == "Text") {
          final style = subchildparams["style"];
          final size =
              style == null ? "16" : getWidgetParams(style)["fontSize"];
          // print("style = $style, size = $size");
          if (size != null) {
            childWidth = ((double.parse(size) / 2) *
                subchildstring!.toString().length /
                2);
            childHeight = double.parse(size);
          }
        } else {
          childHeight = double.tryParse(subchildparams["height"] ?? "");
          childWidth = double.tryParse(subchildparams["width"] ?? "");
        }
      }
    }
    subparams.remove("");
    final top = subparams["top"];
    final right = subparams["right"];
    final bottom = subparams["bottom"];
    final left = subparams["left"];
    if (top != null) {
      yPoints.add(double.parse(top));
    }
    if (right != null) {
      xPoints.add(width! - double.parse(right));
    }
    if (bottom != null) {
      yPoints.add(height! - double.parse(bottom));
    }
    if (left != null) {
      xPoints.add(double.parse(left));
    }

    if (yPoints.isEmpty) {
      yPoints.add(0);
    }
    if (xPoints.isEmpty) {
      xPoints.add(0);
    }
  } else {
    if (subname == "Text") {
      final style = subparams["style"];
      final size = style == null ? "16" : getWidgetParams(style)["fontSize"];
      if (size != null) {
        childWidth = ((double.parse(size) / 2) * substring!.toString().length);
        childHeight = double.parse(size);
      }
    } else {
      childHeight = double.tryParse(subparams["height"] ?? "");
      childWidth = double.tryParse(subparams["width"] ?? "");
    }
    xPoints.add(0);
    yPoints.add(0);
  }

  sizes = [childWidth ?? -1, childHeight ?? -1];
  // print(
  //     "xPoints: $xPoints, yPoints: $yPoints, sizes: $sizes, child: $actualChild");
  return PositionInfo(
      xPoints: xPoints, yPoints: yPoints, sizes: sizes, child: actualChild);
}

String getAlignment(
    List<int> points,
    List<List<double>> allPoints,
    List<List<double>> otherPoints,
    List<List<double>> size,
    double height,
    double width,
    bool isRow) {
  String output = "";
  bool hasCommonCross = true;
  double crossSpaceValue = 0;
  List<double> spacing = [], crossSpacing = [];
  print("sizes = $size");
  for (int j = 0; j < points.length; j++) {
    final point = points[j];
    final value = allPoints[point];
    final otherValue = otherPoints[point];
    final lowValue = getLowValue(value);
    final lowOtherValue = getLowValue(otherValue);
    crossSpacing.add(lowOtherValue);
    final prev = spacing.isEmpty ? 0 : spacing.last;
    final diff = lowValue - prev;
    spacing.add(diff);
  }
  for (int j = 0; j < crossSpacing.length; j++) {
    final value = crossSpacing[j];
    if (j != 0 && hasCommonCross && crossSpaceValue != value) {
      hasCommonCross = false;
    }
    crossSpaceValue = value;
  }
  output += "mainAxisAlignment: MainAxisAlignment.";
  output += ", ";
  output += "crossAxisAlignment: CrossAxisAlignment.";
  if (hasCommonCross) {
    final percent = getPercentage(isRow ? height : width, crossSpaceValue);
    if (percent > 80) {
      output += "end";
    } else if (percent > 20) {
      output += "center";
    } else {
      output += "start";
    }
  } else {
    output += "baseline";
  }

  output += ", ";
  return output;
}

double getPercentage(double total, double value) => (value / total) * 100;

List<double> getSortedPoints(List<double> points) {
  List<double> sortedPoints = [];
  sortedPoints.addAll(points);
  sortedPoints.sortAsc((point) => point);
  return sortedPoints;
}

List<int> getSortedXPoints(List<int> points, List<List<double>> allPoints) {
  List<int> sortedPoints = [];
  sortedPoints.addAll(points);
  sortedPoints.sortAsc((point) => getLowValue(allPoints[point]));
  return sortedPoints;
}

Map<String, String> getWidgetParams(String input) {
  Map<String, String> map = {};
  while (input.trim().endsWith(";")) {
    input = input.trim();
    input = input.substring(0, input.length - 1).trim();
  }
  if (!input.contains("(") && !input.endsWith(")")) return {};
  String name = input.substring(0, input.indexOf("(")).trim();
  if (name.isEmpty) return {};
  map[""] = name;
  String body =
      input.substring(input.indexOf("(") + 1, input.lastIndexOf(")")).trim();
  final params = customBracedSplitting(body, ",", false, true).trim();

  for (int i = 0; i < params.length; i++) {
    final param = params[i];
    final entries = customBracedSplitting(param, ":", false, true);
    String key = "", value = "";
    if (entries.length == 1) {
      key = "$i";
      value = entries[0].trim();
    } else {
      key = entries[0].trim();
      value = entries[1].trim();
    }
    if (name == "TextStyle" && key == "height") {
      continue;
    }

    map[key] = value;
  }
  //print("map = $map");
  return map;
}

String converWidgetParamsToString(Map<String, String> map) {
  if (map.isEmpty) return "";
  final name = map[""];
  map.remove("");
  String keyValue = "";
  for (var entry in map.entries) {
    String key = entry.key;
    String value = entry.value;
    keyValue += "$key: $value";
  }
  return "$name($keyValue)";
}

double getLowValue(List<double> values) {
  return values.length > 1
      ? values[0] < values[1]
          ? values[0]
          : values[1]
      : values.isNotEmpty
          ? values[0]
          : 0;
}

ConvertedData getConvertedData(
    List<List<double>> xPoints,
    List<List<double>> yPoints,
    List<List<double>> sizes,
    List<String> children,
    double width,
    double height) {
  ConvertedData data = ConvertedData(children: [], widgetName: "Column");
  if (xPoints.length != sizes.length || xPoints.length != sizes.length) {
    print("Inaccurate Info, sizes = $sizes");
  }
  List<List<int>> stackList = [];
  final axis = getCommonAxis(xPoints, yPoints);
  print("commonAxis = $axis, sizes = $sizes");

  final xAxis = axis[0];
  final yAxis = axis[1];

  final yPositions = getSortedPoints(yAxis.keys.toList());
  final xPositions = getSortedPoints(xAxis.keys.toList());

  print("yPositions = $yPositions, xPositions = $xPositions");
  bool isColumn = true;
  for (int p = 0; p < yPositions.length; p++) {
    final lowY = yPositions[p];
    final xs = getSortedXPoints(yAxis[lowY]!, xPoints);
    final lowX = xs[0];
    final size = sizes[p];
    final limit = lowY + size[1];
    if (p < yPositions.length - 1) {
      if (limit > yPositions[p + 1]) {
        isColumn = false;
      }
    }
    if (!isColumn) {
      data.widgetName = "Row";
      if (xs.length > 1) {}
    }
  }
  if (isColumn) {
    if (yPositions.length == 1) {
      data.crossAlignment = "start";
    }
    for (int i = 0; i < yPositions.length; i++) {
      final yPos = yPositions[i];
      final childrenPositions = yAxis[yPos]!;
      for (int j = 0; j < childrenPositions.length; j++) {
        data.children.add(children[childrenPositions[j]]);
      }
    }
  } else {
    if (xPositions.length == 1) {
      data.crossAlignment = "start";
    }
    for (int i = 0; i < xPositions.length; i++) {
      final xPos = xPositions[i];
      final childrenPositions = xAxis[xPos]!;
      for (int j = 0; j < childrenPositions.length; j++) {
        data.children.add(children[childrenPositions[j]]);
      }
    }
  }
  // final percent = getPercentage(isRow ? height : width, crossSpaceValue);
  // if (percent > 80) {
  //   output += "end";
  // } else if (percent > 20) {
  //   output += "center";
  // } else {
  //   output += "start";
  // }
  return data;
}

List<Map<double, List<int>>> getCommonAxis(
    List<List<double>> xPoints, List<List<double>> yPoints) {
  List<Map<double, List<int>>> result = [{}, {}];
  for (int j = 0; j < xPoints.length; j++) {
    final x = xPoints[j];
    final y = yPoints[j];
    final lowX = getLowValue(x);
    final lowY = getLowValue(y);
    if (result[0].isEmpty || result[0][lowX] == null) {
      result[0][lowX] = [j];
    } else {
      result[0][lowX]!.add(j);
    }
    if (result[1].isEmpty || result[1][lowY] == null) {
      result[1][lowY] = [j];
    } else {
      result[1][lowY]!.add(j);
    }
  }
  return result;
}

dynamic getValue(String? input, Map<String, List<InputData>> datas,
    [String returnType = "",
    List<Map<String, dynamic>> vars = const [],
    List<Map<String, String>> props = const []]) {
  if (input == null || input.trim().isEmpty) return input;
  String value = input.trim();
  //print("valueInput = $input");

  String bracedString = "";
  value = value.removeCommentsAndTrim();
  if (value.startsWith("return")) {
    value = value.substring(6);
  }
  if (value.startsWith("const")) {
    value = value.substring(5);
  }
  while (value.endsWith(";") || value.endsWith(",") || value.endsWith(":")) {
    value = value.substring(0, value.length - 1);
  }
  while (value.startsWith("(") && value.endsWith(")")) {
    value = value.substring(1, value.length - 1);
  }
  value = value.trim();
  if (value.startsWith("<")) {
    bracedString = getBraceString(value, "<");
    value = value.substring(bracedString.length).trim();
  }
  print("value = $value");

  if (value.startsWith("setState")) {
    //ref.read(textProvider.notifier).updateString(text);
  }
  if (value.startsWith("(") &&
      value.contains(")") &&
      ((value.endsWith("}") && value.contains("{")) ||
          (value.contains("=>")))) {
    String bracedString = getBraceString(value, "(");
    String bodyString = value.substring(bracedString.length).trim();
    bracedString = bracedString.substring(1, bracedString.length - 1);
    if (bodyString.startsWith("=>")) {
      bodyString = bodyString.substring(2).trim();
      // if (bodyString.endsWith(";")) {
      //   bodyString = bodyString.substring(0, bodyString.length - 1).trim();
      // }
    } else if (bodyString.startsWith("{")) {
      bodyString = getBraceString(bodyString, "{");
      bodyString = bodyString.substring(1, bodyString.length - 1);
      // if (bodyString.endsWith(";")) {
      //   bodyString = bodyString.substring(0, bodyString.length - 1);
      // }
    }
    print(
        "bracedString = $bracedString, bodyString = $bodyString, input = $input");
    return getFunctionValue(
        value, returnType, bracedString, bodyString, datas, vars, props);
    //return solveFunction(callInput, vars, props, datas);
  }
  List<String> strings = customBracedSplitting(value.trim()).trimList();
  // if (strings.length == 1) {
  //   value = value.trim();
  //   dynamic result = getValue(value, datas);
  //   if (result is num &&
  //       (value.startsWith("++") ||
  //           value.startsWith("--") ||
  //           value.endsWith("++") ||
  //           value.endsWith("--"))) {
  //     if (value.startsWith("++")) {
  //       ++result;
  //     } else if (value.startsWith("--")) {
  //       --result;
  //     } else if (value.endsWith("++")) {
  //       result++;
  //     } else if (value.endsWith("--")) {
  //       result--;
  //     }
  //     return getValue(result.toString(), datas);
  //   } else if (result is bool && value.startsWith("!")) {
  //     result = !result;
  //     return getValue(result.toString(), datas);
  //   } else if (value.endsWith("!")) {
  //     result = result!;
  //     return getValue(result.toString(), datas);
  //   }
  // }

  if (value.contains("?") &&
      value.contains(":") &&
      strings.equalsCount("?") == strings.equalsCount(":")) {
    if (value.endsWith(";")) {
      value = value.substring(0, value.length - 1);
    }
    final condition = value.substring(0, value.indexOf("?"));
    final left = value.substring(value.indexOf("?") + 1, value.indexOf(":"));
    final right = value.substring(value.indexOf(":") + 1);
    return evaluateCondition(condition, datas)
        ? getValue(left, datas)
        : getValue(right, datas);
  }
  if (strings.length > 2) {
    //final left = strings[0];
    final symbol = strings[1];
    //final right = strings[2];
    List<String> operatorSymbols = [
      "*",
      "+",
      "-",
      "/",
      "%",
      "~/",
      "*=",
      "+=",
      "-=",
      "/=",
      "%=",
      "~/="
    ];
    List<String> conditionSymbols = [">", "<", ">=", "<=", "==", "!="];
    if (conditionSymbols.contains(symbol)) {
      return evaluateCondition(input, datas);
    }
    if (operatorSymbols.contains(symbol)) {
      return evaluateOperation(input, datas);
    }
  }

  if ((value.startsWith('"') && value.endsWith('"')) ||
      (value.startsWith("'") && value.endsWith("'")) ||
      (value.startsWith('"""') && value.endsWith('"""')) ||
      (value.startsWith("'''") && value.endsWith("'''"))) {
    if ((value.startsWith('"') && value.endsWith('"')) ||
        (value.startsWith("'") && value.endsWith("'"))) {
      value = value.substring(1, value.length - 1);
    } else {
      value = value.substring(3, value.length - 3);
    }
    return value;
  } else if (int.tryParse(value) != null) {
    if (returnType == "double" || returnType == "double?") {
      return int.parse(value).toDouble();
    } else {
      return int.parse(value);
    }
  } else if (double.tryParse(value) != null) {
    return double.parse(value);
  } else if (bool.tryParse(value) != null) {
    bool.parse(value);
  } else if (value.startsWith("[") && value.endsWith("]")) {
    value = value.substring(1, value.length - 1).trim();
    List list = [];
    final parameters = customBracedSplitting(value, ",");
    if (parameters.isEmpty) return [];

    for (int i = 0; i < parameters.length; i++) {
      final parameter = parameters[i];
      final parameterValue = getValue(parameter, datas, returnType, vars);
      list.add(parameterValue);
    }
    return list;
  } else if (value.startsWith("{") && value.endsWith("}")) {
    value = value.substring(1, value.length - 1).trim();
    final parameters = customBracedSplitting(value, ",");
    //print("parameters = $parameters");
    if (parameters.isEmpty) return {};
    bool isMap = parameters.first.splitUseStringIfEmpty(":").length > 1;
    if (isMap) {
      Map map = {};
      for (int i = 0; i < parameters.length; i++) {
        final parameter = parameters[i];
        final values = parameter.splitUseStringIfEmpty(":");
        final mapKey = getValue(values.first, datas, returnType, vars);
        final mapValue = values.length > 1
            ? getValue(values[1], datas, returnType, vars)
            : "";
        map[mapKey] = mapValue;
      }
      return map;
    } else {
      Set set = {};
      for (int i = 0; i < parameters.length; i++) {
        final parameter = parameters[i];
        set.add(getValue(parameter, datas, returnType, vars));
      }
      return set;
    }
  }
  if (strings.length == 1) {
    print("strings = $strings, ${strings.length}");

    if (value.contains("[") && value.contains("]") && !value.startsWith("[")) {
      final bracketIndex = value.indexOf("[");
      final endBracketIndex = value.lastIndexOf("]");
      final className = value.substring(0, bracketIndex);
      final key = value.substring(bracketIndex + 1, endBracketIndex);
      final firstValue = getValue(className, datas, returnType, vars, props);
      print(
          "bracfirstValue = $firstValue, className = $className, key = $key}");
      if (firstValue != null) {
        final classPropResult = classProperties(firstValue, "[]", [key], datas);
        if (classPropResult != null) {
          return classPropResult;
        }
      }
    }
    List<String> dotStrings = customBracedSplitting(value, ".");
    print("dotStrings = $dotStrings");
    if (dotStrings.length > 1) {
      final className = dotStrings.first;
      String classValue = dotStrings[1];
      final firstValue = getValue(className, datas, returnType, vars, props);
      String bracketValue = "";
      List<String> parameters = [];
      print("firstValue = $firstValue");
      if (firstValue != null) {
        if (classValue.contains("(") && classValue.contains(")")) {
          final bracketIndex = classValue.indexOf("(");
          final endBracketIndex = classValue.lastIndexOf(")");
          bracketValue =
              classValue.substring(bracketIndex + 1, endBracketIndex);
          classValue = classValue.substring(0, bracketIndex);
          parameters = customBracedSplitting(bracketValue, ",");
        }
        print(
            "firstValue = $firstValue, classValue = $classValue, splitValue = ${dotStrings[1]} bracketValue = $bracketValue, parameters = $parameters");
        final classPropResult =
            classProperties(firstValue, classValue, parameters, datas);
        if (classPropResult != null) {
          return classPropResult;
        }
      }
      print("vars = $vars");
      final classResult = staticClassesWithFunctions(
          className, classValue, parameters, datas, returnType, vars);
      //print("staticString = $strings, classResult= $classResult");
      if (classResult != null) {
        return classResult;
      }
      final enumResult = enumsDatas(className, classValue);
      //print("staticString = $strings, enumResult= $enumResult");
      if (enumResult != null) {
        return enumResult;
      }

      // if (className.isNotEmpty && classValue.isNotEmpty && datas.isNotEmpty) {
      //   final classInputs = datas[className];
      //   if (classInputs != null && classInputs.isNotEmpty) {
      //     bool isEnum = false;
      //     int index = classInputs.indexWhere(
      //         (element) => getInputParameters(element).inputType == "class");
      //     if (index == -1) {
      //       index = classInputs.indexWhere(
      //           (element) => getInputParameters(element).inputType == "enum");
      //       isEnum = true;
      //     }
      //     if (index != -1) {
      //       final input = classInputs[index];
      //       if (!isEnum) {
      //         final subInputs = input.blockInputs;
      //         if (subInputs != null && subInputs.isNotEmpty) {
      //           final subInputIndex = subInputs.indexWhere((element) {
      //             final parameters = getInputParameters(element);
      //             return parameters.modifiers.contains("static") &&
      //                 parameters.name == classValue;
      //           });
      //           if (subInputIndex != -1) {
      //             final subInput = subInputs[subInputIndex];
      //             final inputValue = getInputParameters(subInput).value;
      //             //print("colorConstr = $inputValue");
      //             if (inputValue != "") {
      //               return getValue(inputValue, datas, className, vars, props);
      //             }
      //           }
      //         }
      //       } else {
      //         final fullString = input.data;
      //         final openIndex = fullString.indexOf("{");
      //         final closeIndex = fullString.indexOf("}");
      //         if (openIndex != -1 && closeIndex != -1) {
      //           final string = fullString.substring(1, fullString.length - 1);
      //           final values = string.splitUseStringIfEmpty(",");
      //           final valueIndex = values.indexOf(classValue);
      //         }
      //       }
      //     }
      //   }
      // }
    }

    if (value.contains("(") && value.endsWith(")") && !value.startsWith("(")) {
      final bracketIndex = value.indexOf("(");
      final endBracketIndex = value.lastIndexOf(")");
      String name = value.substring(0, bracketIndex);
      value = value.substring(bracketIndex + 1, endBracketIndex);
      print("constructorStringValue = $value");
      final parameters = customBracedSplitting(value, ",");
      //print("name = $name, value = $value, parameters = $parameters");
      //return allclassConstructors(name, parameters, datas, returnType, vars);
      final result =
          allclassConstructors(name, parameters, datas, returnType, vars);
      if (result != null) {
        return result;
      }
    }
  }

  // final newValue = getParameterValue(returnType, value, datas);
  // if (newValue != "") {
  //   return getValue(newValue, datas, returnType, vars);
  // }

  if (strings.length == 1 && !value.contains(".")) {
    final mapValue = getMapValue(vars, value);
    print("mapValue = $mapValue, value = $value");
    if (mapValue != null) {
      return mapValue;
    }
  }
  return null;
}

List convertList(List list) {
  List newList = [];
  for (int i = 0; i < list.length; i++) {
    newList.add(list[i] as Widget);
  }
  return newList;
}
