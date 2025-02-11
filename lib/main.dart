import 'package:flutter/material.dart';
import 'package:web/web.dart' as web;

import 'js_interop_service/js_interop_service.dart';

/// Entrypoint of the application.
void main() {
  runApp(const MyApp());
}

/// Application itself.
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'Flutter Demo', home: const HomePage());
  }
}

/// [Widget] displaying the home page consisting of an image and the buttons.
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

/// State of a [HomePage].
class _HomePageState extends State<HomePage> {

  /// Controller for the URL text input.
  final _myController = TextEditingController();

  ///HTML image element.
  late final web.HTMLImageElement _webHtmlImageElement;

  /// Service to work with JavaScript functions.
  final _jsInteropService = JsInteropService();

  /// Controller for the window mode menu.
  final MenuController _menuController = MenuController();

  ///The key to specify Scaffold widget.
  final GlobalKey<ScaffoldState> _key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      key: _key,
      body: Column(
        children: [
          AppBar(),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(32, 16, 32, 16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    child: AspectRatio(
                      aspectRatio: 1,
                      child: GestureDetector(
                        onDoubleTap: () {
                          /// Toggles window mode.
                          _jsInteropService.toggleFullscreen();
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: HtmlElementView.fromTagName(
                            tagName: 'img',
                            onElementCreated: (element) {
                              /// Casts object to web.HTMLImageElement.
                              element as web.HTMLImageElement;
                              _webHtmlImageElement = element;
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(hintText: 'Image URL'),
                          controller: _myController,
                        ),
                      ),
                      ElevatedButton(
                        onPressed: elevatedButtonOnPressed,
                        child: const Padding(
                          padding: EdgeInsets.fromLTRB(0, 12, 0, 12),
                          child: Icon(Icons.arrow_forward),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 64),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: MenuAnchor(
        onClose: menuAnchorOnClose,
        menuChildren: [
          MenuItemButton(
            child: const Text("Enter fullscreen"),
            onPressed: _jsInteropService.enterFullscreen,
          ),
          MenuItemButton(
            child: const Text("Exit fullscreen"),
            onPressed: _jsInteropService.exitFullscreen,
          ),
        ],
        controller: _menuController,
        child: FloatingActionButton(
          onPressed: floatingActionButtonOnPressed,
          child: const Icon(Icons.add),
        ),
      ),
    );
  }

  /// Toggles window mode menu state.
  void floatingActionButtonOnPressed() {
    if (_menuController.isOpen) {
      _menuController.close();
      _key.currentState?.showBodyScrim(false, .5);
    } else {
      _menuController.open();
      _key.currentState?.showBodyScrim(true, .5);
    }
  }

  /// Removes background darkening when window mode menu closes.
  void menuAnchorOnClose() {
    _key.currentState?.showBodyScrim(false, .5);
  }

  /// Sets an image to the HTML element using the input URL.
  ///
  /// Sets the value of [_webHtmlImageElement.src] to the URL provided
  /// by [_myController.text].
  void elevatedButtonOnPressed() {
    _webHtmlImageElement.src = _myController.text;
  }
}