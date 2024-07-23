import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_coder/features/shared/providers/editor_text_provider.dart';
import 'package:flutter_coder/features/shared/utils/extensions.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../converter/components/action_button.dart';
import '../../converter/components/app_textfield.dart';

class CodeEditorView extends ConsumerStatefulWidget {
  const CodeEditorView({super.key});

  @override
  ConsumerState<CodeEditorView> createState() => _CodeEditorViewState();
}

class _CodeEditorViewState extends ConsumerState<CodeEditorView> {
  final _outputController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose

    _outputController.dispose();
    super.dispose();
  }

  void pasteCode() async {
    final data = await Clipboard.getData(Clipboard.kTextPlain);
    if (data != null && data.text != null) {
      String code = data.text!;

      final index = _outputController.selection.baseOffset;
      final string = _outputController.text;
      _outputController.text = (index > 0 ? string.substring(0, index) : "") +
          code +
          (index >= 0 && index < string.length ? string.substring(index) : "");
    }
  }

  void pasteReplaceCode() async {
    final data = await Clipboard.getData(Clipboard.kTextPlain);
    if (data != null && data.text != null) {
      String code = data.text!;
      _outputController.text = code;
    }
  }

  void copyCode() {
    String code = "";
    code = _outputController.text;

    Clipboard.setData(ClipboardData(text: code));
  }

  void clearCodeOutput() {
    _outputController.clear();
  }

  @override
  Widget build(BuildContext context) {
    final text = ref.watch(editorTextProvider);
    _outputController.text = text;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                "Code Editor",
                style: context.bodyLarge,
              ),
            ),
          ],
        ),
        Expanded(
          child: TextField(
            decoration: const InputDecoration(
              // border: InputBorder.none,
              hintText: "Code Output",
            ),
            minLines: 10,
            maxLines: 20,
            controller: _outputController,
          ),
        ),
        Wrap(
          children: [
            ActionButton(
              title: "Paste",
              onPressed: pasteCode,
            ),
            ActionButton(
              title: "Paste Replace",
              color: Colors.indigo,
              onPressed: pasteReplaceCode,
            ),
            ActionButton(
              title: "Copy",
              color: Colors.green,
              onPressed: copyCode,
            ),
            ActionButton(
              title: "Clear",
              color: Colors.red,
              onPressed: clearCodeOutput,
            ),
          ],
        )
      ],
    );
  }
}
