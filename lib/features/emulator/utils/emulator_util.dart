import 'package:flutter_coder/features/emulator/models/emulator_output.dart';
import 'package:flutter_coder/features/shared/utils/extensions.dart';

import '../../converter/utils/constants_utils.dart';
import '../models/prop.dart';

EmulatorOutput getEmulatorOutput(String string) {
  String className = "";
  String widgetType = "";
  dynamic output;

  Map<String, Prop> propMap = {};
  Prop? classProp;

  final combinations = getCombinations(string);

  for (int i = 0; i < combinations.length; i++) {
    final combination = combinations[i].trim();
    final map = getProps(combination);
    propMap.addAll(map);

    if (map.length == 1) {
      final key = map.keys.first;
      final value = map[key]!;
      if (value.type == "class" &&
          (value.returnType.contains("StatelessWidget") ||
              value.returnType.contains("StatefulWidget"))) {
        widgetType = value.returnType.contains("StatelessWidget")
            ? "StatelessWidget"
            : value.returnType.contains("StatefulWidget")
                ? "StatefulWidget"
                : "";
        className = key;
        classProp = value;
      }
    }
  }

  Prop? buildFunctionProp;
  if (classProp != null) {
    string = classProp.string;
    final bracedString =
        string.substring(string.indexOf("{") + 1, string.lastIndexOf("}"));
    final combinations = getCombinations(bracedString);

    for (int i = 0; i < combinations.length; i++) {
      final combination = combinations[i];

      final map = getProps(
          combination, combination.startsWith("static") ? className : "");
      propMap.addAll(map);

      if (map.length == 1) {
        final key = map.keys.first;
        final value = map[key]!;
        if (key == "build" &&
            value.type == "function" &&
            (value.returnType.isEmpty || value.returnType.contains("void"))) {
          buildFunctionProp = value;
        }
      }
    }
  }
  if (buildFunctionProp != null) {
    string = buildFunctionProp.string;
    final bracedString =
        string.substring(string.indexOf("{") + 1, string.lastIndexOf("}"));
  }
  return EmulatorOutput(
      className: className, widgetType: widgetType, output: output);
}

Map<String, Prop> getFuntionCallProps(String string, String callString) {
  Map<String, Prop> propMap = {};
  final bracketString = string.contains("(") && string.contains(")")
      ? string.substring(string.indexOf("(") + 1, string.indexOf(")"))
      : string;
  final callBracketString = callString.contains("(") && callString.contains(")")
      ? callString.substring(
          callString.indexOf("(") + 1, callString.indexOf(")"))
      : callString;

  Map<String, String> callMap = {};

  final callStrings = callBracketString.customSplit(",");
  for (int i = 0; i < callStrings.length; i++) {
    final callString = callStrings[i].trim();
    final values = callString.customSplit(":");
    if (values.length == 1) {
      callMap["$i"] = values[0];
    } else if (values.length == 2) {
      callMap[values[0]] = values[1];
    }
  }
  final strings = bracketString.customSplit(",");
  for (int i = 0; i < strings.length; i++) {
    final string = strings[i].trim();
    if ((string.startsWith("[") && string.startsWith("]")) ||
        (string.startsWith("{") && string.startsWith("}"))) {
      String braceChar =
          string.startsWith("[") && string.startsWith("]") ? "[" : "{";
      final bracketString = string.substring(1, string.length - 1);
      final strings = bracketString.customSplit(",");
      for (int i = 0; i < strings.length; i++) {
        String string = strings[i].trim();
        String value = "";
        String name = "";
        String returnType = "";
        if (string.contains("=")) {
          value = string.substring(string.indexOf("=") + 1).trim();
          string = string.substring(0, string.indexOf("=")).trim();
        }
        final values = string.customSplit(" ");
        if (values.length == 1) {
          name = values[0];
        } else {
          name = values[values.length - 1];
          returnType = values[values.length - 2];
        }
        propMap[name] = Prop(
            type: "variable",
            name: name,
            returnType: returnType,
            value: braceChar == "{"
                ? (callMap[name] ?? value)
                : (callMap["$i"] ?? value),
            string: string);
      }
    } else {
      String name = "";
      String returnType = "";
      final values = string.customSplit(" ");
      if (values.length == 1) {
        name = values[0];
      } else {
        name = values[values.length - 1];
        returnType = values[values.length - 2];
      }
      propMap[name] = Prop(
          type: "variable",
          name: name,
          returnType: returnType,
          value: callMap["$i"] ?? "",
          string: string);
    }
  }
  return propMap;
}

