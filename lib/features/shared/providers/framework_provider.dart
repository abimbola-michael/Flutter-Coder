import 'package:flutter_riverpod/flutter_riverpod.dart';

enum CodeFramework { flutter, react, tailwind, htmlAndCss, reactNative }

extension CodeFrameworkExtensions on CodeFramework {
  bool get isFlutter => this == CodeFramework.flutter;
  bool get isReact => this == CodeFramework.react;
  bool get isReactNative => this == CodeFramework.reactNative;

  bool get isTailwind => this == CodeFramework.tailwind;
  bool get isHtmlAndCss => this == CodeFramework.htmlAndCss;
}

class FrameworkNotifier extends StateNotifier<CodeFramework> {
  FrameworkNotifier(super.state);

  void updateFrameWork(CodeFramework newFramework) {
    state = newFramework;
  }
}

final frameworkProvider =
    StateNotifierProvider<FrameworkNotifier, CodeFramework>(
  (ref) => FrameworkNotifier(CodeFramework.flutter),
);
