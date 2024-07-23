// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'input.dart';
import 'variable.dart';

class Method {
  final String returnType;
  final String name;
  final List<Variable> argument;
  final List<Line> codeLines;
  final String functionType;
  const Method({
    required this.returnType,
    required this.name,
    required this.argument,
    required this.codeLines,
    required this.functionType,
  });
}
