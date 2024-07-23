import 'dart:async';
import 'dart:io';
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';
import 'package:flutter/services.dart';

import '../../models/input.dart';
import '../data/typedefs.dart';
import '../widgets_data.dart';

dynamic getFunctionValue<T, R>(
    String string,
    String functionType,
    String bracedString,
    String bodyString,
    Map<String, List<InputData>> datas,
    List<Map<String, dynamic>> vars,
    List<Map<String, String>> props) {
  final parameters = customBracedSplitting(bracedString, ",");
  if (!bracedString.startsWith("(") && !bracedString.endsWith(")")) {
    bracedString = "($bracedString)";
  }
  final infos = getFunctionInfo(InputData(data: bracedString, filePath: ""));
  String type = "";
  print("functionType = $functionType, string = $string");

  if (!functionType.contains("Function")) {
    functionType = typeDefs[functionType] ?? "";
  }

  if (functionType.contains("Function")) {
    String returnType = customBracedSplitting(functionType).first;
    if (!returnType.contains("Function") && returnType.length > 1) {
      if (returnType.endsWith("?")) {
        returnType = returnType.substring(0, returnType.length - 1);

        // if (bodyString.contains("return") ||
        //     bodyString.trim().startsWith("=>")) {
        //   returnType = returnType.substring(0, returnType.length - 1);
        // }
      }
      if (returnType != "void" && returnType != "dynamic") {
        type = returnType;
      }
    }
  }
  print("type = $type, functionType = $functionType");

  if (type == "") {
    switch (parameters.length) {
      case 0:
        return () {
          final parametersValues = [];
          final map = getVarsFromParameters(parametersValues, infos);
          solveCallbackFunction(string, vars, props, datas, map);
        };
      case 1:
        return (item0) {
          final parametersValues = [item0];
          final map = getVarsFromParameters(parametersValues, infos);
          solveCallbackFunction(string, vars, props, datas, map);
        };
      case 2:
        return (item0, item1) {
          final parametersValues = [item0, item1];
          final map = getVarsFromParameters(parametersValues, infos);
          solveCallbackFunction(string, vars, props, datas, map);
        };
      case 3:
        return (item0, item1, item2) {
          final parametersValues = [item0, item1, item2];
          final map = getVarsFromParameters(parametersValues, infos);
          solveCallbackFunction(string, vars, props, datas, map);
        };
      case 4:
        return (item0, item1, item2, item3) {
          final parametersValues = [item0, item1, item2, item3];
          final map = getVarsFromParameters(parametersValues, infos);
          solveCallbackFunction(string, vars, props, datas, map);
        };
      case 5:
        return (item0, item1, item2, item3, item4) {
          final parametersValues = [item0, item1, item2, item3, item4];
          final map = getVarsFromParameters(parametersValues, infos);
          solveCallbackFunction(string, vars, props, datas, map);
        };
      case 6:
        return (item0, item1, item2, item3, item4, item5) {
          final parametersValues = [item0, item1, item2, item3, item4, item5];
          final map = getVarsFromParameters(parametersValues, infos);
          solveCallbackFunction(string, vars, props, datas, map);
        };
      case 7:
        return (item0, item1, item2, item3, item4, item5, item6) {
          final parametersValues = [
            item0,
            item1,
            item2,
            item3,
            item4,
            item5,
            item6
          ];
          final map = getVarsFromParameters(parametersValues, infos);
          solveCallbackFunction(string, vars, props, datas, map);
        };
      case 8:
        return (item0, item1, item2, item3, item4, item5, item6, item7) {
          final parametersValues = [
            item0,
            item1,
            item2,
            item3,
            item4,
            item5,
            item6,
            item7
          ];
          final map = getVarsFromParameters(parametersValues, infos);
          solveCallbackFunction(string, vars, props, datas, map);
        };
      case 9:
        return (item0, item1, item2, item3, item4, item5, item6, item7, item8) {
          final parametersValues = [
            item0,
            item1,
            item2,
            item3,
            item4,
            item5,
            item6,
            item7,
            item8
          ];
          final map = getVarsFromParameters(parametersValues, infos);
          solveCallbackFunction(string, vars, props, datas, map);
        };
    }
  } else if (type == "Widget") {
    switch (parameters.length) {
      case 0:
        return () {
          final parametersValues = [];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as Widget;
        };
      case 1:
        return (item0) {
          final parametersValues = [item0];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as Widget;
        };
      case 2:
        return (item0, item1) {
          final parametersValues = [item0, item1];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as Widget;
        };
      case 3:
        return (item0, item1, item2) {
          final parametersValues = [item0, item1, item2];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as Widget;
        };
      case 4:
        return (item0, item1, item2, item3) {
          final parametersValues = [item0, item1, item2, item3];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as Widget;
        };
      case 5:
        return (item0, item1, item2, item3, item4) {
          final parametersValues = [item0, item1, item2, item3, item4];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as Widget;
        };
      case 6:
        return (item0, item1, item2, item3, item4, item5) {
          final parametersValues = [item0, item1, item2, item3, item4, item5];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as Widget;
        };
      case 7:
        return (item0, item1, item2, item3, item4, item5, item6) {
          final parametersValues = [
            item0,
            item1,
            item2,
            item3,
            item4,
            item5,
            item6
          ];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as Widget;
        };
      case 8:
        return (item0, item1, item2, item3, item4, item5, item6, item7) {
          final parametersValues = [
            item0,
            item1,
            item2,
            item3,
            item4,
            item5,
            item6,
            item7
          ];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as Widget;
        };
      case 9:
        return (item0, item1, item2, item3, item4, item5, item6, item7, item8) {
          final parametersValues = [
            item0,
            item1,
            item2,
            item3,
            item4,
            item5,
            item6,
            item7,
            item8
          ];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as Widget;
        };
    }
  } else if (type == "Map<String, Object>") {
    switch (parameters.length) {
      case 0:
        return () {
          final parametersValues = [];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as Map<String, Object>;
        };
      case 1:
        return (item0) {
          final parametersValues = [item0];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as Map<String, Object>;
        };
      case 2:
        return (item0, item1) {
          final parametersValues = [item0, item1];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as Map<String, Object>;
        };
      case 3:
        return (item0, item1, item2) {
          final parametersValues = [item0, item1, item2];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as Map<String, Object>;
        };
      case 4:
        return (item0, item1, item2, item3) {
          final parametersValues = [item0, item1, item2, item3];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as Map<String, Object>;
        };
      case 5:
        return (item0, item1, item2, item3, item4) {
          final parametersValues = [item0, item1, item2, item3, item4];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as Map<String, Object>;
        };
      case 6:
        return (item0, item1, item2, item3, item4, item5) {
          final parametersValues = [item0, item1, item2, item3, item4, item5];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as Map<String, Object>;
        };
      case 7:
        return (item0, item1, item2, item3, item4, item5, item6) {
          final parametersValues = [
            item0,
            item1,
            item2,
            item3,
            item4,
            item5,
            item6
          ];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as Map<String, Object>;
        };
      case 8:
        return (item0, item1, item2, item3, item4, item5, item6, item7) {
          final parametersValues = [
            item0,
            item1,
            item2,
            item3,
            item4,
            item5,
            item6,
            item7
          ];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as Map<String, Object>;
        };
      case 9:
        return (item0, item1, item2, item3, item4, item5, item6, item7, item8) {
          final parametersValues = [
            item0,
            item1,
            item2,
            item3,
            item4,
            item5,
            item6,
            item7,
            item8
          ];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as Map<String, Object>;
        };
    }
  } else if (type == "bool") {
    switch (parameters.length) {
      case 0:
        return () {
          final parametersValues = [];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as bool;
        };
      case 1:
        return (item0) {
          final parametersValues = [item0];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as bool;
        };
      case 2:
        return (item0, item1) {
          final parametersValues = [item0, item1];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as bool;
        };
      case 3:
        return (item0, item1, item2) {
          final parametersValues = [item0, item1, item2];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as bool;
        };
      case 4:
        return (item0, item1, item2, item3) {
          final parametersValues = [item0, item1, item2, item3];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as bool;
        };
      case 5:
        return (item0, item1, item2, item3, item4) {
          final parametersValues = [item0, item1, item2, item3, item4];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as bool;
        };
      case 6:
        return (item0, item1, item2, item3, item4, item5) {
          final parametersValues = [item0, item1, item2, item3, item4, item5];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as bool;
        };
      case 7:
        return (item0, item1, item2, item3, item4, item5, item6) {
          final parametersValues = [
            item0,
            item1,
            item2,
            item3,
            item4,
            item5,
            item6
          ];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as bool;
        };
      case 8:
        return (item0, item1, item2, item3, item4, item5, item6, item7) {
          final parametersValues = [
            item0,
            item1,
            item2,
            item3,
            item4,
            item5,
            item6,
            item7
          ];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as bool;
        };
      case 9:
        return (item0, item1, item2, item3, item4, item5, item6, item7, item8) {
          final parametersValues = [
            item0,
            item1,
            item2,
            item3,
            item4,
            item5,
            item6,
            item7,
            item8
          ];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as bool;
        };
    }
  } else if (type == "Future<void>") {
    switch (parameters.length) {
      case 0:
        return () {
          final parametersValues = [];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as Future<void>;
        };
      case 1:
        return (item0) {
          final parametersValues = [item0];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as Future<void>;
        };
      case 2:
        return (item0, item1) {
          final parametersValues = [item0, item1];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as Future<void>;
        };
      case 3:
        return (item0, item1, item2) {
          final parametersValues = [item0, item1, item2];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as Future<void>;
        };
      case 4:
        return (item0, item1, item2, item3) {
          final parametersValues = [item0, item1, item2, item3];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as Future<void>;
        };
      case 5:
        return (item0, item1, item2, item3, item4) {
          final parametersValues = [item0, item1, item2, item3, item4];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as Future<void>;
        };
      case 6:
        return (item0, item1, item2, item3, item4, item5) {
          final parametersValues = [item0, item1, item2, item3, item4, item5];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as Future<void>;
        };
      case 7:
        return (item0, item1, item2, item3, item4, item5, item6) {
          final parametersValues = [
            item0,
            item1,
            item2,
            item3,
            item4,
            item5,
            item6
          ];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as Future<void>;
        };
      case 8:
        return (item0, item1, item2, item3, item4, item5, item6, item7) {
          final parametersValues = [
            item0,
            item1,
            item2,
            item3,
            item4,
            item5,
            item6,
            item7
          ];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as Future<void>;
        };
      case 9:
        return (item0, item1, item2, item3, item4, item5, item6, item7, item8) {
          final parametersValues = [
            item0,
            item1,
            item2,
            item3,
            item4,
            item5,
            item6,
            item7,
            item8
          ];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as Future<void>;
        };
    }
  } else if (type == "Future<T>") {
    switch (parameters.length) {
      case 0:
        return () {
          final parametersValues = [];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as Future<T>;
        };
      case 1:
        return (item0) {
          final parametersValues = [item0];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as Future<T>;
        };
      case 2:
        return (item0, item1) {
          final parametersValues = [item0, item1];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as Future<T>;
        };
      case 3:
        return (item0, item1, item2) {
          final parametersValues = [item0, item1, item2];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as Future<T>;
        };
      case 4:
        return (item0, item1, item2, item3) {
          final parametersValues = [item0, item1, item2, item3];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as Future<T>;
        };
      case 5:
        return (item0, item1, item2, item3, item4) {
          final parametersValues = [item0, item1, item2, item3, item4];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as Future<T>;
        };
      case 6:
        return (item0, item1, item2, item3, item4, item5) {
          final parametersValues = [item0, item1, item2, item3, item4, item5];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as Future<T>;
        };
      case 7:
        return (item0, item1, item2, item3, item4, item5, item6) {
          final parametersValues = [
            item0,
            item1,
            item2,
            item3,
            item4,
            item5,
            item6
          ];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as Future<T>;
        };
      case 8:
        return (item0, item1, item2, item3, item4, item5, item6, item7) {
          final parametersValues = [
            item0,
            item1,
            item2,
            item3,
            item4,
            item5,
            item6,
            item7
          ];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as Future<T>;
        };
      case 9:
        return (item0, item1, item2, item3, item4, item5, item6, item7, item8) {
          final parametersValues = [
            item0,
            item1,
            item2,
            item3,
            item4,
            item5,
            item6,
            item7,
            item8
          ];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as Future<T>;
        };
    }
  } else if (type == "String") {
    switch (parameters.length) {
      case 0:
        return () {
          final parametersValues = [];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as String;
        };
      case 1:
        return (item0) {
          final parametersValues = [item0];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as String;
        };
      case 2:
        return (item0, item1) {
          final parametersValues = [item0, item1];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as String;
        };
      case 3:
        return (item0, item1, item2) {
          final parametersValues = [item0, item1, item2];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as String;
        };
      case 4:
        return (item0, item1, item2, item3) {
          final parametersValues = [item0, item1, item2, item3];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as String;
        };
      case 5:
        return (item0, item1, item2, item3, item4) {
          final parametersValues = [item0, item1, item2, item3, item4];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as String;
        };
      case 6:
        return (item0, item1, item2, item3, item4, item5) {
          final parametersValues = [item0, item1, item2, item3, item4, item5];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as String;
        };
      case 7:
        return (item0, item1, item2, item3, item4, item5, item6) {
          final parametersValues = [
            item0,
            item1,
            item2,
            item3,
            item4,
            item5,
            item6
          ];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as String;
        };
      case 8:
        return (item0, item1, item2, item3, item4, item5, item6, item7) {
          final parametersValues = [
            item0,
            item1,
            item2,
            item3,
            item4,
            item5,
            item6,
            item7
          ];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as String;
        };
      case 9:
        return (item0, item1, item2, item3, item4, item5, item6, item7, item8) {
          final parametersValues = [
            item0,
            item1,
            item2,
            item3,
            item4,
            item5,
            item6,
            item7,
            item8
          ];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as String;
        };
    }
  } else if (type == "FutureOr<Iterable<T>>") {
    switch (parameters.length) {
      case 0:
        return () {
          final parametersValues = [];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as FutureOr<Iterable<T>>;
        };
      case 1:
        return (item0) {
          final parametersValues = [item0];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as FutureOr<Iterable<T>>;
        };
      case 2:
        return (item0, item1) {
          final parametersValues = [item0, item1];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as FutureOr<Iterable<T>>;
        };
      case 3:
        return (item0, item1, item2) {
          final parametersValues = [item0, item1, item2];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as FutureOr<Iterable<T>>;
        };
      case 4:
        return (item0, item1, item2, item3) {
          final parametersValues = [item0, item1, item2, item3];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as FutureOr<Iterable<T>>;
        };
      case 5:
        return (item0, item1, item2, item3, item4) {
          final parametersValues = [item0, item1, item2, item3, item4];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as FutureOr<Iterable<T>>;
        };
      case 6:
        return (item0, item1, item2, item3, item4, item5) {
          final parametersValues = [item0, item1, item2, item3, item4, item5];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as FutureOr<Iterable<T>>;
        };
      case 7:
        return (item0, item1, item2, item3, item4, item5, item6) {
          final parametersValues = [
            item0,
            item1,
            item2,
            item3,
            item4,
            item5,
            item6
          ];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as FutureOr<Iterable<T>>;
        };
      case 8:
        return (item0, item1, item2, item3, item4, item5, item6, item7) {
          final parametersValues = [
            item0,
            item1,
            item2,
            item3,
            item4,
            item5,
            item6,
            item7
          ];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as FutureOr<Iterable<T>>;
        };
      case 9:
        return (item0, item1, item2, item3, item4, item5, item6, item7, item8) {
          final parametersValues = [
            item0,
            item1,
            item2,
            item3,
            item4,
            item5,
            item6,
            item7,
            item8
          ];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as FutureOr<Iterable<T>>;
        };
    }
  } else if (type == "BoxConstraints") {
    switch (parameters.length) {
      case 0:
        return () {
          final parametersValues = [];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as BoxConstraints;
        };
      case 1:
        return (item0) {
          final parametersValues = [item0];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as BoxConstraints;
        };
      case 2:
        return (item0, item1) {
          final parametersValues = [item0, item1];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as BoxConstraints;
        };
      case 3:
        return (item0, item1, item2) {
          final parametersValues = [item0, item1, item2];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as BoxConstraints;
        };
      case 4:
        return (item0, item1, item2, item3) {
          final parametersValues = [item0, item1, item2, item3];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as BoxConstraints;
        };
      case 5:
        return (item0, item1, item2, item3, item4) {
          final parametersValues = [item0, item1, item2, item3, item4];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as BoxConstraints;
        };
      case 6:
        return (item0, item1, item2, item3, item4, item5) {
          final parametersValues = [item0, item1, item2, item3, item4, item5];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as BoxConstraints;
        };
      case 7:
        return (item0, item1, item2, item3, item4, item5, item6) {
          final parametersValues = [
            item0,
            item1,
            item2,
            item3,
            item4,
            item5,
            item6
          ];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as BoxConstraints;
        };
      case 8:
        return (item0, item1, item2, item3, item4, item5, item6, item7) {
          final parametersValues = [
            item0,
            item1,
            item2,
            item3,
            item4,
            item5,
            item6,
            item7
          ];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as BoxConstraints;
        };
      case 9:
        return (item0, item1, item2, item3, item4, item5, item6, item7, item8) {
          final parametersValues = [
            item0,
            item1,
            item2,
            item3,
            item4,
            item5,
            item6,
            item7,
            item8
          ];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as BoxConstraints;
        };
    }
  } else if (type == "int") {
    switch (parameters.length) {
      case 0:
        return () {
          final parametersValues = [];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as int;
        };
      case 1:
        return (item0) {
          final parametersValues = [item0];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as int;
        };
      case 2:
        return (item0, item1) {
          final parametersValues = [item0, item1];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as int;
        };
      case 3:
        return (item0, item1, item2) {
          final parametersValues = [item0, item1, item2];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as int;
        };
      case 4:
        return (item0, item1, item2, item3) {
          final parametersValues = [item0, item1, item2, item3];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as int;
        };
      case 5:
        return (item0, item1, item2, item3, item4) {
          final parametersValues = [item0, item1, item2, item3, item4];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as int;
        };
      case 6:
        return (item0, item1, item2, item3, item4, item5) {
          final parametersValues = [item0, item1, item2, item3, item4, item5];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as int;
        };
      case 7:
        return (item0, item1, item2, item3, item4, item5, item6) {
          final parametersValues = [
            item0,
            item1,
            item2,
            item3,
            item4,
            item5,
            item6
          ];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as int;
        };
      case 8:
        return (item0, item1, item2, item3, item4, item5, item6, item7) {
          final parametersValues = [
            item0,
            item1,
            item2,
            item3,
            item4,
            item5,
            item6,
            item7
          ];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as int;
        };
      case 9:
        return (item0, item1, item2, item3, item4, item5, item6, item7, item8) {
          final parametersValues = [
            item0,
            item1,
            item2,
            item3,
            item4,
            item5,
            item6,
            item7,
            item8
          ];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as int;
        };
    }
  } else if (type == "Size") {
    switch (parameters.length) {
      case 0:
        return () {
          final parametersValues = [];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as Size;
        };
      case 1:
        return (item0) {
          final parametersValues = [item0];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as Size;
        };
      case 2:
        return (item0, item1) {
          final parametersValues = [item0, item1];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as Size;
        };
      case 3:
        return (item0, item1, item2) {
          final parametersValues = [item0, item1, item2];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as Size;
        };
      case 4:
        return (item0, item1, item2, item3) {
          final parametersValues = [item0, item1, item2, item3];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as Size;
        };
      case 5:
        return (item0, item1, item2, item3, item4) {
          final parametersValues = [item0, item1, item2, item3, item4];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as Size;
        };
      case 6:
        return (item0, item1, item2, item3, item4, item5) {
          final parametersValues = [item0, item1, item2, item3, item4, item5];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as Size;
        };
      case 7:
        return (item0, item1, item2, item3, item4, item5, item6) {
          final parametersValues = [
            item0,
            item1,
            item2,
            item3,
            item4,
            item5,
            item6
          ];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as Size;
        };
      case 8:
        return (item0, item1, item2, item3, item4, item5, item6, item7) {
          final parametersValues = [
            item0,
            item1,
            item2,
            item3,
            item4,
            item5,
            item6,
            item7
          ];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as Size;
        };
      case 9:
        return (item0, item1, item2, item3, item4, item5, item6, item7, item8) {
          final parametersValues = [
            item0,
            item1,
            item2,
            item3,
            item4,
            item5,
            item6,
            item7,
            item8
          ];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as Size;
        };
    }
  } else if (type == "ChildSemanticsConfigurationsResult") {
    switch (parameters.length) {
      case 0:
        return () {
          final parametersValues = [];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as ChildSemanticsConfigurationsResult;
        };
      case 1:
        return (item0) {
          final parametersValues = [item0];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as ChildSemanticsConfigurationsResult;
        };
      case 2:
        return (item0, item1) {
          final parametersValues = [item0, item1];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as ChildSemanticsConfigurationsResult;
        };
      case 3:
        return (item0, item1, item2) {
          final parametersValues = [item0, item1, item2];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as ChildSemanticsConfigurationsResult;
        };
      case 4:
        return (item0, item1, item2, item3) {
          final parametersValues = [item0, item1, item2, item3];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as ChildSemanticsConfigurationsResult;
        };
      case 5:
        return (item0, item1, item2, item3, item4) {
          final parametersValues = [item0, item1, item2, item3, item4];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as ChildSemanticsConfigurationsResult;
        };
      case 6:
        return (item0, item1, item2, item3, item4, item5) {
          final parametersValues = [item0, item1, item2, item3, item4, item5];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as ChildSemanticsConfigurationsResult;
        };
      case 7:
        return (item0, item1, item2, item3, item4, item5, item6) {
          final parametersValues = [
            item0,
            item1,
            item2,
            item3,
            item4,
            item5,
            item6
          ];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as ChildSemanticsConfigurationsResult;
        };
      case 8:
        return (item0, item1, item2, item3, item4, item5, item6, item7) {
          final parametersValues = [
            item0,
            item1,
            item2,
            item3,
            item4,
            item5,
            item6,
            item7
          ];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as ChildSemanticsConfigurationsResult;
        };
      case 9:
        return (item0, item1, item2, item3, item4, item5, item6, item7, item8) {
          final parametersValues = [
            item0,
            item1,
            item2,
            item3,
            item4,
            item5,
            item6,
            item7,
            item8
          ];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as ChildSemanticsConfigurationsResult;
        };
    }
  } else if (type == "FutureOr<R>") {
    switch (parameters.length) {
      case 0:
        return () {
          final parametersValues = [];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as FutureOr<R>;
        };
      case 1:
        return (item0) {
          final parametersValues = [item0];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as FutureOr<R>;
        };
      case 2:
        return (item0, item1) {
          final parametersValues = [item0, item1];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as FutureOr<R>;
        };
      case 3:
        return (item0, item1, item2) {
          final parametersValues = [item0, item1, item2];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as FutureOr<R>;
        };
      case 4:
        return (item0, item1, item2, item3) {
          final parametersValues = [item0, item1, item2, item3];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as FutureOr<R>;
        };
      case 5:
        return (item0, item1, item2, item3, item4) {
          final parametersValues = [item0, item1, item2, item3, item4];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as FutureOr<R>;
        };
      case 6:
        return (item0, item1, item2, item3, item4, item5) {
          final parametersValues = [item0, item1, item2, item3, item4, item5];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as FutureOr<R>;
        };
      case 7:
        return (item0, item1, item2, item3, item4, item5, item6) {
          final parametersValues = [
            item0,
            item1,
            item2,
            item3,
            item4,
            item5,
            item6
          ];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as FutureOr<R>;
        };
      case 8:
        return (item0, item1, item2, item3, item4, item5, item6, item7) {
          final parametersValues = [
            item0,
            item1,
            item2,
            item3,
            item4,
            item5,
            item6,
            item7
          ];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as FutureOr<R>;
        };
      case 9:
        return (item0, item1, item2, item3, item4, item5, item6, item7, item8) {
          final parametersValues = [
            item0,
            item1,
            item2,
            item3,
            item4,
            item5,
            item6,
            item7,
            item8
          ];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as FutureOr<R>;
        };
    }
  } else if (type == "Future<R>") {
    switch (parameters.length) {
      case 0:
        return () {
          final parametersValues = [];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as Future<R>;
        };
      case 1:
        return (item0) {
          final parametersValues = [item0];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as Future<R>;
        };
      case 2:
        return (item0, item1) {
          final parametersValues = [item0, item1];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as Future<R>;
        };
      case 3:
        return (item0, item1, item2) {
          final parametersValues = [item0, item1, item2];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as Future<R>;
        };
      case 4:
        return (item0, item1, item2, item3) {
          final parametersValues = [item0, item1, item2, item3];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as Future<R>;
        };
      case 5:
        return (item0, item1, item2, item3, item4) {
          final parametersValues = [item0, item1, item2, item3, item4];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as Future<R>;
        };
      case 6:
        return (item0, item1, item2, item3, item4, item5) {
          final parametersValues = [item0, item1, item2, item3, item4, item5];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as Future<R>;
        };
      case 7:
        return (item0, item1, item2, item3, item4, item5, item6) {
          final parametersValues = [
            item0,
            item1,
            item2,
            item3,
            item4,
            item5,
            item6
          ];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as Future<R>;
        };
      case 8:
        return (item0, item1, item2, item3, item4, item5, item6, item7) {
          final parametersValues = [
            item0,
            item1,
            item2,
            item3,
            item4,
            item5,
            item6,
            item7
          ];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as Future<R>;
        };
      case 9:
        return (item0, item1, item2, item3, item4, item5, item6, item7, item8) {
          final parametersValues = [
            item0,
            item1,
            item2,
            item3,
            item4,
            item5,
            item6,
            item7,
            item8
          ];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as Future<R>;
        };
    }
  } else if (type == "T") {
    switch (parameters.length) {
      case 0:
        return () {
          final parametersValues = [];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as T;
        };
      case 1:
        return (item0) {
          final parametersValues = [item0];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as T;
        };
      case 2:
        return (item0, item1) {
          final parametersValues = [item0, item1];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as T;
        };
      case 3:
        return (item0, item1, item2) {
          final parametersValues = [item0, item1, item2];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as T;
        };
      case 4:
        return (item0, item1, item2, item3) {
          final parametersValues = [item0, item1, item2, item3];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as T;
        };
      case 5:
        return (item0, item1, item2, item3, item4) {
          final parametersValues = [item0, item1, item2, item3, item4];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as T;
        };
      case 6:
        return (item0, item1, item2, item3, item4, item5) {
          final parametersValues = [item0, item1, item2, item3, item4, item5];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as T;
        };
      case 7:
        return (item0, item1, item2, item3, item4, item5, item6) {
          final parametersValues = [
            item0,
            item1,
            item2,
            item3,
            item4,
            item5,
            item6
          ];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as T;
        };
      case 8:
        return (item0, item1, item2, item3, item4, item5, item6, item7) {
          final parametersValues = [
            item0,
            item1,
            item2,
            item3,
            item4,
            item5,
            item6,
            item7
          ];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as T;
        };
      case 9:
        return (item0, item1, item2, item3, item4, item5, item6, item7, item8) {
          final parametersValues = [
            item0,
            item1,
            item2,
            item3,
            item4,
            item5,
            item6,
            item7,
            item8
          ];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as T;
        };
    }
  } else if (type == "Future<bool?>") {
    switch (parameters.length) {
      case 0:
        return () {
          final parametersValues = [];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as Future<bool?>;
        };
      case 1:
        return (item0) {
          final parametersValues = [item0];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as Future<bool?>;
        };
      case 2:
        return (item0, item1) {
          final parametersValues = [item0, item1];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as Future<bool?>;
        };
      case 3:
        return (item0, item1, item2) {
          final parametersValues = [item0, item1, item2];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as Future<bool?>;
        };
      case 4:
        return (item0, item1, item2, item3) {
          final parametersValues = [item0, item1, item2, item3];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as Future<bool?>;
        };
      case 5:
        return (item0, item1, item2, item3, item4) {
          final parametersValues = [item0, item1, item2, item3, item4];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as Future<bool?>;
        };
      case 6:
        return (item0, item1, item2, item3, item4, item5) {
          final parametersValues = [item0, item1, item2, item3, item4, item5];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as Future<bool?>;
        };
      case 7:
        return (item0, item1, item2, item3, item4, item5, item6) {
          final parametersValues = [
            item0,
            item1,
            item2,
            item3,
            item4,
            item5,
            item6
          ];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as Future<bool?>;
        };
      case 8:
        return (item0, item1, item2, item3, item4, item5, item6, item7) {
          final parametersValues = [
            item0,
            item1,
            item2,
            item3,
            item4,
            item5,
            item6,
            item7
          ];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as Future<bool?>;
        };
      case 9:
        return (item0, item1, item2, item3, item4, item5, item6, item7, item8) {
          final parametersValues = [
            item0,
            item1,
            item2,
            item3,
            item4,
            item5,
            item6,
            item7,
            item8
          ];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as Future<bool?>;
        };
    }
  } else if (type == "PlatformViewController") {
    switch (parameters.length) {
      case 0:
        return () {
          final parametersValues = [];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as PlatformViewController;
        };
      case 1:
        return (item0) {
          final parametersValues = [item0];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as PlatformViewController;
        };
      case 2:
        return (item0, item1) {
          final parametersValues = [item0, item1];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as PlatformViewController;
        };
      case 3:
        return (item0, item1, item2) {
          final parametersValues = [item0, item1, item2];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as PlatformViewController;
        };
      case 4:
        return (item0, item1, item2, item3) {
          final parametersValues = [item0, item1, item2, item3];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as PlatformViewController;
        };
      case 5:
        return (item0, item1, item2, item3, item4) {
          final parametersValues = [item0, item1, item2, item3, item4];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as PlatformViewController;
        };
      case 6:
        return (item0, item1, item2, item3, item4, item5) {
          final parametersValues = [item0, item1, item2, item3, item4, item5];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as PlatformViewController;
        };
      case 7:
        return (item0, item1, item2, item3, item4, item5, item6) {
          final parametersValues = [
            item0,
            item1,
            item2,
            item3,
            item4,
            item5,
            item6
          ];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as PlatformViewController;
        };
      case 8:
        return (item0, item1, item2, item3, item4, item5, item6, item7) {
          final parametersValues = [
            item0,
            item1,
            item2,
            item3,
            item4,
            item5,
            item6,
            item7
          ];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as PlatformViewController;
        };
      case 9:
        return (item0, item1, item2, item3, item4, item5, item6, item7, item8) {
          final parametersValues = [
            item0,
            item1,
            item2,
            item3,
            item4,
            item5,
            item6,
            item7,
            item8
          ];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as PlatformViewController;
        };
    }
  } else if (type == "Tween<Rect?>") {
    switch (parameters.length) {
      case 0:
        return () {
          final parametersValues = [];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as Tween<Rect?>;
        };
      case 1:
        return (item0) {
          final parametersValues = [item0];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as Tween<Rect?>;
        };
      case 2:
        return (item0, item1) {
          final parametersValues = [item0, item1];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as Tween<Rect?>;
        };
      case 3:
        return (item0, item1, item2) {
          final parametersValues = [item0, item1, item2];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as Tween<Rect?>;
        };
      case 4:
        return (item0, item1, item2, item3) {
          final parametersValues = [item0, item1, item2, item3];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as Tween<Rect?>;
        };
      case 5:
        return (item0, item1, item2, item3, item4) {
          final parametersValues = [item0, item1, item2, item3, item4];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as Tween<Rect?>;
        };
      case 6:
        return (item0, item1, item2, item3, item4, item5) {
          final parametersValues = [item0, item1, item2, item3, item4, item5];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as Tween<Rect?>;
        };
      case 7:
        return (item0, item1, item2, item3, item4, item5, item6) {
          final parametersValues = [
            item0,
            item1,
            item2,
            item3,
            item4,
            item5,
            item6
          ];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as Tween<Rect?>;
        };
      case 8:
        return (item0, item1, item2, item3, item4, item5, item6, item7) {
          final parametersValues = [
            item0,
            item1,
            item2,
            item3,
            item4,
            item5,
            item6,
            item7
          ];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as Tween<Rect?>;
        };
      case 9:
        return (item0, item1, item2, item3, item4, item5, item6, item7, item8) {
          final parametersValues = [
            item0,
            item1,
            item2,
            item3,
            item4,
            item5,
            item6,
            item7,
            item8
          ];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as Tween<Rect?>;
        };
    }
  } else if (type == "Future<Codec>") {
    switch (parameters.length) {
      case 0:
        return () {
          final parametersValues = [];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as Future<Codec>;
        };
      case 1:
        return (item0) {
          final parametersValues = [item0];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as Future<Codec>;
        };
      case 2:
        return (item0, item1) {
          final parametersValues = [item0, item1];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as Future<Codec>;
        };
      case 3:
        return (item0, item1, item2) {
          final parametersValues = [item0, item1, item2];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as Future<Codec>;
        };
      case 4:
        return (item0, item1, item2, item3) {
          final parametersValues = [item0, item1, item2, item3];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as Future<Codec>;
        };
      case 5:
        return (item0, item1, item2, item3, item4) {
          final parametersValues = [item0, item1, item2, item3, item4];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as Future<Codec>;
        };
      case 6:
        return (item0, item1, item2, item3, item4, item5) {
          final parametersValues = [item0, item1, item2, item3, item4, item5];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as Future<Codec>;
        };
      case 7:
        return (item0, item1, item2, item3, item4, item5, item6) {
          final parametersValues = [
            item0,
            item1,
            item2,
            item3,
            item4,
            item5,
            item6
          ];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as Future<Codec>;
        };
      case 8:
        return (item0, item1, item2, item3, item4, item5, item6, item7) {
          final parametersValues = [
            item0,
            item1,
            item2,
            item3,
            item4,
            item5,
            item6,
            item7
          ];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as Future<Codec>;
        };
      case 9:
        return (item0, item1, item2, item3, item4, item5, item6, item7, item8) {
          final parametersValues = [
            item0,
            item1,
            item2,
            item3,
            item4,
            item5,
            item6,
            item7,
            item8
          ];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as Future<Codec>;
        };
    }
  } else if (type == "Iterable<DiagnosticsNode>") {
    switch (parameters.length) {
      case 0:
        return () {
          final parametersValues = [];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as Iterable<DiagnosticsNode>;
        };
      case 1:
        return (item0) {
          final parametersValues = [item0];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as Iterable<DiagnosticsNode>;
        };
      case 2:
        return (item0, item1) {
          final parametersValues = [item0, item1];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as Iterable<DiagnosticsNode>;
        };
      case 3:
        return (item0, item1, item2) {
          final parametersValues = [item0, item1, item2];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as Iterable<DiagnosticsNode>;
        };
      case 4:
        return (item0, item1, item2, item3) {
          final parametersValues = [item0, item1, item2, item3];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as Iterable<DiagnosticsNode>;
        };
      case 5:
        return (item0, item1, item2, item3, item4) {
          final parametersValues = [item0, item1, item2, item3, item4];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as Iterable<DiagnosticsNode>;
        };
      case 6:
        return (item0, item1, item2, item3, item4, item5) {
          final parametersValues = [item0, item1, item2, item3, item4, item5];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as Iterable<DiagnosticsNode>;
        };
      case 7:
        return (item0, item1, item2, item3, item4, item5, item6) {
          final parametersValues = [
            item0,
            item1,
            item2,
            item3,
            item4,
            item5,
            item6
          ];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as Iterable<DiagnosticsNode>;
        };
      case 8:
        return (item0, item1, item2, item3, item4, item5, item6, item7) {
          final parametersValues = [
            item0,
            item1,
            item2,
            item3,
            item4,
            item5,
            item6,
            item7
          ];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as Iterable<DiagnosticsNode>;
        };
      case 9:
        return (item0, item1, item2, item3, item4, item5, item6, item7, item8) {
          final parametersValues = [
            item0,
            item1,
            item2,
            item3,
            item4,
            item5,
            item6,
            item7,
            item8
          ];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as Iterable<DiagnosticsNode>;
        };
    }
  } else if (type == "Offset") {
    switch (parameters.length) {
      case 0:
        return () {
          final parametersValues = [];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as Offset;
        };
      case 1:
        return (item0) {
          final parametersValues = [item0];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as Offset;
        };
      case 2:
        return (item0, item1) {
          final parametersValues = [item0, item1];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as Offset;
        };
      case 3:
        return (item0, item1, item2) {
          final parametersValues = [item0, item1, item2];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as Offset;
        };
      case 4:
        return (item0, item1, item2, item3) {
          final parametersValues = [item0, item1, item2, item3];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as Offset;
        };
      case 5:
        return (item0, item1, item2, item3, item4) {
          final parametersValues = [item0, item1, item2, item3, item4];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as Offset;
        };
      case 6:
        return (item0, item1, item2, item3, item4, item5) {
          final parametersValues = [item0, item1, item2, item3, item4, item5];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as Offset;
        };
      case 7:
        return (item0, item1, item2, item3, item4, item5, item6) {
          final parametersValues = [
            item0,
            item1,
            item2,
            item3,
            item4,
            item5,
            item6
          ];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as Offset;
        };
      case 8:
        return (item0, item1, item2, item3, item4, item5, item6, item7) {
          final parametersValues = [
            item0,
            item1,
            item2,
            item3,
            item4,
            item5,
            item6,
            item7
          ];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as Offset;
        };
      case 9:
        return (item0, item1, item2, item3, item4, item5, item6, item7, item8) {
          final parametersValues = [
            item0,
            item1,
            item2,
            item3,
            item4,
            item5,
            item6,
            item7,
            item8
          ];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as Offset;
        };
    }
  } else if (type == "List<Widget>") {
    switch (parameters.length) {
      case 0:
        return () {
          final parametersValues = [];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as List<Widget>;
        };
      case 1:
        return (item0) {
          final parametersValues = [item0];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as List<Widget>;
        };
      case 2:
        return (item0, item1) {
          final parametersValues = [item0, item1];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as List<Widget>;
        };
      case 3:
        return (item0, item1, item2) {
          final parametersValues = [item0, item1, item2];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as List<Widget>;
        };
      case 4:
        return (item0, item1, item2, item3) {
          final parametersValues = [item0, item1, item2, item3];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as List<Widget>;
        };
      case 5:
        return (item0, item1, item2, item3, item4) {
          final parametersValues = [item0, item1, item2, item3, item4];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as List<Widget>;
        };
      case 6:
        return (item0, item1, item2, item3, item4, item5) {
          final parametersValues = [item0, item1, item2, item3, item4, item5];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as List<Widget>;
        };
      case 7:
        return (item0, item1, item2, item3, item4, item5, item6) {
          final parametersValues = [
            item0,
            item1,
            item2,
            item3,
            item4,
            item5,
            item6
          ];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as List<Widget>;
        };
      case 8:
        return (item0, item1, item2, item3, item4, item5, item6, item7) {
          final parametersValues = [
            item0,
            item1,
            item2,
            item3,
            item4,
            item5,
            item6,
            item7
          ];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as List<Widget>;
        };
      case 9:
        return (item0, item1, item2, item3, item4, item5, item6, item7, item8) {
          final parametersValues = [
            item0,
            item1,
            item2,
            item3,
            item4,
            item5,
            item6,
            item7,
            item8
          ];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as List<Widget>;
        };
    }
  } else if (type == "KeyEventResult") {
    switch (parameters.length) {
      case 0:
        return () {
          final parametersValues = [];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as KeyEventResult;
        };
      case 1:
        return (item0) {
          final parametersValues = [item0];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as KeyEventResult;
        };
      case 2:
        return (item0, item1) {
          final parametersValues = [item0, item1];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as KeyEventResult;
        };
      case 3:
        return (item0, item1, item2) {
          final parametersValues = [item0, item1, item2];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as KeyEventResult;
        };
      case 4:
        return (item0, item1, item2, item3) {
          final parametersValues = [item0, item1, item2, item3];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as KeyEventResult;
        };
      case 5:
        return (item0, item1, item2, item3, item4) {
          final parametersValues = [item0, item1, item2, item3, item4];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as KeyEventResult;
        };
      case 6:
        return (item0, item1, item2, item3, item4, item5) {
          final parametersValues = [item0, item1, item2, item3, item4, item5];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as KeyEventResult;
        };
      case 7:
        return (item0, item1, item2, item3, item4, item5, item6) {
          final parametersValues = [
            item0,
            item1,
            item2,
            item3,
            item4,
            item5,
            item6
          ];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as KeyEventResult;
        };
      case 8:
        return (item0, item1, item2, item3, item4, item5, item6, item7) {
          final parametersValues = [
            item0,
            item1,
            item2,
            item3,
            item4,
            item5,
            item6,
            item7
          ];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as KeyEventResult;
        };
      case 9:
        return (item0, item1, item2, item3, item4, item5, item6, item7, item8) {
          final parametersValues = [
            item0,
            item1,
            item2,
            item3,
            item4,
            item5,
            item6,
            item7,
            item8
          ];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as KeyEventResult;
        };
    }
  } else if (type == "double") {
    switch (parameters.length) {
      case 0:
        return () {
          final parametersValues = [];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as double;
        };
      case 1:
        return (item0) {
          final parametersValues = [item0];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as double;
        };
      case 2:
        return (item0, item1) {
          final parametersValues = [item0, item1];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as double;
        };
      case 3:
        return (item0, item1, item2) {
          final parametersValues = [item0, item1, item2];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as double;
        };
      case 4:
        return (item0, item1, item2, item3) {
          final parametersValues = [item0, item1, item2, item3];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as double;
        };
      case 5:
        return (item0, item1, item2, item3, item4) {
          final parametersValues = [item0, item1, item2, item3, item4];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as double;
        };
      case 6:
        return (item0, item1, item2, item3, item4, item5) {
          final parametersValues = [item0, item1, item2, item3, item4, item5];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as double;
        };
      case 7:
        return (item0, item1, item2, item3, item4, item5, item6) {
          final parametersValues = [
            item0,
            item1,
            item2,
            item3,
            item4,
            item5,
            item6
          ];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as double;
        };
      case 8:
        return (item0, item1, item2, item3, item4, item5, item6, item7) {
          final parametersValues = [
            item0,
            item1,
            item2,
            item3,
            item4,
            item5,
            item6,
            item7
          ];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as double;
        };
      case 9:
        return (item0, item1, item2, item3, item4, item5, item6, item7, item8) {
          final parametersValues = [
            item0,
            item1,
            item2,
            item3,
            item4,
            item5,
            item6,
            item7,
            item8
          ];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as double;
        };
    }
  } else if (type == "Drag") {
    switch (parameters.length) {
      case 0:
        return () {
          final parametersValues = [];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as Drag;
        };
      case 1:
        return (item0) {
          final parametersValues = [item0];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as Drag;
        };
      case 2:
        return (item0, item1) {
          final parametersValues = [item0, item1];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as Drag;
        };
      case 3:
        return (item0, item1, item2) {
          final parametersValues = [item0, item1, item2];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as Drag;
        };
      case 4:
        return (item0, item1, item2, item3) {
          final parametersValues = [item0, item1, item2, item3];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as Drag;
        };
      case 5:
        return (item0, item1, item2, item3, item4) {
          final parametersValues = [item0, item1, item2, item3, item4];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as Drag;
        };
      case 6:
        return (item0, item1, item2, item3, item4, item5) {
          final parametersValues = [item0, item1, item2, item3, item4, item5];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as Drag;
        };
      case 7:
        return (item0, item1, item2, item3, item4, item5, item6) {
          final parametersValues = [
            item0,
            item1,
            item2,
            item3,
            item4,
            item5,
            item6
          ];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as Drag;
        };
      case 8:
        return (item0, item1, item2, item3, item4, item5, item6, item7) {
          final parametersValues = [
            item0,
            item1,
            item2,
            item3,
            item4,
            item5,
            item6,
            item7
          ];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as Drag;
        };
      case 9:
        return (item0, item1, item2, item3, item4, item5, item6, item7, item8) {
          final parametersValues = [
            item0,
            item1,
            item2,
            item3,
            item4,
            item5,
            item6,
            item7,
            item8
          ];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as Drag;
        };
    }
  } else if (type == "VelocityTracker") {
    switch (parameters.length) {
      case 0:
        return () {
          final parametersValues = [];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as VelocityTracker;
        };
      case 1:
        return (item0) {
          final parametersValues = [item0];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as VelocityTracker;
        };
      case 2:
        return (item0, item1) {
          final parametersValues = [item0, item1];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as VelocityTracker;
        };
      case 3:
        return (item0, item1, item2) {
          final parametersValues = [item0, item1, item2];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as VelocityTracker;
        };
      case 4:
        return (item0, item1, item2, item3) {
          final parametersValues = [item0, item1, item2, item3];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as VelocityTracker;
        };
      case 5:
        return (item0, item1, item2, item3, item4) {
          final parametersValues = [item0, item1, item2, item3, item4];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as VelocityTracker;
        };
      case 6:
        return (item0, item1, item2, item3, item4, item5) {
          final parametersValues = [item0, item1, item2, item3, item4, item5];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as VelocityTracker;
        };
      case 7:
        return (item0, item1, item2, item3, item4, item5, item6) {
          final parametersValues = [
            item0,
            item1,
            item2,
            item3,
            item4,
            item5,
            item6
          ];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as VelocityTracker;
        };
      case 8:
        return (item0, item1, item2, item3, item4, item5, item6, item7) {
          final parametersValues = [
            item0,
            item1,
            item2,
            item3,
            item4,
            item5,
            item6,
            item7
          ];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as VelocityTracker;
        };
      case 9:
        return (item0, item1, item2, item3, item4, item5, item6, item7, item8) {
          final parametersValues = [
            item0,
            item1,
            item2,
            item3,
            item4,
            item5,
            item6,
            item7,
            item8
          ];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as VelocityTracker;
        };
    }
  } else if (type == "HttpClient") {
    switch (parameters.length) {
      case 0:
        return () {
          final parametersValues = [];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as HttpClient;
        };
      case 1:
        return (item0) {
          final parametersValues = [item0];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as HttpClient;
        };
      case 2:
        return (item0, item1) {
          final parametersValues = [item0, item1];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as HttpClient;
        };
      case 3:
        return (item0, item1, item2) {
          final parametersValues = [item0, item1, item2];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as HttpClient;
        };
      case 4:
        return (item0, item1, item2, item3) {
          final parametersValues = [item0, item1, item2, item3];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as HttpClient;
        };
      case 5:
        return (item0, item1, item2, item3, item4) {
          final parametersValues = [item0, item1, item2, item3, item4];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as HttpClient;
        };
      case 6:
        return (item0, item1, item2, item3, item4, item5) {
          final parametersValues = [item0, item1, item2, item3, item4, item5];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as HttpClient;
        };
      case 7:
        return (item0, item1, item2, item3, item4, item5, item6) {
          final parametersValues = [
            item0,
            item1,
            item2,
            item3,
            item4,
            item5,
            item6
          ];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as HttpClient;
        };
      case 8:
        return (item0, item1, item2, item3, item4, item5, item6, item7) {
          final parametersValues = [
            item0,
            item1,
            item2,
            item3,
            item4,
            item5,
            item6,
            item7
          ];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as HttpClient;
        };
      case 9:
        return (item0, item1, item2, item3, item4, item5, item6, item7, item8) {
          final parametersValues = [
            item0,
            item1,
            item2,
            item3,
            item4,
            item5,
            item6,
            item7,
            item8
          ];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as HttpClient;
        };
    }
  } else if (type == "List<Route<dynamic>>") {
    switch (parameters.length) {
      case 0:
        return () {
          final parametersValues = [];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as List<Route<dynamic>>;
        };
      case 1:
        return (item0) {
          final parametersValues = [item0];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as List<Route<dynamic>>;
        };
      case 2:
        return (item0, item1) {
          final parametersValues = [item0, item1];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as List<Route<dynamic>>;
        };
      case 3:
        return (item0, item1, item2) {
          final parametersValues = [item0, item1, item2];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as List<Route<dynamic>>;
        };
      case 4:
        return (item0, item1, item2, item3) {
          final parametersValues = [item0, item1, item2, item3];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as List<Route<dynamic>>;
        };
      case 5:
        return (item0, item1, item2, item3, item4) {
          final parametersValues = [item0, item1, item2, item3, item4];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as List<Route<dynamic>>;
        };
      case 6:
        return (item0, item1, item2, item3, item4, item5) {
          final parametersValues = [item0, item1, item2, item3, item4, item5];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as List<Route<dynamic>>;
        };
      case 7:
        return (item0, item1, item2, item3, item4, item5, item6) {
          final parametersValues = [
            item0,
            item1,
            item2,
            item3,
            item4,
            item5,
            item6
          ];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as List<Route<dynamic>>;
        };
      case 8:
        return (item0, item1, item2, item3, item4, item5, item6, item7) {
          final parametersValues = [
            item0,
            item1,
            item2,
            item3,
            item4,
            item5,
            item6,
            item7
          ];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as List<Route<dynamic>>;
        };
      case 9:
        return (item0, item1, item2, item3, item4, item5, item6, item7, item8) {
          final parametersValues = [
            item0,
            item1,
            item2,
            item3,
            item4,
            item5,
            item6,
            item7,
            item8
          ];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as List<Route<dynamic>>;
        };
    }
  } else if (type == "Iterable<T>") {
    switch (parameters.length) {
      case 0:
        return () {
          final parametersValues = [];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as Iterable<T>;
        };
      case 1:
        return (item0) {
          final parametersValues = [item0];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as Iterable<T>;
        };
      case 2:
        return (item0, item1) {
          final parametersValues = [item0, item1];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as Iterable<T>;
        };
      case 3:
        return (item0, item1, item2) {
          final parametersValues = [item0, item1, item2];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as Iterable<T>;
        };
      case 4:
        return (item0, item1, item2, item3) {
          final parametersValues = [item0, item1, item2, item3];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as Iterable<T>;
        };
      case 5:
        return (item0, item1, item2, item3, item4) {
          final parametersValues = [item0, item1, item2, item3, item4];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as Iterable<T>;
        };
      case 6:
        return (item0, item1, item2, item3, item4, item5) {
          final parametersValues = [item0, item1, item2, item3, item4, item5];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as Iterable<T>;
        };
      case 7:
        return (item0, item1, item2, item3, item4, item5, item6) {
          final parametersValues = [
            item0,
            item1,
            item2,
            item3,
            item4,
            item5,
            item6
          ];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as Iterable<T>;
        };
      case 8:
        return (item0, item1, item2, item3, item4, item5, item6, item7) {
          final parametersValues = [
            item0,
            item1,
            item2,
            item3,
            item4,
            item5,
            item6,
            item7
          ];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as Iterable<T>;
        };
      case 9:
        return (item0, item1, item2, item3, item4, item5, item6, item7, item8) {
          final parametersValues = [
            item0,
            item1,
            item2,
            item3,
            item4,
            item5,
            item6,
            item7,
            item8
          ];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as Iterable<T>;
        };
    }
  } else if (type == "Stream<LicenseEntry>") {
    switch (parameters.length) {
      case 0:
        return () {
          final parametersValues = [];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as Stream<LicenseEntry>;
        };
      case 1:
        return (item0) {
          final parametersValues = [item0];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as Stream<LicenseEntry>;
        };
      case 2:
        return (item0, item1) {
          final parametersValues = [item0, item1];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as Stream<LicenseEntry>;
        };
      case 3:
        return (item0, item1, item2) {
          final parametersValues = [item0, item1, item2];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as Stream<LicenseEntry>;
        };
      case 4:
        return (item0, item1, item2, item3) {
          final parametersValues = [item0, item1, item2, item3];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as Stream<LicenseEntry>;
        };
      case 5:
        return (item0, item1, item2, item3, item4) {
          final parametersValues = [item0, item1, item2, item3, item4];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as Stream<LicenseEntry>;
        };
      case 6:
        return (item0, item1, item2, item3, item4, item5) {
          final parametersValues = [item0, item1, item2, item3, item4, item5];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as Stream<LicenseEntry>;
        };
      case 7:
        return (item0, item1, item2, item3, item4, item5, item6) {
          final parametersValues = [
            item0,
            item1,
            item2,
            item3,
            item4,
            item5,
            item6
          ];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as Stream<LicenseEntry>;
        };
      case 8:
        return (item0, item1, item2, item3, item4, item5, item6, item7) {
          final parametersValues = [
            item0,
            item1,
            item2,
            item3,
            item4,
            item5,
            item6,
            item7
          ];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as Stream<LicenseEntry>;
        };
      case 9:
        return (item0, item1, item2, item3, item4, item5, item6, item7, item8) {
          final parametersValues = [
            item0,
            item1,
            item2,
            item3,
            item4,
            item5,
            item6,
            item7,
            item8
          ];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as Stream<LicenseEntry>;
        };
    }
  } else if (type == "Locale") {
    switch (parameters.length) {
      case 0:
        return () {
          final parametersValues = [];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as Locale;
        };
      case 1:
        return (item0) {
          final parametersValues = [item0];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as Locale;
        };
      case 2:
        return (item0, item1) {
          final parametersValues = [item0, item1];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as Locale;
        };
      case 3:
        return (item0, item1, item2) {
          final parametersValues = [item0, item1, item2];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as Locale;
        };
      case 4:
        return (item0, item1, item2, item3) {
          final parametersValues = [item0, item1, item2, item3];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as Locale;
        };
      case 5:
        return (item0, item1, item2, item3, item4) {
          final parametersValues = [item0, item1, item2, item3, item4];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as Locale;
        };
      case 6:
        return (item0, item1, item2, item3, item4, item5) {
          final parametersValues = [item0, item1, item2, item3, item4, item5];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as Locale;
        };
      case 7:
        return (item0, item1, item2, item3, item4, item5, item6) {
          final parametersValues = [
            item0,
            item1,
            item2,
            item3,
            item4,
            item5,
            item6
          ];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as Locale;
        };
      case 8:
        return (item0, item1, item2, item3, item4, item5, item6, item7) {
          final parametersValues = [
            item0,
            item1,
            item2,
            item3,
            item4,
            item5,
            item6,
            item7
          ];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as Locale;
        };
      case 9:
        return (item0, item1, item2, item3, item4, item5, item6, item7, item8) {
          final parametersValues = [
            item0,
            item1,
            item2,
            item3,
            item4,
            item5,
            item6,
            item7,
            item8
          ];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as Locale;
        };
    }
  } else if (type == "Future<ByteData?>") {
    switch (parameters.length) {
      case 0:
        return () {
          final parametersValues = [];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as Future<ByteData?>;
        };
      case 1:
        return (item0) {
          final parametersValues = [item0];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as Future<ByteData?>;
        };
      case 2:
        return (item0, item1) {
          final parametersValues = [item0, item1];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as Future<ByteData?>;
        };
      case 3:
        return (item0, item1, item2) {
          final parametersValues = [item0, item1, item2];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as Future<ByteData?>;
        };
      case 4:
        return (item0, item1, item2, item3) {
          final parametersValues = [item0, item1, item2, item3];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as Future<ByteData?>;
        };
      case 5:
        return (item0, item1, item2, item3, item4) {
          final parametersValues = [item0, item1, item2, item3, item4];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as Future<ByteData?>;
        };
      case 6:
        return (item0, item1, item2, item3, item4, item5) {
          final parametersValues = [item0, item1, item2, item3, item4, item5];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as Future<ByteData?>;
        };
      case 7:
        return (item0, item1, item2, item3, item4, item5, item6) {
          final parametersValues = [
            item0,
            item1,
            item2,
            item3,
            item4,
            item5,
            item6
          ];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as Future<ByteData?>;
        };
      case 8:
        return (item0, item1, item2, item3, item4, item5, item6, item7) {
          final parametersValues = [
            item0,
            item1,
            item2,
            item3,
            item4,
            item5,
            item6,
            item7
          ];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as Future<ByteData?>;
        };
      case 9:
        return (item0, item1, item2, item3, item4, item5, item6, item7, item8) {
          final parametersValues = [
            item0,
            item1,
            item2,
            item3,
            item4,
            item5,
            item6,
            item7,
            item8
          ];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as Future<ByteData?>;
        };
    }
  } else if (type == "HitTestResult") {
    switch (parameters.length) {
      case 0:
        return () {
          final parametersValues = [];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as HitTestResult;
        };
      case 1:
        return (item0) {
          final parametersValues = [item0];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as HitTestResult;
        };
      case 2:
        return (item0, item1) {
          final parametersValues = [item0, item1];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as HitTestResult;
        };
      case 3:
        return (item0, item1, item2) {
          final parametersValues = [item0, item1, item2];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as HitTestResult;
        };
      case 4:
        return (item0, item1, item2, item3) {
          final parametersValues = [item0, item1, item2, item3];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as HitTestResult;
        };
      case 5:
        return (item0, item1, item2, item3, item4) {
          final parametersValues = [item0, item1, item2, item3, item4];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as HitTestResult;
        };
      case 6:
        return (item0, item1, item2, item3, item4, item5) {
          final parametersValues = [item0, item1, item2, item3, item4, item5];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as HitTestResult;
        };
      case 7:
        return (item0, item1, item2, item3, item4, item5, item6) {
          final parametersValues = [
            item0,
            item1,
            item2,
            item3,
            item4,
            item5,
            item6
          ];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as HitTestResult;
        };
      case 8:
        return (item0, item1, item2, item3, item4, item5, item6, item7) {
          final parametersValues = [
            item0,
            item1,
            item2,
            item3,
            item4,
            item5,
            item6,
            item7
          ];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as HitTestResult;
        };
      case 9:
        return (item0, item1, item2, item3, item4, item5, item6, item7, item8) {
          final parametersValues = [
            item0,
            item1,
            item2,
            item3,
            item4,
            item5,
            item6,
            item7,
            item8
          ];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as HitTestResult;
        };
    }
  } else if (type == "NavigatorState") {
    switch (parameters.length) {
      case 0:
        return () {
          final parametersValues = [];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as NavigatorState;
        };
      case 1:
        return (item0) {
          final parametersValues = [item0];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as NavigatorState;
        };
      case 2:
        return (item0, item1) {
          final parametersValues = [item0, item1];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as NavigatorState;
        };
      case 3:
        return (item0, item1, item2) {
          final parametersValues = [item0, item1, item2];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as NavigatorState;
        };
      case 4:
        return (item0, item1, item2, item3) {
          final parametersValues = [item0, item1, item2, item3];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as NavigatorState;
        };
      case 5:
        return (item0, item1, item2, item3, item4) {
          final parametersValues = [item0, item1, item2, item3, item4];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as NavigatorState;
        };
      case 6:
        return (item0, item1, item2, item3, item4, item5) {
          final parametersValues = [item0, item1, item2, item3, item4, item5];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as NavigatorState;
        };
      case 7:
        return (item0, item1, item2, item3, item4, item5, item6) {
          final parametersValues = [
            item0,
            item1,
            item2,
            item3,
            item4,
            item5,
            item6
          ];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as NavigatorState;
        };
      case 8:
        return (item0, item1, item2, item3, item4, item5, item6, item7) {
          final parametersValues = [
            item0,
            item1,
            item2,
            item3,
            item4,
            item5,
            item6,
            item7
          ];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as NavigatorState;
        };
      case 9:
        return (item0, item1, item2, item3, item4, item5, item6, item7, item8) {
          final parametersValues = [
            item0,
            item1,
            item2,
            item3,
            item4,
            item5,
            item6,
            item7,
            item8
          ];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as NavigatorState;
        };
    }
  } else if (type == "Object") {
    switch (parameters.length) {
      case 0:
        return () {
          final parametersValues = [];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as Object;
        };
      case 1:
        return (item0) {
          final parametersValues = [item0];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as Object;
        };
      case 2:
        return (item0, item1) {
          final parametersValues = [item0, item1];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as Object;
        };
      case 3:
        return (item0, item1, item2) {
          final parametersValues = [item0, item1, item2];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as Object;
        };
      case 4:
        return (item0, item1, item2, item3) {
          final parametersValues = [item0, item1, item2, item3];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as Object;
        };
      case 5:
        return (item0, item1, item2, item3, item4) {
          final parametersValues = [item0, item1, item2, item3, item4];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as Object;
        };
      case 6:
        return (item0, item1, item2, item3, item4, item5) {
          final parametersValues = [item0, item1, item2, item3, item4, item5];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as Object;
        };
      case 7:
        return (item0, item1, item2, item3, item4, item5, item6) {
          final parametersValues = [
            item0,
            item1,
            item2,
            item3,
            item4,
            item5,
            item6
          ];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as Object;
        };
      case 8:
        return (item0, item1, item2, item3, item4, item5, item6, item7) {
          final parametersValues = [
            item0,
            item1,
            item2,
            item3,
            item4,
            item5,
            item6,
            item7
          ];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as Object;
        };
      case 9:
        return (item0, item1, item2, item3, item4, item5, item6, item7, item8) {
          final parametersValues = [
            item0,
            item1,
            item2,
            item3,
            item4,
            item5,
            item6,
            item7,
            item8
          ];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as Object;
        };
    }
  } else if (type == "PageRoute<T>") {
    switch (parameters.length) {
      case 0:
        return () {
          final parametersValues = [];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as PageRoute<T>;
        };
      case 1:
        return (item0) {
          final parametersValues = [item0];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as PageRoute<T>;
        };
      case 2:
        return (item0, item1) {
          final parametersValues = [item0, item1];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as PageRoute<T>;
        };
      case 3:
        return (item0, item1, item2) {
          final parametersValues = [item0, item1, item2];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as PageRoute<T>;
        };
      case 4:
        return (item0, item1, item2, item3) {
          final parametersValues = [item0, item1, item2, item3];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as PageRoute<T>;
        };
      case 5:
        return (item0, item1, item2, item3, item4) {
          final parametersValues = [item0, item1, item2, item3, item4];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as PageRoute<T>;
        };
      case 6:
        return (item0, item1, item2, item3, item4, item5) {
          final parametersValues = [item0, item1, item2, item3, item4, item5];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as PageRoute<T>;
        };
      case 7:
        return (item0, item1, item2, item3, item4, item5, item6) {
          final parametersValues = [
            item0,
            item1,
            item2,
            item3,
            item4,
            item5,
            item6
          ];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as PageRoute<T>;
        };
      case 8:
        return (item0, item1, item2, item3, item4, item5, item6, item7) {
          final parametersValues = [
            item0,
            item1,
            item2,
            item3,
            item4,
            item5,
            item6,
            item7
          ];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as PageRoute<T>;
        };
      case 9:
        return (item0, item1, item2, item3, item4, item5, item6, item7, item8) {
          final parametersValues = [
            item0,
            item1,
            item2,
            item3,
            item4,
            item5,
            item6,
            item7,
            item8
          ];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as PageRoute<T>;
        };
    }
  } else if (type == "List<PopupMenuEntry<T>>") {
    switch (parameters.length) {
      case 0:
        return () {
          final parametersValues = [];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as List<PopupMenuEntry<T>>;
        };
      case 1:
        return (item0) {
          final parametersValues = [item0];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as List<PopupMenuEntry<T>>;
        };
      case 2:
        return (item0, item1) {
          final parametersValues = [item0, item1];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as List<PopupMenuEntry<T>>;
        };
      case 3:
        return (item0, item1, item2) {
          final parametersValues = [item0, item1, item2];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as List<PopupMenuEntry<T>>;
        };
      case 4:
        return (item0, item1, item2, item3) {
          final parametersValues = [item0, item1, item2, item3];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as List<PopupMenuEntry<T>>;
        };
      case 5:
        return (item0, item1, item2, item3, item4) {
          final parametersValues = [item0, item1, item2, item3, item4];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as List<PopupMenuEntry<T>>;
        };
      case 6:
        return (item0, item1, item2, item3, item4, item5) {
          final parametersValues = [item0, item1, item2, item3, item4, item5];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as List<PopupMenuEntry<T>>;
        };
      case 7:
        return (item0, item1, item2, item3, item4, item5, item6) {
          final parametersValues = [
            item0,
            item1,
            item2,
            item3,
            item4,
            item5,
            item6
          ];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as List<PopupMenuEntry<T>>;
        };
      case 8:
        return (item0, item1, item2, item3, item4, item5, item6, item7) {
          final parametersValues = [
            item0,
            item1,
            item2,
            item3,
            item4,
            item5,
            item6,
            item7
          ];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as List<PopupMenuEntry<T>>;
        };
      case 9:
        return (item0, item1, item2, item3, item4, item5, item6, item7, item8) {
          final parametersValues = [
            item0,
            item1,
            item2,
            item3,
            item4,
            item5,
            item6,
            item7,
            item8
          ];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as List<PopupMenuEntry<T>>;
        };
    }
  } else if (type == "Thumb") {
    switch (parameters.length) {
      case 0:
        return () {
          final parametersValues = [];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as Thumb;
        };
      case 1:
        return (item0) {
          final parametersValues = [item0];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as Thumb;
        };
      case 2:
        return (item0, item1) {
          final parametersValues = [item0, item1];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as Thumb;
        };
      case 3:
        return (item0, item1, item2) {
          final parametersValues = [item0, item1, item2];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as Thumb;
        };
      case 4:
        return (item0, item1, item2, item3) {
          final parametersValues = [item0, item1, item2, item3];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as Thumb;
        };
      case 5:
        return (item0, item1, item2, item3, item4) {
          final parametersValues = [item0, item1, item2, item3, item4];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as Thumb;
        };
      case 6:
        return (item0, item1, item2, item3, item4, item5) {
          final parametersValues = [item0, item1, item2, item3, item4, item5];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as Thumb;
        };
      case 7:
        return (item0, item1, item2, item3, item4, item5, item6) {
          final parametersValues = [
            item0,
            item1,
            item2,
            item3,
            item4,
            item5,
            item6
          ];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as Thumb;
        };
      case 8:
        return (item0, item1, item2, item3, item4, item5, item6, item7) {
          final parametersValues = [
            item0,
            item1,
            item2,
            item3,
            item4,
            item5,
            item6,
            item7
          ];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as Thumb;
        };
      case 9:
        return (item0, item1, item2, item3, item4, item5, item6, item7, item8) {
          final parametersValues = [
            item0,
            item1,
            item2,
            item3,
            item4,
            item5,
            item6,
            item7,
            item8
          ];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as Thumb;
        };
    }
  } else if (type == "Rect") {
    switch (parameters.length) {
      case 0:
        return () {
          final parametersValues = [];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as Rect;
        };
      case 1:
        return (item0) {
          final parametersValues = [item0];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as Rect;
        };
      case 2:
        return (item0, item1) {
          final parametersValues = [item0, item1];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as Rect;
        };
      case 3:
        return (item0, item1, item2) {
          final parametersValues = [item0, item1, item2];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as Rect;
        };
      case 4:
        return (item0, item1, item2, item3) {
          final parametersValues = [item0, item1, item2, item3];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as Rect;
        };
      case 5:
        return (item0, item1, item2, item3, item4) {
          final parametersValues = [item0, item1, item2, item3, item4];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as Rect;
        };
      case 6:
        return (item0, item1, item2, item3, item4, item5) {
          final parametersValues = [item0, item1, item2, item3, item4, item5];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as Rect;
        };
      case 7:
        return (item0, item1, item2, item3, item4, item5, item6) {
          final parametersValues = [
            item0,
            item1,
            item2,
            item3,
            item4,
            item5,
            item6
          ];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as Rect;
        };
      case 8:
        return (item0, item1, item2, item3, item4, item5, item6, item7) {
          final parametersValues = [
            item0,
            item1,
            item2,
            item3,
            item4,
            item5,
            item6,
            item7
          ];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as Rect;
        };
      case 9:
        return (item0, item1, item2, item3, item4, item5, item6, item7, item8) {
          final parametersValues = [
            item0,
            item1,
            item2,
            item3,
            item4,
            item5,
            item6,
            item7,
            item8
          ];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as Rect;
        };
    }
  } else if (type == "Route<T>") {
    switch (parameters.length) {
      case 0:
        return () {
          final parametersValues = [];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as Route<T>;
        };
      case 1:
        return (item0) {
          final parametersValues = [item0];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as Route<T>;
        };
      case 2:
        return (item0, item1) {
          final parametersValues = [item0, item1];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as Route<T>;
        };
      case 3:
        return (item0, item1, item2) {
          final parametersValues = [item0, item1, item2];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as Route<T>;
        };
      case 4:
        return (item0, item1, item2, item3) {
          final parametersValues = [item0, item1, item2, item3];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as Route<T>;
        };
      case 5:
        return (item0, item1, item2, item3, item4) {
          final parametersValues = [item0, item1, item2, item3, item4];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as Route<T>;
        };
      case 6:
        return (item0, item1, item2, item3, item4, item5) {
          final parametersValues = [item0, item1, item2, item3, item4, item5];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as Route<T>;
        };
      case 7:
        return (item0, item1, item2, item3, item4, item5, item6) {
          final parametersValues = [
            item0,
            item1,
            item2,
            item3,
            item4,
            item5,
            item6
          ];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as Route<T>;
        };
      case 8:
        return (item0, item1, item2, item3, item4, item5, item6, item7) {
          final parametersValues = [
            item0,
            item1,
            item2,
            item3,
            item4,
            item5,
            item6,
            item7
          ];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as Route<T>;
        };
      case 9:
        return (item0, item1, item2, item3, item4, item5, item6, item7, item8) {
          final parametersValues = [
            item0,
            item1,
            item2,
            item3,
            item4,
            item5,
            item6,
            item7,
            item8
          ];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as Route<T>;
        };
    }
  } else if (type == "Route<dynamic>") {
    switch (parameters.length) {
      case 0:
        return () {
          final parametersValues = [];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as Route<dynamic>;
        };
      case 1:
        return (item0) {
          final parametersValues = [item0];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as Route<dynamic>;
        };
      case 2:
        return (item0, item1) {
          final parametersValues = [item0, item1];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as Route<dynamic>;
        };
      case 3:
        return (item0, item1, item2) {
          final parametersValues = [item0, item1, item2];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as Route<dynamic>;
        };
      case 4:
        return (item0, item1, item2, item3) {
          final parametersValues = [item0, item1, item2, item3];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as Route<dynamic>;
        };
      case 5:
        return (item0, item1, item2, item3, item4) {
          final parametersValues = [item0, item1, item2, item3, item4];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as Route<dynamic>;
        };
      case 6:
        return (item0, item1, item2, item3, item4, item5) {
          final parametersValues = [item0, item1, item2, item3, item4, item5];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as Route<dynamic>;
        };
      case 7:
        return (item0, item1, item2, item3, item4, item5, item6) {
          final parametersValues = [
            item0,
            item1,
            item2,
            item3,
            item4,
            item5,
            item6
          ];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as Route<dynamic>;
        };
      case 8:
        return (item0, item1, item2, item3, item4, item5, item6, item7) {
          final parametersValues = [
            item0,
            item1,
            item2,
            item3,
            item4,
            item5,
            item6,
            item7
          ];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as Route<dynamic>;
        };
      case 9:
        return (item0, item1, item2, item3, item4, item5, item6, item7, item8) {
          final parametersValues = [
            item0,
            item1,
            item2,
            item3,
            item4,
            item5,
            item6,
            item7,
            item8
          ];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as Route<dynamic>;
        };
    }
  } else if (type == "List<CustomPainterSemantics>") {
    switch (parameters.length) {
      case 0:
        return () {
          final parametersValues = [];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as List<CustomPainterSemantics>;
        };
      case 1:
        return (item0) {
          final parametersValues = [item0];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as List<CustomPainterSemantics>;
        };
      case 2:
        return (item0, item1) {
          final parametersValues = [item0, item1];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as List<CustomPainterSemantics>;
        };
      case 3:
        return (item0, item1, item2) {
          final parametersValues = [item0, item1, item2];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as List<CustomPainterSemantics>;
        };
      case 4:
        return (item0, item1, item2, item3) {
          final parametersValues = [item0, item1, item2, item3];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as List<CustomPainterSemantics>;
        };
      case 5:
        return (item0, item1, item2, item3, item4) {
          final parametersValues = [item0, item1, item2, item3, item4];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as List<CustomPainterSemantics>;
        };
      case 6:
        return (item0, item1, item2, item3, item4, item5) {
          final parametersValues = [item0, item1, item2, item3, item4, item5];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as List<CustomPainterSemantics>;
        };
      case 7:
        return (item0, item1, item2, item3, item4, item5, item6) {
          final parametersValues = [
            item0,
            item1,
            item2,
            item3,
            item4,
            item5,
            item6
          ];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as List<CustomPainterSemantics>;
        };
      case 8:
        return (item0, item1, item2, item3, item4, item5, item6, item7) {
          final parametersValues = [
            item0,
            item1,
            item2,
            item3,
            item4,
            item5,
            item6,
            item7
          ];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as List<CustomPainterSemantics>;
        };
      case 9:
        return (item0, item1, item2, item3, item4, item5, item6, item7, item8) {
          final parametersValues = [
            item0,
            item1,
            item2,
            item3,
            item4,
            item5,
            item6,
            item7,
            item8
          ];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as List<CustomPainterSemantics>;
        };
    }
  } else if (type == "Future<Map<String,   dynamic>>") {
    switch (parameters.length) {
      case 0:
        return () {
          final parametersValues = [];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as Future<Map<String, dynamic>>;
        };
      case 1:
        return (item0) {
          final parametersValues = [item0];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as Future<Map<String, dynamic>>;
        };
      case 2:
        return (item0, item1) {
          final parametersValues = [item0, item1];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as Future<Map<String, dynamic>>;
        };
      case 3:
        return (item0, item1, item2) {
          final parametersValues = [item0, item1, item2];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as Future<Map<String, dynamic>>;
        };
      case 4:
        return (item0, item1, item2, item3) {
          final parametersValues = [item0, item1, item2, item3];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as Future<Map<String, dynamic>>;
        };
      case 5:
        return (item0, item1, item2, item3, item4) {
          final parametersValues = [item0, item1, item2, item3, item4];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as Future<Map<String, dynamic>>;
        };
      case 6:
        return (item0, item1, item2, item3, item4, item5) {
          final parametersValues = [item0, item1, item2, item3, item4, item5];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as Future<Map<String, dynamic>>;
        };
      case 7:
        return (item0, item1, item2, item3, item4, item5, item6) {
          final parametersValues = [
            item0,
            item1,
            item2,
            item3,
            item4,
            item5,
            item6
          ];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as Future<Map<String, dynamic>>;
        };
      case 8:
        return (item0, item1, item2, item3, item4, item5, item6, item7) {
          final parametersValues = [
            item0,
            item1,
            item2,
            item3,
            item4,
            item5,
            item6,
            item7
          ];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as Future<Map<String, dynamic>>;
        };
      case 9:
        return (item0, item1, item2, item3, item4, item5, item6, item7, item8) {
          final parametersValues = [
            item0,
            item1,
            item2,
            item3,
            item4,
            item5,
            item6,
            item7,
            item8
          ];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as Future<Map<String, dynamic>>;
        };
    }
  } else if (type == "Shader") {
    switch (parameters.length) {
      case 0:
        return () {
          final parametersValues = [];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as Shader;
        };
      case 1:
        return (item0) {
          final parametersValues = [item0];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as Shader;
        };
      case 2:
        return (item0, item1) {
          final parametersValues = [item0, item1];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as Shader;
        };
      case 3:
        return (item0, item1, item2) {
          final parametersValues = [item0, item1, item2];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as Shader;
        };
      case 4:
        return (item0, item1, item2, item3) {
          final parametersValues = [item0, item1, item2, item3];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as Shader;
        };
      case 5:
        return (item0, item1, item2, item3, item4) {
          final parametersValues = [item0, item1, item2, item3, item4];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as Shader;
        };
      case 6:
        return (item0, item1, item2, item3, item4, item5) {
          final parametersValues = [item0, item1, item2, item3, item4, item5];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as Shader;
        };
      case 7:
        return (item0, item1, item2, item3, item4, item5, item6) {
          final parametersValues = [
            item0,
            item1,
            item2,
            item3,
            item4,
            item5,
            item6
          ];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as Shader;
        };
      case 8:
        return (item0, item1, item2, item3, item4, item5, item6, item7) {
          final parametersValues = [
            item0,
            item1,
            item2,
            item3,
            item4,
            item5,
            item6,
            item7
          ];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as Shader;
        };
      case 9:
        return (item0, item1, item2, item3, item4, item5, item6, item7, item8) {
          final parametersValues = [
            item0,
            item1,
            item2,
            item3,
            item4,
            item5,
            item6,
            item7,
            item8
          ];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as Shader;
        };
    }
  } else if (type == "StackTrace") {
    switch (parameters.length) {
      case 0:
        return () {
          final parametersValues = [];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as StackTrace;
        };
      case 1:
        return (item0) {
          final parametersValues = [item0];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as StackTrace;
        };
      case 2:
        return (item0, item1) {
          final parametersValues = [item0, item1];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as StackTrace;
        };
      case 3:
        return (item0, item1, item2) {
          final parametersValues = [item0, item1, item2];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as StackTrace;
        };
      case 4:
        return (item0, item1, item2, item3) {
          final parametersValues = [item0, item1, item2, item3];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as StackTrace;
        };
      case 5:
        return (item0, item1, item2, item3, item4) {
          final parametersValues = [item0, item1, item2, item3, item4];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as StackTrace;
        };
      case 6:
        return (item0, item1, item2, item3, item4, item5) {
          final parametersValues = [item0, item1, item2, item3, item4, item5];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as StackTrace;
        };
      case 7:
        return (item0, item1, item2, item3, item4, item5, item6) {
          final parametersValues = [
            item0,
            item1,
            item2,
            item3,
            item4,
            item5,
            item6
          ];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as StackTrace;
        };
      case 8:
        return (item0, item1, item2, item3, item4, item5, item6, item7) {
          final parametersValues = [
            item0,
            item1,
            item2,
            item3,
            item4,
            item5,
            item6,
            item7
          ];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as StackTrace;
        };
      case 9:
        return (item0, item1, item2, item3, item4, item5, item6, item7, item8) {
          final parametersValues = [
            item0,
            item1,
            item2,
            item3,
            item4,
            item5,
            item6,
            item7,
            item8
          ];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as StackTrace;
        };
    }
  } else if (type == "Iterable<Widget>") {
    switch (parameters.length) {
      case 0:
        return () {
          final parametersValues = [];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as Iterable<Widget>;
        };
      case 1:
        return (item0) {
          final parametersValues = [item0];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as Iterable<Widget>;
        };
      case 2:
        return (item0, item1) {
          final parametersValues = [item0, item1];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as Iterable<Widget>;
        };
      case 3:
        return (item0, item1, item2) {
          final parametersValues = [item0, item1, item2];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as Iterable<Widget>;
        };
      case 4:
        return (item0, item1, item2, item3) {
          final parametersValues = [item0, item1, item2, item3];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as Iterable<Widget>;
        };
      case 5:
        return (item0, item1, item2, item3, item4) {
          final parametersValues = [item0, item1, item2, item3, item4];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as Iterable<Widget>;
        };
      case 6:
        return (item0, item1, item2, item3, item4, item5) {
          final parametersValues = [item0, item1, item2, item3, item4, item5];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as Iterable<Widget>;
        };
      case 7:
        return (item0, item1, item2, item3, item4, item5, item6) {
          final parametersValues = [
            item0,
            item1,
            item2,
            item3,
            item4,
            item5,
            item6
          ];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as Iterable<Widget>;
        };
      case 8:
        return (item0, item1, item2, item3, item4, item5, item6, item7) {
          final parametersValues = [
            item0,
            item1,
            item2,
            item3,
            item4,
            item5,
            item6,
            item7
          ];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as Iterable<Widget>;
        };
      case 9:
        return (item0, item1, item2, item3, item4, item5, item6, item7, item8) {
          final parametersValues = [
            item0,
            item1,
            item2,
            item3,
            item4,
            item5,
            item6,
            item7,
            item8
          ];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as Iterable<Widget>;
        };
    }
  } else if (type == "TargetImageSize") {
    switch (parameters.length) {
      case 0:
        return () {
          final parametersValues = [];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as TargetImageSize;
        };
      case 1:
        return (item0) {
          final parametersValues = [item0];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as TargetImageSize;
        };
      case 2:
        return (item0, item1) {
          final parametersValues = [item0, item1];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as TargetImageSize;
        };
      case 3:
        return (item0, item1, item2) {
          final parametersValues = [item0, item1, item2];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as TargetImageSize;
        };
      case 4:
        return (item0, item1, item2, item3) {
          final parametersValues = [item0, item1, item2, item3];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as TargetImageSize;
        };
      case 5:
        return (item0, item1, item2, item3, item4) {
          final parametersValues = [item0, item1, item2, item3, item4];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as TargetImageSize;
        };
      case 6:
        return (item0, item1, item2, item3, item4, item5) {
          final parametersValues = [item0, item1, item2, item3, item4, item5];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as TargetImageSize;
        };
      case 7:
        return (item0, item1, item2, item3, item4, item5, item6) {
          final parametersValues = [
            item0,
            item1,
            item2,
            item3,
            item4,
            item5,
            item6
          ];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as TargetImageSize;
        };
      case 8:
        return (item0, item1, item2, item3, item4, item5, item6, item7) {
          final parametersValues = [
            item0,
            item1,
            item2,
            item3,
            item4,
            item5,
            item6,
            item7
          ];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as TargetImageSize;
        };
      case 9:
        return (item0, item1, item2, item3, item4, item5, item6, item7, item8) {
          final parametersValues = [
            item0,
            item1,
            item2,
            item3,
            item4,
            item5,
            item6,
            item7,
            item8
          ];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as TargetImageSize;
        };
    }
  } else if (type == "FutureOr<T>") {
    switch (parameters.length) {
      case 0:
        return () {
          final parametersValues = [];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as FutureOr<T>;
        };
      case 1:
        return (item0) {
          final parametersValues = [item0];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as FutureOr<T>;
        };
      case 2:
        return (item0, item1) {
          final parametersValues = [item0, item1];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as FutureOr<T>;
        };
      case 3:
        return (item0, item1, item2) {
          final parametersValues = [item0, item1, item2];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as FutureOr<T>;
        };
      case 4:
        return (item0, item1, item2, item3) {
          final parametersValues = [item0, item1, item2, item3];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as FutureOr<T>;
        };
      case 5:
        return (item0, item1, item2, item3, item4) {
          final parametersValues = [item0, item1, item2, item3, item4];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as FutureOr<T>;
        };
      case 6:
        return (item0, item1, item2, item3, item4, item5) {
          final parametersValues = [item0, item1, item2, item3, item4, item5];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as FutureOr<T>;
        };
      case 7:
        return (item0, item1, item2, item3, item4, item5, item6) {
          final parametersValues = [
            item0,
            item1,
            item2,
            item3,
            item4,
            item5,
            item6
          ];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as FutureOr<T>;
        };
      case 8:
        return (item0, item1, item2, item3, item4, item5, item6, item7) {
          final parametersValues = [
            item0,
            item1,
            item2,
            item3,
            item4,
            item5,
            item6,
            item7
          ];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as FutureOr<T>;
        };
      case 9:
        return (item0, item1, item2, item3, item4, item5, item6, item7, item8) {
          final parametersValues = [
            item0,
            item1,
            item2,
            item3,
            item4,
            item5,
            item6,
            item7,
            item8
          ];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as FutureOr<T>;
        };
    }
  } else if (type == "Tween<T>") {
    switch (parameters.length) {
      case 0:
        return () {
          final parametersValues = [];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as Tween<T>;
        };
      case 1:
        return (item0) {
          final parametersValues = [item0];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as Tween<T>;
        };
      case 2:
        return (item0, item1) {
          final parametersValues = [item0, item1];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as Tween<T>;
        };
      case 3:
        return (item0, item1, item2) {
          final parametersValues = [item0, item1, item2];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as Tween<T>;
        };
      case 4:
        return (item0, item1, item2, item3) {
          final parametersValues = [item0, item1, item2, item3];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as Tween<T>;
        };
      case 5:
        return (item0, item1, item2, item3, item4) {
          final parametersValues = [item0, item1, item2, item3, item4];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as Tween<T>;
        };
      case 6:
        return (item0, item1, item2, item3, item4, item5) {
          final parametersValues = [item0, item1, item2, item3, item4, item5];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as Tween<T>;
        };
      case 7:
        return (item0, item1, item2, item3, item4, item5, item6) {
          final parametersValues = [
            item0,
            item1,
            item2,
            item3,
            item4,
            item5,
            item6
          ];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as Tween<T>;
        };
      case 8:
        return (item0, item1, item2, item3, item4, item5, item6, item7) {
          final parametersValues = [
            item0,
            item1,
            item2,
            item3,
            item4,
            item5,
            item6,
            item7
          ];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as Tween<T>;
        };
      case 9:
        return (item0, item1, item2, item3, item4, item5, item6, item7, item8) {
          final parametersValues = [
            item0,
            item1,
            item2,
            item3,
            item4,
            item5,
            item6,
            item7,
            item8
          ];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as Tween<T>;
        };
    }
  } else if (type == "Future<bool>") {
    switch (parameters.length) {
      case 0:
        return () {
          final parametersValues = [];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as Future<bool>;
        };
      case 1:
        return (item0) {
          final parametersValues = [item0];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as Future<bool>;
        };
      case 2:
        return (item0, item1) {
          final parametersValues = [item0, item1];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as Future<bool>;
        };
      case 3:
        return (item0, item1, item2) {
          final parametersValues = [item0, item1, item2];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as Future<bool>;
        };
      case 4:
        return (item0, item1, item2, item3) {
          final parametersValues = [item0, item1, item2, item3];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as Future<bool>;
        };
      case 5:
        return (item0, item1, item2, item3, item4) {
          final parametersValues = [item0, item1, item2, item3, item4];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as Future<bool>;
        };
      case 6:
        return (item0, item1, item2, item3, item4, item5) {
          final parametersValues = [item0, item1, item2, item3, item4, item5];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as Future<bool>;
        };
      case 7:
        return (item0, item1, item2, item3, item4, item5, item6) {
          final parametersValues = [
            item0,
            item1,
            item2,
            item3,
            item4,
            item5,
            item6
          ];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as Future<bool>;
        };
      case 8:
        return (item0, item1, item2, item3, item4, item5, item6, item7) {
          final parametersValues = [
            item0,
            item1,
            item2,
            item3,
            item4,
            item5,
            item6,
            item7
          ];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as Future<bool>;
        };
      case 9:
        return (item0, item1, item2, item3, item4, item5, item6, item7, item8) {
          final parametersValues = [
            item0,
            item1,
            item2,
            item3,
            item4,
            item5,
            item6,
            item7,
            item8
          ];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result as Future<bool>;
        };
    }
  } else {
    switch (parameters.length) {
      case 0:
        return () {
          final parametersValues = [];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result;
        };
      case 1:
        return (item0) {
          final parametersValues = [item0];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result;
        };
      case 2:
        return (item0, item1) {
          final parametersValues = [item0, item1];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result;
        };
      case 3:
        return (item0, item1, item2) {
          final parametersValues = [item0, item1, item2];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result;
        };
      case 4:
        return (item0, item1, item2, item3) {
          final parametersValues = [item0, item1, item2, item3];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result;
        };
      case 5:
        return (item0, item1, item2, item3, item4) {
          final parametersValues = [item0, item1, item2, item3, item4];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result;
        };
      case 6:
        return (item0, item1, item2, item3, item4, item5) {
          final parametersValues = [item0, item1, item2, item3, item4, item5];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result;
        };
      case 7:
        return (item0, item1, item2, item3, item4, item5, item6) {
          final parametersValues = [
            item0,
            item1,
            item2,
            item3,
            item4,
            item5,
            item6
          ];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result;
        };
      case 8:
        return (item0, item1, item2, item3, item4, item5, item6, item7) {
          final parametersValues = [
            item0,
            item1,
            item2,
            item3,
            item4,
            item5,
            item6,
            item7
          ];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result;
        };
      case 9:
        return (item0, item1, item2, item3, item4, item5, item6, item7, item8) {
          final parametersValues = [
            item0,
            item1,
            item2,
            item3,
            item4,
            item5,
            item6,
            item7,
            item8
          ];
          final map = getVarsFromParameters(parametersValues, infos);
          final result = solveCallbackFunction(string, vars, props, datas, map);
          return result;
        };
    }
  }
}
