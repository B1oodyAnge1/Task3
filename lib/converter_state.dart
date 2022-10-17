import 'package:flutter/animation.dart';

import 'main.dart';

class ConverterState extends MyApp {
  final String filePath;
  final String fileName;
  final String listExtensionString0;
  final String listExtensionString1;
  final String listExtensionString2;
  final String listExtensionString3;
  const ConverterState({
    this.filePath = '0000',
    this.fileName = ' ',
    this.listExtensionString0 = ' ',
    this.listExtensionString1 = ' ',
    this.listExtensionString2 = ' ',
    this.listExtensionString3 = ' ',
  });
  ConverterState copyWith({
    String? filePath,
    String? fileName,
    String? listExtensionString0,
    String? listExtensionString1,
    String? listExtensionString2,
    String? listExtensionString3,
  }) {
    return ConverterState(
      filePath: filePath ?? this.filePath,
      fileName: fileName ?? this.fileName,
      listExtensionString0: listExtensionString0 ?? this.listExtensionString0,
      listExtensionString1: listExtensionString1 ?? this.listExtensionString1,
      listExtensionString2: listExtensionString2 ?? this.listExtensionString2,
      listExtensionString3: listExtensionString3 ?? this.listExtensionString3,
    );
  }

  @override
  List<Object?> get props => [
        filePath,
        fileName,
        listExtensionString0,
        listExtensionString1,
        listExtensionString2,
        listExtensionString3,
      ];
}
