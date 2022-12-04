import 'package:flutter/material.dart';

import '../app/theme/fonts.dart';
import 'button.dart';
import 'dialog_container.dart';
import 'gaps.dart';

class ErrorDialog extends StatelessWidget {
  final String title, message, primaryText;
  final String? secondaryText;
  final VoidCallback onPrimaryTap;
  final VoidCallback? onSecondaryTap;

  const ErrorDialog({
    Key? key,
    required this.title,
    required this.message,
    required this.primaryText,
    required this.onPrimaryTap,
    this.secondaryText,
    this.onSecondaryTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final secondaryButton = secondaryText == null || onSecondaryTap == null
        ? null
        : Button.black(
            text: secondaryText!,
            onPressed: onSecondaryTap,
          );

    return DialogContainer(
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              title,
              style: Fonts.h5,
              textAlign: TextAlign.center,
            ),
            Vgap.medium(),
            Text(
              message,
              style: Fonts.h6,
              textAlign: TextAlign.center,
            ),
            Vgap.large(),
            Button.primary(
              text: primaryText,
              onPressed: onPrimaryTap,
            ),
            if (secondaryButton != null) ...[
              Vgap.medium(),
              secondaryButton,
            ]
          ],
        ),
      ),
    );
  }
}
