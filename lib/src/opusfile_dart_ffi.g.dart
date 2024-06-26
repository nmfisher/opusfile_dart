// AUTO GENERATED FILE, DO NOT EDIT.
//
// Generated by `package:ffigen`.
// ignore_for_file: type=lint
import 'dart:ffi' as ffi;

@ffi.Native<ffi.Bool Function(ffi.Uint32, ffi.Int32)>(
    symbol: 'opusfile_dart_create_decoder',
    assetId: 'package:opusfile_dart/opusfile_dart.dart')
external bool opusfile_dart_create_decoder(
  int samplingRate,
  int channels,
);

@ffi.Native<
        ffi.Void Function(ffi.Pointer<ffi.Uint8>, ffi.Size,
            ffi.Pointer<ffi.Int16>, ffi.Uint8, ffi.Uint8)>(
    symbol: 'opusfile_dart_decode',
    assetId: 'package:opusfile_dart/opusfile_dart.dart')
external void opusfile_dart_decode(
  ffi.Pointer<ffi.Uint8> encoded,
  int length,
  ffi.Pointer<ffi.Int16> outData,
  int channels,
  int maxFrameSize,
);