dynamic getFunctonValue(String string, String callString) {
  final propMap = getProps(string);
  final inputPropMap = getFuntionCallProps(string, callString);
  //propMap.addAll(inputPropMap);

  // final bracketString = string.contains("(") && string.contains(")")
  //     ? string.substring(string.indexOf("(") + 1, string.indexOf(")"))
  //     : "";
  // if (bracketString.isNotEmpty) {}
  // string =
  //     string.contains(")") ? string.substring(string.indexOf(")") + 1) : string;
  final bodyString = string.contains("=>") && string.endsWith(";")
      ? string.substring(string.indexOf("=>") + 2, string.length - 1)
      : string.contains("{") && string.contains("}")
          ? string.substring(string.indexOf("{") + 1, string.lastIndexOf("}"))
          : "";
}

dynamic getWidget(String string, Map<String, dynamic> inputVars,
    Map<String, String> inputProps) {
  Map<String, dynamic> vars = {};
  Map<String, String> props = {};
  vars.addAll(inputVars);
  props.addAll(inputProps);

  final combinations = getCombinations(string);

  for (int i = 0; i < combinations.length; i++) {
    final combination = combinations[i].trim();
    bool isImportOrExport = (combination.startsWith("import") ||
            combination.startsWith("export")) &&
        combination.endsWith(";");

    bool isClass = combination.endsWith("}") &&
        combination.contains("{") &&
        (combination.startsWith("class") ||
            (combination.contains(" ") &&
                combination
                    .substring(combination.indexOf(" ") + 1)
                    .startsWith("class")));
    bool isMixin = combination.endsWith("}") &&
        combination.contains("{") &&
        (combination.startsWith("mixin") ||
            (combination.contains(" ") &&
                combination
                    .substring(combination.indexOf(" ") + 1)
                    .startsWith("class")));
    bool isEnum = combination.endsWith("}") &&
        combination.contains("{") &&
        combination.startsWith("enum");
    bool isVariable = !isImportOrExport &&
        combination.endsWith(";") &&
        combination.contains("=");
    bool isBracedFunction = combination.contains("(") &&
        combination.contains(")") &&
        combination.endsWith("}") &&
        combination.contains("{");
    bool isArrowFunction =
        combination.contains("=>") && combination.endsWith(";");
    bool isFunction = isBracedFunction || isArrowFunction;

    if (isVariable) {
      final variablesMap = getVariables(combination);
      if (variablesMap.isNotEmpty) {
        vars.addAll(variablesMap);
      }
    } else if (isClass) {
      final staticVariablesMap = getStaticVariblesMap(combination);
      if (staticVariablesMap.isNotEmpty) {
        vars.addAll(staticVariablesMap);
      }
    }
  }
  return vars;
}

