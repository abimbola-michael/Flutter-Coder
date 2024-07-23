// ignore_for_file: public_member_api_docs, sort_constructors_first
class Variable {
  final String type;
  final List<String> names;
  final List<String> values;
  final String modifier;

   Variable(
    this.type,
    this.names,
    this.values,
    this.modifier,
  );
  // const Variable({
  //   required this.type,
  //   required this.names,
  //   required this.values,
  //   required this.modifier,
  // });
}

class Template {
  List<dynamic> parameters = ["type", [], [], "modifier"];
  late Variable variable;
  // Template(){
  //    variable = Variable(...parameters);
  // }
  //Variable variable = Variable(type: type, names: names, values: values, modifier: modifier)
}
