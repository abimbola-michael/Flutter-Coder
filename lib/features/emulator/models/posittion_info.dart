// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class PositionInfo {
  List<double> xPoints;
  List<double> yPoints;
  List<double> sizes;
  String child;
  PositionInfo({
    required this.xPoints,
    required this.yPoints,
    required this.sizes,
    required this.child,
  });

  PositionInfo copyWith({
    List<double>? xPoints,
    List<double>? yPoints,
    List<double>? sizes,
    String? child,
  }) {
    return PositionInfo(
      xPoints: xPoints ?? this.xPoints,
      yPoints: yPoints ?? this.yPoints,
      sizes: sizes ?? this.sizes,
      child: child ?? this.child,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'xPoints': xPoints,
      'yPoints': yPoints,
      'sizes': sizes,
      'child': child,
    };
  }

  factory PositionInfo.fromMap(Map<String, dynamic> map) {
    return PositionInfo(
      xPoints: List<double>.from(
        ((map['xPoints'] ?? const <double>[]) as List<double>),
      ),
      yPoints: List<double>.from(
        ((map['yPoints'] ?? const <double>[]) as List<double>),
      ),
      sizes: List<double>.from(
        ((map['sizes'] ?? const <double>[]) as List<double>),
      ),
      child: (map["child"] ?? '') as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory PositionInfo.fromJson(String source) =>
      PositionInfo.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'PositionInfo(xPoints: $xPoints, yPoints: $yPoints, sizes: $sizes, child: $child)';
  }

  @override
  bool operator ==(covariant PositionInfo other) {
    if (identical(this, other)) return true;

    return listEquals(other.xPoints, xPoints) &&
        listEquals(other.yPoints, yPoints) &&
        listEquals(other.sizes, sizes) &&
        other.child == child;
  }

  @override
  int get hashCode {
    return xPoints.hashCode ^
        yPoints.hashCode ^
        sizes.hashCode ^
        child.hashCode;
  }
}
