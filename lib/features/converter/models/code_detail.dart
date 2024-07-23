import 'dart:convert';

import 'package:flutter/foundation.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class CodeDetail {
  String id;
  String string;
  String type;
  bool circular;
  bool clickable;
  bool expanded;
  double? radius;
  List<CodeDetail> childrenCodeDetails;
  CodeDetail({
    required this.id,
    required this.string,
    required this.type,
    required this.circular,
    required this.clickable,
    required this.expanded,
    this.radius,
    required this.childrenCodeDetails,
  });

  CodeDetail copyWith({
    String? id,
    String? string,
    String? type,
    bool? circular,
    bool? clickable,
    bool? expanded,
    double? radius,
    List<CodeDetail>? childrenCodeDetails,
  }) {
    return CodeDetail(
      id: id ?? this.id,
      string: string ?? this.string,
      type: type ?? this.type,
      circular: circular ?? this.circular,
      clickable: clickable ?? this.clickable,
      expanded: expanded ?? this.expanded,
      radius: radius ?? this.radius,
      childrenCodeDetails: childrenCodeDetails ?? this.childrenCodeDetails,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'string': string,
      'type': type,
      'circular': circular,
      'clickable': clickable,
      'expanded': expanded,
      'radius': radius,
      'childrenCodeDetails': childrenCodeDetails.map((x) => x.toMap()).toList(),
    };
  }

  factory CodeDetail.fromMap(Map<String, dynamic> map) {
    return CodeDetail(
      id: map['id'] as String,
      string: map['string'] as String,
      type: map['type'] as String,
      circular: map['circular'] as bool,
      clickable: map['clickable'] as bool,
      expanded: map['expanded'] as bool,
      radius: map['radius'] != null ? map['radius'] as double : null,
      childrenCodeDetails: List<CodeDetail>.from(
        (map['childrenCodeDetails'] as List<int>).map<CodeDetail>(
          (x) => CodeDetail.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory CodeDetail.fromJson(String source) =>
      CodeDetail.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'CodeDetail(id: $id, string: $string, type: $type, circular: $circular, clickable: $clickable, expanded: $expanded, radius: $radius, childrenCodeDetails: $childrenCodeDetails)';
  }

  @override
  bool operator ==(covariant CodeDetail other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.string == string &&
        other.type == type &&
        other.circular == circular &&
        other.clickable == clickable &&
        other.expanded == expanded &&
        other.radius == radius &&
        listEquals(other.childrenCodeDetails, childrenCodeDetails);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        string.hashCode ^
        type.hashCode ^
        circular.hashCode ^
        clickable.hashCode ^
        expanded.hashCode ^
        radius.hashCode ^
        childrenCodeDetails.hashCode;
  }
}
