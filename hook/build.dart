// Copyright (c) 2023, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:logging/logging.dart';
import 'package:native_assets_cli/native_assets_cli.dart';
import 'package:native_toolchain_c/native_toolchain_c.dart';

void main(List<String> args) async {
  await build(args, (config, output) async {
    final packageName = config.packageName;
    var platform = config.targetOS.toString().toLowerCase();
    var libDir = "${config.packageRoot.toFilePath()}/native/lib/$platform/";
    final cbuilder = CBuilder.library(
      name: packageName,
      language: Language.cpp,
      assetName: '$packageName.dart',
      sources: [
        'native/src/OpusFileDartCApi.cpp',
      ],
      includes: ['native/include', 'native/include/ogg'],
      flags: [
        '-std=c++17',
        '-framework',
        'Foundation',
        if(platform == "ios")
        "-mios-version-min=8.0"
        "-force_load",
        "$libDir/libopusfile.a",
        "-force_load",
        "$libDir/libogg.a",
        "-force_load",
        "$libDir/libopus.a",
      ],
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