Map<String, Prop> getProps(String string, [String className = ""]) {
  string = string.trim();
  String type = "";
  String name = "";
  String returnType = "";
  String value = "";
  List<String> values = [];
  List<String> names = [];
  List<String> returnTypes = [];
  Map<String, Prop> propMap = {};

  bool isImportOrExport =
      (string.startsWith("import") || string.startsWith("export")) &&
          string.endsWith(";");
  if (isImportOrExport) {
    type = string.startsWith("import") ? "import" : "export";
  }

  bool isClass = string.endsWith("}") &&
      string.contains("{") &&
      (string.startsWith("class") ||
          (string.contains(" ") &&
              string.substring(string.indexOf(" ") + 1).startsWith("class")));
  if (type.isEmpty && isClass) {
    type = "class";
  }
  bool isMixin = string.endsWith("}") &&
      string.contains("{") &&
      (string.startsWith("mixin") ||
          (string.contains(" ") &&
              string.substring(string.indexOf(" ") + 1).startsWith("class")));
  if (type.isEmpty && isMixin) {
    type = "mixin";
  }
  bool isEnum =
      string.endsWith("}") && string.contains("{") && string.startsWith("enum");
  if (type.isEmpty && isEnum) {
    type = "enum";
  }

  bool isBracedFunction = string.contains("(") &&
      string.contains(")") &&
      string.endsWith("}") &&
      string.contains("{");
  bool isArrowFunction = string.contains("=>") && string.endsWith(";");
  bool isFunction = isBracedFunction || isArrowFunction;
  if (type.isEmpty && isFunction) {
    type = "function";
  }

  //&& string.contains("=")
  bool isVariable = !isFunction && !isImportOrExport && string.endsWith(";");
  if (type.isEmpty && isVariable) {
    type = "variable";
  }
  switch (type) {
    case "import":
    case "export":
      if (string.endsWith(";")) {
        string = string.substring(0, string.length - 1);
      }
      name = string.substring(string.indexOf(" ") + 1).trim();
      break;
    case "variable":
      final strings = string.contains(",") ? string.split(",") : [string];
      for (int i = 0; i < strings.length; i++) {
        String commaString = strings[i].trim();
        if (commaString.endsWith(";")) {
          commaString = commaString.substring(0, commaString.length - 1);
        }
        String stringBeforeEquals = "";
        if (commaString.contains("=")) {
          stringBeforeEquals =
              commaString.substring(0, commaString.indexOf("="));
          values.add(commaString.substring(commaString.indexOf("=") + 1));
        } else {
          stringBeforeEquals = commaString;
          values.add("");
        }
        stringBeforeEquals = stringBeforeEquals.trim();
        if (stringBeforeEquals.contains(" ")) {
          final returnType = stringBeforeEquals.substring(
              0, stringBeforeEquals.lastIndexOf(" "));
          returnTypes.add(returnType);
          final name = stringBeforeEquals
              .substring(stringBeforeEquals.lastIndexOf(" ") + 1);
          names.add(name);
        } else {
          returnTypes.add("");
          names.add(stringBeforeEquals);
        }
      }
      // name = names.join(",");
      // value = values.join(",");
      break;
    case "function":
    case "constructor":
      String stringBeforeBraces = "";
      if (string.contains("(") && string.contains(")")) {
        stringBeforeBraces = string.substring(0, string.indexOf("("));
      } else if (string.contains("=>")) {
        stringBeforeBraces = string.substring(0, string.indexOf("=>"));
      }
      stringBeforeBraces = stringBeforeBraces.trim();
      if (stringBeforeBraces.contains(" ")) {
        returnType = stringBeforeBraces.substring(
            0, stringBeforeBraces.lastIndexOf(" "));
        name = stringBeforeBraces
            .substring(stringBeforeBraces.lastIndexOf(" ") + 1);
      } else {
        name = stringBeforeBraces;
      }

      break;
    case "enum":
      name = string
          .substring(string.indexOf("enum") + 4, string.indexOf("{"))
          .trim();
      break;
    case "class":
    case "mixin":
      final braceEnd = string.indexOf("{");
      final stringBeforeBraces = string.substring(0, braceEnd);
      final end = stringBeforeBraces.contains("extends")
          ? stringBeforeBraces.indexOf("extends")
          : stringBeforeBraces.contains("with")
              ? stringBeforeBraces.indexOf("with")
              : stringBeforeBraces.contains("implements")
                  ? stringBeforeBraces.indexOf("implements")
                  : braceEnd;

      name = stringBeforeBraces
          .substring(stringBeforeBraces.indexOf(type) + 5, end)
          .trim();
      if (stringBeforeBraces.contains("extends")) {
        returnType = stringBeforeBraces
            .substring(stringBeforeBraces.indexOf("extends"))
            .trim();
      } else if (stringBeforeBraces.contains("with")) {
        returnType = stringBeforeBraces
            .substring(stringBeforeBraces.indexOf("with"))
            .trim();
      } else if (stringBeforeBraces.contains("implements")) {
        returnType = stringBeforeBraces
            .substring(stringBeforeBraces.indexOf("implements"))
            .trim();
      }
      break;
  }
  if (names.isNotEmpty && names.length == values.length) {
    for (int i = 0; i < names.length; i++) {
      String name = names[i];
      String value = values[i];
      String returnType = returnTypes[i];
      if (className.isNotEmpty) {
        name = "$className.$name";
      }
      if (returnType.isEmpty && type == "variable") {
        returnType = returnTypes[0];
      }

      final prop = Prop(
          type: type,
          name: name.trim(),
          returnType: returnType.trim(),
          value: value.trim(),
          string: string);
      propMap[name] = prop;
    }
  } else {
    if (className.isNotEmpty) {
      name = "$className.$name";
    }
    final prop = Prop(
        type: type,
        name: name.trim(),
        returnType: returnType.trim(),
        value: value.trim(),
        string: string);
    propMap[name] = prop;
  }
  return propMap;
}

