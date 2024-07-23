import 'package:flutter_coder/features/shared/utils/extensions.dart';

// String getModelsString(String input) {
//   String output = "";
//   final strings = input.customSplit(",");
//   List<Map<String, String>> models = [];
//   for (int i = 0; i < strings.length; i++) {
//     final string = strings[i].trim();
//     if (string.startsWith("{") && string.endsWith("}")) {}
//   }
//   return output;
// }

String getType(String value) {
  if ((value.startsWith('"') && value.endsWith('"')) ||
      (value.startsWith("'") && value.endsWith("'"))) {
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
    return "Map";
  }
  return "";
}

String getModels(String input, [String name = "Response"]) {
  input = input.trim();
  List<String> models = [];
  List<String> strings = [];

  if (input.startsWith("{") && input.endsWith("}")) {
    strings = input.substring(1, input.length - 1).customSplit(",");
  }
  String output = "class $name {\n";
  for (int i = 0; i < strings.length; i++) {
    final string = strings[i].trim();
    final values = string.customSplit(":");
    if (values.length == 2) {
      String name = values[0].trim();
      String value = values[1].trim();
      name = name.substring(1, name.length - 1);
      String type = getType(value);

      if (type == "Map") {
        type = "${name.capitalize()}Obj";
        final modelOutput = getModels(value, type);
        models.add(modelOutput);
      } else if (type == "List") {
        final listStrings =
            value.substring(1, value.length - 1).customSplit(",");
        final listStringType =
            listStrings.isEmpty ? "" : getType(listStrings[0]);

        if (listStringType.isNotEmpty) {
          if (listStringType == "Map") {
            final modelName =
                name.endsWith("s") ? name.substring(0, name.length - 1) : name;
            type = "List<${modelName.capitalize()}>";

            final listString = listStrings[0];

            final modelOutput = getModels(listString, modelName.capitalize());
            models.add(modelOutput);
          } else {
            type = "List<$listStringType>";
          }
        }
      }

      String model = "\t$type $name;\n";
      output += model;
    }
  }
  output += "}\n\n";
  final modelsString = models.join("\n");
  output += modelsString;
  return output;
}
