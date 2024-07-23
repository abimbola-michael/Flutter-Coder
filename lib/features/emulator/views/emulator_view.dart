import 'package:flutter/material.dart';
import 'package:flutter_coder/features/emulator/utils/emulator_util.dart';
import 'package:flutter_coder/features/shared/utils/extensions.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../converter/components/app_textfield.dart';
import '../../shared/providers/editor_text_provider.dart';
import '../../shared/utils/colors.dart';

class EmulatorView extends ConsumerStatefulWidget {
  const EmulatorView({super.key});

  @override
  ConsumerState<EmulatorView> createState() => _EmulatorViewState();
}

class _EmulatorViewState extends ConsumerState<EmulatorView> {
  final _heightController = TextEditingController(text: "375");
  final _widthController = TextEditingController(text: "812");
  bool isLandscape = false;
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose

    _heightController.dispose();
    _widthController.dispose();
    super.dispose();
  }

  void updateOrientation(bool value) {
    setState(() {
      isLandscape = value;
    });
  }

  double get aspectRatio {
    final width =
        _widthController.text.isEmpty ? 375 : int.parse(_widthController.text);
    final height = _heightController.text.isEmpty
        ? 812
        : int.parse(_heightController.text);
    return !isLandscape ? (height / width) : (width / height);
  }

  @override
  Widget build(BuildContext context) {
    final text = ref.watch(editorTextProvider);
    final output = getEmulatorOutput(text);
    final child = output.output is Widget
        ? widget
        : Text(
            "Flutter Coder",
            style: context.bodyMedium,
          );

    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                "Emulator",
                style: context.bodyLarge,
              ),
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Landscape",
                  style: context.bodyLarge,
                ),
                const SizedBox(
                  width: 5,
                ),
                Switch(value: isLandscape, onChanged: updateOrientation),
                AppTextField(
                  controller: _widthController,
                  title: "Width",
                ),
                const SizedBox(
                  width: 20,
                ),
                AppTextField(
                  controller: _heightController,
                  title: "Height",
                ),
              ],
            ),
          ],
        ),
        Expanded(
          child: Center(
            child: AspectRatio(
              aspectRatio: aspectRatio,
              child: Container(
                decoration: BoxDecoration(
                  color: lightTint,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: child,
              ),
            ),
          ),
        )
      ],
    );
  }
}
