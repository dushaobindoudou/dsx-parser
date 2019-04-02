import 'dart:async';
import 'package:analyzer/dart/element/element.dart';

import 'package:build/build.dart';

import './simple-parser.dart';

class ParserBuilder implements Builder {

  @override
  Future build(BuildStep buildStep) async {
    var inputId = buildStep.inputId;
    var parser = inputId.changeExtension('.dart');
    var contents = await buildStep.readAsString(inputId);
    var nContent = parserTemplate(contents, inputId.package);
    buildStep.writeAsString(parser, nContent);
  }

  /// Configure output extensions. All possible inputs match the empty input
  /// extension. For each input 1 output is created with `extension` appended to
  /// the path.
  /// TODO: 添加额外格式支持
  Map<String, List<String>> get buildExtensions => {'.dsx': ['.dart']};
}