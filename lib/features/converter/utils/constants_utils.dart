Map<String, dynamic> getAllInfosFromString(String string) {
  Map<String, dynamic> resultMap = {};
  final combinations = getCombinations(string);

  for (int i = 0; i < combinations.length; i++) {
    final combination = combinations[i].trim();
    bool isClass = combination.endsWith("}") &&
        combination.contains("{") &&
        (combination.startsWith("class") ||
            (combination.contains(" ") &&
                combination
                    .substring(combination.indexOf(" ") + 1)
                    .startsWith("class")));
    bool isVariable = combination.endsWith(";") && combination.contains("=");
    if (isVariable) {
      final variablesMap = getVariables(combination);
      if (variablesMap.isNotEmpty) {
        resultMap.addAll(variablesMap);
      }
    } else if (isClass) {
      final staticVariablesMap = getStaticVariblesMap(combination);
      if (staticVariablesMap.isNotEmpty) {
        resultMap.addAll(staticVariablesMap);
      }
    } else {}
  }
  return resultMap;
}

List<String> getCombinations(String string) {
  List<String> combinations = [];
  int curlyBraceCount = 0;
  String currentString = "";

  for (int i = 0; i < string.length; i++) {
    final char = string[i];
    currentString += char;

    if (char == "{") {
      curlyBraceCount++;
    } else if (char == "}") {
      curlyBraceCount--;
    } else if (char == "\n") {
      if (curlyBraceCount == 0) {
        if (currentString.trim().isNotEmpty) {
          combinations.add(currentString.trim());
          currentString = "";
        }
      }
    }
  }
  if (currentString.trim().isNotEmpty) {
    combinations.add(currentString.trim());
    currentString = "";
  }
  return combinations;
}

Map<String, dynamic> getStaticVariblesMap(String string) {
  Map<String, dynamic> staticVariablesMap = {};

  if (!string.contains("{") && !string.contains("}")) {
    return {};
  }
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
    final combination = combinations[i];
    if (combination.startsWith("static")) {
      final variablesMap = getVariables(combination, className);
      if (variablesMap.isNotEmpty) {
        staticVariablesMap.addAll(variablesMap);
      }
    }
  }
  return staticVariablesMap;
}

Map<String, dynamic> getVariables(String string, [String className = ""]) {
  Map<String, dynamic> variablesMap = {};
  if (string.startsWith("import") || string.startsWith("export")) return {};
  bool isVariable =
      (string.endsWith(";") && string.contains("=") && string.contains(" "));
  if (!isVariable) return {};

  string = string.replaceAll(";", "").trim();

  final List<String> variables =
      string.contains(",") ? string.split(",") : [string];
  for (int i = 0; i < variables.length; i++) {
    final variable = variables[i];
    final equalsIndex = variable.indexOf("=");
    if (equalsIndex != -1) {
      final left = variable.substring(0, equalsIndex).trim();
      final right = variable.substring(equalsIndex + 1).trim();
      if (left.contains(" ")) {
        final name = left.substring(left.lastIndexOf(" ") + 1).trim();
        final value = right;
        final actualName = variable.startsWith("static") && className.isNotEmpty
            ? "$className.$name"
            : name;
        variablesMap[value] = actualName;
      }
    }
  }
  return variablesMap;
}
