// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class AxisPosition {
  double? top;
  double? right;
  double? bottom;
  double? left;
  AxisPosition({
    this.top,
    this.right,
    this.bottom,
    this.left,
  });

  AxisPosition copyWith({
    double? top,
    double? right,
    double? bottom,
    double? left,
  }) {
    return AxisPosition(
      top: top ?? this.top,
      right: right ?? this.right,
      bottom: bottom ?? this.bottom,
      left: left ?? this.left,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'top': top,
      'right': right,
      'bottom': bottom,
      'left': left,
    };
  }

  factory AxisPosition.fromMap(Map<String, dynamic> map) {
    return AxisPosition(
      top: map['top'] != null ? map["top"] ?? 0.0 as double : null,
      right: map['right'] != null ? map["right"] ?? 0.0 as double : null,
      bottom: map['bottom'] != null ? map["bottom"] ?? 0.0 as double : null,
      left: map['left'] != null ? map["left"] ?? 0.0 as double : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory AxisPosition.fromJson(String source) =>
      AxisPosition.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'AxisPosition(top: $top, right: $right, bottom: $bottom, left: $left)';
  }

  @override
  bool operator ==(covariant AxisPosition other) {
    if (identical(this, other)) return true;

    return other.top == top &&
        other.right == right &&
        other.bottom == bottom &&
        other.left == left;
  }

  @override
  int get hashCode {
    return top.hashCode ^ right.hashCode ^ bottom.hashCode ^ left.hashCode;
  }
}

class ConvertedData {
  List<String> children;
  String widgetName;
  String? crossAlignment;
  String? mainAlignment;
  AxisPosition? position;
  ConvertedData({
    required this.children,
    required this.widgetName,
    this.crossAlignment,
    this.mainAlignment,
    this.position,
  });

  ConvertedData copyWith({
    List<String>? children,
    String? widgetName,
    String? crossAlignment,
    String? mainAlignment,
    AxisPosition? position,
  }) {
    return ConvertedData(
      children: children ?? this.children,
      widgetName: widgetName ?? this.widgetName,
      crossAlignment: crossAlignment ?? this.crossAlignment,
      mainAlignment: mainAlignment ?? this.mainAlignment,
      position: position ?? this.position,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'children': children,
      'widgetName': widgetName,
      'crossAlignment': crossAlignment,
      'mainAlignment': mainAlignment,
      'position': position?.toMap(),
    };
  }

  factory ConvertedData.fromMap(Map<String, dynamic> map) {
    return ConvertedData(
      children: List<String>.from(
        ((map['children'] ?? const <String>[]) as List<String>),
      ),
      widgetName: (map["widgetName"] ?? '') as String,
      crossAlignment: map['crossAlignment'] != null
          ? map["crossAlignment"] ?? '' as String
          : null,
      mainAlignment: map['mainAlignment'] != null
          ? map["mainAlignment"] ?? '' as String
          : null,
      position: map['position'] != null
          ? AxisPosition.fromMap((map["position"] ??
              Map<String, dynamic>.from({})) as Map<String, dynamic>)
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ConvertedData.fromJson(String source) =>
      ConvertedData.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ConvertedData(children: $children, widgetName: $widgetName, crossAlignment: $crossAlignment, mainAlignment: $mainAlignment, position: $position)';
  }

  @override
  bool operator ==(covariant ConvertedData other) {
    if (identical(this, other)) return true;

    return listEquals(other.children, children) &&
        other.widgetName == widgetName &&
        other.crossAlignment == crossAlignment &&
        other.mainAlignment == mainAlignment &&
        other.position == position;
  }

  @override
  int get hashCode {
    return children.hashCode ^
        widgetName.hashCode ^
        crossAlignment.hashCode ^
        mainAlignment.hashCode ^
        position.hashCode;
  }
}
