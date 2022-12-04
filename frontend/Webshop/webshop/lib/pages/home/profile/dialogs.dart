import 'package:flutter/material.dart';

import '../../../app/theme/fonts.dart';
import '../../../widget/gaps.dart';
import '../../../widget/material.dart';

void showStorageAccessDialog(BuildContext context) {
  showThemedDialog(
    context: context,
    builder: (context) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "Valami hiba történt!",
            style: Fonts.h6.bold,
            textAlign: TextAlign.center,
          ),
          Vgap.medium(),
          const Text(
            'Külső tárhely elérés hiba',
            style: Fonts.small,
            textAlign: TextAlign.center,
          ),
        ],
      );
    },
  );
}
