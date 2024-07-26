import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_coder/features/converter/components/action_button.dart';
import 'package:flutter_coder/features/converter/components/app_textfield.dart';
import 'package:flutter_coder/features/converter/components/code_detail_item.dart';
import 'package:flutter_coder/features/converter/components/code_tab_bar.dart';
import 'package:flutter_coder/features/converter/utils/flutter_code_utils.dart';
import 'package:flutter_coder/features/converter/utils/constants_utils.dart';
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
  final _outputController = TextEditingController();
  final _inputController = TextEditingController();
  final _radiusController = TextEditingController();
  final _heightController = TextEditingController();
  final _widthController = TextEditingController();
  final _constantsController = TextEditingController();

  String theme = "";
  List<CodeDetail> codeDetails = [];
  CodeDetail? currentDetail;
  List<CodeDetail>? currentCodeDetails;
  int currentIndex = -1;
  int? currentParentIndex;
  //int selectedDetail = 0;
  List<String> tabNames = ["Properties", "Constants", "Types"];
  List<String> types = ["Default", "Image", "Svg", "Icon"];

  int currentTab = 0;
  late TabController _tabController;
  final _scrollController = ScrollController();

  bool isCodeEditorView = true;
  bool isCodeInputView = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    theme = isDarkMode ? "dark" : "light";
    _tabController = TabController(length: tabNames.length, vsync: this);
    _widthController.text = "375";
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _outputController.dispose();
    _inputController.dispose();
    _radiusController.dispose();
    _tabController.dispose();
    _heightController.dispose();
    _widthController.dispose();
    _constantsController.dispose();

    _scrollController.dispose();

    super.dispose();
  }

  void scrollToBottom() {
    if (!_scrollController.hasClients) return;
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent + 100,
      duration: const Duration(milliseconds: 100),
      curve: Curves.easeIn,
    );
  }

  // void getOutput(String string) {
  //   currentDetail?.string = string;
  //   double radius = double.tryParse(_radiusController.text) != null
  //       ? double.parse(_radiusController.text)
  //       : 0;
  //   _outputController.text =
  //       getFlutterDetailsResult(string, currentType, radius, circular, clickable);
  //   setState(() {});
  // }
  void updateContants(String value) {
    final map = getAllInfosFromString(value);
    constants = map;
    print("map = $map");
  }

  void updateTheme(value) {
    if (value == theme) return;
    theme = value;
    sharedPreferences.setBool("darkmode", value == "dark");
    ref.read(themeProvider.notifier).updateTheme(value);
  }

  void updateTab(int index) {
    setState(() {
      currentTab = index;
    });
  }

  void updateType(String? value) {
    if (value == null) return;
    currentDetail?.type = value;
    regetOutput();
  }

  void updateCircular(bool value) {
    currentDetail?.circular = value;
    regetOutput();
  }

  void updateClickable(bool value) {
    currentDetail?.clickable = value;
    regetOutput();
  }

  void updateExpanded(bool value) {
    currentDetail?.expanded = value;
    regetOutput();
  }

  void updateBorderRadius(String value) {
    currentDetail?.radius =
        double.tryParse(value) != null ? double.parse(value) : null;
    regetOutput();
  }

  void pasteCode(String type) async {
    final data = await Clipboard.getData(Clipboard.kTextPlain);
    if (data != null && data.text != null) {
      String code = data.text!;
      if (type == "input") {
        final index = _inputController.selection.baseOffset;
        final string = _inputController.text;
        _inputController.text = (index > 0 ? string.substring(0, index) : "") +
            code +
            (index >= 0 && index < string.length
                ? string.substring(index)
                : "");
      } else {
        final index = _outputController.selection.baseOffset;
        final string = _outputController.text;
        _outputController.text = (index > 0 ? string.substring(0, index) : "") +
            code +
            (index >= 0 && index < string.length
                ? string.substring(index)
                : "");
      }
    }
    regetOutput();
  }

  void pasteReplaceCode(String type) async {
    final data = await Clipboard.getData(Clipboard.kTextPlain);
    if (data != null && data.text != null) {
      String code = data.text!;
      if (type == "input") {
        _inputController.text = code;
      } else {
        _outputController.text = code;
      }
    }
    regetOutput();
  }

  void copyCode(String type) {
    String code = "";
    if (type == "input") {
      code = _inputController.text;
    } else {
      code = _outputController.text;
    }
    Clipboard.setData(ClipboardData(text: code));
  }

  void clearCodeOutput(String type) {
    if (type == "input") {
      _inputController.clear();
    } else {
      _outputController.clear();
    }
    regetOutput();
  }

  void resetCode(String type) {
    currentDetail = currentDetail?.copyWith(
        radius: null, type: "Default", circular: false, clickable: false);
    regetOutput();
    //clearCodeOutput(type);
  }

  void regetOutput() {
    //if (_inputController.text.isEmpty) return;
    getOutput(_inputController.text);
  }

  void getCurrentDetail() {
    if (currentIndex != -1 && currentCodeDetails != null) {
      if (currentParentIndex != null) {
        currentDetail = currentCodeDetails![currentParentIndex!]
            .childrenCodeDetails[currentIndex];
      } else {
        currentDetail = currentCodeDetails![currentIndex];
      }
    }
    _radiusController.clear();
    _inputController.clear();
  }

  void setCurrentDetails(
      List<CodeDetail> codeDetails, int index, int? parentIndex) {
    currentCodeDetails = codeDetails;
    currentIndex = index;
    currentParentIndex = parentIndex;
    if (currentParentIndex != null) {
      currentDetail = currentCodeDetails![currentParentIndex!]
          .childrenCodeDetails[currentIndex];
    } else {
      currentDetail = currentCodeDetails![currentIndex];
    }
    _radiusController.text = currentDetail!.radius?.toString() ?? "";
    _inputController.text = currentDetail!.string;

    setState(() {});
  }

  void updateCurrentDetailsText(String string) {
    if (currentIndex != -1 && currentCodeDetails != null) {
      if (currentParentIndex != null) {
        currentCodeDetails![currentParentIndex!]
            .childrenCodeDetails[currentIndex]
            .string = string;
      } else {
        currentCodeDetails![currentIndex].string = string;
      }
    }
    currentDetail?.string = string;
  }

  void resetCurrentDetails() {
    currentCodeDetails = null;
    currentIndex = -1;
    currentParentIndex = null;
    currentDetail = null;
    setState(() {});
  }

  void getOutput(String string) {
    //currentDetail?.string = string;
    updateCurrentDetailsText(string);
    // final widthString = _widthController.text;
    // final heightString = _heightController.text;

    // double width =
    //     double.tryParse(widthString) != null ? double.parse(widthString) : 0;
    // double height =
    //     double.tryParse(heightString) != null ? double.parse(heightString) : 0;

    //_outputController.text = getAllDetails(codeDetails, width, height);
    // final mainString = "width: ${width}px;\nheight: ${height}px;";
    // final detail = CodeDetail(
    //   id: "",
    //   string: mainString,
    //   type: "Default",
    //   circular: false,
    //   clickable: false,
    //   childrenCodeDetails: codeDetails,
    // );
    final result = getFlutterDetailsResult(currentDetail!, null, null);
    final type = result.output.contains("(")
        ? result.output.substring(0, result.output.indexOf("("))
        : "Default";
    currentDetail!.type = type;

    _outputController.text = reformatFlutterString(result.output);
    if (!_inputController.text.endsWith("\n")) {
      _inputController.text += "\n";
    }
    setState(() {});
  }

  void removeDetail(List<CodeDetail> codeDetails, int index, int? parentIndex) {
    if (parentIndex != null) {
      codeDetails[parentIndex].childrenCodeDetails.removeAt(index);
    } else {
      codeDetails.removeAt(index);
    }
    resetCurrentDetails();
    //setState(() {});
  }

  void addDetail(List<CodeDetail> codeDetails, int? parentIndex) {
    final details = parentIndex != null
        ? codeDetails[parentIndex].childrenCodeDetails
        : codeDetails;
    int length = details.length;
    final detail = CodeDetail(
      id: parentIndex != null
          ? "${codeDetails[parentIndex].id}-$length"
          : "$length",
      string: "",
      type: "Default",
      circular: false,
      clickable: false,
      expanded: false,
      childrenCodeDetails: [],
    );
    details.add(detail);

    setCurrentDetails(codeDetails, length, parentIndex);
    //viewCode(detail);
    //setState(() {});
    scrollToBottom();
  }

  void selectDetail(List<CodeDetail> codeDetails, int index, int? parentIndex) {
    if (parentIndex != null) {
      currentDetail = codeDetails[parentIndex].childrenCodeDetails[index];
    } else {
      currentDetail = codeDetails[index];
    }
    setCurrentDetails(codeDetails, index, parentIndex);
    //setState(() {});
    regetOutput();
  }

  void addCode() {
    addDetail(codeDetails, null);

    //viewCode(detail);
  }

  void clearSections() {
    codeDetails.clear();
    resetCurrentDetails();
    _inputController.clear();
    _outputController.clear();
    setState(() {});
  }

  // void viewCode(CodeDetail detail) {
  //   currentDetail = detail;
  //   _radiusController.text = detail.radius?.toString() ?? "";
  //   _inputController.text = detail.string;
  //   setState(() {});
  // }

  void toggleCodeInputViewAndBrowser() {
    setState(() {
      isCodeInputView = !isCodeInputView;
    });
  }

  void toggleCodeEditorViewAndEmulator() {
    setState(() {
      isCodeEditorView = !isCodeEditorView;
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
                  icon:
                      Icon(isCodeEditorView ? Icons.phone_android : Icons.edit),
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
        // title: const Text("Flutter Coder"),
        // actions: [ThemeSwitch(theme: theme, onChange: updateTheme)],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          "Code Result",
                          style: context.bodyLarge,
                        ),
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
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
                  Flexible(
                    flex: 1,
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
                        onPressed: () => pasteCode("output"),
                      ),
                      ActionButton(
                        title: "Paste Replace",
                        color: Colors.indigo,
                        onPressed: () => pasteReplaceCode("output"),
                      ),
                      ActionButton(
                        title: "Copy",
                        color: Colors.green,
                        onPressed: () => copyCode("output"),
                      ),
                      ActionButton(
                        title: "Clear",
                        color: Colors.red,
                        onPressed: () => clearCodeOutput("output"),
                      ),
                    ],
                  )
                ],
              ),
            ),
            const SizedBox(
              width: 20,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TabBar(
                    controller: _tabController,
                    tabs: List.generate(
                      tabNames.length,
                      (index) {
                        final name = tabNames[index];
                        return Tab(
                          text: name,
                        );
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Expanded(
                    child: TabBarView(
                      controller: _tabController,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          "Code Sections",
                                          style: context.bodyLarge,
                                        ),
                                      ),
                                      Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          ActionButton(
                                            title: "Clear",
                                            color: Colors.red,
                                            onPressed: clearSections,
                                          ),
                                          ActionButton(
                                            title: "Add",
                                            onPressed: addCode,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  const Divider(),
                                  Expanded(
                                      child: codeDetails.isEmpty
                                          ? Center(
                                              child: Text(
                                                "Tap Add to create new Section",
                                                style: context.bodyMedium,
                                                textAlign: TextAlign.center,
                                              ),
                                            )
                                          : ListView.builder(
                                              controller: _scrollController,
                                              itemCount: codeDetails.length,
                                              itemBuilder: (context, index) {
                                                return CodeDetailItem(
                                                  currentDetail: currentDetail,
                                                  codeDetails: codeDetails,
                                                  index: index,
                                                  parentIndex: null,
                                                  onRemove: removeDetail,
                                                  onAdd: addDetail,
                                                  onSelect: selectDetail,
                                                );
                                              }))
                                ],
                              ),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            Expanded(
                              child: currentDetail == null
                                  ? Center(
                                      child: Text(
                                        "Add and Tap to view details",
                                        style: context.bodyMedium,
                                        textAlign: TextAlign.center,
                                      ),
                                    )
                                  : Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              "Type",
                                              style: context.bodyLarge,
                                            ),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            DropdownButton<String>(
                                              value: types.contains(
                                                      currentDetail!.type)
                                                  ? currentDetail!.type
                                                  : "Default",
                                              items: types
                                                  .map((e) =>
                                                      DropdownMenuItem<String>(
                                                          value: e,
                                                          child: Text(e)))
                                                  .toList(),
                                              onChanged: updateType,
                                            ),
                                            const SizedBox(
                                              width: 20,
                                            ),
                                            AppTextField(
                                              controller: _radiusController,
                                              onChanged: updateBorderRadius,
                                              title: "Radius",
                                            )
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              "Circular",
                                              style: context.bodyLarge,
                                            ),
                                            const SizedBox(
                                              width: 5,
                                            ),
                                            Switch(
                                                value: currentDetail!.circular,
                                                onChanged: updateCircular),
                                            const SizedBox(
                                              width: 5,
                                            ),
                                            Text(
                                              "Clickable",
                                              style: context.bodyLarge,
                                            ),
                                            const SizedBox(
                                              width: 5,
                                            ),
                                            Switch(
                                                value: currentDetail!.clickable,
                                                onChanged: updateClickable),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text(
                                              "Expanded",
                                              style: context.bodyLarge,
                                            ),
                                            const SizedBox(
                                              width: 5,
                                            ),
                                            Switch(
                                                value: currentDetail!.expanded,
                                                onChanged: updateExpanded),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Expanded(
                                          child: TextField(
                                            decoration: const InputDecoration(
                                              hintText: "Code Input",
                                            ),
                                            minLines: 10,
                                            maxLines: 20,
                                            controller: _inputController,
                                            onChanged: getOutput,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Wrap(
                                          children: [
                                            ActionButton(
                                              title: "Paste",
                                              onPressed: () =>
                                                  pasteCode("input"),
                                            ),
                                            ActionButton(
                                              title: "Paste Replace",
                                              color: Colors.indigo,
                                              onPressed: () =>
                                                  pasteReplaceCode("input"),
                                            ),
                                            ActionButton(
                                              title: "Copy",
                                              color: Colors.green,
                                              onPressed: () =>
                                                  copyCode("input"),
                                            ),
                                            ActionButton(
                                              title: "Clear",
                                              color: Colors.red,
                                              onPressed: () =>
                                                  clearCodeOutput("input"),
                                            ),
                                            ActionButton(
                                              title: "Reset",
                                              color: Colors.lightGreen,
                                              onPressed: () =>
                                                  resetCode("input"),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                            ),
                          ],
                        ),
                        SizedBox.expand(
                          child: TextField(
                            decoration: const InputDecoration(
                              hintText: "Code Constants",
                            ),
                            minLines: 10,
                            maxLines: 20,
                            controller: _constantsController,
                            onChanged: updateContants,
                          ),
                        ),
                        Container(),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
