import 'dart:io';

import 'package:opusfile_dart/opusfile_dart.dart';

void main() {
  var scriptDir = File(Platform.script.toFilePath()).parent.path;
  // input is stereo 48kHz
  var encoded = File("$scriptDir/test.ogg").readAsBytesSync();
  var decoder = OpusFileDecoder();

  var decoded = decoder.decode(encoded);
  // output is stereo 48kHz 16-bit PCM
  File("$scriptDir/test.pcm").writeAsBytesSync(decoded.buffer.asUint8List());
}
