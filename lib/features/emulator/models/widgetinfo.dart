// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';

class EditorInfo {
  String type;
  Map<String, dynamic> props;
  //List<List<dynamic>> attributes;
  int count;
  EditorInfo({
    required this.type,
    required this.props,
    this.count = 0,
  });

  EditorInfo copyWith({
    String? type,
    Map<String, dynamic>? props,
    int? count,
  }) {
    return EditorInfo(
      type: type ?? this.type,
      props: props ?? this.props,
      count: count ?? this.count,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'type': type,
      'props': props,
      'count': count,
    };
  }

  factory EditorInfo.fromMap(Map<String, dynamic> map) {
    return EditorInfo(
      type: (map["type"] ?? '') as String,
      props: Map<String, dynamic>.from(
        ((map['props'] ?? Map<String, dynamic>.from({}))
            as Map<String, dynamic>),
      ),
      count: (map["count"] ?? 0) as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory EditorInfo.fromJson(String source) =>
      EditorInfo.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'EditorInfo(type: $type, props: $props, count: $count)';

  @override
  bool operator ==(covariant EditorInfo other) {
    if (identical(this, other)) return true;

    return other.type == type &&
        mapEquals(other.props, props) &&
        other.count == count;
  }

  @override
  int get hashCode => type.hashCode ^ props.hashCode ^ count.hashCode;
}

class WidgetInfo {
  String type;
  Map<String, dynamic>? attributes;
  List<WidgetInfo>? subwidgets;
  List<WidgetInfo>? children;

  WidgetInfo(this.type, [this.attributes, this.subwidgets, this.children]);

  @override
  String toString() {
    if (attributes != null && attributes!.isNotEmpty) {
      final attributesString = attributes!.entries
          .map((entry) => '${entry.key}: ${entry.value}')
          .join(', ');
      return '$type($attributesString, ${subwidgets?.join(', ')}, ${children?.join(', ')})';
    } else {
      return '$type(${subwidgets?.join(', ')}, ${children?.join(', ')})';
    }
  }
}

List<WidgetInfo> extractWidgetsFromString(String buildFunction) {
  final List<WidgetInfo> widgets = [];
  final RegExp widgetPattern = RegExp(r'[A-Z]\w*\(');

  void extractWidgetsRecursive(String code) {
    final List<WidgetInfo> subwidgets = [];
    final List<WidgetInfo> children = [];
    final List<String> matches =
        widgetPattern.allMatches(code).map((m) => m.group(0)!).toList();
    print("matches = $matches");

    for (final match in matches) {
      final endIndex = code.indexOf(match);
      print("endIndex = $endIndex");

      final widgetType = match.substring(0, match.length - 1);
      final attributesString = code.substring(0, endIndex).trim();
      print("widgetType = $widgetType, attributesString= $attributesString");
      final attributes = extractAttributes(attributesString);
      final subcode = code.substring(endIndex + match.length);
      print("attributes = $attributes, subcode= $subcode");
      final closingParenthesisIndex = findClosingParenthesis(subcode);
      print(
          "closingParenthesisIndex = $closingParenthesisIndex, matchLength= ${match.length}");
      if (closingParenthesisIndex >= 0) {
        final subcodeBeforeChild =
            subcode.substring(0, closingParenthesisIndex + 1);
        final subcodeAfterChild =
            subcode.substring(closingParenthesisIndex + 1);
        print(
            "subcodeBeforeChild = $subcodeBeforeChild, subcodeAfterChild= $subcodeAfterChild");
        if (subcodeAfterChild.startsWith(')')) {
          subwidgets.add(WidgetInfo(widgetType, attributes));
          print("}");
        } else if (subcodeAfterChild.startsWith('child:')) {
          subwidgets.add(WidgetInfo(widgetType, attributes));
          final child = extractChild(subcodeAfterChild.substring(6).trim());
          if (child != null) {
            subwidgets.last.children = [child];
          }
          print("child:");
        } else if (subcodeAfterChild.startsWith('children:')) {
          subwidgets.add(WidgetInfo(widgetType, attributes));
          final childList =
              extractChildren(subcodeAfterChild.substring(9).trim());
          if (childList.isNotEmpty) {
            subwidgets.last.children = childList;
          }
          print("children:");
        }
        code = subcodeAfterChild.substring(closingParenthesisIndex + 1);
        print("newCode = $code");
      }
    }

    widgets.addAll(subwidgets);
  }

  extractWidgetsRecursive(buildFunction);

  return widgets;
}

Map<String, dynamic>? extractAttributes(String attributesString) {
  final Map<String, dynamic> attributes = {};
  final RegExp attributePattern = RegExp(r'(\w+)\s*:\s*(.*)');

  final List<String> lines = attributesString.split('\n');
  for (final line in lines) {
    final match = attributePattern.firstMatch(line);
    if (match != null) {
      final key = match.group(1)!;
      final value = match.group(2)!;
      attributes[key] = value;
    }
  }

  return attributes.isNotEmpty ? attributes : null;
}

WidgetInfo? extractChild(String code) {
  final List<WidgetInfo> extractedWidgets = extractWidgetsFromString(code);
  if (extractedWidgets.isNotEmpty) {
    return extractedWidgets.first;
  }
  return null;
}

List<WidgetInfo> extractChildren(String code) {
  return extractWidgetsFromString('[$code]');
}

int findClosingParenthesis(String code) {
  int openParenthesisCount = 0;

  for (int i = 0; i < code.length; i++) {
    if (code[i] == '(') {
      openParenthesisCount++;
    } else if (code[i] == ')') {
      openParenthesisCount--;

      if (openParenthesisCount == 0) {
        return i;
      }
    }
  }

  return -1;
}

String testString = '''
    Container(
          padding: EdgeInsets.all(16),
          color: Colors.blue,
          child: Text('Container Widget'),
    ),
  ''';
// String testString = '''
//     Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       crossAxisAlignment: CrossAxisAlignment.center,
//       children: [
//         Text(
//           'Hello World',
//           style: TextStyle(fontSize: 24),
//         ),
//         Row(
//           children: [
//             Icon(
//               Icons.check,
//               color: Colors.green,
//             ),
//             Text('Flutter'),
//           ],
//         ),
//         Container(
//           padding: EdgeInsets.all(16),
//           color: Colors.blue,
//           child: Text('Container Widget'),
//         ),
//       ],
//     )
//   ''';
// String testString = """
// return Column(
//       children: [
//         buildTopBar(),
//         //buildTitleBar(),
//         Expanded(
//           child: Row(
//             children: [
//               Container(
//                 width: context.screenWidthPercentage(15),
//                 color: context.isDarkMode ? lightestWhite : lightestBlack,
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Container(
//                       child: Text(
//                         projectName,
//                         style: const TextStyle(
//                             fontSize: 20, fontWeight: FontWeight.bold),
//                       ),
//                     ),
//                     SingleChildScrollView(
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: List.generate(folders.length, (folindex) {
//                           final folder = folders[folindex];
//                           final files = folderFiles[folindex];
//                           return FolderWidget(
//                             folder: folder,
//                             files: files,
//                             onTap: (int index) {
//                               final file = files[index];
//                             },
//                           );
//                         }),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Container(
//                       height: 50,
//                       child: SingleChildScrollView(
//                         scrollDirection: Axis.horizontal,
//                         child: Row(
//                           children: List.generate(openedFiles.length, (index) {
//                             final filename = openedFiles[index];
//                             return FileWidget(
//                                 filename: filename, onPressed: () {});
//                           }),
//                         ),
//                       ),
//                     ),
//                     Expanded(
//                       child: Scrollbar(
//                         controller: horController,
//                         child: SingleChildScrollView(
//                           controller: horController,
//                           scrollDirection: Axis.horizontal,
//                           child: SingleChildScrollView(
//                             controller: verController,
//                             child: buildCodeLayout(),
//                           ),
//                         ),
//                       ),
//                     ),
//                     Container(
//                       height: context.screenHeightPercentage(10),
//                       child: Column(
//                         children: [const Text("Terminal"), Container()],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               Container(
//                 width: context.screenWidthPercentage(15),
//                 child: Column(
//                   children: [
//                     AspectRatio(
//                       aspectRatio: 9 / 16,
//                       child: buildEmulator(),
//                     ),
//                   ],
//                 ),
//               ),
//               Container(
//                 width: context.screenWidthPercentage(15),
//                 //color: context.isDarkMode ? lightestWhite : lightestBlack,
//                 child: Column(
//                   children: [
//                     Container(
//                       //color: context.isDarkMode ? lightestWhite : lightestBlack,
//                       child: const Text(
//                         "Widgets",
//                         style: TextStyle(
//                             fontSize: 20, fontWeight: FontWeight.bold),
//                       ),
//                     ),
//                     Expanded(
//                       child: widgetProperties.isEmpty
//                           ? SingleChildScrollView(
//                               scrollDirection: Axis.vertical,
//                               child: Wrap(
//                                 children:
//                                     List.generate(widgets.length, (index) {
//                                   final text = widgets[index];
//                                   return InputButton(
//                                     text: text,
//                                     onTap: () {
//                                       addInput(text);
//                                     },
//                                   );
//                                 }),
//                               ),
//                             )
//                           : Row(
//                               children: [
//                                 Expanded(
//                                   child: ListView(
//                                     children: List.generate(
//                                         widgetProperties.length, (index) {
//                                       final text = widgetProperties[index];
//                                       return InputButton(
//                                         text: text,
//                                         onTap: () {
//                                           addInput(text);
//                                         },
//                                       );
//                                     }),
//                                   ),
//                                 ),
//                                 Expanded(
//                                   child: ListView(
//                                     children: List.generate(
//                                         widgetProperties.length, (index) {
//                                       final text = widgetProperties[index];
//                                       return InputButton(
//                                         text: text,
//                                         onTap: () {
//                                           addInput(text);
//                                         },
//                                       );
//                                     }),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                     ),
//                   ],
//                 ),
//               )
//             ],
//           ),
//         ),
//       ],
//     );
// """;
