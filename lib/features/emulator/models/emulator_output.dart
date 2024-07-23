// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/material.dart';

class EmulatorOutput {
  final String className;
  final String widgetType;
  final dynamic output;
  EmulatorOutput({
    required this.className,
    required this.widgetType,
    required this.output,
  });

  EmulatorOutput copyWith({
    String? className,
    String? widgetType,
    dynamic? output,
  }) {
    return EmulatorOutput(
      className: className ?? this.className,
      widgetType: widgetType ?? this.widgetType,
      output: output ?? this.output,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'className': className,
      'widgetType': widgetType,
      'output': output,
    };
  }

  factory EmulatorOutput.fromMap(Map<String, dynamic> map) {
    return EmulatorOutput(
      className: map['className'] as String,
      widgetType: map['widgetType'] as String,
      output: map['output'] as dynamic,
    );
  }

  String toJson() => json.encode(toMap());

  factory EmulatorOutput.fromJson(String source) =>
      EmulatorOutput.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'EmulatorOutput(className: $className, widgetType: $widgetType, output: $output)';

  @override
  bool operator ==(covariant EmulatorOutput other) {
    if (identical(this, other)) return true;

    return other.className == className &&
        other.widgetType == widgetType &&
        other.output == output;
  }

  @override
  int get hashCode =>
      className.hashCode ^ widgetType.hashCode ^ output.hashCode;
}
