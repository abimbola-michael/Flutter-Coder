import 'package:flutter/material.dart';
import 'package:webview_universal/webview_universal.dart';

import '../../converter/components/action_button.dart';

class BrowserView extends StatefulWidget {
  const BrowserView({super.key});

  @override
  State<BrowserView> createState() => _BrowserViewState();
}

class _BrowserViewState extends State<BrowserView> {
  final _urlController = TextEditingController();
  final _webViewController = WebViewController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  void goBack() {
    _webViewController.goBackSync();
  }

  void goForward() {
    _webViewController.goForwardSync();
  }

  void searchWeb() {
    if (_urlController.text.isEmpty) return;
    _webViewController.init(
        context: context,
        setState: setState,
        uri: Uri.parse(_urlController.text));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _urlController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: TextField(
                decoration: const InputDecoration(
                  // border: InputBorder.none,
                  hintText: "Code Output",
                ),
                minLines: 10,
                maxLines: 20,
                controller: _urlController,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            ActionButton(
              title: "Search",
              color: Colors.purple,
              onPressed: searchWeb,
            ),
          ],
        ),
        Expanded(child: WebView(controller: _webViewController))
      ],
    );
  }
}
