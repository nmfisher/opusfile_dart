import 'dart:ffi';
import 'dart:typed_data';

import 'package:ffi/ffi.dart';
import 'package:opusfile_dart/src/opusfile_dart.g.dart';

class OpusFileDecoder {
  OpusFileDecoder() {}

  Int16List decode(Uint8List encoded) {
    final ptr = calloc<Uint8>(encoded.length);
    ptr.asTypedList(encoded.length).setRange(0, encoded.length, encoded);
    var outLength = calloc<Int64>(1);
    var decoded =
        opusfile_dart_decode(ptr.cast<Void>(), encoded.length, outLength);
    calloc.free(ptr);
    Int16List copy =
        Int16List.fromList(decoded.cast<Int16>().asTypedList(outLength.value));
    opusfile_dart_free(decoded);
    return copy;
  }

  void dispose() {}
}
