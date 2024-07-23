// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Prop {
  final String type;
  final String name;
  final String returnType;
  final String value;
  final String string;
  Prop({
    required this.type,
    required this.name,
    required this.returnType,
    required this.value,
    required this.string,
  });

  Prop copyWith({
    String? type,
    String? name,
    String? returnType,
    String? value,
    String? string,
  }) {
    return Prop(
      type: type ?? this.type,
      name: name ?? this.name,
      returnType: returnType ?? this.returnType,
      value: value ?? this.value,
      string: string ?? this.string,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'type': type,
      'name': name,
      'returnType': returnType,
      'value': value,
      'string': string,
    };
  }

  factory Prop.fromMap(Map<String, dynamic> map) {
    return Prop(
      type: map['type'] as String,
      name: map['name'] as String,
      returnType: map['returnType'] as String,
      value: map['value'] as String,
      string: map['string'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Prop.fromJson(String source) =>
      Prop.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Prop(type: $type, name: $name, returnType: $returnType, value: $value, string: $string)';
  }

  @override
  bool operator ==(covariant Prop other) {
    if (identical(this, other)) return true;

    return other.type == type &&
        other.name == name &&
        other.returnType == returnType &&
        other.value == value &&
        other.string == string;
  }

  @override
  int get hashCode {
    return type.hashCode ^
        name.hashCode ^
        returnType.hashCode ^
        value.hashCode ^
        string.hashCode;
  }
}
