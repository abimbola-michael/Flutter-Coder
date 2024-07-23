import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../main.dart';

class EditorTextNotifier extends StateNotifier<String> {
  EditorTextNotifier(super.state);
  void updateText(String text) {
    state = text;
  }
}

final editorTextProvider = StateNotifierProvider<EditorTextNotifier, String>(
  (ref) {
    return EditorTextNotifier("");
  },
);
