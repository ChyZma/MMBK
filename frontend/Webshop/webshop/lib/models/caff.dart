import 'dart:typed_data';

import 'package:api/api.dart';

class Caff {
  final int id;
  final String name;
  final List<String> tags;
  Uint8List? gif;

  Caff({
    required this.id,
    required this.name,
    required this.tags,
    this.gif,
  });

  factory Caff.from(CaffResponse caffResponse) => Caff(
        id: caffResponse.id!,
        name: caffResponse.fileName!,
        tags: caffResponse.tags!,
      );
}
