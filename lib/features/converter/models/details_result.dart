// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class DetailsResult {
  final String output;
  final double height;
  final double width;
  final double left;
  final double top;
  final bool expanded;
  final DetailsResult? parentDetailsResult;
  final List<DetailsResult> childrenDetailsResults;
  DetailsResult({
    required this.output,
    required this.height,
    required this.width,
    required this.left,
    required this.top,
    required this.expanded,
    this.parentDetailsResult,
    required this.childrenDetailsResults,
  });

  DetailsResult copyWith({
    String? output,
    double? height,
    double? width,
    double? left,
    double? top,
    bool? expanded,
    DetailsResult? parentDetailsResult,
    List<DetailsResult>? childrenDetailsResults,
  }) {
    return DetailsResult(
      output: output ?? this.output,
      height: height ?? this.height,
      width: width ?? this.width,
      left: left ?? this.left,
      top: top ?? this.top,
      expanded: expanded ?? this.expanded,
      parentDetailsResult: parentDetailsResult ?? this.parentDetailsResult,
      childrenDetailsResults:
          childrenDetailsResults ?? this.childrenDetailsResults,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'output': output,
      'height': height,
      'width': width,
      'left': left,
      'top': top,
      'expanded': expanded,
      'parentDetailsResult': parentDetailsResult?.toMap(),
      'childrenDetailsResults':
          childrenDetailsResults.map((x) => x.toMap()).toList(),
    };
  }

  factory DetailsResult.fromMap(Map<String, dynamic> map) {
    return DetailsResult(
      output: map['output'] as String,
      height: map['height'] as double,
      width: map['width'] as double,
      left: map['left'] as double,
      top: map['top'] as double,
      expanded: map['expanded'] as bool,
      parentDetailsResult: map['parentDetailsResult'] != null
          ? DetailsResult.fromMap(
              map['parentDetailsResult'] as Map<String, dynamic>)
          : null,
      childrenDetailsResults: List<DetailsResult>.from(
        (map['childrenDetailsResults'] as List<int>).map<DetailsResult>(
          (x) => DetailsResult.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory DetailsResult.fromJson(String source) =>
      DetailsResult.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'DetailsResult(output: $output, height: $height, width: $width, left: $left, top: $top, expanded: $expanded, parentDetailsResult: $parentDetailsResult, childrenDetailsResults: $childrenDetailsResults)';
  }

  @override
  bool operator ==(covariant DetailsResult other) {
    if (identical(this, other)) return true;

    return other.output == output &&
        other.height == height &&
        other.width == width &&
        other.left == left &&
        other.top == top &&
        other.expanded == expanded &&
        other.parentDetailsResult == parentDetailsResult &&
        listEquals(other.childrenDetailsResults, childrenDetailsResults);
  }

  @override
  int get hashCode {
    return output.hashCode ^
        height.hashCode ^
        width.hashCode ^
        left.hashCode ^
        top.hashCode ^
        expanded.hashCode ^
        parentDetailsResult.hashCode ^
        childrenDetailsResults.hashCode;
  }
}
