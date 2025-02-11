@JS()
library js_interop;

import 'package:js/js.dart';

///Sets a reference to a JS function [_toggleFullscreen]
@JS()
external _toggleFullscreen();

///Sets a reference to a JS function [_exitFullscreen]
@JS()
external _exitFullscreen();

///Sets a reference to a JS function [_requestFullscreen]
@JS()
external _requestFullscreen();


class JsInteropService {

  ///Calls [_toggleFullscreen()]
  toggleFullscreen() {
    _toggleFullscreen();
  }

  ///Calls [_exitFullscreen()]
  exitFullscreen() {
    _exitFullscreen();
  }

  ///Calls [_requestFullscreen()]
  enterFullscreen() {
    _requestFullscreen();
  }
}