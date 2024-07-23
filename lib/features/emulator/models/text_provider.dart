import 'package:flutter_riverpod/flutter_riverpod.dart';

final textProvider = StateNotifierProvider<TextModel, String>((ref) {
  return TextModel();
});

class TextModel extends StateNotifier<String> {
  TextModel() : super("");
  void updateString(String string) {
    state = string;
  }

  void updateState() {
    state = state;
  }
}
