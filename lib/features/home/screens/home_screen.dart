import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_coder/features/browser/views/browser_view.dart';
import 'package:flutter_coder/features/converter/components/action_button.dart';
import 'package:flutter_coder/features/converter/components/app_textfield.dart';
import 'package:flutter_coder/features/converter/components/code_detail_item.dart';
import 'package:flutter_coder/features/converter/components/code_tab_bar.dart';
import 'package:flutter_coder/features/converter/utils/code_utils.dart';
import 'package:flutter_coder/features/converter/utils/constants_utils.dart';
import 'package:flutter_coder/features/converter/views/code_input.dart';
import 'package:flutter_coder/features/editor/views/code_editor.dart';
import 'package:flutter_coder/features/emulator/views/emulator_view.dart';
import 'package:flutter_coder/features/shared/utils/extensions.dart';
import 'package:flutter_coder/features/converter/utils/utils.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../converter/components/theme_switch.dart';
import '../../../main.dart';
import '../../converter/models/code_detail.dart';
import '../../shared/providers/theme_provider.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen>
    with SingleTickerProviderStateMixin {
  String theme = "";

  bool isCodeEditor = true;
  bool isCodeInputView = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    theme = isDarkMode ? "dark" : "light";
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  void updateTheme(value) {
    if (value == theme) return;
    theme = value;
    sharedPreferences.setBool("darkmode", value == "dark");
    ref.read(themeProvider.notifier).updateTheme(value);
  }

  void toggleCodeInputViewAndBrowser() {
    setState(() {
      isCodeInputView = !isCodeInputView;
    });
  }

  void toggleCodeEditorViewAndEmulator() {
    setState(() {
      isCodeEditor = !isCodeEditor;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("Flutter Coder"),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  onPressed: toggleCodeEditorViewAndEmulator,
                  icon: Icon(isCodeEditor ? Icons.phone_android : Icons.edit),
                ),
                const SizedBox(
                  width: 10,
                ),
                IconButton(
                  onPressed: toggleCodeInputViewAndBrowser,
                  icon: Icon(isCodeInputView ? Icons.web : Icons.input_sharp),
                ),
              ],
            ),
            ThemeSwitch(theme: theme, onChange: updateTheme)
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            Expanded(
              child: IndexedStack(
                index: isCodeEditor ? 0 : 1,
                children: const [CodeEditorView(), EmulatorView()],
              ),
            ),
            const SizedBox(
              width: 20,
            ),
            Expanded(
              child: IndexedStack(
                index: isCodeInputView ? 0 : 1,
                children: const [CodeInputView(), BrowserView()],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
