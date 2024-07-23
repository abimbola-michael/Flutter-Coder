import 'package:flutter/material.dart';

Widget getWidget(String name) {
  Widget child = Container();
  switch (name) {
    case "Container":
      return Container();
    case "Column":
      return Container();
    case "Row":
      return Container();
    case "Expanded":
      return Container();
    case "Container":
      return Container();
    case "Container":
      return Container();
    case "Container":
      return Container();
    case "Container":
      return Container();
    case "Container":
      return Container();
    case "Container":
      return Container();
  }

  return child;
}

String getDefaultAbstactClassReturnType(String name) {
  String type = "";
  if (name.endsWith("?")) return "null";
  switch (name) {
    case "Widget":
      type = "Container()";
      break;
    case "int":
      type = "0";
      break;
    case "String":
      type = "\"\"";
      break;
    case "double":
      type = "0.0";
      break;
    case "bool":
      type = "false";
      break;
    case "List":
      type = "[]";
      break;
    case "Map":
      type = "{}";
      break;
    case "Runes":
      type = "".runes.toString();
      break;
    case "Symbol":
      type = "null";
      break;
    default:
      type = "($name)";
  }
  return type;
}

bool isAWidget(String string) {
  return (multiLayout.contains(string) ||
      singleLayout.contains(string) ||
      textsiconsandbuttons.contains(string) ||
      cupertinoWidgets.contains(string));
}

List<String> dataTypes = [
  "Future",
  "Stream",
  "void",
  "String",
  "int",
  "double",
  "bool",
];
List<String> starterWidgets = [
  "Row",
  "Column",
  "Stack",
  "ListView",
  "ListView.builder",
  "ListView.separated",
  "GridView",
  "GridView.builder",
  "PageView",
  "TabBarView",
  "Text",
  "Icon",
  "Image",
  "TextField",
  "MaterialButton",
  "TextButton",
  "OutlineButton",
  "ElevatedButton",
  "IconButton",
  "FloatingActionButton",
  "PopupMenuButton",
  "DropDownButton",
  "Checkbox",
  "Radio",
  "Switch",
  "Slider",
  "Scaffold",
  "Container",
  "SizedBox",
  "FutureBuilder",
  "StreamBuilder",
  "LayoutBuilder",
  "Builder",
  // "BlocBuilder",
  // "Consumer",
];

List<String> multiLayout = [
  "Row",
  "Column",
  "Stack",
  "ListView",
  "ListViewB",
  "ListViewS",
  "GridView",
  "GridViewB",
  "PageView",
  "TabBarView",
  "Drawer",
  "Stateful",
  "Stateless",
  "Consumer",
  "FutureBuild",
  "StreamBuild",
  "LayoutBuild",
  "WidgetBuild",
  "BlocBuild",
  "Builder",
  "CircleAvatar",
  "ListTile",
  "GridTile",
  "CircleProgressBar",
  "LinearProgressBar",
];
List<String> singleLayout = [
  "Scaffold",
  "Container",
  "SizedBox",
  "CircleAvatar",
  "ListTile",
  "GridTile",
  "AppBar",
  "TabBar",
  "TabBarView",
  "BottomNavigationBar",
  "BottomTabBar",
  "BottomNavigationBarItem",
  "PopUpMenuItem",
  "SimpleDialog",
  "AlertDialog",
];
List<String> textsiconsandbuttons = [
  "Text",
  "Icon",
  "TextField",
  "MaterialBut",
  "TextBut",
  "OutlineBut",
  "ElevatedBut",
  "IconBut",
  "FloatingActionBut",
  "PopupMenuBut",
  "DropDownBut",
  "ButtonBar",
  "CheckBox",
  "Radio",
  "Switch",
  "Slider",
  "DatePicker",
  "TimePicker",
  "CircleProgressBar",
  "LinearProgressBar",
];
//List<String> dialogs = ["SimpleDialog", "AlertDialog"];
// List<String> tabs = [
//   "TabBar",
//   "TabBarView",
//   "BottomNavigationBar",
//   "BottomTabBar",
//   "BottomNavigationBarItem",
//   "PopUpMenuItem",
// ];

List<String> cupertinoWidgets = [
  "CupBut",
  "CupPicker",
  "CupDatePicker",
  "CupTimePicker",
  "CupNavigationBar",
  "CupTabBar",
  "CupScaffold",
  "CupTabView",
  "CupTextField",
  "CupPageScaffold",
  "CupDialog",
  "CupDialogAction",
  "CupActionSheet",
  "CupActivityIndicator",
  "CupAlertDialog",
  "CupPopupSurface",
];
List<String> reservedKeywords = [
  "abstract",
  "as",
  "assert",
  "async",
  "await",
  "base",
  "break",
  "case",
  "catch",
  "class",
  "const",
  "continue",
  "covariant",
  "default",
  "deferred",
  "do",
  "dynamic",
  "else",
  "enum",
  "export",
  "extends",
  "extension",
  "external",
  "factory",
  "false",
  "final",
  "finally",
  "Function",
  "get",
  "hide",
  "if",
  "implements",
  "import",
  "in",
  "interface",
  "is",
  "late",
  "library",
  "mixin",
  "new",
  "null",
  "new",
  "null",
  "as",
  "on",
  "operator",
  "part",
  "required",
  "rethrow",
  "return",
  "sealed",
  "set",
  "show",
  "static",
  "super",
  "switch",
  "sync",
  "this",
  "throw",
  "true",
  "try",
  "typedef",
  "var",
  "void",
  "when",
  "while",
  "with",
  "yield",
];
List<String> datatypes = ["int", "String", "double", "void"];
List<String> modifiers = ["const", "var", "final"];
List<String> loopcond = ["if", "else", "else if", "for", "while"];

Map<String, String> widgetsMap = {
  "Column": """
    super.key,
    super.mainAxisAlignment,
    super.mainAxisSize,
    super.crossAxisAlignment,
    super.textDirection,
    super.verticalDirection,
    super.textBaseline,
    super.children,""",
  "Row": """
    super.key,
    super.mainAxisAlignment,
    super.mainAxisSize,
    super.crossAxisAlignment,
    super.textDirection,
    super.verticalDirection,
    super.textBaseline,
    super.children,"""
};
List<String> loopsAndConditions = [
  "if",
  "else",
  "else if",
  "for",
  "while",
  "switch",
  "case",
  "return"
];

Map<String, String> enumsMap = {
  "": "",
};
