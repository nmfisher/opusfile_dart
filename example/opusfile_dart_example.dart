import 'dart:io';

import 'package:opusfile_dart/opusfile_dart.dart';

void main() {
  var scriptDir = File(Platform.script.toFilePath()).parent.path;
  var encoded = File("$scriptDir/test.opus").readAsBytesSync();
  // var encoded = File(
  //         "/Users/nickfisher/Documents/polyvox/flutter/polyvox_assets/assets/audio/1a21304defa425cd9c135bbff043c580.opus")
  //     .readAsBytesSync();
  var decoder = OpusFileDecoder();

  var decoded = decoder.decode(encoded);
  File("$scriptDir/test.pcm").writeAsBytesSync(decoded.buffer.asUint8List());
}
