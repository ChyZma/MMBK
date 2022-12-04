import 'package:flutter/material.dart';

import '../../../app/theme/color_palette.dart';
import '../../../app/theme/fonts.dart';
import '../../../models/user.dart';
import '../../../widget/gaps.dart';

class UserItem extends StatelessWidget {
  final User user;

  final Future<void> Function(String) onDelete;

  const UserItem({
    super.key,
    required this.user,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(minHeight: 88),
      decoration: const BoxDecoration(
        color: ColorPalette.white,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                user.name!,
                style: Fonts.smallTitle
                  ..copyWith(
                    color: ColorPalette.black,
                  ),
              ),
              Vgap.small(),
              if (user.email != null)
                Text(
                  user.email!,
                  style: Fonts.small
                    ..copyWith(
                      color: ColorPalette.gray60,
                    ),
                ),
            ],
          ),
          const Spacer(),
          if (user.role != Role.admin)
            TextButton(
                onPressed: () {
                  onDelete(user.id!);
                },
                child: Text(
                  "Törlés",
                  style: Fonts.smallTitle.copyWith(color: ColorPalette.error),
                ))
        ],
      ),
    );
  }
}