dynamic getClassOrMixinResult(String string) {
  Map<String, dynamic> vars = {};
  Map<String, String> props = {};

  if (!string.contains("{") && !string.contains("}")) {
    return {};
  }
  final typeName = string.startsWith("class") ? "class" : "mixin";

  final braceEnd = string.indexOf("{");
  final stringBeforeBraces = string.substring(0, braceEnd);
  final end = stringBeforeBraces.contains("extends")
      ? string.indexOf("extends")
      : stringBeforeBraces.contains("with")
          ? string.indexOf("with")
          : stringBeforeBraces.contains("implements")
              ? string.indexOf("implements")
              : braceEnd;

  final className = string.substring(string.indexOf("class") + 5, end).trim();
  final bracedString =
      string.substring(string.indexOf("{") + 1, string.lastIndexOf("}"));
  final combinations = getCombinations(bracedString);

  for (int i = 0; i < combinations.length; i++) {
    final combination = combinations[i].trim();
    bool isVariable = combination.endsWith(";") && combination.contains("=");
    bool isBracedFunction = combination.contains("(") &&
        combination.contains(")") &&
        combination.endsWith("}") &&
        combination.contains("{");
    bool isArrowFunction =
        combination.contains("=>") && combination.endsWith(";");
    bool isFunction = isBracedFunction || isArrowFunction;
    bool isConstructor = combination.startsWith(className) &&
        combination.contains("(") &&
        combination.contains(")") &&
        combination.endsWith(";");
  }
}

String get tayo => "";
set tayo(String value) => "";

dynamic getFunctionResult(String string) {
  Map<String, dynamic> vars = {};
  Map<String, String> props = {};
  bool isArrowFunction = string.contains("=>") && string.endsWith(";");
  final braceEnd = string.indexOf("{");
  final stringBeforeBraces = string.substring(0, braceEnd);
  final end = stringBeforeBraces.contains("extends")
      ? string.indexOf("extends")
      : stringBeforeBraces.contains("with")
          ? string.indexOf("with")
          : stringBeforeBraces.contains("implements")
              ? string.indexOf("implements")
              : braceEnd;

  final className = string.substring(string.indexOf("class") + 5, end).trim();

  final leftString =
      string.contains("(") ? string.substring(0, string.indexOf("(")) : "";

  final bracketString = string.contains("(") && string.contains(")")
      ? string.substring(string.indexOf("(") + 1, string.lastIndexOf(")"))
      : "";
  final bracedString =
      string.substring(string.indexOf("{") + 1, string.lastIndexOf("}"));
  final combinations = getCombinations(bracedString);

  for (int i = 0; i < combinations.length; i++) {
    final combination = combinations[i].trim();
    bool isVariable = combination.endsWith(";") && combination.contains("=");
    bool isBracedFunction = combination.contains("(") &&
        combination.contains(")") &&
        combination.endsWith("}") &&
        combination.contains("{");
    bool isArrowFunction =
        combination.contains("=>") && combination.endsWith(";");
    bool isFunction = isBracedFunction || isArrowFunction;
    bool isFunctionOrClassCall = combination.contains("(") &&
        combination.contains(")") &&
        combination.endsWith(";");
    bool isForLoop = isBracedFunction && combination.startsWith("for");
    bool isWhileLoop = isBracedFunction && combination.startsWith("while");
    bool isIf = isBracedFunction && combination.startsWith("if");
    bool isElseIf = isBracedFunction && combination.startsWith("else if");
    bool isElse = isBracedFunction && combination.startsWith("else");
    bool isSwitch = isBracedFunction && combination.startsWith("switch");
  }
}
