// ignore_for_file: prefer_if_null_operators

import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';

import '../../models/input.dart';
import '../widgets_data.dart';

dynamic staticClassesWithFunctions<T extends Object, I extends Intent,
        B extends BindingBase, S, K, V>(String className, String value,
    List<String> parameters, Map<String, List<InputData>> datas,
    [String returnType = "",
    List<Map<String, dynamic>> vars = const [],
    List<Map<String, String>> props = const []]) async {
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
      // const list = List();
      // list.where((element) => false)
    }
  }

  return <String, dynamic Function()>{
    "ActionIconTheme": () {
      switch (value) {
        case "of":
          if (maps["0"] == null) {
            return null;
          }
          return ActionIconTheme.of(
              getValue(maps["0"], datas, returnType, vars, props)!);
      }
    },
    "ActionIconThemeData": () {
      switch (value) {
        case "lerp":
          if (maps["0"] == null || maps["1"] == null || maps["2"] == null) {
            return null;
          }
          return ActionIconThemeData.lerp(
              getValue(maps["0"], datas, returnType, vars, props)!,
              getValue(maps["1"], datas, returnType, vars, props)!,
              getValue(maps["2"], datas, returnType, vars, props).toDouble()!);
      }
    },
    "Actions": () {
      switch (value) {
        case "handler":
          if (maps["0"] == null || maps["1"] == null) {
            return null;
          }
          return Actions.handler<I>(
              getValue(maps["0"], datas, returnType, vars, props)!,
              getValue(maps["1"], datas, returnType, vars, props)!);
        case "find":
          if (maps["0"] == null) {
            return null;
          }
          return Actions.find<I>(
              getValue(maps["0"], datas, returnType, vars, props)!,
              intent: getValue(maps["intent"], datas, returnType, vars, props));
        case "maybeFind":
          if (maps["0"] == null) {
            return null;
          }
          return Actions.maybeFind<I>(
              getValue(maps["0"], datas, returnType, vars, props)!,
              intent: getValue(maps["intent"], datas, returnType, vars, props));
        case "of":
          if (maps["0"] == null) {
            return null;
          }
          return Actions.of(
              getValue(maps["0"], datas, returnType, vars, props)!);
        case "invoke":
          if (maps["0"] == null || maps["1"] == null) {
            return null;
          }
          return Actions.invoke<I>(
              getValue(maps["0"], datas, returnType, vars, props)!,
              getValue(maps["1"], datas, returnType, vars, props)!);
        case "maybeInvoke":
          if (maps["0"] == null || maps["1"] == null) {
            return null;
          }
          return Actions.maybeInvoke<I>(
              getValue(maps["0"], datas, returnType, vars, props)!,
              getValue(maps["1"], datas, returnType, vars, props)!);
      }
    },
    "AdaptiveTextSelectionToolbar": () {
      switch (value) {
        case "getButtonLabel":
          if (maps["0"] == null || maps["1"] == null) {
            return null;
          }
          return AdaptiveTextSelectionToolbar.getButtonLabel(
              getValue(maps["0"], datas, returnType, vars, props)!,
              getValue(maps["1"], datas, returnType, vars, props)!);
        case "getAdaptiveButtons":
          if (maps["0"] == null || maps["1"] == null) {
            return null;
          }
          return AdaptiveTextSelectionToolbar.getAdaptiveButtons(
              getValue(maps["0"], datas, returnType, vars, props)!,
              List<ContextMenuButtonItem>.from(
                  getValue(maps["1"], datas, returnType, vars, props)));
      }
    },
    "AlignmentDirectional": () {
      switch (value) {
        case "topStart":
          return AlignmentDirectional.topStart;
        case "topCenter":
          return AlignmentDirectional.topCenter;
        case "topEnd":
          return AlignmentDirectional.topEnd;
        case "centerStart":
          return AlignmentDirectional.centerStart;
        case "center":
          return AlignmentDirectional.center;
        case "centerEnd":
          return AlignmentDirectional.centerEnd;
        case "bottomStart":
          return AlignmentDirectional.bottomStart;
        case "bottomCenter":
          return AlignmentDirectional.bottomCenter;
        case "bottomEnd":
          return AlignmentDirectional.bottomEnd;
        case "lerp":
          if (maps["0"] == null || maps["1"] == null || maps["2"] == null) {
            return null;
          }
          return AlignmentDirectional.lerp(
              getValue(maps["0"], datas, returnType, vars, props)!,
              getValue(maps["1"], datas, returnType, vars, props)!,
              getValue(maps["2"], datas, returnType, vars, props).toDouble()!);
      }
    },
    "AlignmentGeometry": () {
      switch (value) {
        case "lerp":
          if (maps["0"] == null || maps["1"] == null || maps["2"] == null) {
            return null;
          }
          return AlignmentGeometry.lerp(
              getValue(maps["0"], datas, returnType, vars, props)!,
              getValue(maps["1"], datas, returnType, vars, props)!,
              getValue(maps["2"], datas, returnType, vars, props).toDouble()!);
      }
    },
    "AndroidPointerProperties": () {
      switch (value) {
        case "kToolTypeUnknown":
          return AndroidPointerProperties.kToolTypeUnknown;
        case "kToolTypeFinger":
          return AndroidPointerProperties.kToolTypeFinger;
        case "kToolTypeStylus":
          return AndroidPointerProperties.kToolTypeStylus;
        case "kToolTypeMouse":
          return AndroidPointerProperties.kToolTypeMouse;
        case "kToolTypeEraser":
          return AndroidPointerProperties.kToolTypeEraser;
      }
    },
    "AndroidViewController": () {
      switch (value) {
        case "kActionDown":
          return AndroidViewController.kActionDown;
        case "kActionUp":
          return AndroidViewController.kActionUp;
        case "kActionMove":
          return AndroidViewController.kActionMove;
        case "kActionCancel":
          return AndroidViewController.kActionCancel;
        case "kActionPointerDown":
          return AndroidViewController.kActionPointerDown;
        case "kActionPointerUp":
          return AndroidViewController.kActionPointerUp;
        case "kAndroidLayoutDirectionLtr":
          return AndroidViewController.kAndroidLayoutDirectionLtr;
        case "kAndroidLayoutDirectionRtl":
          return AndroidViewController.kAndroidLayoutDirectionRtl;
        case "pointerAction":
          if (maps["0"] == null || maps["1"] == null) {
            return null;
          }
          return AndroidViewController.pointerAction(
              getValue(maps["0"], datas, returnType, vars, props)!,
              getValue(maps["1"], datas, returnType, vars, props)!);
      }
    },
    "AnimatedCrossFade": () {
      switch (value) {
        case "defaultLayoutBuilder":
          if (maps["0"] == null ||
              maps["1"] == null ||
              maps["2"] == null ||
              maps["3"] == null) {
            return null;
          }
          return AnimatedCrossFade.defaultLayoutBuilder(
              getValue(maps["0"], datas, returnType, vars, props)!,
              getValue(maps["1"], datas, returnType, vars, props)!,
              getValue(maps["2"], datas, returnType, vars, props)!,
              getValue(maps["3"], datas, returnType, vars, props)!);
      }
    },
    "AnimatedGrid": () {
      switch (value) {
        case "of":
          if (maps["0"] == null) {
            return null;
          }
          return AnimatedGrid.of(
              getValue(maps["0"], datas, returnType, vars, props)!);
        case "maybeOf":
          if (maps["0"] == null) {
            return null;
          }
          return AnimatedGrid.maybeOf(
              getValue(maps["0"], datas, returnType, vars, props)!);
      }
    },
    "AnimatedIcons": () {
      switch (value) {
        case "add_event":
          return AnimatedIcons.add_event;
        case "arrow_menu":
          return AnimatedIcons.arrow_menu;
        case "close_menu":
          return AnimatedIcons.close_menu;
        case "ellipsis_search":
          return AnimatedIcons.ellipsis_search;
        case "event_add":
          return AnimatedIcons.event_add;
        case "home_menu":
          return AnimatedIcons.home_menu;
        case "list_view":
          return AnimatedIcons.list_view;
        case "menu_arrow":
          return AnimatedIcons.menu_arrow;
        case "menu_close":
          return AnimatedIcons.menu_close;
        case "menu_home":
          return AnimatedIcons.menu_home;
        case "pause_play":
          return AnimatedIcons.pause_play;
        case "play_pause":
          return AnimatedIcons.play_pause;
        case "search_ellipsis":
          return AnimatedIcons.search_ellipsis;
        case "view_list":
          return AnimatedIcons.view_list;
      }
    },
    "AnimatedList": () {
      switch (value) {
        case "of":
          if (maps["0"] == null) {
            return null;
          }
          return AnimatedList.of(
              getValue(maps["0"], datas, returnType, vars, props)!);
        case "maybeOf":
          if (maps["0"] == null) {
            return null;
          }
          return AnimatedList.maybeOf(
              getValue(maps["0"], datas, returnType, vars, props)!);
      }
    },
    "AnimatedSwitcher": () {
      switch (value) {
        case "defaultTransitionBuilder":
          if (maps["0"] == null || maps["1"] == null) {
            return null;
          }
          return AnimatedSwitcher.defaultTransitionBuilder(
              getValue(maps["0"], datas, returnType, vars, props)!,
              getValue(maps["1"], datas, returnType, vars, props)!);
        case "defaultLayoutBuilder":
          if (maps["0"] == null || maps["1"] == null) {
            return null;
          }
          return AnimatedSwitcher.defaultLayoutBuilder(
              getValue(maps["0"], datas, returnType, vars, props)!,
              List<Widget>.from(
                  getValue(maps["1"], datas, returnType, vars, props)));
      }
    },
    "AppBar": () {
      switch (value) {
        case "preferredHeightFor":
          if (maps["0"] == null || maps["1"] == null) {
            return null;
          }
          return AppBar.preferredHeightFor(
              getValue(maps["0"], datas, returnType, vars, props)!,
              getValue(maps["1"], datas, returnType, vars, props)!);
      }
    },
    "AppBarTheme": () {
      switch (value) {
        case "of":
          if (maps["0"] == null) {
            return null;
          }
          return AppBarTheme.of(
              getValue(maps["0"], datas, returnType, vars, props)!);
        case "lerp":
          if (maps["0"] == null || maps["1"] == null || maps["2"] == null) {
            return null;
          }
          return AppBarTheme.lerp(
              getValue(maps["0"], datas, returnType, vars, props)!,
              getValue(maps["1"], datas, returnType, vars, props)!,
              getValue(maps["2"], datas, returnType, vars, props).toDouble()!);
      }
    },
    "ArgumentError": () {
      switch (value) {
        case "checkNotNull":
          if (maps["0"] == null) {
            return null;
          }
          return ArgumentError.checkNotNull(
              getValue(maps["0"], datas, returnType, vars, props)!);
      }
    },
    "AssetManifest": () {
      switch (value) {
        case "loadFromAssetBundle":
          if (maps["0"] == null) {
            return null;
          }
          return AssetManifest.loadFromAssetBundle(
              getValue(maps["0"], datas, returnType, vars, props)!);
      }
    },
    "AutocompleteHighlightedOption": () {
      switch (value) {
        case "of":
          if (maps["0"] == null) {
            return null;
          }
          return AutocompleteHighlightedOption.of(
              getValue(maps["0"], datas, returnType, vars, props)!);
      }
    },
    "AutofillConfiguration": () {
      switch (value) {
        case "disabled":
          return AutofillConfiguration.disabled;
      }
    },
    "AutofillGroup": () {
      switch (value) {
        case "maybeOf":
          if (maps["0"] == null) {
            return null;
          }
          return AutofillGroup.maybeOf(
              getValue(maps["0"], datas, returnType, vars, props)!);
        case "of":
          if (maps["0"] == null) {
            return null;
          }
          return AutofillGroup.of(
              getValue(maps["0"], datas, returnType, vars, props)!);
      }
    },
    "AutofillHints": () {
      switch (value) {
        case "addressCity":
          return AutofillHints.addressCity;
        case "addressCityAndState":
          return AutofillHints.addressCityAndState;
        case "addressState":
          return AutofillHints.addressState;
        case "birthday":
          return AutofillHints.birthday;
        case "birthdayDay":
          return AutofillHints.birthdayDay;
        case "birthdayMonth":
          return AutofillHints.birthdayMonth;
        case "birthdayYear":
          return AutofillHints.birthdayYear;
        case "countryCode":
          return AutofillHints.countryCode;
        case "countryName":
          return AutofillHints.countryName;
        case "creditCardExpirationDate":
          return AutofillHints.creditCardExpirationDate;
        case "creditCardExpirationDay":
          return AutofillHints.creditCardExpirationDay;
        case "creditCardExpirationMonth":
          return AutofillHints.creditCardExpirationMonth;
        case "creditCardExpirationYear":
          return AutofillHints.creditCardExpirationYear;
        case "creditCardFamilyName":
          return AutofillHints.creditCardFamilyName;
        case "creditCardGivenName":
          return AutofillHints.creditCardGivenName;
        case "creditCardMiddleName":
          return AutofillHints.creditCardMiddleName;
        case "creditCardName":
          return AutofillHints.creditCardName;
        case "creditCardNumber":
          return AutofillHints.creditCardNumber;
        case "creditCardSecurityCode":
          return AutofillHints.creditCardSecurityCode;
        case "creditCardType":
          return AutofillHints.creditCardType;
        case "email":
          return AutofillHints.email;
        case "familyName":
          return AutofillHints.familyName;
        case "fullStreetAddress":
          return AutofillHints.fullStreetAddress;
        case "gender":
          return AutofillHints.gender;
        case "givenName":
          return AutofillHints.givenName;
        case "impp":
          return AutofillHints.impp;
        case "jobTitle":
          return AutofillHints.jobTitle;
        case "language":
          return AutofillHints.language;
        case "location":
          return AutofillHints.location;
        case "middleInitial":
          return AutofillHints.middleInitial;
        case "middleName":
          return AutofillHints.middleName;
        case "name":
          return AutofillHints.name;
        case "namePrefix":
          return AutofillHints.namePrefix;
        case "nameSuffix":
          return AutofillHints.nameSuffix;
        case "newPassword":
          return AutofillHints.newPassword;
        case "newUsername":
          return AutofillHints.newUsername;
        case "nickname":
          return AutofillHints.nickname;
        case "oneTimeCode":
          return AutofillHints.oneTimeCode;
        case "organizationName":
          return AutofillHints.organizationName;
        case "password":
          return AutofillHints.password;
        case "photo":
          return AutofillHints.photo;
        case "postalAddress":
          return AutofillHints.postalAddress;
        case "postalAddressExtended":
          return AutofillHints.postalAddressExtended;
        case "postalAddressExtendedPostalCode":
          return AutofillHints.postalAddressExtendedPostalCode;
        case "postalCode":
          return AutofillHints.postalCode;
        case "streetAddressLevel1":
          return AutofillHints.streetAddressLevel1;
        case "streetAddressLevel2":
          return AutofillHints.streetAddressLevel2;
        case "streetAddressLevel3":
          return AutofillHints.streetAddressLevel3;
        case "streetAddressLevel4":
          return AutofillHints.streetAddressLevel4;
        case "streetAddressLine1":
          return AutofillHints.streetAddressLine1;
        case "streetAddressLine2":
          return AutofillHints.streetAddressLine2;
        case "streetAddressLine3":
          return AutofillHints.streetAddressLine3;
        case "sublocality":
          return AutofillHints.sublocality;
        case "telephoneNumber":
          return AutofillHints.telephoneNumber;
        case "telephoneNumberAreaCode":
          return AutofillHints.telephoneNumberAreaCode;
        case "telephoneNumberCountryCode":
          return AutofillHints.telephoneNumberCountryCode;
        case "telephoneNumberDevice":
          return AutofillHints.telephoneNumberDevice;
        case "telephoneNumberExtension":
          return AutofillHints.telephoneNumberExtension;
        case "telephoneNumberLocal":
          return AutofillHints.telephoneNumberLocal;
        case "telephoneNumberLocalPrefix":
          return AutofillHints.telephoneNumberLocalPrefix;
        case "telephoneNumberLocalSuffix":
          return AutofillHints.telephoneNumberLocalSuffix;
        case "telephoneNumberNational":
          return AutofillHints.telephoneNumberNational;
        case "transactionAmount":
          return AutofillHints.transactionAmount;
        case "transactionCurrency":
          return AutofillHints.transactionCurrency;
        case "url":
          return AutofillHints.url;
        case "username":
          return AutofillHints.username;
      }
    },
    "BackgroundIsolateBinaryMessenger": () {
      switch (value) {
        case "instance":
          return BackgroundIsolateBinaryMessenger.instance;
        case "ensureInitialized":
          if (maps["0"] == null) {
            return null;
          }
          BackgroundIsolateBinaryMessenger.ensureInitialized(
              getValue(maps["0"], datas, returnType, vars, props)!);
      }
    },
    "BackgroundIsolateBinaryMessenger": () {
      switch (value) {
        case "instance":
          return BackgroundIsolateBinaryMessenger.instance;
      }
    },
    "BadgeTheme": () {
      switch (value) {
        case "of":
          if (maps["0"] == null) {
            return null;
          }
          return BadgeTheme.of(
              getValue(maps["0"], datas, returnType, vars, props)!);
      }
    },
    "BadgeThemeData": () {
      switch (value) {
        case "lerp":
          if (maps["0"] == null || maps["1"] == null || maps["2"] == null) {
            return null;
          }
          return BadgeThemeData.lerp(
              getValue(maps["0"], datas, returnType, vars, props)!,
              getValue(maps["1"], datas, returnType, vars, props)!,
              getValue(maps["2"], datas, returnType, vars, props).toDouble()!);
      }
    },
    "BigInt": () {
      switch (value) {
        case "zero;":
          return BigInt.zero;
          ;
        case "one;":
          return BigInt.one;
          ;
        case "two;":
          return BigInt.two;
          ;
        case "parse":
          if (maps["0"] == null) {
            return null;
          }
          return BigInt.parse(
              getValue(maps["0"], datas, returnType, vars, props)!,
              radix: getValue(maps["radix"], datas, returnType, vars, props));
        case "tryParse":
          if (maps["0"] == null) {
            return null;
          }
          return BigInt.tryParse(
              getValue(maps["0"], datas, returnType, vars, props)!,
              radix: getValue(maps["radix"], datas, returnType, vars, props));
      }
    },
    "BindingBase": () {
      switch (value) {
        // case "debugReassembleConfig":
        //   return BindingBase.debugReassembleConfig;
        case "checkInstance":
          if (maps["0"] == null) {
            return null;
          }
          return BindingBase.checkInstance<B>(
              getValue(maps["0"], datas, returnType, vars, props)!);
        case "debugBindingType":
          return BindingBase.debugBindingType();
        case "debugZoneErrorsAreFatal":
          return BindingBase.debugZoneErrorsAreFatal;
      }
    },
    "Border": () {
      switch (value) {
        case "merge":
          if (maps["0"] == null || maps["1"] == null) {
            return null;
          }
          return Border.merge(
              getValue(maps["0"], datas, returnType, vars, props)!,
              getValue(maps["1"], datas, returnType, vars, props)!);
        case "lerp":
          if (maps["0"] == null || maps["1"] == null || maps["2"] == null) {
            return null;
          }
          return Border.lerp(
              getValue(maps["0"], datas, returnType, vars, props)!,
              getValue(maps["1"], datas, returnType, vars, props)!,
              getValue(maps["2"], datas, returnType, vars, props).toDouble()!);
      }
    },
    "BorderRadius": () {
      switch (value) {
        case "zero":
          return BorderRadius.zero;
        case "lerp":
          if (maps["0"] == null || maps["1"] == null || maps["2"] == null) {
            return null;
          }
          return BorderRadius.lerp(
              getValue(maps["0"], datas, returnType, vars, props)!,
              getValue(maps["1"], datas, returnType, vars, props)!,
              getValue(maps["2"], datas, returnType, vars, props).toDouble()!);
      }
    },
    "BorderRadiusDirectional": () {
      switch (value) {
        case "zero":
          return BorderRadiusDirectional.zero;
        case "lerp":
          if (maps["0"] == null || maps["1"] == null || maps["2"] == null) {
            return null;
          }
          return BorderRadiusDirectional.lerp(
              getValue(maps["0"], datas, returnType, vars, props)!,
              getValue(maps["1"], datas, returnType, vars, props)!,
              getValue(maps["2"], datas, returnType, vars, props).toDouble()!);
      }
    },
    "BorderRadiusGeometry": () {
      switch (value) {
        case "lerp":
          if (maps["0"] == null || maps["1"] == null || maps["2"] == null) {
            return null;
          }
          return BorderRadiusGeometry.lerp(
              getValue(maps["0"], datas, returnType, vars, props)!,
              getValue(maps["1"], datas, returnType, vars, props)!,
              getValue(maps["2"], datas, returnType, vars, props).toDouble()!);
      }
    },
    "BorderSide": () {
      switch (value) {
        case "merge":
          if (maps["0"] == null || maps["1"] == null) {
            return null;
          }
          return BorderSide.merge(
              getValue(maps["0"], datas, returnType, vars, props)!,
              getValue(maps["1"], datas, returnType, vars, props)!);
        case "none":
          return BorderSide.none;
        case "strokeAlignInside":
          return BorderSide.strokeAlignInside;
        case "strokeAlignCenter":
          return BorderSide.strokeAlignCenter;
        case "strokeAlignOutside":
          return BorderSide.strokeAlignOutside;
        case "canMerge":
          if (maps["0"] == null || maps["1"] == null) {
            return null;
          }
          return BorderSide.canMerge(
              getValue(maps["0"], datas, returnType, vars, props)!,
              getValue(maps["1"], datas, returnType, vars, props)!);
        case "lerp":
          if (maps["0"] == null || maps["1"] == null || maps["2"] == null) {
            return null;
          }
          return BorderSide.lerp(
              getValue(maps["0"], datas, returnType, vars, props)!,
              getValue(maps["1"], datas, returnType, vars, props)!,
              getValue(maps["2"], datas, returnType, vars, props).toDouble()!);
      }
    },
    "BottomAppBarTheme": () {
      switch (value) {
        case "of":
          if (maps["0"] == null) {
            return null;
          }
          return BottomAppBarTheme.of(
              getValue(maps["0"], datas, returnType, vars, props)!);
        case "lerp":
          if (maps["0"] == null || maps["1"] == null || maps["2"] == null) {
            return null;
          }
          return BottomAppBarTheme.lerp(
              getValue(maps["0"], datas, returnType, vars, props)!,
              getValue(maps["1"], datas, returnType, vars, props)!,
              getValue(maps["2"], datas, returnType, vars, props).toDouble()!);
      }
    },
    "BottomNavigationBarTheme": () {
      switch (value) {
        case "of":
          if (maps["0"] == null) {
            return null;
          }
          return BottomNavigationBarTheme.of(
              getValue(maps["0"], datas, returnType, vars, props)!);
      }
    },
    "BottomNavigationBarThemeData": () {
      switch (value) {
        case "lerp":
          if (maps["0"] == null || maps["1"] == null || maps["2"] == null) {
            return null;
          }
          return BottomNavigationBarThemeData.lerp(
              getValue(maps["0"], datas, returnType, vars, props)!,
              getValue(maps["1"], datas, returnType, vars, props)!,
              getValue(maps["2"], datas, returnType, vars, props).toDouble()!);
      }
    },
    "BottomSheet": () {
      switch (value) {
        case "createAnimationController":
          if (maps["0"] == null) {
            return null;
          }
          return BottomSheet.createAnimationController(
              getValue(maps["0"], datas, returnType, vars, props)!);
      }
    },
    "BottomSheetThemeData": () {
      switch (value) {
        case "lerp":
          if (maps["0"] == null || maps["1"] == null || maps["2"] == null) {
            return null;
          }
          return BottomSheetThemeData.lerp(
              getValue(maps["0"], datas, returnType, vars, props)!,
              getValue(maps["1"], datas, returnType, vars, props)!,
              getValue(maps["2"], datas, returnType, vars, props).toDouble()!);
      }
    },
    "BouncingScrollSimulation": () {
      switch (value) {
        case "maxSpringTransferVelocity":
          return BouncingScrollSimulation.maxSpringTransferVelocity;
      }
    },
    "BoxBorder": () {
      switch (value) {
        case "lerp":
          if (maps["0"] == null || maps["1"] == null || maps["2"] == null) {
            return null;
          }
          return BoxBorder.lerp(
              getValue(maps["0"], datas, returnType, vars, props)!,
              getValue(maps["1"], datas, returnType, vars, props)!,
              getValue(maps["2"], datas, returnType, vars, props).toDouble()!);
      }
    },
    "BoxConstraints": () {
      switch (value) {
        case "lerp":
          if (maps["0"] == null || maps["1"] == null || maps["2"] == null) {
            return null;
          }
          return BoxConstraints.lerp(
              getValue(maps["0"], datas, returnType, vars, props)!,
              getValue(maps["1"], datas, returnType, vars, props)!,
              getValue(maps["2"], datas, returnType, vars, props).toDouble()!);
      }
    },
    "BoxDecoration": () {
      switch (value) {
        case "lerp":
          if (maps["0"] == null || maps["1"] == null || maps["2"] == null) {
            return null;
          }
          return BoxDecoration.lerp(
              getValue(maps["0"], datas, returnType, vars, props)!,
              getValue(maps["1"], datas, returnType, vars, props)!,
              getValue(maps["2"], datas, returnType, vars, props).toDouble()!);
      }
    },
    "BoxShadow": () {
      switch (value) {
        case "lerp":
          if (maps["0"] == null || maps["1"] == null || maps["2"] == null) {
            return null;
          }
          return BoxShadow.lerp(
              getValue(maps["0"], datas, returnType, vars, props)!,
              getValue(maps["1"], datas, returnType, vars, props)!,
              getValue(maps["2"], datas, returnType, vars, props).toDouble()!);
        case "lerpList":
          if (maps["0"] == null || maps["1"] == null || maps["2"] == null) {
            return null;
          }
          return BoxShadow.lerpList(
              List<BoxShadow>.from(
                  getValue(maps["0"], datas, returnType, vars, props)),
              List<BoxShadow>.from(
                  getValue(maps["1"], datas, returnType, vars, props)),
              getValue(maps["2"], datas, returnType, vars, props).toDouble()!);
      }
    },
    "BrowserContextMenu": () {
      switch (value) {
        case "enabled":
          return BrowserContextMenu.enabled;
        case "disableContextMenu":
          return BrowserContextMenu.disableContextMenu();
        case "enableContextMenu":
          return BrowserContextMenu.enableContextMenu();
      }
    },
    "ButtonBarTheme": () {
      switch (value) {
        case "of":
          if (maps["0"] == null) {
            return null;
          }
          return ButtonBarTheme.of(
              getValue(maps["0"], datas, returnType, vars, props)!);
      }
    },
    "ButtonBarThemeData": () {
      switch (value) {
        case "lerp":
          if (maps["0"] == null || maps["1"] == null || maps["2"] == null) {
            return null;
          }
          return ButtonBarThemeData.lerp(
              getValue(maps["0"], datas, returnType, vars, props)!,
              getValue(maps["1"], datas, returnType, vars, props)!,
              getValue(maps["2"], datas, returnType, vars, props).toDouble()!);
      }
    },
    "ButtonStyle": () {
      switch (value) {
        case "lerp":
          if (maps["0"] == null || maps["1"] == null || maps["2"] == null) {
            return null;
          }
          return ButtonStyle.lerp(
              getValue(maps["0"], datas, returnType, vars, props)!,
              getValue(maps["1"], datas, returnType, vars, props)!,
              getValue(maps["2"], datas, returnType, vars, props).toDouble()!);
      }
    },
    "ButtonStyleButton": () {
      switch (value) {
        case "allOrNull":
          if (maps["0"] == null) {
            return null;
          }
          return ButtonStyleButton.allOrNull(
              getValue(maps["0"], datas, returnType, vars, props)!);
        case "scaledPadding":
          if (maps["0"] == null ||
              maps["1"] == null ||
              maps["2"] == null ||
              maps["3"] == null) {
            return null;
          }
          return ButtonStyleButton.scaledPadding(
              getValue(maps["0"], datas, returnType, vars, props)!,
              getValue(maps["1"], datas, returnType, vars, props)!,
              getValue(maps["2"], datas, returnType, vars, props)!,
              getValue(maps["3"], datas, returnType, vars, props).toDouble()!);
      }
    },
    "ButtonTheme": () {
      switch (value) {
        case "of":
          if (maps["0"] == null) {
            return null;
          }
          return ButtonTheme.of(
              getValue(maps["0"], datas, returnType, vars, props)!);
      }
    },
    "CardTheme": () {
      switch (value) {
        case "of":
          if (maps["0"] == null) {
            return null;
          }
          return CardTheme.of(
              getValue(maps["0"], datas, returnType, vars, props)!);
        case "lerp":
          if (maps["0"] == null || maps["1"] == null || maps["2"] == null) {
            return null;
          }
          return CardTheme.lerp(
              getValue(maps["0"], datas, returnType, vars, props)!,
              getValue(maps["1"], datas, returnType, vars, props)!,
              getValue(maps["2"], datas, returnType, vars, props).toDouble()!);
      }
    },
    "ChannelBuffers": () {
      switch (value) {
        case "kDefaultBufferSize":
          return ChannelBuffers.kDefaultBufferSize;
        case "kControlChannelName":
          return ChannelBuffers.kControlChannelName;
      }
    },
    "Checkbox": () {
      switch (value) {
        case "width":
          return Checkbox.width;
      }
    },
    "CheckboxTheme": () {
      switch (value) {
        case "of":
          if (maps["0"] == null) {
            return null;
          }
          return CheckboxTheme.of(
              getValue(maps["0"], datas, returnType, vars, props)!);
      }
    },
    "CheckboxThemeData": () {
      switch (value) {
        case "lerp":
          if (maps["0"] == null || maps["1"] == null || maps["2"] == null) {
            return null;
          }
          return CheckboxThemeData.lerp(
              getValue(maps["0"], datas, returnType, vars, props)!,
              getValue(maps["1"], datas, returnType, vars, props)!,
              getValue(maps["2"], datas, returnType, vars, props).toDouble()!);
      }
    },
    "ChildLayoutHelper": () {
      switch (value) {
        case "dryLayoutChild":
          if (maps["0"] == null || maps["1"] == null) {
            return null;
          }
          return ChildLayoutHelper.dryLayoutChild(
              getValue(maps["0"], datas, returnType, vars, props)!,
              getValue(maps["1"], datas, returnType, vars, props)!);
        case "layoutChild":
          if (maps["0"] == null || maps["1"] == null) {
            return null;
          }
          return ChildLayoutHelper.layoutChild(
              getValue(maps["0"], datas, returnType, vars, props)!,
              getValue(maps["1"], datas, returnType, vars, props)!);
      }
    },
    "ChipTheme": () {
      switch (value) {
        case "of":
          if (maps["0"] == null) {
            return null;
          }
          return ChipTheme.of(
              getValue(maps["0"], datas, returnType, vars, props)!);
      }
    },
    "ChipThemeData": () {
      switch (value) {
        case "lerp":
          if (maps["0"] == null || maps["1"] == null || maps["2"] == null) {
            return null;
          }
          return ChipThemeData.lerp(
              getValue(maps["0"], datas, returnType, vars, props)!,
              getValue(maps["1"], datas, returnType, vars, props)!,
              getValue(maps["2"], datas, returnType, vars, props).toDouble()!);
      }
    },
    "ClipPath": () {
      switch (value) {
        case "shape":
          if (maps["shape"] == null) {
            return null;
          }
          return ClipPath.shape(
              key: getValue(maps["key"], datas, returnType, vars, props),
              shape: getValue(maps["shape"], datas, returnType, vars, props)!,
              clipBehavior: getValue(
                      maps["clipBehavior"], datas, returnType, vars, props) ??
                  Clip.antiAlias,
              child: getValue(maps["child"], datas, returnType, vars, props));
      }
    },
    "Clipboard": () {
      switch (value) {
        case "kTextPlain":
          return Clipboard.kTextPlain;
        case "setData":
          if (maps["0"] == null) {
            return null;
          }
          return Clipboard.setData(
              getValue(maps["0"], datas, returnType, vars, props)!);
        case "getData":
          if (maps["0"] == null) {
            return null;
          }
          return Clipboard.getData(
              getValue(maps["0"], datas, returnType, vars, props)!);
        case "hasStrings":
          return Clipboard.hasStrings();
      }
    },
    "Color": () {
      switch (value) {
        case "lerp":
          if (maps["0"] == null || maps["1"] == null || maps["2"] == null) {
            return null;
          }
          return Color.lerp(
              getValue(maps["0"], datas, returnType, vars, props)!,
              getValue(maps["1"], datas, returnType, vars, props)!,
              getValue(maps["2"], datas, returnType, vars, props).toDouble()!);
        case "alphaBlend":
          if (maps["0"] == null || maps["1"] == null) {
            return null;
          }
          return Color.alphaBlend(
              getValue(maps["0"], datas, returnType, vars, props)!,
              getValue(maps["1"], datas, returnType, vars, props)!);
        case "getAlphaFromOpacity":
          if (maps["0"] == null) {
            return null;
          }
          return Color.getAlphaFromOpacity(
              getValue(maps["0"], datas, returnType, vars, props).toDouble()!);
      }
    },
    "ColorScheme": () {
      switch (value) {
        case "lerp":
          if (maps["0"] == null || maps["1"] == null || maps["2"] == null) {
            return null;
          }
          return ColorScheme.lerp(
              getValue(maps["0"], datas, returnType, vars, props)!,
              getValue(maps["1"], datas, returnType, vars, props)!,
              getValue(maps["2"], datas, returnType, vars, props).toDouble()!);
        case "fromImageProvider":
          if (maps["provider"] == null) {
            return null;
          }
          return ColorScheme.fromImageProvider(
              provider:
                  getValue(maps["provider"], datas, returnType, vars, props)!,
              brightness:
                  getValue(maps["brightness"], datas, returnType, vars, props) ??
                      Brightness.light,
              primary:
                  getValue(maps["primary"], datas, returnType, vars, props),
              onPrimary:
                  getValue(maps["onPrimary"], datas, returnType, vars, props),
              primaryContainer: getValue(
                  maps["primaryContainer"], datas, returnType, vars, props),
              onPrimaryContainer: getValue(
                  maps["onPrimaryContainer"], datas, returnType, vars, props),
              secondary:
                  getValue(maps["secondary"], datas, returnType, vars, props),
              onSecondary:
                  getValue(maps["onSecondary"], datas, returnType, vars, props),
              secondaryContainer: getValue(
                  maps["secondaryContainer"], datas, returnType, vars, props),
              onSecondaryContainer: getValue(
                  maps["onSecondaryContainer"], datas, returnType, vars, props),
              tertiary:
                  getValue(maps["tertiary"], datas, returnType, vars, props),
              onTertiary:
                  getValue(maps["onTertiary"], datas, returnType, vars, props),
              tertiaryContainer: getValue(
                  maps["tertiaryContainer"], datas, returnType, vars, props),
              onTertiaryContainer: getValue(
                  maps["onTertiaryContainer"], datas, returnType, vars, props),
              error: getValue(maps["error"], datas, returnType, vars, props),
              onError: getValue(maps["onError"], datas, returnType, vars, props),
              errorContainer: getValue(maps["errorContainer"], datas, returnType, vars, props),
              onErrorContainer: getValue(maps["onErrorContainer"], datas, returnType, vars, props),
              outline: getValue(maps["outline"], datas, returnType, vars, props),
              outlineVariant: getValue(maps["outlineVariant"], datas, returnType, vars, props),
              background: getValue(maps["background"], datas, returnType, vars, props),
              onBackground: getValue(maps["onBackground"], datas, returnType, vars, props),
              surface: getValue(maps["surface"], datas, returnType, vars, props),
              onSurface: getValue(maps["onSurface"], datas, returnType, vars, props),
              surfaceVariant: getValue(maps["surfaceVariant"], datas, returnType, vars, props),
              onSurfaceVariant: getValue(maps["onSurfaceVariant"], datas, returnType, vars, props),
              inverseSurface: getValue(maps["inverseSurface"], datas, returnType, vars, props),
              onInverseSurface: getValue(maps["onInverseSurface"], datas, returnType, vars, props),
              inversePrimary: getValue(maps["inversePrimary"], datas, returnType, vars, props),
              shadow: getValue(maps["shadow"], datas, returnType, vars, props),
              scrim: getValue(maps["scrim"], datas, returnType, vars, props),
              surfaceTint: getValue(maps["surfaceTint"], datas, returnType, vars, props));
      }
    },
    "Colors": () {
      switch (value) {
        case "transparent":
          return Colors.transparent;
        case "black":
          return Colors.black;
        case "black87":
          return Colors.black87;
        case "black54":
          return Colors.black54;
        case "black45":
          return Colors.black45;
        case "black38":
          return Colors.black38;
        case "black26":
          return Colors.black26;
        case "black12":
          return Colors.black12;
        case "white":
          return Colors.white;
        case "white70":
          return Colors.white70;
        case "white60":
          return Colors.white60;
        case "white54":
          return Colors.white54;
        case "white38":
          return Colors.white38;
        case "white30":
          return Colors.white30;
        case "white24":
          return Colors.white24;
        case "white12":
          return Colors.white12;
        case "white10":
          return Colors.white10;
        case "red":
          return Colors.red;
        case "redAccent":
          return Colors.redAccent;
        case "pink":
          return Colors.pink;
        case "pinkAccent":
          return Colors.pinkAccent;
        case "purple":
          return Colors.purple;
        case "purpleAccent":
          return Colors.purpleAccent;
        case "deepPurple":
          return Colors.deepPurple;
        case "deepPurpleAccent":
          return Colors.deepPurpleAccent;
        case "indigo":
          return Colors.indigo;
        case "indigoAccent":
          return Colors.indigoAccent;
        case "blue":
          return Colors.blue;
        case "blueAccent":
          return Colors.blueAccent;
        case "lightBlue":
          return Colors.lightBlue;
        case "lightBlueAccent":
          return Colors.lightBlueAccent;
        case "cyan":
          return Colors.cyan;
        case "cyanAccent":
          return Colors.cyanAccent;
        case "teal":
          return Colors.teal;
        case "tealAccent":
          return Colors.tealAccent;
        case "green":
          return Colors.green;
        case "greenAccent":
          return Colors.greenAccent;
        case "lightGreen":
          return Colors.lightGreen;
        case "lightGreenAccent":
          return Colors.lightGreenAccent;
        case "lime":
          return Colors.lime;
        case "limeAccent":
          return Colors.limeAccent;
        case "yellow":
          return Colors.yellow;
        case "yellowAccent":
          return Colors.yellowAccent;
        case "amber":
          return Colors.amber;
        case "amberAccent":
          return Colors.amberAccent;
        case "orange":
          return Colors.orange;
        case "orangeAccent":
          return Colors.orangeAccent;
        case "deepOrange":
          return Colors.deepOrange;
        case "deepOrangeAccent":
          return Colors.deepOrangeAccent;
        case "brown":
          return Colors.brown;
        case "grey":
          return Colors.grey;
        case "blueGrey":
          return Colors.blueGrey;
        case "primaries":
          return Colors.primaries;
        case "accents":
          return Colors.accents;
      }
    },
    "ConstraintsTransformBox": () {
      switch (value) {
        case "unmodified":
          if (maps["0"] == null) {
            return null;
          }
          return ConstraintsTransformBox.unmodified(
              getValue(maps["0"], datas, returnType, vars, props)!);
        case "unconstrained":
          if (maps["0"] == null) {
            return null;
          }
          return ConstraintsTransformBox.unconstrained(
              getValue(maps["0"], datas, returnType, vars, props)!);
        case "widthUnconstrained":
          if (maps["0"] == null) {
            return null;
          }
          return ConstraintsTransformBox.widthUnconstrained(
              getValue(maps["0"], datas, returnType, vars, props)!);
        case "heightUnconstrained":
          if (maps["0"] == null) {
            return null;
          }
          return ConstraintsTransformBox.heightUnconstrained(
              getValue(maps["0"], datas, returnType, vars, props)!);
        case "maxHeightUnconstrained":
          if (maps["0"] == null) {
            return null;
          }
          return ConstraintsTransformBox.maxHeightUnconstrained(
              getValue(maps["0"], datas, returnType, vars, props)!);
        case "maxWidthUnconstrained":
          if (maps["0"] == null) {
            return null;
          }
          return ConstraintsTransformBox.maxWidthUnconstrained(
              getValue(maps["0"], datas, returnType, vars, props)!);
        case "maxUnconstrained":
          if (maps["0"] == null) {
            return null;
          }
          return ConstraintsTransformBox.maxUnconstrained(
              getValue(maps["0"], datas, returnType, vars, props)!);
      }
    },
    "ContextMenuController": () {
      switch (value) {
        case "removeAny":
          return ContextMenuController.removeAny();
      }
    },
    "CopySelectionTextIntent": () {
      switch (value) {
        case "copy":
          return CopySelectionTextIntent.copy;
      }
    },
    "CupertinoAdaptiveTextSelectionToolbar": () {
      switch (value) {
        case "getAdaptiveButtons":
          if (maps["0"] == null || maps["1"] == null) {
            return null;
          }
          return CupertinoAdaptiveTextSelectionToolbar.getAdaptiveButtons(
              getValue(maps["0"], datas, returnType, vars, props)!,
              List<ContextMenuButtonItem>.from(
                  getValue(maps["1"], datas, returnType, vars, props)));
      }
    },
    "CupertinoApp": () {
      switch (value) {
        case "createCupertinoHeroController":
          return CupertinoApp.createCupertinoHeroController();
      }
    },
    "CupertinoCheckbox": () {
      switch (value) {
        case "width":
          return CupertinoCheckbox.width;
      }
    },
    "CupertinoColors": () {
      switch (value) {
        case "activeBlue":
          return CupertinoColors.activeBlue;
        case "activeGreen":
          return CupertinoColors.activeGreen;
        case "activeOrange":
          return CupertinoColors.activeOrange;
        case "white":
          return CupertinoColors.white;
        case "black":
          return CupertinoColors.black;
        case "lightBackgroundGray":
          return CupertinoColors.lightBackgroundGray;
        case "extraLightBackgroundGray":
          return CupertinoColors.extraLightBackgroundGray;
        case "darkBackgroundGray":
          return CupertinoColors.darkBackgroundGray;
        case "inactiveGray":
          return CupertinoColors.inactiveGray;
        case "destructiveRed":
          return CupertinoColors.destructiveRed;
        case "systemBlue":
          return CupertinoColors.systemBlue;
        case "systemGreen":
          return CupertinoColors.systemGreen;
        case "systemMint":
          return CupertinoColors.systemMint;
        case "systemIndigo":
          return CupertinoColors.systemIndigo;
        case "systemOrange":
          return CupertinoColors.systemOrange;
        case "systemPink":
          return CupertinoColors.systemPink;
        case "systemBrown":
          return CupertinoColors.systemBrown;
        case "systemPurple":
          return CupertinoColors.systemPurple;
        case "systemRed":
          return CupertinoColors.systemRed;
        case "systemTeal":
          return CupertinoColors.systemTeal;
        case "systemCyan":
          return CupertinoColors.systemCyan;
        case "systemYellow":
          return CupertinoColors.systemYellow;
        case "systemGrey":
          return CupertinoColors.systemGrey;
        case "systemGrey2":
          return CupertinoColors.systemGrey2;
        case "systemGrey3":
          return CupertinoColors.systemGrey3;
        case "systemGrey4":
          return CupertinoColors.systemGrey4;
        case "systemGrey5":
          return CupertinoColors.systemGrey5;
        case "systemGrey6":
          return CupertinoColors.systemGrey6;
        case "label":
          return CupertinoColors.label;
        case "secondaryLabel":
          return CupertinoColors.secondaryLabel;
        case "tertiaryLabel":
          return CupertinoColors.tertiaryLabel;
        case "quaternaryLabel":
          return CupertinoColors.quaternaryLabel;
        case "systemFill":
          return CupertinoColors.systemFill;
        case "secondarySystemFill":
          return CupertinoColors.secondarySystemFill;
        case "tertiarySystemFill":
          return CupertinoColors.tertiarySystemFill;
        case "quaternarySystemFill":
          return CupertinoColors.quaternarySystemFill;
        case "placeholderText":
          return CupertinoColors.placeholderText;
        case "systemBackground":
          return CupertinoColors.systemBackground;
        case "secondarySystemBackground":
          return CupertinoColors.secondarySystemBackground;
        case "tertiarySystemBackground":
          return CupertinoColors.tertiarySystemBackground;
        case "systemGroupedBackground":
          return CupertinoColors.systemGroupedBackground;
        case "secondarySystemGroupedBackground":
          return CupertinoColors.secondarySystemGroupedBackground;
        case "tertiarySystemGroupedBackground":
          return CupertinoColors.tertiarySystemGroupedBackground;
        case "separator":
          return CupertinoColors.separator;
        case "opaqueSeparator":
          return CupertinoColors.opaqueSeparator;
        case "link":
          return CupertinoColors.link;
      }
    },
    "CupertinoContextMenu": () {
      switch (value) {
        case "kOpenBorderRadius":
          return CupertinoContextMenu.kOpenBorderRadius;
        case "kEndBoxShadow":
          return CupertinoContextMenu.kEndBoxShadow;
        case "animationOpensAt":
          return CupertinoContextMenu.animationOpensAt;
      }
    },
    "CupertinoDynamicColor": () {
      switch (value) {
        case "resolve":
          if (maps["0"] == null || maps["1"] == null) {
            return null;
          }
          return CupertinoDynamicColor.resolve(
              getValue(maps["0"], datas, returnType, vars, props)!,
              getValue(maps["1"], datas, returnType, vars, props)!);
        case "maybeResolve":
          if (maps["0"] == null || maps["1"] == null) {
            return null;
          }
          return CupertinoDynamicColor.maybeResolve(
              getValue(maps["0"], datas, returnType, vars, props)!,
              getValue(maps["1"], datas, returnType, vars, props)!);
      }
    },
    "CupertinoLocalizations": () {
      switch (value) {
        case "of":
          if (maps["0"] == null) {
            return null;
          }
          return CupertinoLocalizations.of(
              getValue(maps["0"], datas, returnType, vars, props)!);
      }
    },
    "CupertinoMagnifier": () {
      switch (value) {
        case "kMagnifierAboveFocalPoint":
          return CupertinoMagnifier.kMagnifierAboveFocalPoint;
        case "kDefaultSize":
          return CupertinoMagnifier.kDefaultSize;
      }
    },
    "CupertinoScrollbar": () {
      switch (value) {
        case "defaultThickness":
          return CupertinoScrollbar.defaultThickness;
        case "defaultThicknessWhileDragging":
          return CupertinoScrollbar.defaultThicknessWhileDragging;
        case "defaultRadius":
          return CupertinoScrollbar.defaultRadius;
        case "defaultRadiusWhileDragging":
          return CupertinoScrollbar.defaultRadiusWhileDragging;
      }
    },
    "CupertinoSliverRefreshControl": () {
      switch (value) {
        case "state":
          if (maps["0"] == null) {
            return null;
          }
          return CupertinoSliverRefreshControl.state(
              getValue(maps["0"], datas, returnType, vars, props)!);
        case "buildRefreshIndicator":
          if (maps["0"] == null ||
              maps["1"] == null ||
              maps["2"] == null ||
              maps["3"] == null ||
              maps["4"] == null) {
            return null;
          }
          return CupertinoSliverRefreshControl.buildRefreshIndicator(
              getValue(maps["0"], datas, returnType, vars, props)!,
              getValue(maps["1"], datas, returnType, vars, props)!,
              getValue(maps["2"], datas, returnType, vars, props).toDouble()!,
              getValue(maps["3"], datas, returnType, vars, props).toDouble()!,
              getValue(maps["4"], datas, returnType, vars, props).toDouble()!);
      }
    },
    "CupertinoSpellCheckSuggestionsToolbar": () {
      switch (value) {
        case "buildButtonItems":
          if (maps["0"] == null) {
            return null;
          }
          return CupertinoSpellCheckSuggestionsToolbar.buildButtonItems(
              getValue(maps["0"], datas, returnType, vars, props)!);
      }
    },
    "CupertinoTextSelectionToolbar": () {
      switch (value) {
        case "kToolbarScreenPadding":
          return CupertinoTextSelectionToolbar.kToolbarScreenPadding;
      }
    },
    "CupertinoTextSelectionToolbarButton": () {
      switch (value) {
        case "getButtonLabel":
          if (maps["0"] == null || maps["1"] == null) {
            return null;
          }
          return CupertinoTextSelectionToolbarButton.getButtonLabel(
              getValue(maps["0"], datas, returnType, vars, props)!,
              getValue(maps["1"], datas, returnType, vars, props)!);
      }
    },
    "CupertinoTheme": () {
      switch (value) {
        case "of":
          if (maps["0"] == null) {
            return null;
          }
          return CupertinoTheme.of(
              getValue(maps["0"], datas, returnType, vars, props)!);
        case "brightnessOf":
          if (maps["0"] == null) {
            return null;
          }
          return CupertinoTheme.brightnessOf(
              getValue(maps["0"], datas, returnType, vars, props)!);
        case "maybeBrightnessOf":
          if (maps["0"] == null) {
            return null;
          }
          return CupertinoTheme.maybeBrightnessOf(
              getValue(maps["0"], datas, returnType, vars, props)!);
      }
    },
    "CupertinoThumbPainter": () {
      switch (value) {
        case "radius":
          return CupertinoThumbPainter.radius;
        case "extension":
          return CupertinoThumbPainter.extension;
      }
    },
    "CupertinoUserInterfaceLevel": () {
      switch (value) {
        case "of":
          if (maps["0"] == null) {
            return null;
          }
          return CupertinoUserInterfaceLevel.of(
              getValue(maps["0"], datas, returnType, vars, props)!);
        case "maybeOf":
          if (maps["0"] == null) {
            return null;
          }
          return CupertinoUserInterfaceLevel.maybeOf(
              getValue(maps["0"], datas, returnType, vars, props)!);
      }
    },
    "CustomSemanticsAction": () {
      switch (value) {
        case "getIdentifier":
          if (maps["0"] == null) {
            return null;
          }
          return CustomSemanticsAction.getIdentifier(
              getValue(maps["0"], datas, returnType, vars, props)!);
        case "getAction":
          if (maps["0"] == null) {
            return null;
          }
          return CustomSemanticsAction.getAction(
              getValue(maps["0"], datas, returnType, vars, props)!);
      }
    },
    "DartPluginRegistrant": () {
      switch (value) {
        case "ensureInitialized":
          return DartPluginRegistrant.ensureInitialized();
      }
    },
    "DataCell": () {
      switch (value) {
        case "empty":
          return DataCell.empty;
      }
    },
    "DataTableTheme": () {
      switch (value) {
        case "of":
          if (maps["0"] == null) {
            return null;
          }
          return DataTableTheme.of(
              getValue(maps["0"], datas, returnType, vars, props)!);
      }
    },
    "DatePickerTheme": () {
      switch (value) {
        case "of":
          if (maps["0"] == null) {
            return null;
          }
          return DatePickerTheme.of(
              getValue(maps["0"], datas, returnType, vars, props)!);
        case "maybeOf":
          if (maps["0"] == null) {
            return null;
          }
          return DatePickerTheme.maybeOf(
              getValue(maps["0"], datas, returnType, vars, props)!);
        case "defaults":
          if (maps["0"] == null) {
            return null;
          }
          return DatePickerTheme.defaults(
              getValue(maps["0"], datas, returnType, vars, props)!);
      }
    },
    "DatePickerThemeData": () {
      switch (value) {
        case "lerp":
          if (maps["0"] == null || maps["1"] == null || maps["2"] == null) {
            return null;
          }
          return DatePickerThemeData.lerp(
              getValue(maps["0"], datas, returnType, vars, props)!,
              getValue(maps["1"], datas, returnType, vars, props)!,
              getValue(maps["2"], datas, returnType, vars, props).toDouble()!);
      }
    },
    "DateUtils": () {
      switch (value) {
        case "dateOnly":
          if (maps["0"] == null) {
            return null;
          }
          return DateUtils.dateOnly(
              getValue(maps["0"], datas, returnType, vars, props)!);
        case "datesOnly":
          if (maps["0"] == null) {
            return null;
          }
          return DateUtils.datesOnly(
              getValue(maps["0"], datas, returnType, vars, props)!);
        case "isSameDay":
          if (maps["0"] == null || maps["1"] == null) {
            return null;
          }
          return DateUtils.isSameDay(
              getValue(maps["0"], datas, returnType, vars, props)!,
              getValue(maps["1"], datas, returnType, vars, props)!);
        case "isSameMonth":
          if (maps["0"] == null || maps["1"] == null) {
            return null;
          }
          return DateUtils.isSameMonth(
              getValue(maps["0"], datas, returnType, vars, props)!,
              getValue(maps["1"], datas, returnType, vars, props)!);
        case "monthDelta":
          if (maps["0"] == null || maps["1"] == null) {
            return null;
          }
          return DateUtils.monthDelta(
              getValue(maps["0"], datas, returnType, vars, props)!,
              getValue(maps["1"], datas, returnType, vars, props)!);
        case "addMonthsToMonthDate":
          if (maps["0"] == null || maps["1"] == null) {
            return null;
          }
          return DateUtils.addMonthsToMonthDate(
              getValue(maps["0"], datas, returnType, vars, props)!,
              getValue(maps["1"], datas, returnType, vars, props)!);
        case "addDaysToDate":
          if (maps["0"] == null || maps["1"] == null) {
            return null;
          }
          return DateUtils.addDaysToDate(
              getValue(maps["0"], datas, returnType, vars, props)!,
              getValue(maps["1"], datas, returnType, vars, props)!);
        case "firstDayOffset":
          if (maps["0"] == null || maps["1"] == null || maps["2"] == null) {
            return null;
          }
          return DateUtils.firstDayOffset(
              getValue(maps["0"], datas, returnType, vars, props)!,
              getValue(maps["1"], datas, returnType, vars, props)!,
              getValue(maps["2"], datas, returnType, vars, props)!);
        case "getDaysInMonth":
          if (maps["0"] == null || maps["1"] == null) {
            return null;
          }
          return DateUtils.getDaysInMonth(
              getValue(maps["0"], datas, returnType, vars, props)!,
              getValue(maps["1"], datas, returnType, vars, props)!);
      }
    },
    "Decoration": () {
      switch (value) {
        case "lerp":
          if (maps["0"] == null || maps["1"] == null || maps["2"] == null) {
            return null;
          }
          return Decoration.lerp(
              getValue(maps["0"], datas, returnType, vars, props)!,
              getValue(maps["1"], datas, returnType, vars, props)!,
              getValue(maps["2"], datas, returnType, vars, props).toDouble()!);
      }
    },
    "DefaultAssetBundle": () {
      switch (value) {
        case "of":
          if (maps["0"] == null) {
            return null;
          }
          return DefaultAssetBundle.of(
              getValue(maps["0"], datas, returnType, vars, props)!);
      }
    },
    "DefaultCupertinoLocalizations": () {
      switch (value) {
        case "shortWeekdays":
          return DefaultCupertinoLocalizations.shortWeekdays;
      }
    },
    "DefaultSelectionStyle": () {
      switch (value) {
        case "defaultColor":
          return DefaultSelectionStyle.defaultColor;
        case "of":
          if (maps["0"] == null) {
            return null;
          }
          return DefaultSelectionStyle.of(
              getValue(maps["0"], datas, returnType, vars, props)!);
      }
    },
    "DefaultSpellCheckService": () {
      switch (value) {
        case "mergeResults":
          if (maps["0"] == null || maps["1"] == null) {
            return null;
          }
          return DefaultSpellCheckService.mergeResults(
              List<SuggestionSpan>.from(
                  getValue(maps["0"], datas, returnType, vars, props)),
              List<SuggestionSpan>.from(
                  getValue(maps["1"], datas, returnType, vars, props)));
      }
    },
    "DefaultTabController": () {
      switch (value) {
        case "maybeOf":
          if (maps["0"] == null) {
            return null;
          }
          return DefaultTabController.maybeOf(
              getValue(maps["0"], datas, returnType, vars, props)!);
        case "of":
          if (maps["0"] == null) {
            return null;
          }
          return DefaultTabController.of(
              getValue(maps["0"], datas, returnType, vars, props)!);
      }
    },
    "DefaultTextHeightBehavior": () {
      switch (value) {
        case "maybeOf":
          if (maps["0"] == null) {
            return null;
          }
          return DefaultTextHeightBehavior.maybeOf(
              getValue(maps["0"], datas, returnType, vars, props)!);
        case "of":
          if (maps["0"] == null) {
            return null;
          }
          return DefaultTextHeightBehavior.of(
              getValue(maps["0"], datas, returnType, vars, props)!);
      }
    },
    "DefaultTextStyle": () {
      switch (value) {
        case "merge":
          if (maps["child"] == null) {
            return null;
          }
          return DefaultTextStyle.merge(
              key: getValue(maps["key"], datas, returnType, vars, props),
              style: getValue(maps["style"], datas, returnType, vars, props),
              textAlign:
                  getValue(maps["textAlign"], datas, returnType, vars, props),
              softWrap:
                  getValue(maps["softWrap"], datas, returnType, vars, props),
              overflow:
                  getValue(maps["overflow"], datas, returnType, vars, props),
              maxLines:
                  getValue(maps["maxLines"], datas, returnType, vars, props),
              textWidthBasis: getValue(
                  maps["textWidthBasis"], datas, returnType, vars, props),
              child: getValue(maps["child"], datas, returnType, vars, props)!);
        case "of":
          if (maps["0"] == null) {
            return null;
          }
          return DefaultTextStyle.of(
              getValue(maps["0"], datas, returnType, vars, props)!);
      }
    },
    "DefaultWidgetsLocalizations": () {
      switch (value) {
        case "load":
          if (maps["0"] == null) {
            return null;
          }
          return DefaultWidgetsLocalizations.load(
              getValue(maps["0"], datas, returnType, vars, props)!);
        case "delegate":
          return DefaultWidgetsLocalizations.delegate;
      }
    },
    "DeferredComponent": () {
      switch (value) {
        case "installDeferredComponent":
          if (maps["componentName"] == null) {
            return null;
          }
          return DeferredComponent.installDeferredComponent(
              componentName: getValue(
                  maps["componentName"], datas, returnType, vars, props)!);
        case "uninstallDeferredComponent":
          if (maps["componentName"] == null) {
            return null;
          }
          return DeferredComponent.uninstallDeferredComponent(
              componentName: getValue(
                  maps["componentName"], datas, returnType, vars, props)!);
      }
    },
    "DialogTheme": () {
      switch (value) {
        case "of":
          if (maps["0"] == null) {
            return null;
          }
          return DialogTheme.of(
              getValue(maps["0"], datas, returnType, vars, props)!);
        case "lerp":
          if (maps["0"] == null || maps["1"] == null || maps["2"] == null) {
            return null;
          }
          return DialogTheme.lerp(
              getValue(maps["0"], datas, returnType, vars, props)!,
              getValue(maps["1"], datas, returnType, vars, props)!,
              getValue(maps["2"], datas, returnType, vars, props).toDouble()!);
      }
    },
    "Directionality": () {
      switch (value) {
        case "of":
          if (maps["0"] == null) {
            return null;
          }
          return Directionality.of(
              getValue(maps["0"], datas, returnType, vars, props)!);
        case "maybeOf":
          if (maps["0"] == null) {
            return null;
          }
          return Directionality.maybeOf(
              getValue(maps["0"], datas, returnType, vars, props)!);
      }
    },
    "DisplayFeatureSubScreen": () {
      switch (value) {
        case "avoidBounds":
          if (maps["0"] == null) {
            return null;
          }
          return DisplayFeatureSubScreen.avoidBounds(
              getValue(maps["0"], datas, returnType, vars, props)!);
        case "subScreensInBounds":
          if (maps["0"] == null || maps["1"] == null) {
            return null;
          }
          return DisplayFeatureSubScreen.subScreensInBounds(
              getValue(maps["0"], datas, returnType, vars, props)!,
              getValue(maps["1"], datas, returnType, vars, props)!);
      }
    },
    "Divider": () {
      switch (value) {
        case "createBorderSide":
          if (maps["0"] == null) {
            return null;
          }
          return Divider.createBorderSide(
              getValue(maps["0"], datas, returnType, vars, props)!,
              color: getValue(maps["color"], datas, returnType, vars, props),
              width: getValue(maps["width"], datas, returnType, vars, props)
                  ?.toDouble());
      }
    },
    "DividerTheme": () {
      switch (value) {
        case "of":
          if (maps["0"] == null) {
            return null;
          }
          return DividerTheme.of(
              getValue(maps["0"], datas, returnType, vars, props)!);
      }
    },
    "DividerThemeData": () {
      switch (value) {
        case "lerp":
          if (maps["0"] == null || maps["1"] == null || maps["2"] == null) {
            return null;
          }
          return DividerThemeData.lerp(
              getValue(maps["0"], datas, returnType, vars, props)!,
              getValue(maps["1"], datas, returnType, vars, props)!,
              getValue(maps["2"], datas, returnType, vars, props).toDouble()!);
      }
    },
    "DraggableScrollableActuator": () {
      switch (value) {
        case "reset":
          if (maps["0"] == null) {
            return null;
          }
          return DraggableScrollableActuator.reset(
              getValue(maps["0"], datas, returnType, vars, props)!);
      }
    },
    "DrawerController": () {
      switch (value) {
        case "maybeOf":
          if (maps["0"] == null) {
            return null;
          }
          return DrawerController.maybeOf(
              getValue(maps["0"], datas, returnType, vars, props)!);
        case "of":
          if (maps["0"] == null) {
            return null;
          }
          return DrawerController.of(
              getValue(maps["0"], datas, returnType, vars, props)!);
      }
    },
    "DrawerTheme": () {
      switch (value) {
        case "of":
          if (maps["0"] == null) {
            return null;
          }
          return DrawerTheme.of(
              getValue(maps["0"], datas, returnType, vars, props)!);
      }
    },
    "DrawerThemeData": () {
      switch (value) {
        case "lerp":
          if (maps["0"] == null || maps["1"] == null || maps["2"] == null) {
            return null;
          }
          return DrawerThemeData.lerp(
              getValue(maps["0"], datas, returnType, vars, props)!,
              getValue(maps["1"], datas, returnType, vars, props)!,
              getValue(maps["2"], datas, returnType, vars, props).toDouble()!);
      }
    },
    "DropdownButtonHideUnderline": () {
      switch (value) {
        case "at":
          if (maps["0"] == null) {
            return null;
          }
          return DropdownButtonHideUnderline.at(
              getValue(maps["0"], datas, returnType, vars, props)!);
      }
    },
    "DropdownMenuTheme": () {
      switch (value) {
        case "of":
          if (maps["0"] == null) {
            return null;
          }
          return DropdownMenuTheme.of(
              getValue(maps["0"], datas, returnType, vars, props)!);
        case "maybeOf":
          if (maps["0"] == null) {
            return null;
          }
          return DropdownMenuTheme.maybeOf(
              getValue(maps["0"], datas, returnType, vars, props)!);
      }
    },
    "DropdownMenuThemeData": () {
      switch (value) {
        case "lerp":
          if (maps["0"] == null || maps["1"] == null || maps["2"] == null) {
            return null;
          }
          return DropdownMenuThemeData.lerp(
              getValue(maps["0"], datas, returnType, vars, props)!,
              getValue(maps["1"], datas, returnType, vars, props)!,
              getValue(maps["2"], datas, returnType, vars, props).toDouble()!);
      }
    },
    "Duration": () {
      switch (value) {
        case "microsecondsPerMillisecond":
          return Duration.microsecondsPerMillisecond;
        case "millisecondsPerSecond":
          return Duration.millisecondsPerSecond;
        case "secondsPerMinute":
          return Duration.secondsPerMinute;
        case "minutesPerHour":
          return Duration.minutesPerHour;
        case "hoursPerDay":
          return Duration.hoursPerDay;
        case "microsecondsPerSecond":
          return Duration.microsecondsPerSecond;
        case "microsecondsPerMinute":
          return Duration.microsecondsPerMinute;
        case "microsecondsPerHour":
          return Duration.microsecondsPerHour;
        case "microsecondsPerDay":
          return Duration.microsecondsPerDay;
        case "millisecondsPerMinute":
          return Duration.millisecondsPerMinute;
        case "millisecondsPerHour":
          return Duration.millisecondsPerHour;
        case "millisecondsPerDay":
          return Duration.millisecondsPerDay;
        case "secondsPerHour":
          return Duration.secondsPerHour;
        case "secondsPerDay":
          return Duration.secondsPerDay;
        case "minutesPerDay":
          return Duration.minutesPerDay;
        case "zero":
          return Duration.zero;
      }
    },
    "EdgeInsets": () {
      switch (value) {
        case "zero":
          return EdgeInsets.zero;
        case "lerp":
          if (maps["0"] == null || maps["1"] == null || maps["2"] == null) {
            return null;
          }
          return EdgeInsets.lerp(
              getValue(maps["0"], datas, returnType, vars, props)!,
              getValue(maps["1"], datas, returnType, vars, props)!,
              getValue(maps["2"], datas, returnType, vars, props).toDouble()!);
      }
    },
    "EdgeInsetsDirectional": () {
      switch (value) {
        case "zero":
          return EdgeInsetsDirectional.zero;
        case "lerp":
          if (maps["0"] == null || maps["1"] == null || maps["2"] == null) {
            return null;
          }
          return EdgeInsetsDirectional.lerp(
              getValue(maps["0"], datas, returnType, vars, props)!,
              getValue(maps["1"], datas, returnType, vars, props)!,
              getValue(maps["2"], datas, returnType, vars, props).toDouble()!);
      }
    },
    "EdgeInsetsGeometry": () {
      switch (value) {
        case "infinity":
          return EdgeInsetsGeometry.infinity;
        case "lerp":
          if (maps["0"] == null || maps["1"] == null || maps["2"] == null) {
            return null;
          }
          return EdgeInsetsGeometry.lerp(
              getValue(maps["0"], datas, returnType, vars, props)!,
              getValue(maps["1"], datas, returnType, vars, props)!,
              getValue(maps["2"], datas, returnType, vars, props).toDouble()!);
      }
    },
    "ElevatedButton": () {
      switch (value) {
        case "styleFrom":
          return ElevatedButton.styleFrom(
            foregroundColor: getValue(
                maps["foregroundColor"], datas, returnType, vars, props),
            backgroundColor: getValue(
                maps["backgroundColor"], datas, returnType, vars, props),
            disabledForegroundColor: getValue(maps["disabledForegroundColor"],
                datas, returnType, vars, props),
            disabledBackgroundColor: getValue(maps["disabledBackgroundColor"],
                datas, returnType, vars, props),
            shadowColor:
                getValue(maps["shadowColor"], datas, returnType, vars, props),
            surfaceTintColor: getValue(
                maps["surfaceTintColor"], datas, returnType, vars, props),
            elevation:
                getValue(maps["elevation"], datas, returnType, vars, props)
                    ?.toDouble(),
            textStyle:
                getValue(maps["textStyle"], datas, returnType, vars, props),
            padding: getValue(maps["padding"], datas, returnType, vars, props),
            minimumSize:
                getValue(maps["minimumSize"], datas, returnType, vars, props),
            fixedSize:
                getValue(maps["fixedSize"], datas, returnType, vars, props),
            maximumSize:
                getValue(maps["maximumSize"], datas, returnType, vars, props),
            side: getValue(maps["side"], datas, returnType, vars, props),
            shape: getValue(maps["shape"], datas, returnType, vars, props),
            enabledMouseCursor: getValue(
                maps["enabledMouseCursor"], datas, returnType, vars, props),
            disabledMouseCursor: getValue(
                maps["disabledMouseCursor"], datas, returnType, vars, props),
            visualDensity:
                getValue(maps["visualDensity"], datas, returnType, vars, props),
            tapTargetSize:
                getValue(maps["tapTargetSize"], datas, returnType, vars, props),
            animationDuration: getValue(
                maps["animationDuration"], datas, returnType, vars, props),
            enableFeedback: getValue(
                maps["enableFeedback"], datas, returnType, vars, props),
            alignment:
                getValue(maps["alignment"], datas, returnType, vars, props),
            splashFactory:
                getValue(maps["splashFactory"], datas, returnType, vars, props),
            // primary: getValue(maps["primary"], datas, returnType, vars, props),
            // onPrimary: getValue(maps["onPrimary"], datas, returnType, vars, props),
            // onSurface: getValue(maps["onSurface"], datas, returnType, vars, props),
          );
      }
    },
    "ElevatedButtonTheme": () {
      switch (value) {
        case "of":
          if (maps["0"] == null) {
            return null;
          }
          return ElevatedButtonTheme.of(
              getValue(maps["0"], datas, returnType, vars, props)!);
      }
    },
    "ElevatedButtonThemeData": () {
      switch (value) {
        case "lerp":
          if (maps["0"] == null || maps["1"] == null || maps["2"] == null) {
            return null;
          }
          return ElevatedButtonThemeData.lerp(
              getValue(maps["0"], datas, returnType, vars, props)!,
              getValue(maps["1"], datas, returnType, vars, props)!,
              getValue(maps["2"], datas, returnType, vars, props).toDouble()!);
      }
    },
    "ElevationOverlay": () {
      switch (value) {
        case "applySurfaceTint":
          if (maps["0"] == null || maps["1"] == null || maps["2"] == null) {
            return null;
          }
          return ElevationOverlay.applySurfaceTint(
              getValue(maps["0"], datas, returnType, vars, props)!,
              getValue(maps["1"], datas, returnType, vars, props)!,
              getValue(maps["2"], datas, returnType, vars, props).toDouble()!);
        case "applyOverlay":
          if (maps["0"] == null || maps["1"] == null || maps["2"] == null) {
            return null;
          }
          return ElevationOverlay.applyOverlay(
              getValue(maps["0"], datas, returnType, vars, props)!,
              getValue(maps["1"], datas, returnType, vars, props)!,
              getValue(maps["2"], datas, returnType, vars, props).toDouble()!);
        case "overlayColor":
          if (maps["0"] == null || maps["1"] == null) {
            return null;
          }
          return ElevationOverlay.overlayColor(
              getValue(maps["0"], datas, returnType, vars, props)!,
              getValue(maps["1"], datas, returnType, vars, props).toDouble()!);
        case "colorWithOverlay":
          if (maps["0"] == null || maps["1"] == null || maps["2"] == null) {
            return null;
          }
          return ElevationOverlay.colorWithOverlay(
              getValue(maps["0"], datas, returnType, vars, props)!,
              getValue(maps["1"], datas, returnType, vars, props)!,
              getValue(maps["2"], datas, returnType, vars, props).toDouble()!);
      }
    },
    "Error": () {
      switch (value) {
        case "safeToString":
          if (maps["0"] == null) {
            return null;
          }
          return Error.safeToString(
              getValue(maps["0"], datas, returnType, vars, props)!);
        case "throwWithStackTrace":
          if (maps["0"] == null || maps["1"] == null) {
            return null;
          }
          return Error.throwWithStackTrace(
              getValue(maps["0"], datas, returnType, vars, props)!,
              getValue(maps["1"], datas, returnType, vars, props)!);
      }
    },
    "ExpansionTileController": () {
      switch (value) {
        case "of":
          if (maps["0"] == null) {
            return null;
          }
          return ExpansionTileController.of(
              getValue(maps["0"], datas, returnType, vars, props)!);
        case "maybeOf":
          if (maps["0"] == null) {
            return null;
          }
          return ExpansionTileController.maybeOf(
              getValue(maps["0"], datas, returnType, vars, props)!);
      }
    },
    "ExpansionTileTheme": () {
      switch (value) {
        case "of":
          if (maps["0"] == null) {
            return null;
          }
          return ExpansionTileTheme.of(
              getValue(maps["0"], datas, returnType, vars, props)!);
      }
    },
    "ExpansionTileThemeData": () {
      switch (value) {
        case "lerp":
          if (maps["0"] == null || maps["1"] == null || maps["2"] == null) {
            return null;
          }
          return ExpansionTileThemeData.lerp(
              getValue(maps["0"], datas, returnType, vars, props)!,
              getValue(maps["1"], datas, returnType, vars, props)!,
              getValue(maps["2"], datas, returnType, vars, props).toDouble()!);
      }
    },
    "Feedback": () {
      switch (value) {
        case "forTap":
          if (maps["0"] == null) {
            return null;
          }
          return Feedback.forTap(
              getValue(maps["0"], datas, returnType, vars, props)!);
        case "wrapForTap":
          if (maps["0"] == null || maps["1"] == null) {
            return null;
          }
          return Feedback.wrapForTap(
              getValue(maps["0"], datas, returnType, vars, props)!,
              getValue(maps["1"], datas, returnType, vars, props)!);
        case "forLongPress":
          if (maps["0"] == null) {
            return null;
          }
          return Feedback.forLongPress(
              getValue(maps["0"], datas, returnType, vars, props)!);
        case "wrapForLongPress":
          if (maps["0"] == null || maps["1"] == null) {
            return null;
          }
          return Feedback.wrapForLongPress(
              getValue(maps["0"], datas, returnType, vars, props)!,
              getValue(maps["1"], datas, returnType, vars, props)!);
      }
    },
    "FilledButton": () {
      switch (value) {
        case "styleFrom":
          return FilledButton.styleFrom(
              foregroundColor: getValue(
                  maps["foregroundColor"], datas, returnType, vars, props),
              backgroundColor: getValue(
                  maps["backgroundColor"], datas, returnType, vars, props),
              disabledForegroundColor: getValue(maps["disabledForegroundColor"],
                  datas, returnType, vars, props),
              disabledBackgroundColor: getValue(maps["disabledBackgroundColor"],
                  datas, returnType, vars, props),
              shadowColor:
                  getValue(maps["shadowColor"], datas, returnType, vars, props),
              surfaceTintColor: getValue(
                  maps["surfaceTintColor"], datas, returnType, vars, props),
              elevation: getValue(maps["elevation"], datas, returnType, vars, props)
                  ?.toDouble(),
              textStyle:
                  getValue(maps["textStyle"], datas, returnType, vars, props),
              padding:
                  getValue(maps["padding"], datas, returnType, vars, props),
              minimumSize:
                  getValue(maps["minimumSize"], datas, returnType, vars, props),
              fixedSize:
                  getValue(maps["fixedSize"], datas, returnType, vars, props),
              maximumSize:
                  getValue(maps["maximumSize"], datas, returnType, vars, props),
              side: getValue(maps["side"], datas, returnType, vars, props),
              shape: getValue(maps["shape"], datas, returnType, vars, props),
              enabledMouseCursor: getValue(
                  maps["enabledMouseCursor"], datas, returnType, vars, props),
              disabledMouseCursor: getValue(
                  maps["disabledMouseCursor"], datas, returnType, vars, props),
              visualDensity: getValue(
                  maps["visualDensity"], datas, returnType, vars, props),
              tapTargetSize: getValue(
                  maps["tapTargetSize"], datas, returnType, vars, props),
              animationDuration: getValue(
                  maps["animationDuration"], datas, returnType, vars, props),
              enableFeedback: getValue(maps["enableFeedback"], datas, returnType, vars, props),
              alignment: getValue(maps["alignment"], datas, returnType, vars, props),
              splashFactory: getValue(maps["splashFactory"], datas, returnType, vars, props));
      }
    },
    "FilledButtonTheme": () {
      switch (value) {
        case "of":
          if (maps["0"] == null) {
            return null;
          }
          return FilledButtonTheme.of(
              getValue(maps["0"], datas, returnType, vars, props)!);
      }
    },
    "FilledButtonThemeData": () {
      switch (value) {
        case "lerp":
          if (maps["0"] == null || maps["1"] == null || maps["2"] == null) {
            return null;
          }
          return FilledButtonThemeData.lerp(
              getValue(maps["0"], datas, returnType, vars, props)!,
              getValue(maps["1"], datas, returnType, vars, props)!,
              getValue(maps["2"], datas, returnType, vars, props).toDouble()!);
      }
    },
    "FilteringTextInputFormatter": () {
      switch (value) {
        case "singleLineFormatter":
          return FilteringTextInputFormatter.singleLineFormatter;
        case "digitsOnly":
          return FilteringTextInputFormatter.digitsOnly;
      }
    },
    "FlexibleSpaceBar": () {
      switch (value) {
        case "createSettings":
          if (maps["currentExtent"] == null || maps["child"] == null) {
            return null;
          }
          return FlexibleSpaceBar.createSettings(
              toolbarOpacity: getValue(
                      maps["toolbarOpacity"], datas, returnType, vars, props)
                  ?.toDouble(),
              minExtent:
                  getValue(maps["minExtent"], datas, returnType, vars, props)
                      ?.toDouble(),
              maxExtent:
                  getValue(maps["maxExtent"], datas, returnType, vars, props)
                      ?.toDouble(),
              isScrolledUnder: getValue(
                  maps["isScrolledUnder"], datas, returnType, vars, props),
              currentExtent: getValue(
                      maps["currentExtent"], datas, returnType, vars, props)
                  .toDouble()!,
              child: getValue(maps["child"], datas, returnType, vars, props)!);
      }
    },
    "FloatingActionButtonAnimator": () {
      switch (value) {
        case "scaling":
          return FloatingActionButtonAnimator.scaling;
      }
    },
    "FloatingActionButtonLocation": () {
      switch (value) {
        case "startTop":
          return FloatingActionButtonLocation.startTop;
        case "miniStartTop":
          return FloatingActionButtonLocation.miniStartTop;
        case "centerTop":
          return FloatingActionButtonLocation.centerTop;
        case "miniCenterTop":
          return FloatingActionButtonLocation.miniCenterTop;
        case "endTop":
          return FloatingActionButtonLocation.endTop;
        case "miniEndTop":
          return FloatingActionButtonLocation.miniEndTop;
        case "startFloat":
          return FloatingActionButtonLocation.startFloat;
        case "miniStartFloat":
          return FloatingActionButtonLocation.miniStartFloat;
        case "centerFloat":
          return FloatingActionButtonLocation.centerFloat;
        case "miniCenterFloat":
          return FloatingActionButtonLocation.miniCenterFloat;
        case "endFloat":
          return FloatingActionButtonLocation.endFloat;
        case "miniEndFloat":
          return FloatingActionButtonLocation.miniEndFloat;
        case "startDocked":
          return FloatingActionButtonLocation.startDocked;
        case "miniStartDocked":
          return FloatingActionButtonLocation.miniStartDocked;
        case "centerDocked":
          return FloatingActionButtonLocation.centerDocked;
        case "miniCenterDocked":
          return FloatingActionButtonLocation.miniCenterDocked;
        case "endDocked":
          return FloatingActionButtonLocation.endDocked;
        case "miniEndDocked":
          return FloatingActionButtonLocation.miniEndDocked;
        case "endContained":
          return FloatingActionButtonLocation.endContained;
      }
    },
    "FloatingActionButtonThemeData": () {
      switch (value) {
        case "lerp":
          if (maps["0"] == null || maps["1"] == null || maps["2"] == null) {
            return null;
          }
          return FloatingActionButtonThemeData.lerp(
              getValue(maps["0"], datas, returnType, vars, props)!,
              getValue(maps["1"], datas, returnType, vars, props)!,
              getValue(maps["2"], datas, returnType, vars, props).toDouble()!);
      }
    },
    "FloatingLabelAlignment": () {
      switch (value) {
        case "start":
          return FloatingLabelAlignment.start;
        case "center":
          return FloatingLabelAlignment.center;
      }
    },
    "FlutterErrorDetails": () {
      switch (value) {
        case "propertiesTransformers":
          return FlutterErrorDetails.propertiesTransformers;
      }
    },
    "FlutterLogoDecoration": () {
      switch (value) {
        case "lerp":
          if (maps["0"] == null || maps["1"] == null || maps["2"] == null) {
            return null;
          }
          return FlutterLogoDecoration.lerp(
              getValue(maps["0"], datas, returnType, vars, props)!,
              getValue(maps["1"], datas, returnType, vars, props)!,
              getValue(maps["2"], datas, returnType, vars, props).toDouble()!);
      }
    },
    "Focus": () {
      switch (value) {
        case "of":
          if (maps["0"] == null) {
            return null;
          }
          return Focus.of(getValue(maps["0"], datas, returnType, vars, props)!,
              scopeOk:
                  getValue(maps["scopeOk"], datas, returnType, vars, props) ??
                      false,
              createDependency: getValue(maps["createDependency"], datas,
                      returnType, vars, props) ??
                  true);
        case "maybeOf":
          if (maps["0"] == null) {
            return null;
          }
          return Focus.maybeOf(
              getValue(maps["0"], datas, returnType, vars, props)!,
              scopeOk:
                  getValue(maps["scopeOk"], datas, returnType, vars, props) ??
                      false,
              createDependency: getValue(maps["createDependency"], datas,
                      returnType, vars, props) ??
                  true);
        case "isAt":
          if (maps["0"] == null) {
            return null;
          }
          return Focus.isAt(
              getValue(maps["0"], datas, returnType, vars, props)!);
      }
    },
    "FocusManager": () {
      switch (value) {
        case "instance":
          return FocusManager.instance;
      }
    },
    "FocusScope": () {
      switch (value) {
        case "of":
          if (maps["0"] == null) {
            return null;
          }
          return FocusScope.of(
              getValue(maps["0"], datas, returnType, vars, props)!,
              createDependency: getValue(maps["createDependency"], datas,
                      returnType, vars, props) ??
                  true);
      }
    },
    "FocusTraversalGroup": () {
      switch (value) {
        case "maybeOfNode":
          if (maps["0"] == null) {
            return null;
          }
          return FocusTraversalGroup.maybeOfNode(
              getValue(maps["0"], datas, returnType, vars, props)!);
        case "of":
          if (maps["0"] == null) {
            return null;
          }
          return FocusTraversalGroup.of(
              getValue(maps["0"], datas, returnType, vars, props)!);
        case "maybeOf":
          if (maps["0"] == null) {
            return null;
          }
          return FocusTraversalGroup.maybeOf(
              getValue(maps["0"], datas, returnType, vars, props)!);
      }
    },
    "FocusTraversalOrder": () {
      switch (value) {
        case "of":
          if (maps["0"] == null) {
            return null;
          }
          return FocusTraversalOrder.of(
              getValue(maps["0"], datas, returnType, vars, props)!);
        case "maybeOf":
          if (maps["0"] == null) {
            return null;
          }
          return FocusTraversalOrder.maybeOf(
              getValue(maps["0"], datas, returnType, vars, props)!);
      }
    },
    "FontWeight": () {
      switch (value) {
        case "w100":
          return FontWeight.w100;
        case "w200":
          return FontWeight.w200;
        case "w300":
          return FontWeight.w300;
        case "w400":
          return FontWeight.w400;
        case "w500":
          return FontWeight.w500;
        case "w600":
          return FontWeight.w600;
        case "w700":
          return FontWeight.w700;
        case "w800":
          return FontWeight.w800;
        case "w900":
          return FontWeight.w900;
        case "normal":
          return FontWeight.normal;
        case "bold":
          return FontWeight.bold;
        case "values":
          return FontWeight.values;
        case "lerp":
          if (maps["0"] == null || maps["1"] == null || maps["2"] == null) {
            return null;
          }
          return FontWeight.lerp(
              getValue(maps["0"], datas, returnType, vars, props)!,
              getValue(maps["1"], datas, returnType, vars, props)!,
              getValue(maps["2"], datas, returnType, vars, props).toDouble()!);
      }
    },
    "Form": () {
      switch (value) {
        case "maybeOf":
          if (maps["0"] == null) {
            return null;
          }
          return Form.maybeOf(
              getValue(maps["0"], datas, returnType, vars, props)!);
        case "of":
          if (maps["0"] == null) {
            return null;
          }
          return Form.of(getValue(maps["0"], datas, returnType, vars, props)!);
      }
    },
    "FractionalOffset": () {
      switch (value) {
        case "topLeft":
          return FractionalOffset.topLeft;
        case "topCenter":
          return FractionalOffset.topCenter;
        case "topRight":
          return FractionalOffset.topRight;
        case "centerLeft":
          return FractionalOffset.centerLeft;
        case "center":
          return FractionalOffset.center;
        case "centerRight":
          return FractionalOffset.centerRight;
        case "bottomLeft":
          return FractionalOffset.bottomLeft;
        case "bottomCenter":
          return FractionalOffset.bottomCenter;
        case "bottomRight":
          return FractionalOffset.bottomRight;
        case "lerp":
          if (maps["0"] == null || maps["1"] == null || maps["2"] == null) {
            return null;
          }
          return FractionalOffset.lerp(
              getValue(maps["0"], datas, returnType, vars, props)!,
              getValue(maps["1"], datas, returnType, vars, props)!,
              getValue(maps["2"], datas, returnType, vars, props).toDouble()!);
      }
    },
    "FragmentProgram": () {
      switch (value) {
        case "fromAsset":
          if (maps["0"] == null) {
            return null;
          }
          return FragmentProgram.fromAsset(
              getValue(maps["0"], datas, returnType, vars, props)!);
      }
    },
    "Function": () {
      switch (value) {
        case "apply":
          if (maps["0"] == null || maps["1"] == null) {
            return null;
          }
          return Function.apply(
              getValue(maps["0"], datas, returnType, vars, props)!,
              List<dynamic>.from(
                  getValue(maps["1"], datas, returnType, vars, props)),
              getValue(maps["3"], datas, returnType, vars, props) != null
                  ? Map<Symbol, dynamic>.from(
                      getValue(maps["3"], datas, returnType, vars, props))
                  : null);
      }
    },
    "FutureBuilder": () {
      switch (value) {
        case "debugRethrowError":
          return FutureBuilder.debugRethrowError;
      }
    },
    "GLFWKeyHelper": () {
      switch (value) {
        case "modifierCapsLock":
          return GLFWKeyHelper.modifierCapsLock;
        case "modifierShift":
          return GLFWKeyHelper.modifierShift;
        case "modifierControl":
          return GLFWKeyHelper.modifierControl;
        case "modifierAlt":
          return GLFWKeyHelper.modifierAlt;
        case "modifierMeta":
          return GLFWKeyHelper.modifierMeta;
        case "modifierNumericPad":
          return GLFWKeyHelper.modifierNumericPad;
      }
    },
    "GtkKeyHelper": () {
      switch (value) {
        case "modifierShift":
          return GtkKeyHelper.modifierShift;
        case "modifierCapsLock":
          return GtkKeyHelper.modifierCapsLock;
        case "modifierControl":
          return GtkKeyHelper.modifierControl;
        case "modifierMod1":
          return GtkKeyHelper.modifierMod1;
        case "modifierMod2":
          return GtkKeyHelper.modifierMod2;
        case "modifierMeta":
          return GtkKeyHelper.modifierMeta;
      }
    },
    "HSVColor": () {
      switch (value) {
        case "lerp":
          if (maps["0"] == null || maps["1"] == null || maps["2"] == null) {
            return null;
          }
          return HSVColor.lerp(
              getValue(maps["0"], datas, returnType, vars, props)!,
              getValue(maps["1"], datas, returnType, vars, props)!,
              getValue(maps["2"], datas, returnType, vars, props).toDouble()!);
      }
    },
    "HapticFeedback": () {
      switch (value) {
        case "vibrate":
          return HapticFeedback.vibrate();
        case "lightImpact":
          return HapticFeedback.lightImpact();
        case "mediumImpact":
          return HapticFeedback.mediumImpact();
        case "heavyImpact":
          return HapticFeedback.heavyImpact();
        case "selectionClick":
          return HapticFeedback.selectionClick();
      }
    },
    "HardwareKeyboard": () {
      switch (value) {
        case "instance":
          return HardwareKeyboard.instance;
      }
    },
    "HeroControllerScope": () {
      switch (value) {
        case "maybeOf":
          if (maps["0"] == null) {
            return null;
          }
          return HeroControllerScope.maybeOf(
              getValue(maps["0"], datas, returnType, vars, props)!);
        case "of":
          if (maps["0"] == null) {
            return null;
          }
          return HeroControllerScope.of(
              getValue(maps["0"], datas, returnType, vars, props)!);
      }
    },
    "IconButton": () {
      switch (value) {
        case "styleFrom":
          return IconButton.styleFrom(
              foregroundColor: getValue(
                  maps["foregroundColor"], datas, returnType, vars, props),
              backgroundColor: getValue(
                  maps["backgroundColor"], datas, returnType, vars, props),
              disabledForegroundColor: getValue(maps["disabledForegroundColor"],
                  datas, returnType, vars, props),
              disabledBackgroundColor: getValue(maps["disabledBackgroundColor"],
                  datas, returnType, vars, props),
              focusColor:
                  getValue(maps["focusColor"], datas, returnType, vars, props),
              hoverColor:
                  getValue(maps["hoverColor"], datas, returnType, vars, props),
              highlightColor: getValue(
                  maps["highlightColor"], datas, returnType, vars, props),
              shadowColor:
                  getValue(maps["shadowColor"], datas, returnType, vars, props),
              surfaceTintColor: getValue(
                  maps["surfaceTintColor"], datas, returnType, vars, props),
              elevation:
                  getValue(maps["elevation"], datas, returnType, vars, props)
                      ?.toDouble(),
              minimumSize:
                  getValue(maps["minimumSize"], datas, returnType, vars, props),
              fixedSize:
                  getValue(maps["fixedSize"], datas, returnType, vars, props),
              maximumSize:
                  getValue(maps["maximumSize"], datas, returnType, vars, props),
              iconSize: getValue(maps["iconSize"], datas, returnType, vars, props)
                  ?.toDouble(),
              side: getValue(maps["side"], datas, returnType, vars, props),
              shape: getValue(maps["shape"], datas, returnType, vars, props),
              padding:
                  getValue(maps["padding"], datas, returnType, vars, props),
              enabledMouseCursor: getValue(
                  maps["enabledMouseCursor"], datas, returnType, vars, props),
              disabledMouseCursor: getValue(
                  maps["disabledMouseCursor"], datas, returnType, vars, props),
              visualDensity: getValue(
                  maps["visualDensity"], datas, returnType, vars, props),
              tapTargetSize:
                  getValue(maps["tapTargetSize"], datas, returnType, vars, props),
              animationDuration: getValue(maps["animationDuration"], datas, returnType, vars, props),
              enableFeedback: getValue(maps["enableFeedback"], datas, returnType, vars, props),
              alignment: getValue(maps["alignment"], datas, returnType, vars, props),
              splashFactory: getValue(maps["splashFactory"], datas, returnType, vars, props));
      }
    },
    "IconButtonTheme": () {
      switch (value) {
        case "of":
          if (maps["0"] == null) {
            return null;
          }
          return IconButtonTheme.of(
              getValue(maps["0"], datas, returnType, vars, props)!);
      }
    },
    "IconButtonThemeData": () {
      switch (value) {
        case "lerp":
          if (maps["0"] == null || maps["1"] == null || maps["2"] == null) {
            return null;
          }
          return IconButtonThemeData.lerp(
              getValue(maps["0"], datas, returnType, vars, props)!,
              getValue(maps["1"], datas, returnType, vars, props)!,
              getValue(maps["2"], datas, returnType, vars, props).toDouble()!);
      }
    },
    "IconTheme": () {
      switch (value) {
        case "merge":
          if (maps["data"] == null || maps["child"] == null) {
            return null;
          }
          return IconTheme.merge(
              key: getValue(maps["key"], datas, returnType, vars, props),
              data: getValue(maps["data"], datas, returnType, vars, props)!,
              child: getValue(maps["child"], datas, returnType, vars, props)!);
        case "of":
          if (maps["0"] == null) {
            return null;
          }
          return IconTheme.of(
              getValue(maps["0"], datas, returnType, vars, props)!);
      }
    },
    "IconThemeData": () {
      switch (value) {
        case "lerp":
          if (maps["0"] == null || maps["1"] == null || maps["2"] == null) {
            return null;
          }
          return IconThemeData.lerp(
              getValue(maps["0"], datas, returnType, vars, props)!,
              getValue(maps["1"], datas, returnType, vars, props)!,
              getValue(maps["2"], datas, returnType, vars, props).toDouble()!);
      }
    },
    "ImageConfiguration": () {
      switch (value) {
        case "empty":
          return ImageConfiguration.empty;
      }
    },
    "ImageDescriptor": () {
      switch (value) {
        case "encoded":
          if (maps["0"] == null) {
            return null;
          }
          return ImageDescriptor.encoded(
              getValue(maps["0"], datas, returnType, vars, props)!);
      }
    },
    "ImmutableBuffer": () {
      switch (value) {
        case "fromUint8List":
          if (maps["0"] == null) {
            return null;
          }
          return ImmutableBuffer.fromUint8List(
              getValue(maps["0"], datas, returnType, vars, props)!);
        case "fromAsset":
          if (maps["0"] == null) {
            return null;
          }
          return ImmutableBuffer.fromAsset(
              getValue(maps["0"], datas, returnType, vars, props)!);
        case "fromFilePath":
          if (maps["0"] == null) {
            return null;
          }
          return ImmutableBuffer.fromFilePath(
              getValue(maps["0"], datas, returnType, vars, props)!);
      }
    },
    "InheritedModel": () {
      switch (value) {
        case "inheritFrom":
          if (maps["0"] == null) {
            return null;
          }
          return InheritedModel.inheritFrom(
              getValue(maps["0"], datas, returnType, vars, props)!,
              aspect: getValue(maps["aspect"], datas, returnType, vars, props));
      }
    },
    "InheritedTheme": () {
      switch (value) {
        case "captureAll":
          if (maps["0"] == null || maps["1"] == null) {
            return null;
          }
          return InheritedTheme.captureAll(
              getValue(maps["0"], datas, returnType, vars, props)!,
              getValue(maps["1"], datas, returnType, vars, props)!,
              to: getValue(maps["to"], datas, returnType, vars, props));
        case "capture":
          if (maps["from"] == null || maps["to"] == null) {
            return null;
          }
          return InheritedTheme.capture(
              from: getValue(maps["from"], datas, returnType, vars, props)!,
              to: getValue(maps["to"], datas, returnType, vars, props)!);
      }
    },
    "InkRipple": () {
      switch (value) {
        case "splashFactory":
          return InkRipple.splashFactory;
      }
    },
    "InkSparkle": () {
      switch (value) {
        case "splashFactory":
          return InkSparkle.splashFactory;
        case "constantTurbulenceSeedSplashFactory":
          return InkSparkle.constantTurbulenceSeedSplashFactory;
      }
    },
    "InkSplash": () {
      switch (value) {
        case "splashFactory":
          return InkSplash.splashFactory;
      }
    },
    "InlineSpanSemanticsInformation": () {
      switch (value) {
        case "placeholder":
          return InlineSpanSemanticsInformation.placeholder;
      }
    },
    "InputBorder": () {
      switch (value) {
        case "none":
          return InputBorder.none;
      }
    },
    "InputDecorator": () {
      switch (value) {
        case "containerOf":
          if (maps["0"] == null) {
            return null;
          }
          return InputDecorator.containerOf(
              getValue(maps["0"], datas, returnType, vars, props)!);
      }
    },
    "Intent": () {
      switch (value) {
        case "doNothing":
          return Intent.doNothing;
      }
    },
    "InteractiveViewer": () {
      switch (value) {
        case "getNearestPointOnLine":
          if (maps["0"] == null || maps["1"] == null || maps["2"] == null) {
            return null;
          }
          return InteractiveViewer.getNearestPointOnLine(
              getValue(maps["0"], datas, returnType, vars, props)!,
              getValue(maps["1"], datas, returnType, vars, props)!,
              getValue(maps["2"], datas, returnType, vars, props)!);
        case "getAxisAlignedBoundingBox":
          if (maps["0"] == null) {
            return null;
          }
          return InteractiveViewer.getAxisAlignedBoundingBox(
              getValue(maps["0"], datas, returnType, vars, props)!);
        case "pointIsInside":
          if (maps["0"] == null || maps["1"] == null) {
            return null;
          }
          return InteractiveViewer.pointIsInside(
              getValue(maps["0"], datas, returnType, vars, props)!,
              getValue(maps["1"], datas, returnType, vars, props)!);
        case "getNearestPointInside":
          if (maps["0"] == null || maps["1"] == null) {
            return null;
          }
          return InteractiveViewer.getNearestPointInside(
              getValue(maps["0"], datas, returnType, vars, props)!,
              getValue(maps["1"], datas, returnType, vars, props)!);
      }
    },
    "IsolateNameServer": () {
      switch (value) {
        case "lookupPortByName":
          if (maps["0"] == null) {
            return null;
          }
          return IsolateNameServer.lookupPortByName(
              getValue(maps["0"], datas, returnType, vars, props)!);
        case "registerPortWithName":
          if (maps["0"] == null || maps["1"] == null) {
            return null;
          }
          return IsolateNameServer.registerPortWithName(
              getValue(maps["0"], datas, returnType, vars, props)!,
              getValue(maps["1"], datas, returnType, vars, props)!);
        case "removePortNameMapping":
          if (maps["0"] == null) {
            return null;
          }
          return IsolateNameServer.removePortNameMapping(
              getValue(maps["0"], datas, returnType, vars, props)!);
      }
    },
    "KeyedSubtree": () {
      switch (value) {
        case "ensureUniqueKeysForList":
          if (maps["0"] == null) {
            return null;
          }
          return KeyedSubtree.ensureUniqueKeysForList(
              List<Widget>.from(
                  getValue(maps["0"], datas, returnType, vars, props)),
              baseIndex:
                  getValue(maps["baseIndex"], datas, returnType, vars, props) ??
                      0);
      }
    },
    "LengthLimitingTextInputFormatter": () {
      switch (value) {
        case "getDefaultMaxLengthEnforcement":
          return LengthLimitingTextInputFormatter
              .getDefaultMaxLengthEnforcement(
                  getValue(maps["0"], datas, returnType, vars, props));
        case "truncate":
          if (maps["0"] == null || maps["1"] == null) {
            return null;
          }
          return LengthLimitingTextInputFormatter.truncate(
              getValue(maps["0"], datas, returnType, vars, props)!,
              getValue(maps["1"], datas, returnType, vars, props)!);
      }
    },
    "LicenseParagraph": () {
      switch (value) {
        case "centeredIndent":
          return LicenseParagraph.centeredIndent;
      }
    },
    "LicenseRegistry": () {
      switch (value) {
        case "addLicense":
          if (maps["0"] == null) {
            return null;
          }
          LicenseRegistry.addLicense(
              getValue(maps["0"], datas, returnType, vars, props)!);
        case "licenses":
          return LicenseRegistry.licenses;
        case "reset":
          LicenseRegistry.reset();
      }
    },
    "LinearBorderEdge": () {
      switch (value) {
        case "lerp":
          if (maps["0"] == null || maps["1"] == null || maps["2"] == null) {
            return null;
          }
          return LinearBorderEdge.lerp(
              getValue(maps["0"], datas, returnType, vars, props)!,
              getValue(maps["1"], datas, returnType, vars, props)!,
              getValue(maps["2"], datas, returnType, vars, props).toDouble()!);
      }
    },
    "LinearGradient": () {
      switch (value) {
        case "lerp":
          if (maps["0"] == null || maps["1"] == null || maps["2"] == null) {
            return null;
          }
          return LinearGradient.lerp(
              getValue(maps["0"], datas, returnType, vars, props)!,
              getValue(maps["1"], datas, returnType, vars, props)!,
              getValue(maps["2"], datas, returnType, vars, props).toDouble()!);
      }
    },
    "List": () {
      switch (value) {
        case "castFrom":
          if (maps["0"] == null) {
            return null;
          }
          return List.castFrom(List<S>.from(
              getValue(maps["0"], datas, returnType, vars, props)));

        case "copyRange":
          if (maps["0"] == null || maps["1"] == null || maps["2"] == null) {
            return null;
          }
          List.copyRange(
              List<T>.from(getValue(maps["0"], datas, returnType, vars, props)),
              getValue(maps["1"], datas, returnType, vars, props)!,
              List<T>.from(getValue(maps["2"], datas, returnType, vars, props)),
              getValue(maps["4"], datas, returnType, vars, props),
              getValue(maps["5"], datas, returnType, vars, props));
        case "writeIterable":
          if (maps["0"] == null || maps["1"] == null || maps["2"] == null) {
            return null;
          }
          List.writeIterable(
              List<T>.from(getValue(maps["0"], datas, returnType, vars, props)),
              getValue(maps["1"], datas, returnType, vars, props)!,
              getValue(maps["2"], datas, returnType, vars, props)!);
      }
    },
    "ListTile": () {
      switch (value) {
        case "divideTiles":
          if (maps["tiles"] == null) {
            return null;
          }
          return ListTile.divideTiles(
              context:
                  getValue(maps["context"], datas, returnType, vars, props),
              tiles: getValue(maps["tiles"], datas, returnType, vars, props)!,
              color: getValue(maps["color"], datas, returnType, vars, props));
      }
    },
    "ListTileTheme": () {
      switch (value) {
        case "of":
          if (maps["0"] == null) {
            return null;
          }
          return ListTileTheme.of(
              getValue(maps["0"], datas, returnType, vars, props)!);
        case "merge":
          if (maps["child"] == null) {
            return null;
          }
          return ListTileTheme.merge(
              key: getValue(maps["key"], datas, returnType, vars, props),
              dense: getValue(maps["dense"], datas, returnType, vars, props),
              shape: getValue(maps["shape"], datas, returnType, vars, props),
              style: getValue(maps["style"], datas, returnType, vars, props),
              selectedColor: getValue(
                  maps["selectedColor"], datas, returnType, vars, props),
              iconColor:
                  getValue(maps["iconColor"], datas, returnType, vars, props),
              textColor:
                  getValue(maps["textColor"], datas, returnType, vars, props),
              titleTextStyle: getValue(
                  maps["titleTextStyle"], datas, returnType, vars, props),
              subtitleTextStyle: getValue(
                  maps["subtitleTextStyle"], datas, returnType, vars, props),
              leadingAndTrailingTextStyle: getValue(
                  maps["leadingAndTrailingTextStyle"],
                  datas,
                  returnType,
                  vars,
                  props),
              contentPadding: getValue(
                  maps["contentPadding"], datas, returnType, vars, props),
              tileColor:
                  getValue(maps["tileColor"], datas, returnType, vars, props),
              selectedTileColor: getValue(
                  maps["selectedTileColor"], datas, returnType, vars, props),
              enableFeedback: getValue(
                  maps["enableFeedback"], datas, returnType, vars, props),
              horizontalTitleGap:
                  getValue(maps["horizontalTitleGap"], datas, returnType, vars, props)
                      ?.toDouble(),
              minVerticalPadding:
                  getValue(maps["minVerticalPadding"], datas, returnType, vars, props)
                      ?.toDouble(),
              minLeadingWidth: getValue(
                      maps["minLeadingWidth"], datas, returnType, vars, props)
                  ?.toDouble(),
              titleAlignment: getValue(
                  maps["titleAlignment"], datas, returnType, vars, props),
              mouseCursor:
                  getValue(maps["mouseCursor"], datas, returnType, vars, props),
              visualDensity:
                  getValue(maps["visualDensity"], datas, returnType, vars, props),
              child: getValue(maps["child"], datas, returnType, vars, props)!);
      }
    },
    "ListTileThemeData": () {
      switch (value) {
        case "lerp":
          if (maps["0"] == null || maps["1"] == null || maps["2"] == null) {
            return null;
          }
          return ListTileThemeData.lerp(
              getValue(maps["0"], datas, returnType, vars, props)!,
              getValue(maps["1"], datas, returnType, vars, props)!,
              getValue(maps["2"], datas, returnType, vars, props).toDouble()!);
      }
    },
    "Localizations": () {
      switch (value) {
        case "localeOf":
          if (maps["0"] == null) {
            return null;
          }
          return Localizations.localeOf(
              getValue(maps["0"], datas, returnType, vars, props)!);
        case "maybeLocaleOf":
          if (maps["0"] == null) {
            return null;
          }
          return Localizations.maybeLocaleOf(
              getValue(maps["0"], datas, returnType, vars, props)!);
        case "of":
          if (maps["0"] == null || maps["1"] == null) {
            return null;
          }
          return Localizations.of(
              getValue(maps["0"], datas, returnType, vars, props)!,
              getValue(maps["1"], datas, returnType, vars, props)!);
      }
    },
    "LogicalKeyboardKey": () {
      switch (value) {
        case "findKeyByKeyId":
          if (maps["0"] == null) {
            return null;
          }
          return LogicalKeyboardKey.findKeyByKeyId(
              getValue(maps["0"], datas, returnType, vars, props)!);
        case "isControlCharacter":
          if (maps["0"] == null) {
            return null;
          }
          return LogicalKeyboardKey.isControlCharacter(
              getValue(maps["0"], datas, returnType, vars, props)!);
        case "collapseSynonyms":
          if (maps["0"] == null) {
            return null;
          }
          return LogicalKeyboardKey.collapseSynonyms(
              Set<LogicalKeyboardKey>.from(
                  getValue(maps["0"], datas, returnType, vars, props)));
      }
    },
    "LookupBoundary": () {
      switch (value) {
        case "dependOnInheritedWidgetOfExactType":
          if (maps["0"] == null) {
            return null;
          }
          return LookupBoundary.dependOnInheritedWidgetOfExactType(
              getValue(maps["0"], datas, returnType, vars, props)!,
              aspect: getValue(maps["aspect"], datas, returnType, vars, props));
        case "getElementForInheritedWidgetOfExactType":
          if (maps["0"] == null) {
            return null;
          }
          return LookupBoundary.getElementForInheritedWidgetOfExactType(
              getValue(maps["0"], datas, returnType, vars, props)!);
        case "findAncestorWidgetOfExactType":
          if (maps["0"] == null) {
            return null;
          }
          return LookupBoundary.findAncestorWidgetOfExactType(
              getValue(maps["0"], datas, returnType, vars, props)!);
        case "findAncestorStateOfType":
          if (maps["0"] == null) {
            return null;
          }
          return LookupBoundary.findAncestorStateOfType(
              getValue(maps["0"], datas, returnType, vars, props)!);
        case "findRootAncestorStateOfType":
          if (maps["0"] == null) {
            return null;
          }
          return LookupBoundary.findRootAncestorStateOfType(
              getValue(maps["0"], datas, returnType, vars, props)!);
        case "findAncestorRenderObjectOfType":
          if (maps["0"] == null) {
            return null;
          }
          return LookupBoundary.findAncestorRenderObjectOfType(
              getValue(maps["0"], datas, returnType, vars, props)!);
        case "visitAncestorElements":
          if (maps["0"] == null || maps["1"] == null) {
            return null;
          }
          LookupBoundary.visitAncestorElements(
              getValue(maps["0"], datas, returnType, vars, props)!,
              getValue(maps["1"], datas, returnType, vars, props)!);
        case "visitChildElements":
          if (maps["0"] == null || maps["1"] == null) {
            return null;
          }
          LookupBoundary.visitChildElements(
              getValue(maps["0"], datas, returnType, vars, props)!,
              getValue(maps["1"], datas, returnType, vars, props)!);
        case "debugIsHidingAncestorWidgetOfExactType":
          if (maps["0"] == null) {
            return null;
          }
          return LookupBoundary.debugIsHidingAncestorWidgetOfExactType(
              getValue(maps["0"], datas, returnType, vars, props)!);
        case "debugIsHidingAncestorStateOfType":
          if (maps["0"] == null) {
            return null;
          }
          return LookupBoundary.debugIsHidingAncestorStateOfType(
              getValue(maps["0"], datas, returnType, vars, props)!);
        case "debugIsHidingAncestorRenderObjectOfType":
          if (maps["0"] == null) {
            return null;
          }
          return LookupBoundary.debugIsHidingAncestorRenderObjectOfType(
              getValue(maps["0"], datas, returnType, vars, props)!);
      }
    },
    "Magnifier": () {
      switch (value) {
        case "kDefaultMagnifierSize":
          return Magnifier.kDefaultMagnifierSize;
        case "kStandardVerticalFocalPointShift":
          return Magnifier.kStandardVerticalFocalPointShift;
      }
    },
    "MagnifierController": () {
      switch (value) {
        case "shiftWithinBounds":
          if (maps["rect"] == null || maps["bounds"] == null) {
            return null;
          }
          return MagnifierController.shiftWithinBounds(
              rect: getValue(maps["rect"], datas, returnType, vars, props)!,
              bounds:
                  getValue(maps["bounds"], datas, returnType, vars, props)!);
      }
    },
    "MagnifierInfo": () {
      switch (value) {
        case "empty":
          return MagnifierInfo.empty;
      }
    },
    "Map": () {
      switch (value) {
        case "castFrom":
          if (maps["0"] == null) {
            return null;
          }
          return Map.castFrom(Map<K, V>.from(
              getValue(maps["0"], datas, returnType, vars, props)));
      }
    },
    "Material": () {
      switch (value) {
        case "maybeOf":
          if (maps["0"] == null) {
            return null;
          }
          return Material.maybeOf(
              getValue(maps["0"], datas, returnType, vars, props)!);
        case "of":
          if (maps["0"] == null) {
            return null;
          }
          return Material.of(
              getValue(maps["0"], datas, returnType, vars, props)!);
        case "defaultSplashRadius":
          return Material.defaultSplashRadius;
      }
    },
    "MaterialApp": () {
      switch (value) {
        case "createMaterialHeroController":
          return MaterialApp.createMaterialHeroController();
      }
    },
    "MaterialBanner": () {
      switch (value) {
        case "createAnimationController":
          if (maps["vsync"] == null) {
            return null;
          }
          return MaterialBanner.createAnimationController(
              vsync: getValue(maps["vsync"], datas, returnType, vars, props)!);
      }
    },
    "MaterialBannerTheme": () {
      switch (value) {
        case "of":
          if (maps["0"] == null) {
            return null;
          }
          return MaterialBannerTheme.of(
              getValue(maps["0"], datas, returnType, vars, props)!);
      }
    },
    "MaterialBannerThemeData": () {
      switch (value) {
        case "lerp":
          if (maps["0"] == null || maps["1"] == null || maps["2"] == null) {
            return null;
          }
          return MaterialBannerThemeData.lerp(
              getValue(maps["0"], datas, returnType, vars, props)!,
              getValue(maps["1"], datas, returnType, vars, props)!,
              getValue(maps["2"], datas, returnType, vars, props).toDouble()!);
      }
    },
    "MaterialLocalizations": () {
      switch (value) {
        case "of":
          if (maps["0"] == null) {
            return null;
          }
          return MaterialLocalizations.of(
              getValue(maps["0"], datas, returnType, vars, props)!);
      }
    },
    "MaterialStateBorderSide": () {
      switch (value) {
        case "resolveWith":
          if (maps["0"] == null) {
            return null;
          }
          return MaterialStateBorderSide.resolveWith(
              getValue(maps["0"], datas, returnType, vars, props)!);
      }
    },
    "MaterialStateColor": () {
      switch (value) {
        case "resolveWith":
          if (maps["0"] == null) {
            return null;
          }
          return MaterialStateColor.resolveWith(
              getValue(maps["0"], datas, returnType, vars, props)!);
      }
    },
    "MaterialStateMouseCursor": () {
      switch (value) {
        case "clickable":
          return MaterialStateMouseCursor.clickable;
        case "textable":
          return MaterialStateMouseCursor.textable;
      }
    },
    "MaterialStateOutlineInputBorder": () {
      switch (value) {
        case "resolveWith":
          if (maps["0"] == null) {
            return null;
          }
          return MaterialStateOutlineInputBorder.resolveWith(
              getValue(maps["0"], datas, returnType, vars, props)!);
      }
    },
    "MaterialStateProperty": () {
      switch (value) {
        case "resolveAs":
          if (maps["0"] == null || maps["1"] == null) {
            return null;
          }
          return MaterialStateProperty.resolveAs(
              getValue(maps["0"], datas, returnType, vars, props)!,
              Set<MaterialState>.from(
                  getValue(maps["1"], datas, returnType, vars, props)));
        case "resolveWith":
          if (maps["0"] == null) {
            return null;
          }
          return MaterialStateProperty.resolveWith(
              getValue(maps["0"], datas, returnType, vars, props)!);
        case "all":
          if (maps["0"] == null) {
            return null;
          }
          return MaterialStateProperty.all(
              getValue(maps["0"], datas, returnType, vars, props)!);
        case "lerp":
          if (maps["0"] == null ||
              maps["1"] == null ||
              maps["2"] == null ||
              maps["3"] == null) {
            return null;
          }
          return MaterialStateProperty.lerp(
              getValue(maps["0"], datas, returnType, vars, props)!,
              getValue(maps["1"], datas, returnType, vars, props)!,
              getValue(maps["2"], datas, returnType, vars, props).toDouble()!,
              getValue(maps["3"], datas, returnType, vars, props)!);
      }
    },
    "MaterialStateTextStyle": () {
      switch (value) {
        case "resolveWith":
          if (maps["0"] == null) {
            return null;
          }
          return MaterialStateTextStyle.resolveWith(
              getValue(maps["0"], datas, returnType, vars, props)!);
      }
    },
    "MaterialStateUnderlineInputBorder": () {
      switch (value) {
        case "resolveWith":
          if (maps["0"] == null) {
            return null;
          }
          return MaterialStateUnderlineInputBorder.resolveWith(
              getValue(maps["0"], datas, returnType, vars, props)!);
      }
    },
    "MatrixUtils": () {
      switch (value) {
        case "getAsTranslation":
          if (maps["0"] == null) {
            return null;
          }
          return MatrixUtils.getAsTranslation(
              getValue(maps["0"], datas, returnType, vars, props)!);
        case "getAsScale":
          if (maps["0"] == null) {
            return null;
          }
          return MatrixUtils.getAsScale(
              getValue(maps["0"], datas, returnType, vars, props)!);
        case "matrixEquals":
          if (maps["0"] == null || maps["1"] == null) {
            return null;
          }
          return MatrixUtils.matrixEquals(
              getValue(maps["0"], datas, returnType, vars, props)!,
              getValue(maps["1"], datas, returnType, vars, props)!);
        case "isIdentity":
          if (maps["0"] == null) {
            return null;
          }
          return MatrixUtils.isIdentity(
              getValue(maps["0"], datas, returnType, vars, props)!);
        case "transformPoint":
          if (maps["0"] == null || maps["1"] == null) {
            return null;
          }
          return MatrixUtils.transformPoint(
              getValue(maps["0"], datas, returnType, vars, props)!,
              getValue(maps["1"], datas, returnType, vars, props)!);
        case "transformRect":
          if (maps["0"] == null || maps["1"] == null) {
            return null;
          }
          return MatrixUtils.transformRect(
              getValue(maps["0"], datas, returnType, vars, props)!,
              getValue(maps["1"], datas, returnType, vars, props)!);
        case "inverseTransformRect":
          if (maps["0"] == null || maps["1"] == null) {
            return null;
          }
          return MatrixUtils.inverseTransformRect(
              getValue(maps["0"], datas, returnType, vars, props)!,
              getValue(maps["1"], datas, returnType, vars, props)!);
        case "createCylindricalProjectionTransform":
          if (maps["radius"] == null || maps["angle"] == null) {
            return null;
          }
          return MatrixUtils.createCylindricalProjectionTransform(
              radius: getValue(maps["radius"], datas, returnType, vars, props)
                  .toDouble()!,
              angle: getValue(maps["angle"], datas, returnType, vars, props)
                  .toDouble()!,
              perspective:
                  getValue(maps["perspective"], datas, returnType, vars, props)
                          .toDouble() ??
                      0.001,
              orientation: getValue(
                      maps["orientation"], datas, returnType, vars, props) ??
                  Axis.vertical);
        case "forceToPoint":
          if (maps["0"] == null) {
            return null;
          }
          return MatrixUtils.forceToPoint(
              getValue(maps["0"], datas, returnType, vars, props)!);
      }
    },
    "MediaQuery": () {
      switch (value) {
        case "fromWindow":
          if (maps["child"] == null) {
            return null;
          }
          return MediaQuery.fromWindow(
              key: getValue(maps["key"], datas, returnType, vars, props),
              child: getValue(maps["child"], datas, returnType, vars, props)!);
        case "fromView":
          if (maps["view"] == null || maps["child"] == null) {
            return null;
          }
          return MediaQuery.fromView(
              key: getValue(maps["key"], datas, returnType, vars, props),
              view: getValue(maps["view"], datas, returnType, vars, props)!,
              child: getValue(maps["child"], datas, returnType, vars, props)!);
        case "of":
          if (maps["0"] == null) {
            return null;
          }
          return MediaQuery.of(
              getValue(maps["0"], datas, returnType, vars, props)!);
        case "maybeOf":
          if (maps["0"] == null) {
            return null;
          }
          return MediaQuery.maybeOf(
              getValue(maps["0"], datas, returnType, vars, props)!);
        case "sizeOf":
          if (maps["0"] == null) {
            return null;
          }
          return MediaQuery.sizeOf(
              getValue(maps["0"], datas, returnType, vars, props)!);
        case "maybeSizeOf":
          if (maps["0"] == null) {
            return null;
          }
          return MediaQuery.maybeSizeOf(
              getValue(maps["0"], datas, returnType, vars, props)!);
        case "orientationOf":
          if (maps["0"] == null) {
            return null;
          }
          return MediaQuery.orientationOf(
              getValue(maps["0"], datas, returnType, vars, props)!);
        case "maybeOrientationOf":
          if (maps["0"] == null) {
            return null;
          }
          return MediaQuery.maybeOrientationOf(
              getValue(maps["0"], datas, returnType, vars, props)!);
        case "devicePixelRatioOf":
          if (maps["0"] == null) {
            return null;
          }
          return MediaQuery.devicePixelRatioOf(
              getValue(maps["0"], datas, returnType, vars, props)!);
        case "maybeDevicePixelRatioOf":
          if (maps["0"] == null) {
            return null;
          }
          return MediaQuery.maybeDevicePixelRatioOf(
              getValue(maps["0"], datas, returnType, vars, props)!);
        case "textScaleFactorOf":
          if (maps["0"] == null) {
            return null;
          }
          return MediaQuery.textScaleFactorOf(
              getValue(maps["0"], datas, returnType, vars, props)!);
        case "maybeTextScaleFactorOf":
          if (maps["0"] == null) {
            return null;
          }
          return MediaQuery.maybeTextScaleFactorOf(
              getValue(maps["0"], datas, returnType, vars, props)!);
        case "platformBrightnessOf":
          if (maps["0"] == null) {
            return null;
          }
          return MediaQuery.platformBrightnessOf(
              getValue(maps["0"], datas, returnType, vars, props)!);
        case "maybePlatformBrightnessOf":
          if (maps["0"] == null) {
            return null;
          }
          return MediaQuery.maybePlatformBrightnessOf(
              getValue(maps["0"], datas, returnType, vars, props)!);
        case "paddingOf":
          if (maps["0"] == null) {
            return null;
          }
          return MediaQuery.paddingOf(
              getValue(maps["0"], datas, returnType, vars, props)!);
        case "maybePaddingOf":
          if (maps["0"] == null) {
            return null;
          }
          return MediaQuery.maybePaddingOf(
              getValue(maps["0"], datas, returnType, vars, props)!);
        case "viewInsetsOf":
          if (maps["0"] == null) {
            return null;
          }
          return MediaQuery.viewInsetsOf(
              getValue(maps["0"], datas, returnType, vars, props)!);
        case "maybeViewInsetsOf":
          if (maps["0"] == null) {
            return null;
          }
          return MediaQuery.maybeViewInsetsOf(
              getValue(maps["0"], datas, returnType, vars, props)!);
        case "systemGestureInsetsOf":
          if (maps["0"] == null) {
            return null;
          }
          return MediaQuery.systemGestureInsetsOf(
              getValue(maps["0"], datas, returnType, vars, props)!);
        case "maybeSystemGestureInsetsOf":
          if (maps["0"] == null) {
            return null;
          }
          return MediaQuery.maybeSystemGestureInsetsOf(
              getValue(maps["0"], datas, returnType, vars, props)!);
        case "viewPaddingOf":
          if (maps["0"] == null) {
            return null;
          }
          return MediaQuery.viewPaddingOf(
              getValue(maps["0"], datas, returnType, vars, props)!);
        case "maybeViewPaddingOf":
          if (maps["0"] == null) {
            return null;
          }
          return MediaQuery.maybeViewPaddingOf(
              getValue(maps["0"], datas, returnType, vars, props)!);
        case "alwaysUse24HourFormatOf":
          if (maps["0"] == null) {
            return null;
          }
          return MediaQuery.alwaysUse24HourFormatOf(
              getValue(maps["0"], datas, returnType, vars, props)!);
        case "maybeAlwaysUse24HourFormatOf":
          if (maps["0"] == null) {
            return null;
          }
          return MediaQuery.maybeAlwaysUse24HourFormatOf(
              getValue(maps["0"], datas, returnType, vars, props)!);
        case "accessibleNavigationOf":
          if (maps["0"] == null) {
            return null;
          }
          return MediaQuery.accessibleNavigationOf(
              getValue(maps["0"], datas, returnType, vars, props)!);
        case "maybeAccessibleNavigationOf":
          if (maps["0"] == null) {
            return null;
          }
          return MediaQuery.maybeAccessibleNavigationOf(
              getValue(maps["0"], datas, returnType, vars, props)!);
        case "invertColorsOf":
          if (maps["0"] == null) {
            return null;
          }
          return MediaQuery.invertColorsOf(
              getValue(maps["0"], datas, returnType, vars, props)!);
        case "maybeInvertColorsOf":
          if (maps["0"] == null) {
            return null;
          }
          return MediaQuery.maybeInvertColorsOf(
              getValue(maps["0"], datas, returnType, vars, props)!);
        case "highContrastOf":
          if (maps["0"] == null) {
            return null;
          }
          return MediaQuery.highContrastOf(
              getValue(maps["0"], datas, returnType, vars, props)!);
        case "maybeHighContrastOf":
          if (maps["0"] == null) {
            return null;
          }
          return MediaQuery.maybeHighContrastOf(
              getValue(maps["0"], datas, returnType, vars, props)!);
        case "disableAnimationsOf":
          if (maps["0"] == null) {
            return null;
          }
          return MediaQuery.disableAnimationsOf(
              getValue(maps["0"], datas, returnType, vars, props)!);
        case "maybeDisableAnimationsOf":
          if (maps["0"] == null) {
            return null;
          }
          return MediaQuery.maybeDisableAnimationsOf(
              getValue(maps["0"], datas, returnType, vars, props)!);
        case "boldTextOf":
          if (maps["0"] == null) {
            return null;
          }
          return MediaQuery.boldTextOf(
              getValue(maps["0"], datas, returnType, vars, props)!);
        // case "boldTextOverride":
        //   if (maps["0"] == null) {
        //     return null;
        //   }
        //   return MediaQuery.boldTextOverride(
        //       getValue(maps["0"], datas, returnType, vars, props)!);
        case "maybeBoldTextOf":
          if (maps["0"] == null) {
            return null;
          }
          return MediaQuery.maybeBoldTextOf(
              getValue(maps["0"], datas, returnType, vars, props)!);
        case "navigationModeOf":
          if (maps["0"] == null) {
            return null;
          }
          return MediaQuery.navigationModeOf(
              getValue(maps["0"], datas, returnType, vars, props)!);
        case "maybeNavigationModeOf":
          if (maps["0"] == null) {
            return null;
          }
          return MediaQuery.maybeNavigationModeOf(
              getValue(maps["0"], datas, returnType, vars, props)!);
        case "gestureSettingsOf":
          if (maps["0"] == null) {
            return null;
          }
          return MediaQuery.gestureSettingsOf(
              getValue(maps["0"], datas, returnType, vars, props)!);
        case "maybeGestureSettingsOf":
          if (maps["0"] == null) {
            return null;
          }
          return MediaQuery.maybeGestureSettingsOf(
              getValue(maps["0"], datas, returnType, vars, props)!);
        case "displayFeaturesOf":
          if (maps["0"] == null) {
            return null;
          }
          return MediaQuery.displayFeaturesOf(
              getValue(maps["0"], datas, returnType, vars, props)!);
        case "maybeDisplayFeaturesOf":
          if (maps["0"] == null) {
            return null;
          }
          return MediaQuery.maybeDisplayFeaturesOf(
              getValue(maps["0"], datas, returnType, vars, props)!);
      }
    },
    "MemoryAllocations": () {
      switch (value) {
        case "instance":
          return MemoryAllocations.instance;
      }
    },
    "MenuBarTheme": () {
      switch (value) {
        case "of":
          if (maps["0"] == null) {
            return null;
          }
          return MenuBarTheme.of(
              getValue(maps["0"], datas, returnType, vars, props)!);
      }
    },
    "MenuBarThemeData": () {
      switch (value) {
        case "lerp":
          if (maps["0"] == null || maps["1"] == null || maps["2"] == null) {
            return null;
          }
          return MenuBarThemeData.lerp(
              getValue(maps["0"], datas, returnType, vars, props)!,
              getValue(maps["1"], datas, returnType, vars, props)!,
              getValue(maps["2"], datas, returnType, vars, props).toDouble()!);
      }
    },
    "MenuButtonTheme": () {
      switch (value) {
        case "of":
          if (maps["0"] == null) {
            return null;
          }
          return MenuButtonTheme.of(
              getValue(maps["0"], datas, returnType, vars, props)!);
      }
    },
    "MenuButtonThemeData": () {
      switch (value) {
        case "lerp":
          if (maps["0"] == null || maps["1"] == null || maps["2"] == null) {
            return null;
          }
          return MenuButtonThemeData.lerp(
              getValue(maps["0"], datas, returnType, vars, props)!,
              getValue(maps["1"], datas, returnType, vars, props)!,
              getValue(maps["2"], datas, returnType, vars, props).toDouble()!);
      }
    },
    "MenuItemButton": () {
      switch (value) {
        case "styleFrom":
          return MenuItemButton.styleFrom(
              foregroundColor: getValue(
                  maps["foregroundColor"], datas, returnType, vars, props),
              backgroundColor: getValue(
                  maps["backgroundColor"], datas, returnType, vars, props),
              disabledForegroundColor: getValue(maps["disabledForegroundColor"],
                  datas, returnType, vars, props),
              disabledBackgroundColor: getValue(maps["disabledBackgroundColor"],
                  datas, returnType, vars, props),
              shadowColor:
                  getValue(maps["shadowColor"], datas, returnType, vars, props),
              surfaceTintColor: getValue(
                  maps["surfaceTintColor"], datas, returnType, vars, props),
              iconColor:
                  getValue(maps["iconColor"], datas, returnType, vars, props),
              textStyle:
                  getValue(maps["textStyle"], datas, returnType, vars, props),
              elevation:
                  getValue(maps["elevation"], datas, returnType, vars, props)
                      ?.toDouble(),
              padding:
                  getValue(maps["padding"], datas, returnType, vars, props),
              minimumSize:
                  getValue(maps["minimumSize"], datas, returnType, vars, props),
              fixedSize:
                  getValue(maps["fixedSize"], datas, returnType, vars, props),
              maximumSize:
                  getValue(maps["maximumSize"], datas, returnType, vars, props),
              enabledMouseCursor: getValue(
                  maps["enabledMouseCursor"], datas, returnType, vars, props),
              disabledMouseCursor: getValue(
                  maps["disabledMouseCursor"], datas, returnType, vars, props),
              side: getValue(maps["side"], datas, returnType, vars, props),
              shape: getValue(maps["shape"], datas, returnType, vars, props),
              visualDensity: getValue(
                  maps["visualDensity"], datas, returnType, vars, props),
              tapTargetSize: getValue(
                  maps["tapTargetSize"], datas, returnType, vars, props),
              animationDuration: getValue(
                  maps["animationDuration"], datas, returnType, vars, props),
              enableFeedback: getValue(maps["enableFeedback"], datas, returnType, vars, props),
              alignment: getValue(maps["alignment"], datas, returnType, vars, props),
              splashFactory: getValue(maps["splashFactory"], datas, returnType, vars, props));
      }
    },
    "MenuStyle": () {
      switch (value) {
        case "lerp":
          if (maps["0"] == null || maps["1"] == null || maps["2"] == null) {
            return null;
          }
          return MenuStyle.lerp(
              getValue(maps["0"], datas, returnType, vars, props)!,
              getValue(maps["1"], datas, returnType, vars, props)!,
              getValue(maps["2"], datas, returnType, vars, props).toDouble()!);
      }
    },
    "MenuTheme": () {
      switch (value) {
        case "of":
          if (maps["0"] == null) {
            return null;
          }
          return MenuTheme.of(
              getValue(maps["0"], datas, returnType, vars, props)!);
      }
    },
    "MenuThemeData": () {
      switch (value) {
        case "lerp":
          if (maps["0"] == null || maps["1"] == null || maps["2"] == null) {
            return null;
          }
          return MenuThemeData.lerp(
              getValue(maps["0"], datas, returnType, vars, props)!,
              getValue(maps["1"], datas, returnType, vars, props)!,
              getValue(maps["2"], datas, returnType, vars, props).toDouble()!);
      }
    },
    "ModalRoute": () {
      switch (value) {
        case "of":
          if (maps["0"] == null) {
            return null;
          }
          return ModalRoute.of(
              getValue(maps["0"], datas, returnType, vars, props)!);
        case "withName":
          if (maps["0"] == null) {
            return null;
          }
          return ModalRoute.withName(
              getValue(maps["0"], datas, returnType, vars, props)!);
      }
    },
    "MouseCursor": () {
      switch (value) {
        case "defer":
          return MouseCursor.defer;
        case "uncontrolled":
          return MouseCursor.uncontrolled;
      }
    },
    "NavigationBarTheme": () {
      switch (value) {
        case "of":
          if (maps["0"] == null) {
            return null;
          }
          return NavigationBarTheme.of(
              getValue(maps["0"], datas, returnType, vars, props)!);
      }
    },
    "NavigationBarThemeData": () {
      switch (value) {
        case "lerp":
          if (maps["0"] == null || maps["1"] == null || maps["2"] == null) {
            return null;
          }
          return NavigationBarThemeData.lerp(
              getValue(maps["0"], datas, returnType, vars, props)!,
              getValue(maps["1"], datas, returnType, vars, props)!,
              getValue(maps["2"], datas, returnType, vars, props).toDouble()!);
      }
    },
    "NavigationDrawerTheme": () {
      switch (value) {
        case "of":
          if (maps["0"] == null) {
            return null;
          }
          return NavigationDrawerTheme.of(
              getValue(maps["0"], datas, returnType, vars, props)!);
      }
    },
    "NavigationDrawerThemeData": () {
      switch (value) {
        case "lerp":
          if (maps["0"] == null || maps["1"] == null || maps["2"] == null) {
            return null;
          }
          return NavigationDrawerThemeData.lerp(
              getValue(maps["0"], datas, returnType, vars, props)!,
              getValue(maps["1"], datas, returnType, vars, props)!,
              getValue(maps["2"], datas, returnType, vars, props).toDouble()!);
      }
    },
    "NavigationRail": () {
      switch (value) {
        case "extendedAnimation":
          if (maps["0"] == null) {
            return null;
          }
          return NavigationRail.extendedAnimation(
              getValue(maps["0"], datas, returnType, vars, props)!);
      }
    },
    "NavigationRailTheme": () {
      switch (value) {
        case "of":
          if (maps["0"] == null) {
            return null;
          }
          return NavigationRailTheme.of(
              getValue(maps["0"], datas, returnType, vars, props)!);
      }
    },
    "NavigationRailThemeData": () {
      switch (value) {
        case "lerp":
          if (maps["0"] == null || maps["1"] == null || maps["2"] == null) {
            return null;
          }
          return NavigationRailThemeData.lerp(
              getValue(maps["0"], datas, returnType, vars, props)!,
              getValue(maps["1"], datas, returnType, vars, props)!,
              getValue(maps["2"], datas, returnType, vars, props).toDouble()!);
      }
    },
    "NavigationToolbar": () {
      switch (value) {
        case "kMiddleSpacing":
          return NavigationToolbar.kMiddleSpacing;
      }
    },
    "Navigator": () {
      switch (value) {
        case "defaultRouteName":
          return Navigator.defaultRouteName;
        case "pushNamed":
          if (maps["0"] == null || maps["1"] == null) {
            return null;
          }
          return Navigator.pushNamed(
              getValue(maps["0"], datas, returnType, vars, props)!,
              getValue(maps["1"], datas, returnType, vars, props)!,
              arguments:
                  getValue(maps["arguments"], datas, returnType, vars, props));
        case "restorablePushNamed":
          if (maps["0"] == null || maps["1"] == null) {
            return null;
          }
          return Navigator.restorablePushNamed(
              getValue(maps["0"], datas, returnType, vars, props)!,
              getValue(maps["1"], datas, returnType, vars, props)!,
              arguments:
                  getValue(maps["arguments"], datas, returnType, vars, props));
        case "pushReplacementNamed":
          if (maps["0"] == null || maps["1"] == null) {
            return null;
          }
          return Navigator.pushReplacementNamed(
              getValue(maps["0"], datas, returnType, vars, props)!,
              getValue(maps["1"], datas, returnType, vars, props)!,
              result: getValue(maps["result"], datas, returnType, vars, props),
              arguments:
                  getValue(maps["arguments"], datas, returnType, vars, props));
        case "restorablePushReplacementNamed":
          if (maps["0"] == null || maps["1"] == null) {
            return null;
          }
          return Navigator.restorablePushReplacementNamed(
              getValue(maps["0"], datas, returnType, vars, props)!,
              getValue(maps["1"], datas, returnType, vars, props)!,
              result: getValue(maps["result"], datas, returnType, vars, props),
              arguments:
                  getValue(maps["arguments"], datas, returnType, vars, props));
        case "popAndPushNamed":
          if (maps["0"] == null || maps["1"] == null) {
            return null;
          }
          return Navigator.popAndPushNamed(
              getValue(maps["0"], datas, returnType, vars, props)!,
              getValue(maps["1"], datas, returnType, vars, props)!,
              result: getValue(maps["result"], datas, returnType, vars, props),
              arguments:
                  getValue(maps["arguments"], datas, returnType, vars, props));
        case "restorablePopAndPushNamed":
          if (maps["0"] == null || maps["1"] == null) {
            return null;
          }
          return Navigator.restorablePopAndPushNamed(
              getValue(maps["0"], datas, returnType, vars, props)!,
              getValue(maps["1"], datas, returnType, vars, props)!,
              result: getValue(maps["result"], datas, returnType, vars, props),
              arguments:
                  getValue(maps["arguments"], datas, returnType, vars, props));
        case "pushNamedAndRemoveUntil":
          if (maps["0"] == null || maps["1"] == null || maps["2"] == null) {
            return null;
          }
          return Navigator.pushNamedAndRemoveUntil(
              getValue(maps["0"], datas, returnType, vars, props)!,
              getValue(maps["1"], datas, returnType, vars, props)!,
              getValue(maps["2"], datas, returnType, vars, props)!,
              arguments:
                  getValue(maps["arguments"], datas, returnType, vars, props));
        case "restorablePushNamedAndRemoveUntil":
          if (maps["0"] == null || maps["1"] == null || maps["2"] == null) {
            return null;
          }
          return Navigator.restorablePushNamedAndRemoveUntil(
              getValue(maps["0"], datas, returnType, vars, props)!,
              getValue(maps["1"], datas, returnType, vars, props)!,
              getValue(maps["2"], datas, returnType, vars, props)!,
              arguments:
                  getValue(maps["arguments"], datas, returnType, vars, props));
        case "push":
          if (maps["0"] == null || maps["1"] == null) {
            return null;
          }
          return Navigator.push(
              getValue(maps["0"], datas, returnType, vars, props)!,
              getValue(maps["1"], datas, returnType, vars, props)!);
        case "restorablePush":
          if (maps["0"] == null || maps["1"] == null) {
            return null;
          }
          return Navigator.restorablePush(
              getValue(maps["0"], datas, returnType, vars, props)!,
              getValue(maps["1"], datas, returnType, vars, props)!,
              arguments:
                  getValue(maps["arguments"], datas, returnType, vars, props));
        case "pushReplacement":
          if (maps["0"] == null || maps["1"] == null) {
            return null;
          }
          return Navigator.pushReplacement(
              getValue(maps["0"], datas, returnType, vars, props)!,
              getValue(maps["1"], datas, returnType, vars, props)!,
              result: getValue(maps["result"], datas, returnType, vars, props));
        case "restorablePushReplacement":
          if (maps["0"] == null || maps["1"] == null) {
            return null;
          }
          return Navigator.restorablePushReplacement(
              getValue(maps["0"], datas, returnType, vars, props)!,
              getValue(maps["1"], datas, returnType, vars, props)!,
              result: getValue(maps["result"], datas, returnType, vars, props),
              arguments:
                  getValue(maps["arguments"], datas, returnType, vars, props));
        case "pushAndRemoveUntil":
          if (maps["0"] == null || maps["1"] == null || maps["2"] == null) {
            return null;
          }
          return Navigator.pushAndRemoveUntil(
              getValue(maps["0"], datas, returnType, vars, props)!,
              getValue(maps["1"], datas, returnType, vars, props)!,
              getValue(maps["2"], datas, returnType, vars, props)!);
        case "restorablePushAndRemoveUntil":
          if (maps["0"] == null || maps["1"] == null || maps["2"] == null) {
            return null;
          }
          return Navigator.restorablePushAndRemoveUntil(
              getValue(maps["0"], datas, returnType, vars, props)!,
              getValue(maps["1"], datas, returnType, vars, props)!,
              getValue(maps["2"], datas, returnType, vars, props)!,
              arguments:
                  getValue(maps["arguments"], datas, returnType, vars, props));
        case "replace":
          if (maps["0"] == null ||
              maps["oldRoute"] == null ||
              maps["newRoute"] == null) {
            return null;
          }
          Navigator.replace(
              getValue(maps["0"], datas, returnType, vars, props)!,
              oldRoute:
                  getValue(maps["oldRoute"], datas, returnType, vars, props)!,
              newRoute:
                  getValue(maps["newRoute"], datas, returnType, vars, props)!);
        case "restorableReplace":
          if (maps["0"] == null ||
              maps["oldRoute"] == null ||
              maps["newRouteBuilder"] == null) {
            return null;
          }
          return Navigator.restorableReplace(
              getValue(maps["0"], datas, returnType, vars, props)!,
              oldRoute:
                  getValue(maps["oldRoute"], datas, returnType, vars, props)!,
              newRouteBuilder: getValue(
                  maps["newRouteBuilder"], datas, returnType, vars, props)!,
              arguments:
                  getValue(maps["arguments"], datas, returnType, vars, props));
        case "replaceRouteBelow":
          if (maps["0"] == null ||
              maps["anchorRoute"] == null ||
              maps["newRoute"] == null) {
            return null;
          }
          Navigator.replaceRouteBelow(
              getValue(maps["0"], datas, returnType, vars, props)!,
              anchorRoute: getValue(
                  maps["anchorRoute"], datas, returnType, vars, props)!,
              newRoute:
                  getValue(maps["newRoute"], datas, returnType, vars, props)!);
        case "restorableReplaceRouteBelow":
          if (maps["0"] == null ||
              maps["anchorRoute"] == null ||
              maps["newRouteBuilder"] == null) {
            return null;
          }
          return Navigator.restorableReplaceRouteBelow(
              getValue(maps["0"], datas, returnType, vars, props)!,
              anchorRoute: getValue(
                  maps["anchorRoute"], datas, returnType, vars, props)!,
              newRouteBuilder: getValue(
                  maps["newRouteBuilder"], datas, returnType, vars, props)!,
              arguments:
                  getValue(maps["arguments"], datas, returnType, vars, props));
        case "canPop":
          if (maps["0"] == null) {
            return null;
          }
          return Navigator.canPop(
              getValue(maps["0"], datas, returnType, vars, props)!);
        case "maybePop":
          if (maps["0"] == null) {
            return null;
          }
          return Navigator.maybePop(
              getValue(maps["0"], datas, returnType, vars, props)!,
              getValue(maps["2"], datas, returnType, vars, props));
        case "pop":
          if (maps["0"] == null) {
            return null;
          }
          Navigator.pop(getValue(maps["0"], datas, returnType, vars, props)!,
              getValue(maps["2"], datas, returnType, vars, props));
        case "popUntil":
          if (maps["0"] == null || maps["1"] == null) {
            return null;
          }
          Navigator.popUntil(
              getValue(maps["0"], datas, returnType, vars, props)!,
              getValue(maps["1"], datas, returnType, vars, props)!);
        case "removeRoute":
          if (maps["0"] == null || maps["1"] == null) {
            return null;
          }
          Navigator.removeRoute(
              getValue(maps["0"], datas, returnType, vars, props)!,
              getValue(maps["1"], datas, returnType, vars, props)!);
        case "removeRouteBelow":
          if (maps["0"] == null || maps["1"] == null) {
            return null;
          }
          Navigator.removeRouteBelow(
              getValue(maps["0"], datas, returnType, vars, props)!,
              getValue(maps["1"], datas, returnType, vars, props)!);
        case "of":
          if (maps["0"] == null) {
            return null;
          }
          return Navigator.of(
              getValue(maps["0"], datas, returnType, vars, props)!,
              rootNavigator: getValue(
                      maps["rootNavigator"], datas, returnType, vars, props) ??
                  false);
        case "maybeOf":
          if (maps["0"] == null) {
            return null;
          }
          return Navigator.maybeOf(
              getValue(maps["0"], datas, returnType, vars, props)!,
              rootNavigator: getValue(
                      maps["rootNavigator"], datas, returnType, vars, props) ??
                  false);
        case "defaultGenerateInitialRoutes":
          if (maps["0"] == null || maps["1"] == null) {
            return null;
          }
          return Navigator.defaultGenerateInitialRoutes(
              getValue(maps["0"], datas, returnType, vars, props)!,
              getValue(maps["1"], datas, returnType, vars, props)!);
      }
    },
    "NestedScrollView": () {
      switch (value) {
        case "sliverOverlapAbsorberHandleFor":
          if (maps["0"] == null) {
            return null;
          }
          return NestedScrollView.sliverOverlapAbsorberHandleFor(
              getValue(maps["0"], datas, returnType, vars, props)!);
      }
    },
    "NoSplash": () {
      switch (value) {
        case "splashFactory":
          return NoSplash.splashFactory;
      }
    },
    "Object": () {
      switch (value) {
        case "hash":
          if (maps["0"] == null || maps["1"] == null) {
            return null;
          }
          return Object.hash(
              getValue(maps["0"], datas, returnType, vars, props),
              getValue(maps["1"], datas, returnType, vars, props));
        case "hashAll":
          if (maps["0"] == null) {
            return null;
          }
          return Object.hashAll(
              getValue(maps["0"], datas, returnType, vars, props)!);
        case "hashAllUnordered":
          if (maps["0"] == null) {
            return null;
          }
          return Object.hashAllUnordered(
              getValue(maps["0"], datas, returnType, vars, props)!);
      }
    },
    "Offset": () {
      switch (value) {
        case "zero":
          return Offset.zero;
        case "infinite":
          return Offset.infinite;
        case "lerp":
          if (maps["0"] == null || maps["1"] == null || maps["2"] == null) {
            return null;
          }
          return Offset.lerp(
              getValue(maps["0"], datas, returnType, vars, props)!,
              getValue(maps["1"], datas, returnType, vars, props)!,
              getValue(maps["2"], datas, returnType, vars, props).toDouble()!);
      }
    },
    "OffsetPair": () {
      switch (value) {
        case "zero":
          return OffsetPair.zero;
      }
    },
    "OutlinedButton": () {
      switch (value) {
        case "styleFrom":
          return OutlinedButton.styleFrom(
            foregroundColor: getValue(
                maps["foregroundColor"], datas, returnType, vars, props),
            backgroundColor: getValue(
                maps["backgroundColor"], datas, returnType, vars, props),
            disabledForegroundColor: getValue(maps["disabledForegroundColor"],
                datas, returnType, vars, props),
            disabledBackgroundColor: getValue(maps["disabledBackgroundColor"],
                datas, returnType, vars, props),
            shadowColor:
                getValue(maps["shadowColor"], datas, returnType, vars, props),
            surfaceTintColor: getValue(
                maps["surfaceTintColor"], datas, returnType, vars, props),
            elevation:
                getValue(maps["elevation"], datas, returnType, vars, props)
                    ?.toDouble(),
            textStyle:
                getValue(maps["textStyle"], datas, returnType, vars, props),
            padding: getValue(maps["padding"], datas, returnType, vars, props),
            minimumSize:
                getValue(maps["minimumSize"], datas, returnType, vars, props),
            fixedSize:
                getValue(maps["fixedSize"], datas, returnType, vars, props),
            maximumSize:
                getValue(maps["maximumSize"], datas, returnType, vars, props),
            side: getValue(maps["side"], datas, returnType, vars, props),
            shape: getValue(maps["shape"], datas, returnType, vars, props),
            enabledMouseCursor: getValue(
                maps["enabledMouseCursor"], datas, returnType, vars, props),
            disabledMouseCursor: getValue(
                maps["disabledMouseCursor"], datas, returnType, vars, props),
            visualDensity:
                getValue(maps["visualDensity"], datas, returnType, vars, props),
            tapTargetSize:
                getValue(maps["tapTargetSize"], datas, returnType, vars, props),
            animationDuration: getValue(
                maps["animationDuration"], datas, returnType, vars, props),
            enableFeedback: getValue(
                maps["enableFeedback"], datas, returnType, vars, props),
            alignment:
                getValue(maps["alignment"], datas, returnType, vars, props),
            splashFactory:
                getValue(maps["splashFactory"], datas, returnType, vars, props),
            // primary: getValue(maps["primary"], datas, returnType, vars, props),
            // onSurface: getValue(maps["onSurface"], datas, returnType, vars, props),
          );
      }
    },
    "OutlinedButtonTheme": () {
      switch (value) {
        case "of":
          if (maps["0"] == null) {
            return null;
          }
          return OutlinedButtonTheme.of(
              getValue(maps["0"], datas, returnType, vars, props)!);
      }
    },
    "OutlinedButtonThemeData": () {
      switch (value) {
        case "lerp":
          if (maps["0"] == null || maps["1"] == null || maps["2"] == null) {
            return null;
          }
          return OutlinedButtonThemeData.lerp(
              getValue(maps["0"], datas, returnType, vars, props)!,
              getValue(maps["1"], datas, returnType, vars, props)!,
              getValue(maps["2"], datas, returnType, vars, props).toDouble()!);
      }
    },
    "Overlay": () {
      switch (value) {
        case "of":
          if (maps["0"] == null) {
            return null;
          }
          return Overlay.of(
              getValue(maps["0"], datas, returnType, vars, props)!,
              rootOverlay: getValue(
                      maps["rootOverlay"], datas, returnType, vars, props) ??
                  false,
              debugRequiredFor: getValue(
                  maps["debugRequiredFor"], datas, returnType, vars, props));
      }
    },
    "PageStorage": () {
      switch (value) {
        case "maybeOf":
          if (maps["0"] == null) {
            return null;
          }
          return PageStorage.maybeOf(
              getValue(maps["0"], datas, returnType, vars, props)!);
        case "of":
          if (maps["0"] == null) {
            return null;
          }
          return PageStorage.of(
              getValue(maps["0"], datas, returnType, vars, props)!);
      }
      //}, "Paint":
      //   switch (value) {
      //     case "enableDithering":
      //       return Paint.enableDithering;
      //   }
    },
    "PaintingContext": () {
      switch (value) {
        case "repaintCompositedChild":
          if (maps["0"] == null) {
            return null;
          }
          return PaintingContext.repaintCompositedChild(
              getValue(maps["0"], datas, returnType, vars, props)!,
              debugAlsoPaintedParent: getValue(maps["debugAlsoPaintedParent"],
                      datas, returnType, vars, props) ??
                  false);
        case "updateLayerProperties":
          if (maps["0"] == null) {
            return null;
          }
          return PaintingContext.updateLayerProperties(
              getValue(maps["0"], datas, returnType, vars, props)!);
        case "debugInstrumentRepaintCompositedChild":
          if (maps["0"] == null || maps["customContext"] == null) {
            return null;
          }
          return PaintingContext.debugInstrumentRepaintCompositedChild(
              getValue(maps["0"], datas, returnType, vars, props)!,
              debugAlsoPaintedParent: getValue(maps["debugAlsoPaintedParent"],
                      datas, returnType, vars, props) ??
                  false,
              customContext: getValue(
                  maps["customContext"], datas, returnType, vars, props)!);
      }
    },
    "PartialStackFrame": () {
      switch (value) {
        case "asynchronousSuspension":
          return PartialStackFrame.asynchronousSuspension;
      }
    },
    "Path": () {
      switch (value) {
        case "combine":
          if (maps["0"] == null || maps["1"] == null || maps["2"] == null) {
            return null;
          }
          return Path.combine(
              getValue(maps["0"], datas, returnType, vars, props)!,
              getValue(maps["1"], datas, returnType, vars, props)!,
              getValue(maps["2"], datas, returnType, vars, props)!);
      }
    },
    "Picture": () {
      switch (value) {
        case "onCreate":
          return Picture.onCreate;
        case "onDispose":
          return Picture.onDispose;
      }
    },
    "PlaceholderDimensions": () {
      switch (value) {
        case "empty":
          return PlaceholderDimensions.empty;
      }
    },
    "PlaceholderSpan": () {
      switch (value) {
        case "placeholderCodeUnit":
          return PlaceholderSpan.placeholderCodeUnit;
      }
    },
    "PlatformMenu": () {
      switch (value) {
        case "getDescendants":
          if (maps["0"] == null) {
            return null;
          }
          return PlatformMenu.getDescendants(
              getValue(maps["0"], datas, returnType, vars, props)!);
        case "serialize":
          if (maps["0"] == null || maps["1"] == null || maps["2"] == null) {
            return null;
          }
          return PlatformMenu.serialize(
              getValue(maps["0"], datas, returnType, vars, props)!,
              getValue(maps["1"], datas, returnType, vars, props)!,
              getValue(maps["2"], datas, returnType, vars, props)!);
      }
    },
    "PlatformMenuItemGroup": () {
      switch (value) {
        case "serialize":
          if (maps["0"] == null || maps["1"] == null || maps["getId"] == null) {
            return null;
          }
          return PlatformMenuItemGroup.serialize(
              getValue(maps["0"], datas, returnType, vars, props)!,
              getValue(maps["1"], datas, returnType, vars, props)!,
              getId: getValue(maps["getId"], datas, returnType, vars, props)!);
      }
    },
    "PlatformProvidedMenuItem": () {
      switch (value) {
        case "hasMenu":
          if (maps["0"] == null) {
            return null;
          }
          return PlatformProvidedMenuItem.hasMenu(
              getValue(maps["0"], datas, returnType, vars, props)!);
      }
    },
    "PlatformSelectableRegionContextMenu": () {
      switch (value) {
        case "attach":
          if (maps["0"] == null) {
            return null;
          }
          return PlatformSelectableRegionContextMenu.attach(
              getValue(maps["0"], datas, returnType, vars, props)!);
        case "detach":
          if (maps["0"] == null) {
            return null;
          }
          return PlatformSelectableRegionContextMenu.detach(
              getValue(maps["0"], datas, returnType, vars, props)!);
      }
    },
    "PlatformSelectableRegionContextMenu": () {
      switch (value) {
        case "attach":
          if (maps["0"] == null) {
            return null;
          }
          return PlatformSelectableRegionContextMenu.attach(
              getValue(maps["0"], datas, returnType, vars, props)!);
        case "detach":
          if (maps["0"] == null) {
            return null;
          }
          return PlatformSelectableRegionContextMenu.detach(
              getValue(maps["0"], datas, returnType, vars, props)!);
      }
    },
    "PlatformViewsService": () {
      switch (value) {
        case "initAndroidView":
          if (maps["id"] == null ||
              maps["viewType"] == null ||
              maps["layoutDirection"] == null) {
            return null;
          }
          return PlatformViewsService.initAndroidView(
              id: getValue(maps["id"], datas, returnType, vars, props)!,
              viewType:
                  getValue(maps["viewType"], datas, returnType, vars, props)!,
              layoutDirection: getValue(
                  maps["layoutDirection"], datas, returnType, vars, props)!,
              creationParams: getValue(
                  maps["creationParams"], datas, returnType, vars, props),
              creationParamsCodec: getValue(
                  maps["creationParamsCodec"], datas, returnType, vars, props),
              onFocus:
                  getValue(maps["onFocus"], datas, returnType, vars, props));
        case "initSurfaceAndroidView":
          if (maps["id"] == null ||
              maps["viewType"] == null ||
              maps["layoutDirection"] == null) {
            return null;
          }
          return PlatformViewsService.initSurfaceAndroidView(
              id: getValue(maps["id"], datas, returnType, vars, props)!,
              viewType:
                  getValue(maps["viewType"], datas, returnType, vars, props)!,
              layoutDirection: getValue(
                  maps["layoutDirection"], datas, returnType, vars, props)!,
              creationParams: getValue(
                  maps["creationParams"], datas, returnType, vars, props),
              creationParamsCodec: getValue(
                  maps["creationParamsCodec"], datas, returnType, vars, props),
              onFocus:
                  getValue(maps["onFocus"], datas, returnType, vars, props));
        case "initExpensiveAndroidView":
          if (maps["id"] == null ||
              maps["viewType"] == null ||
              maps["layoutDirection"] == null) {
            return null;
          }
          return PlatformViewsService.initExpensiveAndroidView(
              id: getValue(maps["id"], datas, returnType, vars, props)!,
              viewType:
                  getValue(maps["viewType"], datas, returnType, vars, props)!,
              layoutDirection: getValue(
                  maps["layoutDirection"], datas, returnType, vars, props)!,
              creationParams: getValue(
                  maps["creationParams"], datas, returnType, vars, props),
              creationParamsCodec: getValue(
                  maps["creationParamsCodec"], datas, returnType, vars, props),
              onFocus:
                  getValue(maps["onFocus"], datas, returnType, vars, props));
        // case "synchronizeToNativeViewHierarchy":
        //   if (maps["0"] == null) {
        //     return null;
        //   }
        //   return PlatformViewsService.synchronizeToNativeViewHierarchy(
        //       getValue(maps["0"], datas, returnType, vars, props)!);
        case "initUiKitView":
          if (maps["id"] == null ||
              maps["viewType"] == null ||
              maps["layoutDirection"] == null) {
            return null;
          }
          return PlatformViewsService.initUiKitView(
              id: getValue(maps["id"], datas, returnType, vars, props)!,
              viewType:
                  getValue(maps["viewType"], datas, returnType, vars, props)!,
              layoutDirection: getValue(
                  maps["layoutDirection"], datas, returnType, vars, props)!,
              creationParams: getValue(
                  maps["creationParams"], datas, returnType, vars, props),
              creationParamsCodec: getValue(
                  maps["creationParamsCodec"], datas, returnType, vars, props),
              onFocus:
                  getValue(maps["onFocus"], datas, returnType, vars, props));
      }
    },
    "PluginUtilities": () {
      switch (value) {
        case "getCallbackHandle":
          if (maps["0"] == null) {
            return null;
          }
          return PluginUtilities.getCallbackHandle(
              getValue(maps["0"], datas, returnType, vars, props)!);
        case "getCallbackFromHandle":
          if (maps["0"] == null) {
            return null;
          }
          return PluginUtilities.getCallbackFromHandle(
              getValue(maps["0"], datas, returnType, vars, props)!);
      }
    },
    "PointerEvent": () {
      switch (value) {
        case "transformPosition":
          if (maps["0"] == null || maps["1"] == null) {
            return null;
          }
          return PointerEvent.transformPosition(
              getValue(maps["0"], datas, returnType, vars, props)!,
              getValue(maps["1"], datas, returnType, vars, props)!);
        case "transformDeltaViaPositions":
          if (maps["untransformedEndPosition"] == null ||
              maps["untransformedDelta"] == null ||
              maps["transform"] == null) {
            return null;
          }
          return PointerEvent.transformDeltaViaPositions(
              untransformedEndPosition: getValue(
                  maps["untransformedEndPosition"],
                  datas,
                  returnType,
                  vars,
                  props)!,
              transformedEndPosition: getValue(maps["transformedEndPosition"],
                  datas, returnType, vars, props),
              untransformedDelta: getValue(
                  maps["untransformedDelta"], datas, returnType, vars, props)!,
              transform:
                  getValue(maps["transform"], datas, returnType, vars, props)!);
        case "removePerspectiveTransform":
          if (maps["0"] == null) {
            return null;
          }
          return PointerEvent.removePerspectiveTransform(
              getValue(maps["0"], datas, returnType, vars, props)!);
      }
    },
    "PointerEventConverter": () {
      switch (value) {
        case "expand":
          if (maps["0"] == null || maps["1"] == null) {
            return null;
          }
          return PointerEventConverter.expand(
              getValue(maps["0"], datas, returnType, vars, props)!,
              getValue(maps["1"], datas, returnType, vars, props).toDouble()!);
      }
    },
    "PopupMenuTheme": () {
      switch (value) {
        case "of":
          if (maps["0"] == null) {
            return null;
          }
          return PopupMenuTheme.of(
              getValue(maps["0"], datas, returnType, vars, props)!);
      }
    },
    "PopupMenuThemeData": () {
      switch (value) {
        case "lerp":
          if (maps["0"] == null || maps["1"] == null || maps["2"] == null) {
            return null;
          }
          return PopupMenuThemeData.lerp(
              getValue(maps["0"], datas, returnType, vars, props)!,
              getValue(maps["1"], datas, returnType, vars, props)!,
              getValue(maps["2"], datas, returnType, vars, props).toDouble()!);
      }
    },
    "PrimaryScrollController": () {
      switch (value) {
        case "shouldInherit":
          if (maps["0"] == null || maps["1"] == null) {
            return null;
          }
          return PrimaryScrollController.shouldInherit(
              getValue(maps["0"], datas, returnType, vars, props)!,
              getValue(maps["1"], datas, returnType, vars, props)!);
        case "maybeOf":
          if (maps["0"] == null) {
            return null;
          }
          return PrimaryScrollController.maybeOf(
              getValue(maps["0"], datas, returnType, vars, props)!);
        case "of":
          if (maps["0"] == null) {
            return null;
          }
          return PrimaryScrollController.of(
              getValue(maps["0"], datas, returnType, vars, props)!);
      }
    },
    "Priority": () {
      switch (value) {
        case "idle":
          return Priority.idle;
        case "animation":
          return Priority.animation;
        case "touch":
          return Priority.touch;
        case "kMaxOffset":
          return Priority.kMaxOffset;
      }
    },
    "ProgressIndicatorTheme": () {
      switch (value) {
        case "of":
          if (maps["0"] == null) {
            return null;
          }
          return ProgressIndicatorTheme.of(
              getValue(maps["0"], datas, returnType, vars, props)!);
      }
    },
    "ProgressIndicatorThemeData": () {
      switch (value) {
        case "lerp":
          if (maps["0"] == null || maps["1"] == null || maps["2"] == null) {
            return null;
          }
          return ProgressIndicatorThemeData.lerp(
              getValue(maps["0"], datas, returnType, vars, props)!,
              getValue(maps["1"], datas, returnType, vars, props)!,
              getValue(maps["2"], datas, returnType, vars, props).toDouble()!);
      }
    },
    "RRect": () {
      switch (value) {
        case "zero":
          return RRect.zero;
        case "lerp":
          if (maps["0"] == null || maps["1"] == null || maps["2"] == null) {
            return null;
          }
          return RRect.lerp(
              getValue(maps["0"], datas, returnType, vars, props)!,
              getValue(maps["1"], datas, returnType, vars, props)!,
              getValue(maps["2"], datas, returnType, vars, props).toDouble()!);
      }
    },
    "RadialGradient": () {
      switch (value) {
        case "lerp":
          if (maps["0"] == null || maps["1"] == null || maps["2"] == null) {
            return null;
          }
          return RadialGradient.lerp(
              getValue(maps["0"], datas, returnType, vars, props)!,
              getValue(maps["1"], datas, returnType, vars, props)!,
              getValue(maps["2"], datas, returnType, vars, props).toDouble()!);
      }
    },
    "RadioTheme": () {
      switch (value) {
        case "of":
          if (maps["0"] == null) {
            return null;
          }
          return RadioTheme.of(
              getValue(maps["0"], datas, returnType, vars, props)!);
      }
    },
    "RadioThemeData": () {
      switch (value) {
        case "lerp":
          if (maps["0"] == null || maps["1"] == null || maps["2"] == null) {
            return null;
          }
          return RadioThemeData.lerp(
              getValue(maps["0"], datas, returnType, vars, props)!,
              getValue(maps["1"], datas, returnType, vars, props)!,
              getValue(maps["2"], datas, returnType, vars, props).toDouble()!);
      }
    },
    "Radius": () {
      switch (value) {
        case "zero":
          return Radius.zero;
        case "lerp":
          if (maps["0"] == null || maps["1"] == null || maps["2"] == null) {
            return null;
          }
          return Radius.lerp(
              getValue(maps["0"], datas, returnType, vars, props)!,
              getValue(maps["1"], datas, returnType, vars, props)!,
              getValue(maps["2"], datas, returnType, vars, props).toDouble()!);
      }
    },
    "RawAutocomplete": () {
      switch (value) {
        case "onFieldSubmitted":
          if (maps["0"] == null) {
            return null;
          }
          RawAutocomplete.onFieldSubmitted(
              getValue(maps["0"], datas, returnType, vars, props)!);
        case "defaultStringForOption":
          if (maps["0"] == null) {
            return null;
          }
          return RawAutocomplete.defaultStringForOption(
              getValue(maps["0"], datas, returnType, vars, props)!);
      }
    },
    "RawKeyEventDataAndroid": () {
      switch (value) {
        case "modifierNone":
          return RawKeyEventDataAndroid.modifierNone;
        case "modifierAlt":
          return RawKeyEventDataAndroid.modifierAlt;
        case "modifierLeftAlt":
          return RawKeyEventDataAndroid.modifierLeftAlt;
        case "modifierRightAlt":
          return RawKeyEventDataAndroid.modifierRightAlt;
        case "modifierShift":
          return RawKeyEventDataAndroid.modifierShift;
        case "modifierLeftShift":
          return RawKeyEventDataAndroid.modifierLeftShift;
        case "modifierRightShift":
          return RawKeyEventDataAndroid.modifierRightShift;
        case "modifierSym":
          return RawKeyEventDataAndroid.modifierSym;
        case "modifierControl":
          return RawKeyEventDataAndroid.modifierControl;
        case "modifierLeftControl":
          return RawKeyEventDataAndroid.modifierLeftControl;
        case "modifierRightControl":
          return RawKeyEventDataAndroid.modifierRightControl;
        case "modifierMeta":
          return RawKeyEventDataAndroid.modifierMeta;
        case "modifierLeftMeta":
          return RawKeyEventDataAndroid.modifierLeftMeta;
        case "modifierRightMeta":
          return RawKeyEventDataAndroid.modifierRightMeta;
        case "modifierCapsLock":
          return RawKeyEventDataAndroid.modifierCapsLock;
        case "modifierNumLock":
          return RawKeyEventDataAndroid.modifierNumLock;
        case "modifierScrollLock":
          return RawKeyEventDataAndroid.modifierScrollLock;
      }
    },
    "RawKeyEventDataFuchsia": () {
      switch (value) {
        case "modifierNone":
          return RawKeyEventDataFuchsia.modifierNone;
        case "modifierCapsLock":
          return RawKeyEventDataFuchsia.modifierCapsLock;
        case "modifierLeftShift":
          return RawKeyEventDataFuchsia.modifierLeftShift;
        case "modifierRightShift":
          return RawKeyEventDataFuchsia.modifierRightShift;
        case "modifierShift":
          return RawKeyEventDataFuchsia.modifierShift;
        case "modifierLeftControl":
          return RawKeyEventDataFuchsia.modifierLeftControl;
        case "modifierRightControl":
          return RawKeyEventDataFuchsia.modifierRightControl;
        case "modifierControl":
          return RawKeyEventDataFuchsia.modifierControl;
        case "modifierLeftAlt":
          return RawKeyEventDataFuchsia.modifierLeftAlt;
        case "modifierRightAlt":
          return RawKeyEventDataFuchsia.modifierRightAlt;
        case "modifierAlt":
          return RawKeyEventDataFuchsia.modifierAlt;
        case "modifierLeftMeta":
          return RawKeyEventDataFuchsia.modifierLeftMeta;
        case "modifierRightMeta":
          return RawKeyEventDataFuchsia.modifierRightMeta;
        case "modifierMeta":
          return RawKeyEventDataFuchsia.modifierMeta;
      }
    },
    "RawKeyEventDataIos": () {
      switch (value) {
        case "modifierCapsLock":
          return RawKeyEventDataIos.modifierCapsLock;
        case "modifierShift":
          return RawKeyEventDataIos.modifierShift;
        case "modifierLeftShift":
          return RawKeyEventDataIos.modifierLeftShift;
        case "modifierRightShift":
          return RawKeyEventDataIos.modifierRightShift;
        case "modifierControl":
          return RawKeyEventDataIos.modifierControl;
        case "modifierLeftControl":
          return RawKeyEventDataIos.modifierLeftControl;
        case "modifierRightControl":
          return RawKeyEventDataIos.modifierRightControl;
        case "modifierOption":
          return RawKeyEventDataIos.modifierOption;
        case "modifierLeftOption":
          return RawKeyEventDataIos.modifierLeftOption;
        case "modifierRightOption":
          return RawKeyEventDataIos.modifierRightOption;
        case "modifierCommand":
          return RawKeyEventDataIos.modifierCommand;
        case "modifierLeftCommand":
          return RawKeyEventDataIos.modifierLeftCommand;
        case "modifierRightCommand":
          return RawKeyEventDataIos.modifierRightCommand;
        case "modifierNumericPad":
          return RawKeyEventDataIos.modifierNumericPad;
        case "modifierHelp":
          return RawKeyEventDataIos.modifierHelp;
        case "deviceIndependentMask":
          return RawKeyEventDataIos.deviceIndependentMask;
      }
    },
    "RawKeyEventDataMacOs": () {
      switch (value) {
        case "modifierCapsLock":
          return RawKeyEventDataMacOs.modifierCapsLock;
        case "modifierShift":
          return RawKeyEventDataMacOs.modifierShift;
        case "modifierLeftShift":
          return RawKeyEventDataMacOs.modifierLeftShift;
        case "modifierRightShift":
          return RawKeyEventDataMacOs.modifierRightShift;
        case "modifierControl":
          return RawKeyEventDataMacOs.modifierControl;
        case "modifierLeftControl":
          return RawKeyEventDataMacOs.modifierLeftControl;
        case "modifierRightControl":
          return RawKeyEventDataMacOs.modifierRightControl;
        case "modifierOption":
          return RawKeyEventDataMacOs.modifierOption;
        case "modifierLeftOption":
          return RawKeyEventDataMacOs.modifierLeftOption;
        case "modifierRightOption":
          return RawKeyEventDataMacOs.modifierRightOption;
        case "modifierCommand":
          return RawKeyEventDataMacOs.modifierCommand;
        case "modifierLeftCommand":
          return RawKeyEventDataMacOs.modifierLeftCommand;
        case "modifierRightCommand":
          return RawKeyEventDataMacOs.modifierRightCommand;
        case "modifierNumericPad":
          return RawKeyEventDataMacOs.modifierNumericPad;
        case "modifierHelp":
          return RawKeyEventDataMacOs.modifierHelp;
        case "deviceIndependentMask":
          return RawKeyEventDataMacOs.deviceIndependentMask;
      }
    },
    "RawKeyEventDataWeb": () {
      switch (value) {
        case "modifierNone":
          return RawKeyEventDataWeb.modifierNone;
        case "modifierShift":
          return RawKeyEventDataWeb.modifierShift;
        case "modifierAlt":
          return RawKeyEventDataWeb.modifierAlt;
        case "modifierControl":
          return RawKeyEventDataWeb.modifierControl;
        case "modifierMeta":
          return RawKeyEventDataWeb.modifierMeta;
        case "modifierNumLock":
          return RawKeyEventDataWeb.modifierNumLock;
        case "modifierCapsLock":
          return RawKeyEventDataWeb.modifierCapsLock;
        case "modifierScrollLock":
          return RawKeyEventDataWeb.modifierScrollLock;
      }
    },
    "RawKeyEventDataWindows": () {
      switch (value) {
        case "modifierShift":
          return RawKeyEventDataWindows.modifierShift;
        case "modifierLeftShift":
          return RawKeyEventDataWindows.modifierLeftShift;
        case "modifierRightShift":
          return RawKeyEventDataWindows.modifierRightShift;
        case "modifierControl":
          return RawKeyEventDataWindows.modifierControl;
        case "modifierLeftControl":
          return RawKeyEventDataWindows.modifierLeftControl;
        case "modifierRightControl":
          return RawKeyEventDataWindows.modifierRightControl;
        case "modifierAlt":
          return RawKeyEventDataWindows.modifierAlt;
        case "modifierLeftAlt":
          return RawKeyEventDataWindows.modifierLeftAlt;
        case "modifierRightAlt":
          return RawKeyEventDataWindows.modifierRightAlt;
        case "modifierLeftMeta":
          return RawKeyEventDataWindows.modifierLeftMeta;
        case "modifierRightMeta":
          return RawKeyEventDataWindows.modifierRightMeta;
        case "modifierCaps":
          return RawKeyEventDataWindows.modifierCaps;
        case "modifierNumLock":
          return RawKeyEventDataWindows.modifierNumLock;
        case "modifierScrollLock":
          return RawKeyEventDataWindows.modifierScrollLock;
      }
    },
    "RawKeyboard": () {
      switch (value) {
        case "instance":
          return RawKeyboard.instance;
      }
    },
    "Rect": () {
      switch (value) {
        case "zero":
          return Rect.zero;
        case "largest":
          return Rect.largest;
        case "lerp":
          if (maps["0"] == null || maps["1"] == null || maps["2"] == null) {
            return null;
          }
          return Rect.lerp(
              getValue(maps["0"], datas, returnType, vars, props)!,
              getValue(maps["1"], datas, returnType, vars, props)!,
              getValue(maps["2"], datas, returnType, vars, props).toDouble()!);
      }
    },
    "RefreshProgressIndicator": () {
      switch (value) {
        case "defaultStrokeWidth":
          return RefreshProgressIndicator.defaultStrokeWidth;
      }
    },
    "RelativeRect": () {
      switch (value) {
        case "fill":
          return RelativeRect.fill;
        case "lerp":
          if (maps["0"] == null || maps["1"] == null || maps["2"] == null) {
            return null;
          }
          return RelativeRect.lerp(
              getValue(maps["0"], datas, returnType, vars, props)!,
              getValue(maps["1"], datas, returnType, vars, props)!,
              getValue(maps["2"], datas, returnType, vars, props).toDouble()!);
      }
    },
    "RenderErrorBox": () {
      switch (value) {
        case "padding":
          return RenderErrorBox.padding;
        case "minimumWidth":
          return RenderErrorBox.minimumWidth;
        case "backgroundColor":
          return RenderErrorBox.backgroundColor;
        case "textStyle":
          return RenderErrorBox.textStyle;
        case "paragraphStyle":
          return RenderErrorBox.paragraphStyle;
      }
    },
    "RenderListWheelViewport": () {
      switch (value) {
        case "defaultDiameterRatio":
          return RenderListWheelViewport.defaultDiameterRatio;
        case "defaultPerspective":
          return RenderListWheelViewport.defaultPerspective;
        case "diameterRatioZeroMessage":
          return RenderListWheelViewport.diameterRatioZeroMessage;
        case "perspectiveTooHighMessage":
          return RenderListWheelViewport.perspectiveTooHighMessage;
        case "clipBehaviorAndRenderChildrenOutsideViewportConflict":
          return RenderListWheelViewport
              .clipBehaviorAndRenderChildrenOutsideViewportConflict;
      }
    },
    "RenderObject": () {
      switch (value) {
        case "debugActiveLayout":
          return RenderObject.debugActiveLayout;
        case "debugCheckingIntrinsics":
          return RenderObject.debugCheckingIntrinsics;
      }
    },
    "RenderStack": () {
      switch (value) {
        case "getIntrinsicDimension":
          if (maps["0"] == null || maps["1"] == null) {
            return null;
          }
          return RenderStack.getIntrinsicDimension(
              getValue(maps["0"], datas, returnType, vars, props)!,
              getValue(maps["1"], datas, returnType, vars, props)!);
        case "layoutPositionedChild":
          if (maps["0"] == null ||
              maps["1"] == null ||
              maps["2"] == null ||
              maps["3"] == null) {
            return null;
          }
          return RenderStack.layoutPositionedChild(
              getValue(maps["0"], datas, returnType, vars, props)!,
              getValue(maps["1"], datas, returnType, vars, props)!,
              getValue(maps["2"], datas, returnType, vars, props)!,
              getValue(maps["3"], datas, returnType, vars, props)!);
      }
    },
    "RenderViewport": () {
      switch (value) {
        case "useTwoPaneSemantics":
          return RenderViewport.useTwoPaneSemantics;
        case "excludeFromScrolling":
          return RenderViewport.excludeFromScrolling;
      }
    },
    "RenderingFlutterBinding": () {
      switch (value) {
        case "ensureInitialized":
          return RenderingFlutterBinding.ensureInitialized();
      }
    },
    "ReorderableList": () {
      switch (value) {
        case "of":
          if (maps["0"] == null) {
            return null;
          }
          return ReorderableList.of(
              getValue(maps["0"], datas, returnType, vars, props)!);
        case "maybeOf":
          if (maps["0"] == null) {
            return null;
          }
          return ReorderableList.maybeOf(
              getValue(maps["0"], datas, returnType, vars, props)!);
      }
    },
    "RepaintBoundary": () {
      switch (value) {
        case "wrapAll":
          if (maps["0"] == null) {
            return null;
          }
          return RepaintBoundary.wrapAll(List<Widget>.from(
              getValue(maps["0"], datas, returnType, vars, props)));
      }
    },
    "ResizeImage": () {
      switch (value) {
        case "resizeIfNeeded":
          if (maps["0"] == null || maps["1"] == null || maps["2"] == null) {
            return null;
          }
          return ResizeImage.resizeIfNeeded(
              getValue(maps["0"], datas, returnType, vars, props)!,
              getValue(maps["1"], datas, returnType, vars, props)!,
              getValue(maps["2"], datas, returnType, vars, props)!);
      }
    },
    "RestorationScope": () {
      switch (value) {
        case "maybeOf":
          if (maps["0"] == null) {
            return null;
          }
          return RestorationScope.maybeOf(
              getValue(maps["0"], datas, returnType, vars, props)!);
        case "of":
          if (maps["0"] == null) {
            return null;
          }
          return RestorationScope.of(
              getValue(maps["0"], datas, returnType, vars, props)!);
      }
    },
    "RootIsolateToken": () {
      switch (value) {
        case "instance":
          return RootIsolateToken.instance;
      }
    },
    "Router": () {
      switch (value) {
        case "of":
          if (maps["0"] == null) {
            return null;
          }
          return Router.of(
              getValue(maps["0"], datas, returnType, vars, props)!);
        case "maybeOf":
          if (maps["0"] == null) {
            return null;
          }
          return Router.maybeOf(
              getValue(maps["0"], datas, returnType, vars, props)!);
        case "navigate":
          if (maps["0"] == null || maps["1"] == null) {
            return null;
          }
          Router.navigate(getValue(maps["0"], datas, returnType, vars, props)!,
              getValue(maps["1"], datas, returnType, vars, props)!);
        case "neglect":
          if (maps["0"] == null || maps["1"] == null) {
            return null;
          }
          Router.neglect(getValue(maps["0"], datas, returnType, vars, props)!,
              getValue(maps["1"], datas, returnType, vars, props)!);
      }
    },
    "Scaffold": () {
      switch (value) {
        case "of":
          if (maps["0"] == null) {
            return null;
          }
          return Scaffold.of(
              getValue(maps["0"], datas, returnType, vars, props)!);
        case "maybeOf":
          if (maps["0"] == null) {
            return null;
          }
          return Scaffold.maybeOf(
              getValue(maps["0"], datas, returnType, vars, props)!);
        case "geometryOf":
          if (maps["0"] == null) {
            return null;
          }
          return Scaffold.geometryOf(
              getValue(maps["0"], datas, returnType, vars, props)!);
        case "hasDrawer":
          if (maps["0"] == null) {
            return null;
          }
          return Scaffold.hasDrawer(
              getValue(maps["0"], datas, returnType, vars, props)!,
              registerForUpdates: getValue(maps["registerForUpdates"], datas,
                      returnType, vars, props) ??
                  true);
      }
    },
    "ScaffoldMessenger": () {
      switch (value) {
        case "of":
          if (maps["0"] == null) {
            return null;
          }
          return ScaffoldMessenger.of(
              getValue(maps["0"], datas, returnType, vars, props)!);
        case "maybeOf":
          if (maps["0"] == null) {
            return null;
          }
          return ScaffoldMessenger.maybeOf(
              getValue(maps["0"], datas, returnType, vars, props)!);
      }
    },
    "ScrollAction": () {
      switch (value) {
        case "getDirectionalIncrement":
          if (maps["0"] == null || maps["1"] == null) {
            return null;
          }
          return ScrollAction.getDirectionalIncrement(
              getValue(maps["0"], datas, returnType, vars, props)!,
              getValue(maps["1"], datas, returnType, vars, props)!);
      }
    },
    "ScrollConfiguration": () {
      switch (value) {
        case "of":
          if (maps["0"] == null) {
            return null;
          }
          return ScrollConfiguration.of(
              getValue(maps["0"], datas, returnType, vars, props)!);
      }
    },
    "ScrollDragController": () {
      switch (value) {
        case "momentumRetainStationaryDurationThreshold":
          return ScrollDragController.momentumRetainStationaryDurationThreshold;
        case "momentumRetainVelocityThresholdFactor":
          return ScrollDragController.momentumRetainVelocityThresholdFactor;
        case "motionStoppedDurationThreshold":
          return ScrollDragController.motionStoppedDurationThreshold;
      }
    },
    "ScrollNotificationObserver": () {
      switch (value) {
        case "maybeOf":
          if (maps["0"] == null) {
            return null;
          }
          return ScrollNotificationObserver.maybeOf(
              getValue(maps["0"], datas, returnType, vars, props)!);
        case "of":
          if (maps["0"] == null) {
            return null;
          }
          return ScrollNotificationObserver.of(
              getValue(maps["0"], datas, returnType, vars, props)!);
      }
    },
    "Scrollable": () {
      switch (value) {
        case "maybeOf":
          if (maps["0"] == null) {
            return null;
          }
          return Scrollable.maybeOf(
              getValue(maps["0"], datas, returnType, vars, props)!);
        case "of":
          if (maps["0"] == null) {
            return null;
          }
          return Scrollable.of(
              getValue(maps["0"], datas, returnType, vars, props)!);
        case "recommendDeferredLoadingForContext":
          if (maps["0"] == null) {
            return null;
          }
          return Scrollable.recommendDeferredLoadingForContext(
              getValue(maps["0"], datas, returnType, vars, props)!);
        case "ensureVisible":
          if (maps["0"] == null) {
            return null;
          }
          return Scrollable.ensureVisible(
              getValue(maps["0"], datas, returnType, vars, props)!,
              alignment:
                  getValue(maps["alignment"], datas, returnType, vars, props)
                          .toDouble() ??
                      0.0,
              duration:
                  getValue(maps["duration"], datas, returnType, vars, props) ??
                      Duration.zero,
              curve: getValue(maps["curve"], datas, returnType, vars, props) ??
                  Curves.ease,
              alignmentPolicy: getValue(maps["alignmentPolicy"], datas,
                      returnType, vars, props) ??
                  ScrollPositionAlignmentPolicy.explicit);
      }
    },
    "ScrollbarTheme": () {
      switch (value) {
        case "of":
          if (maps["0"] == null) {
            return null;
          }
          return ScrollbarTheme.of(
              getValue(maps["0"], datas, returnType, vars, props)!);
      }
    },
    "ScrollbarThemeData": () {
      switch (value) {
        case "lerp":
          if (maps["0"] == null || maps["1"] == null || maps["2"] == null) {
            return null;
          }
          return ScrollbarThemeData.lerp(
              getValue(maps["0"], datas, returnType, vars, props)!,
              getValue(maps["1"], datas, returnType, vars, props)!,
              getValue(maps["2"], datas, returnType, vars, props).toDouble()!);
      }
    },
    "SearchBarTheme": () {
      switch (value) {
        case "of":
          if (maps["0"] == null) {
            return null;
          }
          return SearchBarTheme.of(
              getValue(maps["0"], datas, returnType, vars, props)!);
      }
    },
    "SearchBarThemeData": () {
      switch (value) {
        case "lerp":
          if (maps["0"] == null || maps["1"] == null || maps["2"] == null) {
            return null;
          }
          return SearchBarThemeData.lerp(
              getValue(maps["0"], datas, returnType, vars, props)!,
              getValue(maps["1"], datas, returnType, vars, props)!,
              getValue(maps["2"], datas, returnType, vars, props).toDouble()!);
      }
    },
    "SearchViewTheme": () {
      switch (value) {
        case "of":
          if (maps["0"] == null) {
            return null;
          }
          return SearchViewTheme.of(
              getValue(maps["0"], datas, returnType, vars, props)!);
      }
    },
    "SearchViewThemeData": () {
      switch (value) {
        case "lerp":
          if (maps["0"] == null || maps["1"] == null || maps["2"] == null) {
            return null;
          }
          return SearchViewThemeData.lerp(
              getValue(maps["0"], datas, returnType, vars, props)!,
              getValue(maps["1"], datas, returnType, vars, props)!,
              getValue(maps["2"], datas, returnType, vars, props).toDouble()!);
      }
    },
    "SegmentedButtonTheme": () {
      switch (value) {
        case "of":
          if (maps["0"] == null) {
            return null;
          }
          return SegmentedButtonTheme.of(
              getValue(maps["0"], datas, returnType, vars, props)!);
        case "maybeOf":
          if (maps["0"] == null) {
            return null;
          }
          return SegmentedButtonTheme.maybeOf(
              getValue(maps["0"], datas, returnType, vars, props)!);
      }
    },
    "SegmentedButtonThemeData": () {
      switch (value) {
        case "lerp":
          if (maps["0"] == null || maps["1"] == null || maps["2"] == null) {
            return null;
          }
          return SegmentedButtonThemeData.lerp(
              getValue(maps["0"], datas, returnType, vars, props)!,
              getValue(maps["1"], datas, returnType, vars, props)!,
              getValue(maps["2"], datas, returnType, vars, props).toDouble()!);
      }
    },
    "SelectableRegion": () {
      switch (value) {
        case "getSelectableButtonItems":
          if (maps["SelectionGeometry"] == null ||
              maps["onCopy"] == null ||
              maps["onSelectAll"] == null) {
            return null;
          }
          return SelectableRegion.getSelectableButtonItems(
            selectionGeometry: getValue(
                maps["selectionGeometry"], datas, returnType, vars, props)!,
            onCopy: getValue(maps["onCopy"], datas, returnType, vars, props)!,
            onSelectAll:
                getValue(maps["onSelectAll"], datas, returnType, vars, props)!,
            //onShare: getValue(maps["onShare"], datas, returnType, vars, props)!,
          );
      }
    },
    "SelectionContainer": () {
      switch (value) {
        case "maybeOf":
          if (maps["0"] == null) {
            return null;
          }
          return SelectionContainer.maybeOf(
              getValue(maps["0"], datas, returnType, vars, props)!);
      }
    },
    "SelectionOverlay": () {
      switch (value) {
        case "fadeDuration":
          return SelectionOverlay.fadeDuration;
      }
    },
    "SelectionUtils": () {
      switch (value) {
        case "getResultBasedOnRect":
          if (maps["0"] == null || maps["1"] == null) {
            return null;
          }
          return SelectionUtils.getResultBasedOnRect(
              getValue(maps["0"], datas, returnType, vars, props)!,
              getValue(maps["1"], datas, returnType, vars, props)!);
        case "adjustDragOffset":
          if (maps["0"] == null || maps["1"] == null) {
            return null;
          }
          return SelectionUtils.adjustDragOffset(
              getValue(maps["0"], datas, returnType, vars, props)!,
              getValue(maps["1"], datas, returnType, vars, props)!,
              direction:
                  getValue(maps["direction"], datas, returnType, vars, props) ??
                      TextDirection.ltr);
      }
    },
    "SemanticsAction": () {
      switch (value) {
        case "tap":
          return SemanticsAction.tap;
        case "longPress":
          return SemanticsAction.longPress;
        case "scrollLeft":
          return SemanticsAction.scrollLeft;
        case "scrollRight":
          return SemanticsAction.scrollRight;
        case "scrollUp":
          return SemanticsAction.scrollUp;
        case "scrollDown":
          return SemanticsAction.scrollDown;
        case "increase":
          return SemanticsAction.increase;
        case "decrease":
          return SemanticsAction.decrease;
        case "showOnScreen":
          return SemanticsAction.showOnScreen;
        case "moveCursorForwardByCharacter":
          return SemanticsAction.moveCursorForwardByCharacter;
        case "moveCursorBackwardByCharacter":
          return SemanticsAction.moveCursorBackwardByCharacter;
        case "setText":
          return SemanticsAction.setText;
        case "setSelection":
          return SemanticsAction.setSelection;
        case "copy":
          return SemanticsAction.copy;
        case "cut":
          return SemanticsAction.cut;
        case "paste":
          return SemanticsAction.paste;
        case "didGainAccessibilityFocus":
          return SemanticsAction.didGainAccessibilityFocus;
        case "didLoseAccessibilityFocus":
          return SemanticsAction.didLoseAccessibilityFocus;
        case "customAction":
          return SemanticsAction.customAction;
        case "dismiss":
          return SemanticsAction.dismiss;
        case "moveCursorForwardByWord":
          return SemanticsAction.moveCursorForwardByWord;
        case "moveCursorBackwardByWord":
          return SemanticsAction.moveCursorBackwardByWord;
        case "values":
          return SemanticsAction.values;
        // case "doNotUseWillBeDeletedWithoutWarningValuesAsList":
        //   return SemanticsAction
        //       .doNotUseWillBeDeletedWithoutWarningValuesAsList;
        // case "doNotUseWillBeDeletedWithoutWarningKeys":
        //   return SemanticsAction.doNotUseWillBeDeletedWithoutWarningKeys;
      }
    },
    "SemanticsFlag": () {
      switch (value) {
        case "hasCheckedState":
          return SemanticsFlag.hasCheckedState;
        case "isChecked":
          return SemanticsFlag.isChecked;
        case "isCheckStateMixed":
          return SemanticsFlag.isCheckStateMixed;
        case "isSelected":
          return SemanticsFlag.isSelected;
        case "isButton":
          return SemanticsFlag.isButton;
        case "isTextField":
          return SemanticsFlag.isTextField;
        case "isSlider":
          return SemanticsFlag.isSlider;
        case "isKeyboardKey":
          return SemanticsFlag.isKeyboardKey;
        case "isReadOnly":
          return SemanticsFlag.isReadOnly;
        case "isLink":
          return SemanticsFlag.isLink;
        case "isFocusable":
          return SemanticsFlag.isFocusable;
        case "isFocused":
          return SemanticsFlag.isFocused;
        case "hasEnabledState":
          return SemanticsFlag.hasEnabledState;
        case "isEnabled":
          return SemanticsFlag.isEnabled;
        case "isInMutuallyExclusiveGroup":
          return SemanticsFlag.isInMutuallyExclusiveGroup;
        case "isHeader":
          return SemanticsFlag.isHeader;
        case "isObscured":
          return SemanticsFlag.isObscured;
        case "isMultiline":
          return SemanticsFlag.isMultiline;
        case "scopesRoute":
          return SemanticsFlag.scopesRoute;
        case "namesRoute":
          return SemanticsFlag.namesRoute;
        case "isHidden":
          return SemanticsFlag.isHidden;
        case "isImage":
          return SemanticsFlag.isImage;
        case "isLiveRegion":
          return SemanticsFlag.isLiveRegion;
        case "hasToggledState":
          return SemanticsFlag.hasToggledState;
        case "isToggled":
          return SemanticsFlag.isToggled;
        case "hasImplicitScrolling":
          return SemanticsFlag.hasImplicitScrolling;
        case "values":
          return SemanticsFlag.values;
        // case "doNotUseWillBeDeletedWithoutWarningValuesAsList":
        //   if (maps["0"] == null) {
        //     return null;
        //   }
        //   return SemanticsFlag.doNotUseWillBeDeletedWithoutWarningValuesAsList;
        // case "doNotUseWillBeDeletedWithoutWarningKeys":
        //   return SemanticsFlag.doNotUseWillBeDeletedWithoutWarningKeys;
      }
    },
    "SemanticsService": () {
      switch (value) {
        case "announce":
          if (maps["0"] == null || maps["1"] == null) {
            return null;
          }
          return SemanticsService.announce(
              getValue(maps["0"], datas, returnType, vars, props)!,
              getValue(maps["1"], datas, returnType, vars, props)!,
              assertiveness: getValue(
                      maps["assertiveness"], datas, returnType, vars, props) ??
                  Assertiveness.polite);
        case "tooltip":
          if (maps["0"] == null) {
            return null;
          }
          return SemanticsService.tooltip(
              getValue(maps["0"], datas, returnType, vars, props)!);
      }
    },
    "Set": () {
      switch (value) {
        case "castFrom":
          if (maps["0"] == null) {
            return null;
          }
          return Set.castFrom(
              Set<S>.from(getValue(maps["0"], datas, returnType, vars, props)),
              newSet:
                  getValue(maps["newSet"], datas, returnType, vars, props) !=
                          null
                      ? getValue(maps["newSet"], datas, returnType, vars, props)
                      : null);
      }
    },
    "ShapeBorder": () {
      switch (value) {
        case "lerp":
          if (maps["0"] == null || maps["1"] == null || maps["2"] == null) {
            return null;
          }
          return ShapeBorder.lerp(
              getValue(maps["0"], datas, returnType, vars, props)!,
              getValue(maps["1"], datas, returnType, vars, props)!,
              getValue(maps["2"], datas, returnType, vars, props).toDouble()!);
      }
    },
    "ShapeDecoration": () {
      switch (value) {
        case "lerp":
          if (maps["0"] == null || maps["1"] == null || maps["2"] == null) {
            return null;
          }
          return ShapeDecoration.lerp(
              getValue(maps["0"], datas, returnType, vars, props)!,
              getValue(maps["1"], datas, returnType, vars, props)!,
              getValue(maps["2"], datas, returnType, vars, props).toDouble()!);
      }
    },
    "SharedAppData": () {
      switch (value) {
        case "getValue":
          if (maps["0"] == null || maps["1"] == null || maps["2"] == null) {
            return null;
          }
          return SharedAppData.getValue<T, V>(
              getValue(maps["0"], datas, returnType, vars, props)!,
              getValue(maps["1"], datas, returnType, vars, props)!,
              getValue(maps["2"], datas, returnType, vars, props)!);
        case "setValue":
          if (maps["0"] == null || maps["1"] == null || maps["2"] == null) {
            return null;
          }
          SharedAppData.setValue<T, V>(
              getValue(maps["0"], datas, returnType, vars, props)!,
              getValue(maps["1"], datas, returnType, vars, props)!,
              getValue(maps["2"], datas, returnType, vars, props)!);
      }
    },
    "ShortcutActivator": () {
      switch (value) {
        case "isActivatedBy":
          if (maps["0"] == null || maps["1"] == null) {
            return null;
          }
          return ShortcutActivator.isActivatedBy(
              getValue(maps["0"], datas, returnType, vars, props)!,
              getValue(maps["1"], datas, returnType, vars, props)!);
      }
    },
    "ShortcutRegistry": () {
      switch (value) {
        case "of":
          if (maps["0"] == null) {
            return null;
          }
          return ShortcutRegistry.of(
              getValue(maps["0"], datas, returnType, vars, props)!);
        case "maybeOf":
          if (maps["0"] == null) {
            return null;
          }
          return ShortcutRegistry.maybeOf(
              getValue(maps["0"], datas, returnType, vars, props)!);
      }
    },
    "Size": () {
      switch (value) {
        case "zero":
          return Size.zero;
        case "infinite":
          return Size.infinite;
        case "lerp":
          if (maps["0"] == null || maps["1"] == null || maps["2"] == null) {
            return null;
          }
          return Size.lerp(
              getValue(maps["0"], datas, returnType, vars, props)!,
              getValue(maps["1"], datas, returnType, vars, props)!,
              getValue(maps["2"], datas, returnType, vars, props).toDouble()!);
      }
    },
    "SliderComponentShape": () {
      switch (value) {
        case "noThumb":
          return SliderComponentShape.noThumb;
        case "noOverlay":
          return SliderComponentShape.noOverlay;
      }
    },
    "SliderTheme": () {
      switch (value) {
        case "of":
          if (maps["0"] == null) {
            return null;
          }
          return SliderTheme.of(
              getValue(maps["0"], datas, returnType, vars, props)!);
      }
    },
    "SliderThemeData": () {
      switch (value) {
        case "lerp":
          if (maps["0"] == null || maps["1"] == null || maps["2"] == null) {
            return null;
          }
          return SliderThemeData.lerp(
              getValue(maps["0"], datas, returnType, vars, props)!,
              getValue(maps["1"], datas, returnType, vars, props)!,
              getValue(maps["2"], datas, returnType, vars, props).toDouble()!);
      }
    },
    "SliderTickMarkShape": () {
      switch (value) {
        case "noTickMark":
          return SliderTickMarkShape.noTickMark;
      }
    },
    "SliverAnimatedGrid": () {
      switch (value) {
        case "of":
          if (maps["0"] == null) {
            return null;
          }
          return SliverAnimatedGrid.of(
              getValue(maps["0"], datas, returnType, vars, props)!);
        case "maybeOf":
          if (maps["0"] == null) {
            return null;
          }
          return SliverAnimatedGrid.maybeOf(
              getValue(maps["0"], datas, returnType, vars, props)!);
      }
    },
    "SliverAnimatedList": () {
      switch (value) {
        case "of":
          if (maps["0"] == null) {
            return null;
          }
          return SliverAnimatedList.of(
              getValue(maps["0"], datas, returnType, vars, props)!);
        case "maybeOf":
          if (maps["0"] == null) {
            return null;
          }
          return SliverAnimatedList.maybeOf(
              getValue(maps["0"], datas, returnType, vars, props)!);
      }
    },
    "SliverGeometry": () {
      switch (value) {
        case "zero":
          return SliverGeometry.zero;
      }
    },
    "SliverReorderableList": () {
      switch (value) {
        case "of":
          if (maps["0"] == null) {
            return null;
          }
          return SliverReorderableList.of(
              getValue(maps["0"], datas, returnType, vars, props)!);
        case "maybeOf":
          if (maps["0"] == null) {
            return null;
          }
          return SliverReorderableList.maybeOf(
              getValue(maps["0"], datas, returnType, vars, props)!);
      }
    },
    "SpellCheckSuggestionsToolbar": () {
      switch (value) {
        case "buildButtonItems":
          if (maps["0"] == null) {
            return null;
          }
          return SpellCheckSuggestionsToolbar.buildButtonItems(
              getValue(maps["0"], datas, returnType, vars, props)!);
        case "getToolbarAnchor":
          if (maps["0"] == null) {
            return null;
          }
          return SpellCheckSuggestionsToolbar.getToolbarAnchor(
              getValue(maps["0"], datas, returnType, vars, props)!);
      }
    },
    "StackFrame": () {
      switch (value) {
        case "asynchronousSuspension,)":
          return StackFrame.asynchronousSuspension;
        case "stackOverFlowElision":
          return StackFrame.stackOverFlowElision;
        case "fromStackTrace":
          if (maps["0"] == null) {
            return null;
          }
          return StackFrame.fromStackTrace(
              getValue(maps["0"], datas, returnType, vars, props)!);
        case "fromStackString":
          if (maps["0"] == null) {
            return null;
          }
          return StackFrame.fromStackString(
              getValue(maps["0"], datas, returnType, vars, props)!);
      }
    },
    "StrutStyle": () {
      switch (value) {}
    },
    "StrutStyle": () {
      switch (value) {
        case "disabled":
          return StrutStyle.disabled;
      }
    },
    "SubmenuButton": () {
      switch (value) {
        case "styleFrom":
          return SubmenuButton.styleFrom(
              foregroundColor: getValue(
                  maps["foregroundColor"], datas, returnType, vars, props),
              backgroundColor: getValue(
                  maps["backgroundColor"], datas, returnType, vars, props),
              disabledForegroundColor: getValue(maps["disabledForegroundColor"],
                  datas, returnType, vars, props),
              disabledBackgroundColor: getValue(maps["disabledBackgroundColor"],
                  datas, returnType, vars, props),
              shadowColor:
                  getValue(maps["shadowColor"], datas, returnType, vars, props),
              surfaceTintColor: getValue(
                  maps["surfaceTintColor"], datas, returnType, vars, props),
              iconColor:
                  getValue(maps["iconColor"], datas, returnType, vars, props),
              textStyle:
                  getValue(maps["textStyle"], datas, returnType, vars, props),
              elevation:
                  getValue(maps["elevation"], datas, returnType, vars, props)
                      ?.toDouble(),
              padding:
                  getValue(maps["padding"], datas, returnType, vars, props),
              minimumSize:
                  getValue(maps["minimumSize"], datas, returnType, vars, props),
              fixedSize:
                  getValue(maps["fixedSize"], datas, returnType, vars, props),
              maximumSize:
                  getValue(maps["maximumSize"], datas, returnType, vars, props),
              enabledMouseCursor: getValue(
                  maps["enabledMouseCursor"], datas, returnType, vars, props),
              disabledMouseCursor: getValue(
                  maps["disabledMouseCursor"], datas, returnType, vars, props),
              side: getValue(maps["side"], datas, returnType, vars, props),
              shape: getValue(maps["shape"], datas, returnType, vars, props),
              visualDensity: getValue(
                  maps["visualDensity"], datas, returnType, vars, props),
              tapTargetSize: getValue(
                  maps["tapTargetSize"], datas, returnType, vars, props),
              animationDuration: getValue(
                  maps["animationDuration"], datas, returnType, vars, props),
              enableFeedback: getValue(maps["enableFeedback"], datas, returnType, vars, props),
              alignment: getValue(maps["alignment"], datas, returnType, vars, props),
              splashFactory: getValue(maps["splashFactory"], datas, returnType, vars, props));
      }
    },
    "SweepGradient": () {
      switch (value) {
        case "lerp":
          if (maps["0"] == null || maps["1"] == null || maps["2"] == null) {
            return null;
          }
          return SweepGradient.lerp(
              getValue(maps["0"], datas, returnType, vars, props)!,
              getValue(maps["1"], datas, returnType, vars, props)!,
              getValue(maps["2"], datas, returnType, vars, props).toDouble()!);
      }
    },
    "SwitchTheme": () {
      switch (value) {
        case "of":
          if (maps["0"] == null) {
            return null;
          }
          return SwitchTheme.of(
              getValue(maps["0"], datas, returnType, vars, props)!);
      }
    },
    "SwitchThemeData": () {
      switch (value) {
        case "lerp":
          if (maps["0"] == null || maps["1"] == null || maps["2"] == null) {
            return null;
          }
          return SwitchThemeData.lerp(
              getValue(maps["0"], datas, returnType, vars, props)!,
              getValue(maps["1"], datas, returnType, vars, props)!,
              getValue(maps["2"], datas, returnType, vars, props).toDouble()!);
      }
    },
    "Symbol": () {
      switch (value) {
        case "unaryMinus":
          return Symbol.unaryMinus;
        case "empty":
          return Symbol.empty;
      }
    },
    "SystemChannels": () {
      switch (value) {
        case "navigation":
          return SystemChannels.navigation;
        case "platform":
          return SystemChannels.platform;
        case "textInput":
          return SystemChannels.textInput;
        case "spellCheck":
          return SystemChannels.spellCheck;
        case "undoManager":
          return SystemChannels.undoManager;
        case "keyEvent":
          return SystemChannels.keyEvent;
        case "lifecycle":
          return SystemChannels.lifecycle;
        case "system":
          return SystemChannels.system;
        case "accessibility":
          return SystemChannels.accessibility;
        case "platform_views":
          return SystemChannels.platform_views;
        case "skia":
          return SystemChannels.skia;
        case "mouseCursor":
          return SystemChannels.mouseCursor;
        case "restoration":
          return SystemChannels.restoration;
        case "deferredComponent":
          return SystemChannels.deferredComponent;
        case "localization":
          return SystemChannels.localization;
        case "menu":
          return SystemChannels.menu;
        case "contextMenu":
          return SystemChannels.contextMenu;
      }
    },
    "SystemChrome": () {
      switch (value) {
        case "setPreferredOrientations":
          if (maps["0"] == null) {
            return null;
          }
          return SystemChrome.setPreferredOrientations(
              List<DeviceOrientation>.from(
                  getValue(maps["0"], datas, returnType, vars, props)));
        case "setApplicationSwitcherDescription":
          if (maps["0"] == null) {
            return null;
          }
          return SystemChrome.setApplicationSwitcherDescription(
              getValue(maps["0"], datas, returnType, vars, props)!);
        case "setEnabledSystemUIMode":
          if (maps["0"] == null) {
            return null;
          }
          return SystemChrome.setEnabledSystemUIMode(
              getValue(maps["0"], datas, returnType, vars, props)!,
              overlays:
                  getValue(maps["overlays"], datas, returnType, vars, props) !=
                          null
                      ? List<SystemUiOverlay>.from(getValue(
                          maps["overlays"], datas, returnType, vars, props))
                      : null);
        case "setSystemUIChangeCallback":
          if (maps["0"] == null) {
            return null;
          }
          return SystemChrome.setSystemUIChangeCallback(
              getValue(maps["0"], datas, returnType, vars, props)!);
        case "restoreSystemUIOverlays":
          return SystemChrome.restoreSystemUIOverlays();
        case "setSystemUIOverlayStyle":
          if (maps["0"] == null) {
            return null;
          }
          SystemChrome.setSystemUIOverlayStyle(
              getValue(maps["0"], datas, returnType, vars, props)!);
        case "latestStyle":
          return SystemChrome.latestStyle;
      }
    },
    "SystemNavigator": () {
      switch (value) {
        case "pop":
          return SystemNavigator.pop(
              animated:
                  getValue(maps["animated"], datas, returnType, vars, props));
        case "selectSingleEntryHistory":
          return SystemNavigator.selectSingleEntryHistory();
        case "selectMultiEntryHistory":
          return SystemNavigator.selectMultiEntryHistory();
        case "routeInformationUpdated":
          if (maps["location"] == null) {
            return null;
          }
          return SystemNavigator.routeInformationUpdated(
              location:
                  getValue(maps["location"], datas, returnType, vars, props)!,
              state: getValue(maps["state"], datas, returnType, vars, props),
              replace:
                  getValue(maps["replace"], datas, returnType, vars, props) ??
                      false);
      }
    },
    "SystemSound": () {
      switch (value) {
        case "play":
          if (maps["0"] == null) {
            return null;
          }
          return SystemSound.play(
              getValue(maps["0"], datas, returnType, vars, props)!);
      }
    },
    "SystemUiOverlayStyle": () {
      switch (value) {
        case "light":
          return SystemUiOverlayStyle.light;
        case "dark":
          return SystemUiOverlayStyle.dark;
      }
    },
    "TabBarTheme": () {
      switch (value) {
        case "of":
          if (maps["0"] == null) {
            return null;
          }
          return TabBarTheme.of(
              getValue(maps["0"], datas, returnType, vars, props)!);
        case "lerp":
          if (maps["0"] == null || maps["1"] == null || maps["2"] == null) {
            return null;
          }
          return TabBarTheme.lerp(
              getValue(maps["0"], datas, returnType, vars, props)!,
              getValue(maps["1"], datas, returnType, vars, props)!,
              getValue(maps["2"], datas, returnType, vars, props).toDouble()!);
      }
    },
    "TableBorder": () {
      switch (value) {
        case "lerp":
          if (maps["0"] == null || maps["1"] == null || maps["2"] == null) {
            return null;
          }
          return TableBorder.lerp(
              getValue(maps["0"], datas, returnType, vars, props)!,
              getValue(maps["1"], datas, returnType, vars, props)!,
              getValue(maps["2"], datas, returnType, vars, props).toDouble()!);
      }
    },
    "TapRegionRegistry": () {
      switch (value) {
        case "of":
          if (maps["0"] == null) {
            return null;
          }
          return TapRegionRegistry.of(
              getValue(maps["0"], datas, returnType, vars, props)!);
        case "maybeOf":
          if (maps["0"] == null) {
            return null;
          }
          return TapRegionRegistry.maybeOf(
              getValue(maps["0"], datas, returnType, vars, props)!);
      }
    },
    "TextAlignVertical": () {
      switch (value) {
        case "top":
          return TextAlignVertical.top;
        case "center":
          return TextAlignVertical.center;
        case "bottom":
          return TextAlignVertical.bottom;
      }
    },
    "TextButton": () {
      switch (value) {
        case "styleFrom":
          return TextButton.styleFrom(
            foregroundColor: getValue(
                maps["foregroundColor"], datas, returnType, vars, props),
            backgroundColor: getValue(
                maps["backgroundColor"], datas, returnType, vars, props),
            disabledForegroundColor: getValue(maps["disabledForegroundColor"],
                datas, returnType, vars, props),
            disabledBackgroundColor: getValue(maps["disabledBackgroundColor"],
                datas, returnType, vars, props),
            shadowColor:
                getValue(maps["shadowColor"], datas, returnType, vars, props),
            surfaceTintColor: getValue(
                maps["surfaceTintColor"], datas, returnType, vars, props),
            iconColor:
                getValue(maps["iconColor"], datas, returnType, vars, props),
            disabledIconColor: getValue(
                maps["disabledIconColor"], datas, returnType, vars, props),
            elevation:
                getValue(maps["elevation"], datas, returnType, vars, props)
                    ?.toDouble(),
            textStyle:
                getValue(maps["textStyle"], datas, returnType, vars, props),
            padding: getValue(maps["padding"], datas, returnType, vars, props),
            minimumSize:
                getValue(maps["minimumSize"], datas, returnType, vars, props),
            fixedSize:
                getValue(maps["fixedSize"], datas, returnType, vars, props),
            maximumSize:
                getValue(maps["maximumSize"], datas, returnType, vars, props),
            side: getValue(maps["side"], datas, returnType, vars, props),
            shape: getValue(maps["shape"], datas, returnType, vars, props),
            enabledMouseCursor: getValue(
                maps["enabledMouseCursor"], datas, returnType, vars, props),
            disabledMouseCursor: getValue(
                maps["disabledMouseCursor"], datas, returnType, vars, props),
            visualDensity:
                getValue(maps["visualDensity"], datas, returnType, vars, props),
            tapTargetSize:
                getValue(maps["tapTargetSize"], datas, returnType, vars, props),
            animationDuration: getValue(
                maps["animationDuration"], datas, returnType, vars, props),
            enableFeedback: getValue(
                maps["enableFeedback"], datas, returnType, vars, props),
            alignment:
                getValue(maps["alignment"], datas, returnType, vars, props),
            splashFactory:
                getValue(maps["splashFactory"], datas, returnType, vars, props),
            // primary: getValue(maps["primary"], datas, returnType, vars, props),
            // onSurface: getValue(maps["onSurface"], datas, returnType, vars, props),
          );
      }
    },
    "TextButtonTheme": () {
      switch (value) {
        case "of":
          if (maps["0"] == null) {
            return null;
          }
          return TextButtonTheme.of(
              getValue(maps["0"], datas, returnType, vars, props)!);
      }
    },
    "TextButtonThemeData": () {
      switch (value) {
        case "lerp":
          if (maps["0"] == null || maps["1"] == null || maps["2"] == null) {
            return null;
          }
          return TextButtonThemeData.lerp(
              getValue(maps["0"], datas, returnType, vars, props)!,
              getValue(maps["1"], datas, returnType, vars, props)!,
              getValue(maps["2"], datas, returnType, vars, props).toDouble()!);
      }
    },
    "TextDecoration": () {
      switch (value) {
        case "none":
          return TextDecoration.none;
        case "underline":
          return TextDecoration.underline;
        case "overline":
          return TextDecoration.overline;
        case "lineThrough":
          return TextDecoration.lineThrough;
      }
    },
    "TextEditingValue": () {
      switch (value) {
        case "empty":
          return TextEditingValue.empty;
      }
    },
    "TextInput": () {
      switch (value) {
        case "setChannel":
          if (maps["0"] == null) {
            return null;
          }
          TextInput.setChannel(
              getValue(maps["0"], datas, returnType, vars, props)!);
        case "setInputControl":
          if (maps["0"] == null) {
            return null;
          }
          TextInput.setInputControl(
              getValue(maps["0"], datas, returnType, vars, props)!);
        case "restorePlatformInputControl":
          TextInput.restorePlatformInputControl();
        case "ensureInitialized":
          TextInput.ensureInitialized();
        case "attach":
          if (maps["0"] == null || maps["1"] == null) {
            return null;
          }
          return TextInput.attach(
              getValue(maps["0"], datas, returnType, vars, props)!,
              getValue(maps["1"], datas, returnType, vars, props)!);
        case "scribbleClients":
          return TextInput.scribbleClients;
        case "updateEditingValue":
          if (maps["0"] == null) {
            return null;
          }
          TextInput.updateEditingValue(
              getValue(maps["0"], datas, returnType, vars, props)!);
        case "finishAutofillContext":
          TextInput.finishAutofillContext(
              shouldSave: getValue(
                      maps["shouldSave"], datas, returnType, vars, props) ??
                  true);
        case "registerScribbleElement":
          if (maps["0"] == null || maps["1"] == null) {
            return null;
          }
          TextInput.registerScribbleElement(
              getValue(maps["0"], datas, returnType, vars, props)!,
              getValue(maps["1"], datas, returnType, vars, props)!);
        case "unregisterScribbleElement":
          if (maps["0"] == null) {
            return null;
          }
          TextInput.unregisterScribbleElement(
              getValue(maps["0"], datas, returnType, vars, props)!);
      }
    },
    "TextInputConnection": () {
      switch (value) {
        case "debugResetId":
          return TextInputConnection.debugResetId(
              to: getValue(maps["to"], datas, returnType, vars, props) ?? 1);
      }
    },
    "TextInputFormatter": () {
      switch (value) {
        case "withFunction":
          if (maps["0"] == null) {
            return null;
          }
          return TextInputFormatter.withFunction(
              getValue(maps["0"], datas, returnType, vars, props)!);
      }
    },
    "TextInputType": () {
      switch (value) {
        case "text":
          return TextInputType.text;
        case "multiline":
          return TextInputType.multiline;
        case "number":
          return TextInputType.number;
        case "phone":
          return TextInputType.phone;
        case "datetime":
          return TextInputType.datetime;
        case "emailAddress":
          return TextInputType.emailAddress;
        case "url":
          return TextInputType.url;
        case "visiblePassword":
          return TextInputType.visiblePassword;
        case "name":
          return TextInputType.name;
        case "streetAddress":
          return TextInputType.streetAddress;
        case "none":
          return TextInputType.none;
        case "values":
          return TextInputType.values;
      }
    },
    "TextLayoutMetrics": () {
      switch (value) {
        case "isWhitespace":
          if (maps["0"] == null) {
            return null;
          }
          return TextLayoutMetrics.isWhitespace(
              getValue(maps["0"], datas, returnType, vars, props)!);
        case "isLineTerminator":
          if (maps["0"] == null) {
            return null;
          }
          return TextLayoutMetrics.isLineTerminator(
              getValue(maps["0"], datas, returnType, vars, props)!);
      }
    },
    "TextMagnifier": () {
      switch (value) {
        case "adaptiveMagnifierConfiguration":
          return TextMagnifier.adaptiveMagnifierConfiguration;
        case "jumpBetweenLinesAnimationDuration":
          return TextMagnifier.jumpBetweenLinesAnimationDuration;
      }
    },
    "TextMagnifierConfiguration": () {
      switch (value) {
        case "disabled":
          return TextMagnifierConfiguration.disabled;
      }
    },
    "TextPainter": () {
      switch (value) {
        case "computeWidth":
          if (maps["text"] == null || maps["textDirection"] == null) {
            return null;
          }
          return TextPainter.computeWidth(
              text: getValue(maps["text"], datas, returnType, vars, props)!,
              textDirection: getValue(
                  maps["textDirection"], datas, returnType, vars, props)!,
              textAlign:
                  getValue(maps["textAlign"], datas, returnType, vars, props) ??
                      TextAlign.start,
              textScaleFactor:
                  getValue(maps["textScaleFactor"], datas, returnType, vars, props)
                          .toDouble() ??
                      1.0,
              maxLines:
                  getValue(maps["maxLines"], datas, returnType, vars, props),
              ellipsis:
                  getValue(maps["ellipsis"], datas, returnType, vars, props),
              locale: getValue(maps["locale"], datas, returnType, vars, props),
              strutStyle:
                  getValue(maps["strutStyle"], datas, returnType, vars, props),
              textWidthBasis:
                  getValue(maps["textWidthBasis"], datas, returnType, vars, props) ??
                      TextWidthBasis.parent,
              textHeightBehavior: getValue(
                  maps["textHeightBehavior"], datas, returnType, vars, props),
              minWidth:
                  getValue(maps["minWidth"], datas, returnType, vars, props).toDouble() ?? 0.0,
              maxWidth: getValue(maps["maxWidth"], datas, returnType, vars, props).toDouble() ?? double.infinity);
        case "computeMaxIntrinsicWidth":
          if (maps["text"] == null || maps["textDirection"] == null) {
            return null;
          }
          return TextPainter.computeMaxIntrinsicWidth(
              text: getValue(maps["text"], datas, returnType, vars, props)!,
              textDirection: getValue(
                  maps["textDirection"], datas, returnType, vars, props)!,
              textAlign:
                  getValue(maps["textAlign"], datas, returnType, vars, props) ??
                      TextAlign.start,
              textScaleFactor:
                  getValue(maps["textScaleFactor"], datas, returnType, vars, props)
                          .toDouble() ??
                      1.0,
              maxLines:
                  getValue(maps["maxLines"], datas, returnType, vars, props),
              ellipsis:
                  getValue(maps["ellipsis"], datas, returnType, vars, props),
              locale: getValue(maps["locale"], datas, returnType, vars, props),
              strutStyle:
                  getValue(maps["strutStyle"], datas, returnType, vars, props),
              textWidthBasis:
                  getValue(maps["textWidthBasis"], datas, returnType, vars, props) ??
                      TextWidthBasis.parent,
              textHeightBehavior: getValue(
                  maps["textHeightBehavior"], datas, returnType, vars, props),
              minWidth:
                  getValue(maps["minWidth"], datas, returnType, vars, props).toDouble() ?? 0.0,
              maxWidth: getValue(maps["maxWidth"], datas, returnType, vars, props).toDouble() ?? double.infinity);
      }
    },
    "TextRange": () {
      switch (value) {
        case "empty":
          return TextRange.empty;
      }
    },
    //  , "TextSelectionOverlay": () {
    //   switch (value) {
    //     case "fadeDuration":
    //       return TextSelectionOverlay.fadeDuration;
    //   }
    //   },
    "TextSelectionTheme": () {
      switch (value) {
        case "of":
          if (maps["0"] == null) {
            return null;
          }
          return TextSelectionTheme.of(
              getValue(maps["0"], datas, returnType, vars, props)!);
      }
    },
    "TextSelectionThemeData": () {
      switch (value) {
        case "lerp":
          if (maps["0"] == null || maps["1"] == null || maps["2"] == null) {
            return null;
          }
          return TextSelectionThemeData.lerp(
              getValue(maps["0"], datas, returnType, vars, props)!,
              getValue(maps["1"], datas, returnType, vars, props)!,
              getValue(maps["2"], datas, returnType, vars, props).toDouble()!);
      }
    },
    "TextSelectionToolbar": () {
      switch (value) {
        case "kHandleSize":
          return TextSelectionToolbar.kHandleSize;
        case "kToolbarContentDistanceBelow":
          return TextSelectionToolbar.kToolbarContentDistanceBelow;
      }
    },
    "TextSelectionToolbarLayoutDelegate": () {
      switch (value) {
        case "centerOn":
          if (maps["0"] == null || maps["1"] == null || maps["2"] == null) {
            return null;
          }
          return TextSelectionToolbarLayoutDelegate.centerOn(
              getValue(maps["0"], datas, returnType, vars, props).toDouble()!,
              getValue(maps["1"], datas, returnType, vars, props).toDouble()!,
              getValue(maps["2"], datas, returnType, vars, props).toDouble()!);
      }
    },
    "TextSelectionToolbarTextButton": () {
      switch (value) {
        case "getPadding":
          if (maps["0"] == null || maps["1"] == null) {
            return null;
          }
          return TextSelectionToolbarTextButton.getPadding(
              getValue(maps["0"], datas, returnType, vars, props)!,
              getValue(maps["1"], datas, returnType, vars, props)!);
      }
    },
    "TextTheme": () {
      switch (value) {
        case "lerp":
          if (maps["0"] == null || maps["1"] == null || maps["2"] == null) {
            return null;
          }
          return TextTheme.lerp(
              getValue(maps["0"], datas, returnType, vars, props)!,
              getValue(maps["1"], datas, returnType, vars, props)!,
              getValue(maps["2"], datas, returnType, vars, props).toDouble()!);
      }
    },
    "Theme": () {
      switch (value) {
        case "of":
          if (maps["0"] == null) {
            return null;
          }
          return Theme.of(getValue(maps["0"], datas, returnType, vars, props)!);
      }
    },
    "ThemeData": () {
      switch (value) {
        case "localize":
          if (maps["0"] == null || maps["1"] == null) {
            return null;
          }
          return ThemeData.localize(
              getValue(maps["0"], datas, returnType, vars, props)!,
              getValue(maps["1"], datas, returnType, vars, props)!);
        case "estimateBrightnessForColor":
          if (maps["0"] == null) {
            return null;
          }
          return ThemeData.estimateBrightnessForColor(
              getValue(maps["0"], datas, returnType, vars, props)!);
        case "lerp":
          if (maps["0"] == null || maps["1"] == null || maps["2"] == null) {
            return null;
          }
          return ThemeData.lerp(
              getValue(maps["0"], datas, returnType, vars, props)!,
              getValue(maps["1"], datas, returnType, vars, props)!,
              getValue(maps["2"], datas, returnType, vars, props).toDouble()!);
      }
    },
    "TickerMode": () {
      switch (value) {
        case "of":
          if (maps["0"] == null) {
            return null;
          }
          return TickerMode.of(
              getValue(maps["0"], datas, returnType, vars, props)!);
        case "getNotifier":
          if (maps["0"] == null) {
            return null;
          }
          return TickerMode.getNotifier(
              getValue(maps["0"], datas, returnType, vars, props)!);
      }
    },
    "TimeOfDay": () {
      switch (value) {
        case "hoursPerDay":
          return TimeOfDay.hoursPerDay;
        case "hoursPerPeriod":
          return TimeOfDay.hoursPerPeriod;
        case "minutesPerHour":
          return TimeOfDay.minutesPerHour;
      }
    },
    "TimePickerTheme": () {
      switch (value) {
        case "of":
          if (maps["0"] == null) {
            return null;
          }
          return TimePickerTheme.of(
              getValue(maps["0"], datas, returnType, vars, props)!);
      }
    },
    "TimePickerThemeData": () {
      switch (value) {
        case "lerp":
          if (maps["0"] == null || maps["1"] == null || maps["2"] == null) {
            return null;
          }
          return TimePickerThemeData.lerp(
              getValue(maps["0"], datas, returnType, vars, props)!,
              getValue(maps["1"], datas, returnType, vars, props)!,
              getValue(maps["2"], datas, returnType, vars, props).toDouble()!);
      }
    },
    "ToggleButtonsTheme": () {
      switch (value) {
        case "of":
          if (maps["0"] == null) {
            return null;
          }
          return ToggleButtonsTheme.of(
              getValue(maps["0"], datas, returnType, vars, props)!);
      }
    },
    "ToggleButtonsThemeData": () {
      switch (value) {
        case "lerp":
          if (maps["0"] == null || maps["1"] == null || maps["2"] == null) {
            return null;
          }
          return ToggleButtonsThemeData.lerp(
              getValue(maps["0"], datas, returnType, vars, props)!,
              getValue(maps["1"], datas, returnType, vars, props)!,
              getValue(maps["2"], datas, returnType, vars, props).toDouble()!);
      }
    },
    "Tolerance": () {
      switch (value) {
        case "defaultTolerance":
          return Tolerance.defaultTolerance;
      }
    },
    "ToolbarOptions": () {
      switch (value) {
        case "empty":
          return ToolbarOptions.empty;
      }
    },
    "TooltipTheme": () {
      switch (value) {
        case "of":
          if (maps["0"] == null) {
            return null;
          }
          return TooltipTheme.of(
              getValue(maps["0"], datas, returnType, vars, props)!);
      }
    },
    "TooltipThemeData": () {
      switch (value) {
        case "lerp":
          if (maps["0"] == null || maps["1"] == null || maps["2"] == null) {
            return null;
          }
          return TooltipThemeData.lerp(
              getValue(maps["0"], datas, returnType, vars, props)!,
              getValue(maps["1"], datas, returnType, vars, props)!,
              getValue(maps["2"], datas, returnType, vars, props).toDouble()!);
      }
    },
    "TooltipVisibility": () {
      switch (value) {
        case "of":
          if (maps["0"] == null) {
            return null;
          }
          return TooltipVisibility.of(
              getValue(maps["0"], datas, returnType, vars, props)!);
      }
    },
    "Typography": () {
      switch (value) {
        case "lerp":
          if (maps["0"] == null || maps["1"] == null || maps["2"] == null) {
            return null;
          }
          return Typography.lerp(
              getValue(maps["0"], datas, returnType, vars, props)!,
              getValue(maps["1"], datas, returnType, vars, props)!,
              getValue(maps["2"], datas, returnType, vars, props).toDouble()!);
        case "blackMountainView":
          return Typography.blackMountainView;
        case "whiteMountainView":
          return Typography.whiteMountainView;
        case "blackRedmond":
          return Typography.blackRedmond;
        case "whiteRedmond":
          return Typography.whiteRedmond;
        case "blackHelsinki":
          return Typography.blackHelsinki;
        case "whiteHelsinki":
          return Typography.whiteHelsinki;
        case "blackCupertino":
          return Typography.blackCupertino;
        case "whiteCupertino":
          return Typography.whiteCupertino;
        case "blackRedwoodCity":
          return Typography.blackRedwoodCity;
        case "whiteRedwoodCity":
          return Typography.whiteRedwoodCity;
        case "englishLike2014":
          return Typography.englishLike2014;
        case "englishLike2018":
          return Typography.englishLike2018;
        case "dense2014":
          return Typography.dense2014;
        case "dense2018":
          return Typography.dense2018;
        case "tall2014":
          return Typography.tall2014;
        case "tall2018":
          return Typography.tall2018;
        case "englishLike2021":
          return Typography.englishLike2021;
        case "dense2021":
          return Typography.dense2021;
        case "tall2021":
          return Typography.tall2021;
      }
    },
    "UndoHistoryValue": () {
      switch (value) {
        case "empty":
          return UndoHistoryValue.empty;
      }
    },
    "UndoManager": () {
      switch (value) {
        case "setChannel":
          if (maps["0"] == null) {
            return null;
          }
          UndoManager.setChannel(
              getValue(maps["0"], datas, returnType, vars, props)!);
        case "client":
          return UndoManager.client;
        case "setUndoState":
          UndoManager.setUndoState(
              canUndo:
                  getValue(maps["canUndo"], datas, returnType, vars, props) ??
                      false,
              canRedo:
                  getValue(maps["canRedo"], datas, returnType, vars, props) ??
                      false);
      }
    },
    "Unicode": () {
      switch (value) {
        case "LRE":
          return Unicode.LRE;
        case "RLE":
          return Unicode.RLE;
        case "PDF":
          return Unicode.PDF;
        case "LRO":
          return Unicode.LRO;
        case "RLO":
          return Unicode.RLO;
        case "LRI":
          return Unicode.LRI;
        case "RLI":
          return Unicode.RLI;
        case "FSI":
          return Unicode.FSI;
        case "PDI":
          return Unicode.PDI;
        case "LRM":
          return Unicode.LRM;
        case "RLM":
          return Unicode.RLM;
        case "ALM":
          return Unicode.ALM;
      }
    },
    "Uri": () {
      switch (value) {
        case "base;":
          return Uri.base;
          ;
        case "parse":
          if (maps["0"] == null) {
            return null;
          }
          return Uri.parse(
              getValue(maps["0"], datas, returnType, vars, props)!,
              getValue(maps["2"], datas, returnType, vars, props) ?? 0,
              getValue(maps["3"], datas, returnType, vars, props));
      }
    },
    "Velocity": () {
      switch (value) {
        case "zero":
          return Velocity.zero;
      }
    },
    "View": () {
      switch (value) {
        case "maybeOf":
          if (maps["0"] == null) {
            return null;
          }
          return View.maybeOf(
              getValue(maps["0"], datas, returnType, vars, props)!);
        case "of":
          if (maps["0"] == null) {
            return null;
          }
          return View.of(getValue(maps["0"], datas, returnType, vars, props)!);
      }
    },
    "Viewport": () {
      switch (value) {
        case "getDefaultCrossAxisDirection":
          if (maps["0"] == null || maps["1"] == null) {
            return null;
          }
          return Viewport.getDefaultCrossAxisDirection(
              getValue(maps["0"], datas, returnType, vars, props)!,
              getValue(maps["1"], datas, returnType, vars, props)!);
      }
    },
    "Visibility": () {
      switch (value) {
        case "of":
          if (maps["0"] == null) {
            return null;
          }
          return Visibility.of(
              getValue(maps["0"], datas, returnType, vars, props)!);
      }
    },
    "VisualDensity": () {
      switch (value) {
        case "minimumDensity":
          return VisualDensity.minimumDensity;
        case "maximumDensity":
          return VisualDensity.maximumDensity;
        case "standard":
          return VisualDensity.standard;
        case "comfortable":
          return VisualDensity.comfortable;
        case "compact":
          return VisualDensity.compact;
        case "adaptivePlatformDensity":
          return VisualDensity.adaptivePlatformDensity;
        case "defaultDensityForPlatform":
          if (maps["0"] == null) {
            return null;
          }
          return VisualDensity.defaultDensityForPlatform(
              getValue(maps["0"], datas, returnType, vars, props)!);
        case "lerp":
          if (maps["0"] == null || maps["1"] == null || maps["2"] == null) {
            return null;
          }
          return VisualDensity.lerp(
              getValue(maps["0"], datas, returnType, vars, props)!,
              getValue(maps["1"], datas, returnType, vars, props)!,
              getValue(maps["2"], datas, returnType, vars, props).toDouble()!);
      }
    },
    "Widget": () {
      switch (value) {
        case "canUpdate":
          if (maps["0"] == null || maps["1"] == null) {
            return null;
          }
          return Widget.canUpdate(
              getValue(maps["0"], datas, returnType, vars, props)!,
              getValue(maps["1"], datas, returnType, vars, props)!);
      }
    },
    "WidgetsFlutterBinding": () {
      switch (value) {
        case "ensureInitialized":
          return WidgetsFlutterBinding.ensureInitialized();
      }
    },
    "bool": () {
      switch (value) {
        case "parse":
          if (maps["0"] == null) {
            return null;
          }
          return bool.parse(
              getValue(maps["0"], datas, returnType, vars, props)!);
        case "tryParse":
          if (maps["0"] == null) {
            return null;
          }
          return bool.tryParse(
              getValue(maps["0"], datas, returnType, vars, props)!);
      }
    },
    "double": () {
      switch (value) {
        case "nan":
          return double.nan;
        case "infinity":
          return double.infinity;
        case "negativeInfinity":
          return double.negativeInfinity;
        case "minPositive":
          return double.minPositive;
        case "maxFinite":
          return double.maxFinite;
        case "parse":
          if (maps["0"] == null) {
            return null;
          }
          return double.parse(
              getValue(maps["0"], datas, returnType, vars, props)!);
        case "tryParse":
          if (maps["0"] == null) {
            return null;
          }
          return double.tryParse(
              getValue(maps["0"], datas, returnType, vars, props)!);
      }
    },
    "int": () {
      switch (value) {
        case "parse":
          if (maps["0"] == null) {
            return null;
          }
          return int.parse(getValue(maps["0"], datas, returnType, vars, props)!,
              radix: getValue(maps["radix"], datas, returnType, vars, props));
        case "tryParse":
          if (maps["0"] == null) {
            return null;
          }
          return int.tryParse(
              getValue(maps["0"], datas, returnType, vars, props)!,
              radix: getValue(maps["radix"], datas, returnType, vars, props));
      }
    },
  }[className]
      ?.call();
}
