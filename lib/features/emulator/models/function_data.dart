// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class FunctionData {
  final String callKey;
  final String propKey;
  final String value;
  FunctionData({
    required this.callKey,
    required this.propKey,
    required this.value,
  });

  FunctionData copyWith({
    String? callKey,
    String? propKey,
    String? value,
  }) {
    return FunctionData(
      callKey: callKey ?? this.callKey,
      propKey: propKey ?? this.propKey,
      value: value ?? this.value,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'callKey': callKey,
      'propKey': propKey,
      'value': value,
    };
  }

  factory FunctionData.fromMap(Map<String, dynamic> map) {
    return FunctionData(
      callKey: map['callKey'] as String,
      propKey: map['propKey'] as String,
      value: map['value'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory FunctionData.fromJson(String source) =>
      FunctionData.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'FunctionData(callKey: $callKey, propKey: $propKey, value: $value)';

  @override
  bool operator ==(covariant FunctionData other) {
    if (identical(this, other)) return true;

    return other.callKey == callKey &&
        other.propKey == propKey &&
        other.value == value;
  }

  @override
  int get hashCode => callKey.hashCode ^ propKey.hashCode ^ value.hashCode;
}
