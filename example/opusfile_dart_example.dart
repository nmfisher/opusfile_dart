import 'dart:io';

import 'package:opusfile_dart/opusfile_dart.dart';

void main() {
  var scriptDir = File(Platform.script.toFilePath()).parent.path;
  var encoded = File("$scriptDir/test.opus").readAsBytesSync();
  var decoder = OpusFileDecoder();

  var decoded = decoder.decode(encoded);
  File("$scriptDir/test.pcm").writeAsBytesSync(decoded.buffer.asUint8List());
}
