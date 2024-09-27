// Copyright (c) 2023, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.
import 'dart:io';
import 'package:logging/logging.dart';
import 'package:native_assets_cli/native_assets_cli.dart';
import 'package:native_toolchain_c/native_toolchain_c.dart';

void main(List<String> args) async {
  await build(args, (config, output) async {
    final packageName = config.packageName;
    var platform = config.targetOS.toString().toLowerCase();
    var libDir = "${config.packageRoot.toFilePath()}/native/lib/$platform/";

    if (config.targetOS == OS.android) {
      switch (config.targetArchitecture) {
        case Architecture.arm64:
          libDir += "/arm64-v8a/";
        case Architecture.x64:
          libDir += "/x86_64/";
        default:
      }
    }

    var flags = [
      "-v",
      '-std=c++17',
      "-L$libDir",
      "-lm",
      "-lopusfile",
      "-logg",
      "-lopus",
      "-force_load",
      "$libDir/libopusfile.a",
      "-force_load",
      "$libDir/libogg.a",
      "-force_load",
      "$libDir/libopus.a",
    ];
    if (platform == "ios") {
      flags.addAll("-framework Foundation -mios-version-min=8.0".split(" "));
    } else if (platform == "macos") {
      flags.addAll("-framework Foundation".split(" "));
    } else if (platform == "android") {}
    final cbuilder = CBuilder.library(
      name: packageName,
      language: Language.cpp,
      assetName: '$packageName.dart',
      sources: [
        'native/src/OpusFileDartCApi.cpp',
      ],
      includes: ['native/include', 'native/include/ogg'],
      flags: flags,
      dartBuildFiles: ['hook/build.dart'],
    );

    await cbuilder.run(
      buildConfig: config,
      buildOutput: output,
      logger: Logger('')
        ..level = Level.ALL
        ..onRecord.listen((record) => print(record.message)),
    );
  });
}
