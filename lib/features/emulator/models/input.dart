import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first

class Line {
  List<String> texts;
  Line? nextLine;
  Line({
    required this.texts,
  });
}

class InputParameter {
  String inputType;
  String type;
  String name;
  String value;
  List<String> modifiers;
  InputParameter({
    required this.inputType,
    required this.type,
    required this.name,
    required this.value,
    required this.modifiers,
  });

  InputParameter copyWith({
    String? inputType,
    String? type,
    String? name,
    String? value,
    List<String>? modifiers,
  }) {
    return InputParameter(
      inputType: inputType ?? this.inputType,
      type: type ?? this.type,
      name: name ?? this.name,
      value: value ?? this.value,
      modifiers: modifiers ?? this.modifiers,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'inputType': inputType,
      'type': type,
      'name': name,
      'value': value,
      'modifiers': modifiers,
    };
  }

  factory InputParameter.fromMap(Map<String, dynamic> map) {
    return InputParameter(
      inputType: (map["inputType"] ?? '') as String,
      type: (map["type"] ?? '') as String,
      name: (map["name"] ?? '') as String,
      value: (map["value"] ?? '') as String,
      modifiers: List<String>.from(
        ((map['modifiers'] ?? const <String>[]) as List<String>),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory InputParameter.fromJson(String source) =>
      InputParameter.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'InputParameter(inputType: $inputType, type: $type, name: $name, value: $value, modifiers: $modifiers)';
  }

  @override
  bool operator ==(covariant InputParameter other) {
    if (identical(this, other)) return true;

    return other.inputType == inputType &&
        other.type == type &&
        other.name == name &&
        other.value == value &&
        listEquals(other.modifiers, modifiers);
  }

  @override
  int get hashCode {
    return inputType.hashCode ^
        type.hashCode ^
        name.hashCode ^
        value.hashCode ^
        modifiers.hashCode;
  }
}

class InputInfo {
  String name;
  String type;
  String key;
  String value;
  bool required;
  InputInfo({
    required this.name,
    required this.type,
    required this.key,
    required this.value,
    required this.required,
  });

  InputInfo copyWith({
    String? name,
    String? type,
    String? key,
    String? value,
    bool? required,
  }) {
    return InputInfo(
      name: name ?? this.name,
      type: type ?? this.type,
      key: key ?? this.key,
      value: value ?? this.value,
      required: required ?? this.required,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'type': type,
      'key': key,
      'value': value,
      'required': required,
    };
  }

  factory InputInfo.fromMap(Map<String, dynamic> map) {
    return InputInfo(
      name: (map["name"] ?? '') as String,
      type: (map["type"] ?? '') as String,
      key: (map["key"] ?? '') as String,
      value: (map["value"] ?? '') as String,
      required: (map["required"] ?? false) as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory InputInfo.fromJson(String source) =>
      InputInfo.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'InputInfo(name: $name, type: $type, key: $key, value: $value, required: $required)';
  }

  @override
  bool operator ==(covariant InputInfo other) {
    if (identical(this, other)) return true;

    return other.name == name &&
        other.type == type &&
        other.key == key &&
        other.value == value &&
        other.required == required;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        type.hashCode ^
        key.hashCode ^
        value.hashCode ^
        required.hashCode;
  }
}

// class Tola {final joy = "";final joy2 = "";}

class InputData {
  String data;
  List<InputData>? blockInputs;
  String filePath;
  InputData({
    required this.data,
    this.blockInputs,
    required this.filePath,
  });

  InputData copyWith({
    String? data,
    List<InputData>? blockInputs,
    String? filePath,
  }) {
    return InputData(
      data: data ?? this.data,
      blockInputs: blockInputs ?? this.blockInputs,
      filePath: filePath ?? this.filePath,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'data': data,
      'blockInputs': blockInputs?.map((x) {
        return x?.toMap();
      }).toList(growable: false),
      'filePath': filePath,
    };
  }

  factory InputData.fromMap(Map<String, dynamic> map) {
    return InputData(
      data: (map["data"] ?? '') as String,
      blockInputs: map['blockInputs'] != null
          ? List<InputData>.from(
              ((map['blockInputs']) as List).map<InputData?>((x) {
                return InputData.fromMap((x ?? Map<String, dynamic>.from({}))
                    as Map<String, dynamic>);
              }),
            )
          : null,
      filePath: (map["filePath"] ?? '') as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory InputData.fromJson(String source) =>
      InputData.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'InputData(data: $data, blockInputs: $blockInputs, filePath: $filePath)';

  @override
  bool operator ==(covariant InputData other) {
    if (identical(this, other)) return true;

    return other.data == data &&
        listEquals(other.blockInputs, blockInputs) &&
        other.filePath == filePath;
  }

  @override
  int get hashCode => data.hashCode ^ blockInputs.hashCode ^ filePath.hashCode;
}

class Input {
  String inputType;
  String filePath;
  List<String> parameters;
  List<String> modifiers;
  List<String>? atModifiers;
  List<Input>? subInputs;
  List<String>? codeLines;
  Input({
    required this.inputType,
    required this.filePath,
    required this.parameters,
    required this.modifiers,
    this.atModifiers,
    this.subInputs,
  });

  Input copyWith({
    String? inputType,
    String? filePath,
    List<String>? parameters,
    List<String>? modifiers,
    List<String>? atModifiers,
    List<Input>? subInputs,
  }) {
    return Input(
      inputType: inputType ?? this.inputType,
      filePath: filePath ?? this.filePath,
      parameters: parameters ?? this.parameters,
      modifiers: modifiers ?? this.modifiers,
      atModifiers: atModifiers ?? this.atModifiers,
      subInputs: subInputs ?? this.subInputs,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'inputType': inputType,
      'filePath': filePath,
      'parameters': parameters,
      'modifiers': modifiers,
      'atModifiers': atModifiers,
      'subInputs': subInputs?.map((x) {
        return x?.toMap();
      }).toList(growable: false),
    };
  }

  factory Input.fromMap(Map<String, dynamic> map) {
    return Input(
      inputType: (map["inputType"] ?? '') as String,
      filePath: (map["filePath"] ?? '') as String,
      parameters: List<String>.from(
        ((map['parameters'] ?? const <String>[]) as List<String>),
      ),
      modifiers: List<String>.from(
        ((map['modifiers'] ?? const <String>[]) as List<String>),
      ),
      atModifiers: map['atModifiers'] != null
          ? List<String>.from(
              ((map['atModifiers']) as List<String>),
            )
          : null,
      subInputs: map['subInputs'] != null
          ? List<Input>.from(
              ((map['subInputs']) as List).map<Input?>((x) {
                return Input.fromMap((x ?? Map<String, dynamic>.from({}))
                    as Map<String, dynamic>);
              }),
            )
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Input.fromJson(String source) =>
      Input.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Input(inputType: $inputType, filePath: $filePath, parameters: $parameters, modifiers: $modifiers, atModifiers: $atModifiers, subInputs: $subInputs)';
  }

  @override
  bool operator ==(covariant Input other) {
    if (identical(this, other)) return true;

    return other.inputType == inputType &&
        other.filePath == filePath &&
        listEquals(other.parameters, parameters) &&
        listEquals(other.modifiers, modifiers) &&
        listEquals(other.atModifiers, atModifiers) &&
        listEquals(other.subInputs, subInputs);
  }

  @override
  int get hashCode {
    return inputType.hashCode ^
        filePath.hashCode ^
        parameters.hashCode ^
        modifiers.hashCode ^
        atModifiers.hashCode ^
        subInputs.hashCode;
  }
}

class Test {
  String get book => "";
  set book(String name) {
  }
}

String _holla = "";
