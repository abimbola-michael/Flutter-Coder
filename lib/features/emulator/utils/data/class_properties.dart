import 'package:flutter/material.dart';

import '../../models/input.dart';
import '../widgets_data.dart';

dynamic classProperties<E, S, T, K, V>(dynamic className, String value,
    List<String> parameters, Map<String, List<InputData>> datas,
    [String returnType = "",
    List<Map<String, dynamic>> vars = const [],
    List<Map<String, String>> props = const []]) {
  Map<String, dynamic> maps = {};
  if (parameters.isNotEmpty) {
    for (int i = 0; i < parameters.length; i++) {
      final parameter = parameters[i];
      String key, value;
      if (parameter.isNotEmpty) {
        final strings = customBracedSplitting(parameter, ":");
        if (strings.length > 1) {
          key = strings[0];
          final colIndex = parameter.indexOf(":");
          value = parameter.substring(colIndex + 1).trim();
        } else {
          key = "$i";
          value = parameter;
        }
        print("key = $key value = $value, prevClassName = $returnType");
        maps[key] = value;
      }
    }
  }
  if (className is List) {
    switch (value) {
      case "cast":
        return className.cast();
      case "[]":
        if (maps["0"] == null) {
          return;
        }
        return className[getValue(maps["0"], datas, returnType, vars, props)!];
      case "[]=":
        if (maps["0"] == null || maps["1"] == null) {
          return;
        }
        return className[getValue(maps["0"], datas, returnType, vars, props)!] =
            (getValue(maps["1"], datas, returnType, vars, props)!);
      case "first":
        if (maps["0"] == null) {
          return;
        }
        return className
            .first(getValue(maps["0"], datas, returnType, vars, props)!);
      case "last":
        if (maps["0"] == null) {
          return;
        }
        return className
            .last(getValue(maps["0"], datas, returnType, vars, props)!);
      case "length":
        return className.length;
      // case "length":
      //   if (maps["0"] == null) {
      //     return;
      //   }
      //   return className.length;
      case "add":
        if (maps["0"] == null) {
          return;
        }
        return className
            .add(getValue(maps["0"], datas, returnType, vars, props)!);
      case "addAll":
        if (maps["0"] == null) {
          return;
        }
        return className
            .addAll(getValue(maps["0"], datas, returnType, vars, props)!);
      case "reversed":
        return className.reversed;

      case "sort":
        return className
            .sort(getValue(maps["0"], datas, returnType, vars, props));
      case "shuffle":
        return className
            .shuffle(getValue(maps["0"], datas, returnType, vars, props));
      case "indexOf":
        if (maps["0"] == null) {
          return;
        }
        return className.indexOf(
            getValue(maps["0"], datas, returnType, vars, props)!,
            getValue(maps["2"], datas, returnType, vars, props) ?? 0);
      case "indexWhere":
        if (maps["0"] == null) {
          return;
        }
        return className.indexWhere(
            getValue(maps["0"], datas, returnType, vars, props)!,
            getValue(maps["2"], datas, returnType, vars, props) ?? 0);
      case "lastIndexWhere":
        if (maps["0"] == null) {
          return;
        }
        return className.lastIndexWhere(
            getValue(maps["0"], datas, returnType, vars, props)!,
            getValue(maps["2"], datas, returnType, vars, props));
      case "lastIndexOf":
        if (maps["0"] == null) {
          return;
        }
        return className.lastIndexOf(
            getValue(maps["0"], datas, returnType, vars, props)!,
            getValue(maps["2"], datas, returnType, vars, props));
      case "clear":
        return className.clear();
      case "insert":
        if (maps["0"] == null || maps["1"] == null) {
          return;
        }
        return className.insert(
            getValue(maps["0"], datas, returnType, vars, props)!,
            getValue(maps["1"], datas, returnType, vars, props)!);
      case "insertAll":
        if (maps["0"] == null || maps["1"] == null) {
          return;
        }
        return className.insertAll(
            getValue(maps["0"], datas, returnType, vars, props)!,
            getValue(maps["1"], datas, returnType, vars, props)!);
      case "setAll":
        if (maps["0"] == null || maps["1"] == null) {
          return;
        }
        return className.setAll(
            getValue(maps["0"], datas, returnType, vars, props)!,
            getValue(maps["1"], datas, returnType, vars, props)!);
      case "remove":
        if (maps["0"] == null) {
          return;
        }
        return className
            .remove(getValue(maps["0"], datas, returnType, vars, props)!);
      case "removeAt":
        if (maps["0"] == null) {
          return;
        }
        return className
            .removeAt(getValue(maps["0"], datas, returnType, vars, props)!);
      case "removeLast":
        return className.removeLast();
      case "removeWhere":
        if (maps["0"] == null) {
          return;
        }
        return className
            .removeWhere(getValue(maps["0"], datas, returnType, vars, props)!);
      case "retainWhere":
        if (maps["0"] == null) {
          return;
        }
        return className
            .retainWhere(getValue(maps["0"], datas, returnType, vars, props)!);
      case "+":
        if (maps["0"] == null) {
          return;
        }
        return className +
            (List<E>.from(getValue(maps["0"], datas, returnType, vars, props)));
      case "sublist":
        if (maps["0"] == null) {
          return;
        }
        return className.sublist(
            getValue(maps["0"], datas, returnType, vars, props)!,
            getValue(maps["2"], datas, returnType, vars, props));
      case "getRange":
        if (maps["0"] == null || maps["1"] == null) {
          return;
        }
        return className.getRange(
            getValue(maps["0"], datas, returnType, vars, props)!,
            getValue(maps["1"], datas, returnType, vars, props)!);
      case "setRange":
        if (maps["0"] == null || maps["1"] == null || maps["2"] == null) {
          return;
        }
        return className.setRange(
            getValue(maps["0"], datas, returnType, vars, props)!,
            getValue(maps["1"], datas, returnType, vars, props)!,
            getValue(maps["2"], datas, returnType, vars, props)!,
            getValue(maps["4"], datas, returnType, vars, props) ?? 0);
      case "removeRange":
        if (maps["0"] == null || maps["1"] == null) {
          return;
        }
        return className.removeRange(
            getValue(maps["0"], datas, returnType, vars, props)!,
            getValue(maps["1"], datas, returnType, vars, props)!);
      case "fillRange":
        if (maps["0"] == null || maps["1"] == null) {
          return;
        }
        return className.fillRange(
            getValue(maps["0"], datas, returnType, vars, props)!,
            getValue(maps["1"], datas, returnType, vars, props)!,
            getValue(maps["3"], datas, returnType, vars, props));
      case "replaceRange":
        if (maps["0"] == null || maps["1"] == null || maps["2"] == null) {
          return;
        }
        return className.replaceRange(
            getValue(maps["0"], datas, returnType, vars, props)!,
            getValue(maps["1"], datas, returnType, vars, props)!,
            getValue(maps["2"], datas, returnType, vars, props)!);
      case "asMap":
        return className.asMap();
      case "==":
        if (maps["0"] == null) {
          return;
        }
        return className ==
            (getValue(maps["0"], datas, returnType, vars, props)!);
    }
  } else if (className is Map) {
    switch (value) {
      case "cast":
        return className.cast();
      case "containsValue":
        if (maps["0"] == null) {
          return;
        }
        return className.containsValue(
            getValue(maps["0"], datas, returnType, vars, props)!);
      case "containsKey":
        if (maps["0"] == null) {
          return;
        }
        return className
            .containsKey(getValue(maps["0"], datas, returnType, vars, props)!);
      case "[]":
        if (maps["0"] == null) {
          return;
        }
        return className[getValue(maps["0"], datas, returnType, vars, props)!];
      case "[]=":
        if (maps["0"] == null || maps["1"] == null) {
          return;
        }
        return className[getValue(maps["0"], datas, returnType, vars, props)!] =
            (getValue(maps["1"], datas, returnType, vars, props)!);
      case "entries":
        return className.entries;

      case "map":
        if (maps["0"] == null) {
          return;
        }
        return className
            .map(getValue(maps["0"], datas, returnType, vars, props));
      case "addEntries":
        if (maps["0"] == null) {
          return;
        }
        return className
            .addEntries(getValue(maps["0"], datas, returnType, vars, props)!);
      case "update":
        if (maps["0"] == null || maps["1"] == null) {
          return;
        }
        return className.update(
            getValue(maps["0"], datas, returnType, vars, props)!,
            getValue(maps["1"], datas, returnType, vars, props)!,
            ifAbsent:
                getValue(maps["ifAbsent"], datas, returnType, vars, props));
      case "updateAll":
        if (maps["0"] == null) {
          return;
        }
        return className
            .updateAll(getValue(maps["0"], datas, returnType, vars, props)!);
      case "removeWhere":
        if (maps["0"] == null) {
          return;
        }
        return className
            .removeWhere(getValue(maps["0"], datas, returnType, vars, props)!);
      case "putIfAbsent":
        if (maps["0"] == null || maps["1"] == null) {
          return;
        }
        return className.putIfAbsent(
            getValue(maps["0"], datas, returnType, vars, props)!,
            getValue(maps["1"], datas, returnType, vars, props)!);
      case "addAll":
        if (maps["0"] == null) {
          return;
        }
        return className.addAll(Map<K, V>.from(
            getValue(maps["0"], datas, returnType, vars, props)));
      case "remove":
        if (maps["0"] == null) {
          return;
        }
        return className
            .remove(getValue(maps["0"], datas, returnType, vars, props)!);
      case "clear":
        return className.clear();
      case "forEach":
        if (maps["0"] == null) {
          return;
        }
        return className
            .forEach(getValue(maps["0"], datas, returnType, vars, props)!);
      case "keys":
        return className.keys;

      case "values":
        return className.values;

      case "length":
        return className.length;

      case "isEmpty":
        return className.isEmpty;

      case "isNotEmpty":
        return className.isNotEmpty;
    }
  } else if (className is Set) {
    switch (value) {
      case "cast":
        return className.cast();
      case "iterator":
        return className.iterator;

      case "contains":
        if (maps["0"] == null) {
          return;
        }
        return className
            .contains(getValue(maps["0"], datas, returnType, vars, props)!);
      case "add":
        if (maps["0"] == null) {
          return;
        }
        return className
            .add(getValue(maps["0"], datas, returnType, vars, props)!);
      case "addAll":
        if (maps["0"] == null) {
          return;
        }
        return className
            .addAll(getValue(maps["0"], datas, returnType, vars, props)!);
      case "remove":
        if (maps["0"] == null) {
          return;
        }
        return className
            .remove(getValue(maps["0"], datas, returnType, vars, props)!);
      case "lookup":
        if (maps["0"] == null) {
          return;
        }
        return className
            .lookup(getValue(maps["0"], datas, returnType, vars, props)!);
      case "removeAll":
        if (maps["0"] == null) {
          return;
        }
        return className
            .removeAll(getValue(maps["0"], datas, returnType, vars, props)!);
      case "retainAll":
        if (maps["0"] == null) {
          return;
        }
        return className
            .retainAll(getValue(maps["0"], datas, returnType, vars, props)!);
      case "removeWhere":
        if (maps["0"] == null) {
          return;
        }
        return className
            .removeWhere(getValue(maps["0"], datas, returnType, vars, props)!);
      case "retainWhere":
        if (maps["0"] == null) {
          return;
        }
        return className
            .retainWhere(getValue(maps["0"], datas, returnType, vars, props)!);
      case "containsAll":
        if (maps["0"] == null) {
          return;
        }
        return className
            .containsAll(getValue(maps["0"], datas, returnType, vars, props)!);
      case "intersection":
        if (maps["0"] == null) {
          return;
        }
        return className.intersection(Set<Object?>.from(
            getValue(maps["0"], datas, returnType, vars, props)));
      case "union":
        if (maps["0"] == null) {
          return;
        }
        return className.union(
            Set<E>.from(getValue(maps["0"], datas, returnType, vars, props)));
      case "difference":
        if (maps["0"] == null) {
          return;
        }
        return className.difference(Set<Object?>.from(
            getValue(maps["0"], datas, returnType, vars, props)));
      case "clear":
        return className.clear();
      case "toSet":
        return className.toSet();
    }
  } else if (className is String) {
    switch (value) {
      case "[]":
        if (maps["0"] == null) {
          return;
        }
        return className[getValue(maps["0"], datas, returnType, vars, props)!];
      case "codeUnitAt":
        if (maps["0"] == null) {
          return;
        }
        return className
            .codeUnitAt(getValue(maps["0"], datas, returnType, vars, props)!);
      case "length":
        return className.length;

      case "hashCode":
        return className.hashCode;
      case "==":
        if (maps["0"] == null) {
          return;
        }
        return className ==
            (getValue(maps["0"], datas, returnType, vars, props)!);
      case "compareTo":
        if (maps["0"] == null) {
          return;
        }
        return className
            .compareTo(getValue(maps["0"], datas, returnType, vars, props)!);
      case "endsWith":
        if (maps["0"] == null) {
          return;
        }
        return className
            .endsWith(getValue(maps["0"], datas, returnType, vars, props)!);
      case "startsWith":
        if (maps["0"] == null) {
          return;
        }
        return className.startsWith(
            getValue(maps["0"], datas, returnType, vars, props)!,
            getValue(maps["2"], datas, returnType, vars, props) ?? 0);
      case "indexOf":
        if (maps["0"] == null) {
          return;
        }
        return className.indexOf(
            getValue(maps["0"], datas, returnType, vars, props)!,
            getValue(maps["2"], datas, returnType, vars, props) ?? 0);
      case "lastIndexOf":
        if (maps["0"] == null) {
          return;
        }
        return className.lastIndexOf(
            getValue(maps["0"], datas, returnType, vars, props)!,
            getValue(maps["2"], datas, returnType, vars, props));
      case "isEmpty":
        return className.isEmpty;

      case "isNotEmpty":
        return className.isNotEmpty;

      case "+":
        if (maps["0"] == null) {
          return;
        }
        return className +
            (getValue(maps["0"], datas, returnType, vars, props)!);
      case "substring":
        if (maps["0"] == null) {
          return;
        }
        return className.substring(
            getValue(maps["0"], datas, returnType, vars, props)!,
            getValue(maps["2"], datas, returnType, vars, props));
      case "trim":
        return className.trim();
      case "trimLeft":
        return className.trimLeft();
      case "trimRight":
        return className.trimRight();
      case "*":
        if (maps["0"] == null) {
          return;
        }
        return className *
            (getValue(maps["0"], datas, returnType, vars, props)!);
    }
  } else if (className is bool) {
    switch (value) {
      case "hashCode":
        return className.hashCode;

      case "&":
        if (maps["0"] == null) {
          return;
        }
        return className &
            (getValue(maps["0"], datas, returnType, vars, props)!);
      case "|":
        if (maps["0"] == null) {
          return;
        }
        return className |
            (getValue(maps["0"], datas, returnType, vars, props)!);
      case "^":
        if (maps["0"] == null) {
          return;
        }
        return className ^
            (getValue(maps["0"], datas, returnType, vars, props)!);
      case "toString":
        return className.toString();
    }
  } else if (className is double) {
    switch (value) {
      case "remainder":
        if (maps["0"] == null) {
          return;
        }
        return className
            .remainder(getValue(maps["0"], datas, returnType, vars, props)!);
      case "+":
        if (maps["0"] == null) {
          return;
        }
        return className +
            (getValue(maps["0"], datas, returnType, vars, props)!);
      case "-":
        if (maps["0"] == null) {
          return;
        }
        return className -
            (getValue(maps["0"], datas, returnType, vars, props)!);
      case "*":
        if (maps["0"] == null) {
          return;
        }
        return className *
            (getValue(maps["0"], datas, returnType, vars, props)!);
      case "%":
        if (maps["0"] == null) {
          return;
        }
        return className %
            (getValue(maps["0"], datas, returnType, vars, props)!);
      case "/":
        if (maps["0"] == null) {
          return;
        }
        return className /
            (getValue(maps["0"], datas, returnType, vars, props)!);
      case "~/":
        if (maps["0"] == null) {
          return;
        }
        return className ~/
            (getValue(maps["0"], datas, returnType, vars, props)!);
      // case "-":
      //   if (maps["0"] == null) {
      //     return;
      //   }
      //   return className -
      //       (getValue(maps["0"], datas, returnType, vars, props)!);
      case "abs":
        return className.abs();
      case "sign":
        return className.sign;

      case "round":
        return className.round();
      case "floor":
        return className.floor();
      case "ceil":
        return className.ceil();
      case "truncate":
        return className.truncate();
      case "roundToDouble":
        return className.roundToDouble();
      case "floorToDouble":
        return className.floorToDouble();
      case "ceilToDouble":
        return className.ceilToDouble();
      case "truncateToDouble":
        return className.truncateToDouble();
      case "toString":
        return className.toString();
    }
  } else if (className is int) {
    switch (value) {
      case "&":
        if (maps["0"] == null) {
          return;
        }
        return className &
            (getValue(maps["0"], datas, returnType, vars, props)!);
      case "|":
        if (maps["0"] == null) {
          return;
        }
        return className |
            (getValue(maps["0"], datas, returnType, vars, props)!);
      case "^":
        if (maps["0"] == null) {
          return;
        }
        return className ^
            (getValue(maps["0"], datas, returnType, vars, props)!);
      case "modPow":
        if (maps["0"] == null || maps["1"] == null) {
          return;
        }
        return className.modPow(
            getValue(maps["0"], datas, returnType, vars, props)!,
            getValue(maps["1"], datas, returnType, vars, props)!);
      case "modInverse":
        if (maps["0"] == null) {
          return;
        }
        return className
            .modInverse(getValue(maps["0"], datas, returnType, vars, props)!);
      case "gcd":
        if (maps["0"] == null) {
          return;
        }
        return className
            .gcd(getValue(maps["0"], datas, returnType, vars, props)!);
      case "isEven":
        return className.isEven;

      case "isOdd":
        return className.isOdd;

      case "bitLength":
        return className.bitLength;

      case "toUnsigned":
        if (maps["0"] == null) {
          return;
        }
        return className
            .toUnsigned(getValue(maps["0"], datas, returnType, vars, props)!);
      case "toSigned":
        if (maps["0"] == null) {
          return;
        }
        return className
            .toSigned(getValue(maps["0"], datas, returnType, vars, props)!);
      case "-":
        if (maps["0"] == null) {
          return;
        }
        return className -
            (getValue(maps["0"], datas, returnType, vars, props)!);
      case "abs":
        return className.abs();
      case "sign":
        return className.sign;

      case "round":
        return className.round();
      case "floor":
        return className.floor();
      case "ceil":
        return className.ceil();
      case "truncate":
        return className.truncate();
      case "roundToDouble":
        return className.roundToDouble();
      case "floorToDouble":
        return className.floorToDouble();
      case "ceilToDouble":
        return className.ceilToDouble();
      case "truncateToDouble":
        return className.truncateToDouble();
      case "toString":
        return className.toString();
      case "toRadixString":
        if (maps["0"] == null) {
          return;
        }
        return className.toRadixString(
            getValue(maps["0"], datas, returnType, vars, props)!);
    }
  }
  if (className is num) {
    switch (value) {
      case "==":
        if (maps["0"] == null) {
          return;
        }
        return className ==
            (getValue(maps["0"], datas, returnType, vars, props)!);
      case "hashCode":
        return className.hashCode;
      case "compareTo":
        if (maps["0"] == null) {
          return;
        }
        return className
            .compareTo(getValue(maps["0"], datas, returnType, vars, props)!);
      case "+":
        if (maps["0"] == null) {
          return;
        }
        return className +
            (getValue(maps["0"], datas, returnType, vars, props)!);
      case "-":
        if (maps["0"] == null) {
          return;
        }
        return className -
            (getValue(maps["0"], datas, returnType, vars, props)!);
      case "*":
        if (maps["0"] == null) {
          return;
        }
        return className *
            (getValue(maps["0"], datas, returnType, vars, props)!);
      case "%":
        if (maps["0"] == null) {
          return;
        }
        return className %
            (getValue(maps["0"], datas, returnType, vars, props)!);
      case "/":
        if (maps["0"] == null) {
          return;
        }
        return className /
            (getValue(maps["0"], datas, returnType, vars, props)!);
      case "~/":
        if (maps["0"] == null) {
          return;
        }
        return className ~/
            (getValue(maps["0"], datas, returnType, vars, props)!);

      case "remainder":
        if (maps["0"] == null) {
          return;
        }
        return className
            .remainder(getValue(maps["0"], datas, returnType, vars, props)!);
      case "isNaN":
        return className.isNaN;
      case "isNegative":
        return className.isNegative;
      case "isInfinite":
        return className.isInfinite;
      case "isFinite":
        return className.isFinite;
      case "abs":
        return className.abs();
      case "sign":
        return className.sign;
      case "round":
        return className.round();
      case "floor":
        return className.floor();
      case "ceil":
        return className.ceil();
      case "truncate":
        return className.truncate();
      case "roundToDouble":
        return className.roundToDouble();
      case "floorToDouble":
        return className.floorToDouble();
      case "ceilToDouble":
        return className.ceilToDouble();
      case "truncateToDouble":
        return className.truncateToDouble();
      case "clamp":
        if (maps["0"] == null || maps["1"] == null) {
          return;
        }
        return className.clamp(
            getValue(maps["0"], datas, returnType, vars, props)!,
            getValue(maps["1"], datas, returnType, vars, props)!);
      case "toInt":
        return className.toInt();
      case "toDouble":
        return className.toDouble();
      case "toStringAsFixed":
        if (maps["0"] == null) {
          return;
        }
        return className.toStringAsFixed(
            getValue(maps["0"], datas, returnType, vars, props)!);
      case "toStringAsExponential":
        return className.toStringAsExponential(
            getValue(maps["0"], datas, returnType, vars, props));
      case "toStringAsPrecision":
        if (maps["0"] == null) {
          return;
        }
        return className.toStringAsPrecision(
            getValue(maps["0"], datas, returnType, vars, props)!);
      case "toString":
        return className.toString();
    }
  } else if (className is Iterable) {
    switch (value) {
      case "iterator":
        return className.iterator;

      case "cast":
        return className.cast();
      case "followedBy":
        if (maps["0"] == null) {
          return;
        }
        return className
            .followedBy(getValue(maps["0"], datas, returnType, vars, props)!);
      case "map":
        if (maps["0"] == null) {
          return;
        }
        return className
            .map(getValue(maps["0"], datas, returnType, vars, props)!);
      case "where":
        if (maps["0"] == null) {
          return;
        }
        return className
            .where(getValue(maps["0"], datas, returnType, vars, props)!);
      case "whereType":
        return className.whereType();
      case "expand":
        if (maps["0"] == null) {
          return;
        }
        return className
            .expand(getValue(maps["0"], datas, returnType, vars, props)!);
      case "contains":
        if (maps["0"] == null) {
          return;
        }
        return className
            .contains(getValue(maps["0"], datas, returnType, vars, props)!);
      case "forEach":
        if (maps["0"] == null) {
          return;
        }
        return className
            .forEach(getValue(maps["0"], datas, returnType, vars, props)!);
      case "reduce":
        if (maps["0"] == null) {
          return;
        }
        return className
            .reduce(getValue(maps["0"], datas, returnType, vars, props)!);
      case "fold":
        if (maps["0"] == null || maps["1"] == null) {
          return;
        }
        return className.fold(
            getValue(maps["0"], datas, returnType, vars, props)!,
            getValue(maps["1"], datas, returnType, vars, props)!);
      case "every":
        if (maps["0"] == null) {
          return;
        }
        return className
            .every(getValue(maps["0"], datas, returnType, vars, props)!);
      case "join":
        return className
            .join(getValue(maps["0"], datas, returnType, vars, props) ?? "");
      case "any":
        if (maps["0"] == null) {
          return;
        }
        return className
            .any(getValue(maps["0"], datas, returnType, vars, props)!);
      case "toList":
        return className.toList(
            growable:
                getValue(maps["growable"], datas, returnType, vars, props) ??
                    true);
      case "toSet":
        return className.toSet();
      case "length":
        return className.length;
      case "isEmpty":
        return className.isEmpty;
      case "isNotEmpty":
        return className.isNotEmpty;
      case "take":
        if (maps["0"] == null) {
          return;
        }
        return className
            .take(getValue(maps["0"], datas, returnType, vars, props)!);
      case "takeWhile":
        if (maps["0"] == null) {
          return;
        }
        return className
            .takeWhile(getValue(maps["0"], datas, returnType, vars, props)!);
      case "skip":
        if (maps["0"] == null) {
          return;
        }
        return className
            .skip(getValue(maps["0"], datas, returnType, vars, props)!);
      case "skipWhile":
        if (maps["0"] == null) {
          return;
        }
        return className
            .skipWhile(getValue(maps["0"], datas, returnType, vars, props)!);
      case "first":
        return className.first;
      case "last":
        return className.last;
      case "single":
        return className.single;
      case "firstWhere":
        if (maps["0"] == null) {
          return;
        }
        return className.firstWhere(
            getValue(maps["0"], datas, returnType, vars, props)!,
            orElse: getValue(maps["orElse"], datas, returnType, vars, props));
      case "lastWhere":
        if (maps["0"] == null) {
          return;
        }
        return className.lastWhere(
            getValue(maps["0"], datas, returnType, vars, props)!,
            orElse: getValue(maps["orElse"], datas, returnType, vars, props));
      case "singleWhere":
        if (maps["0"] == null) {
          return;
        }
        return className.singleWhere(
            getValue(maps["0"], datas, returnType, vars, props)!,
            orElse: getValue(maps["orElse"], datas, returnType, vars, props));
      case "elementAt":
        if (maps["0"] == null) {
          return;
        }
        return className
            .elementAt(getValue(maps["0"], datas, returnType, vars, props)!);
      case "toString":
        return className.toString();
    }
  }
}
