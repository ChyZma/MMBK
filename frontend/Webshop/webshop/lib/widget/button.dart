import 'package:flutter/material.dart';
import 'package:webshop/widget/progress_indicator.dart';

import '../../app/theme/color_palette.dart';
import '../../app/theme/durations.dart';
import '../../app/theme/fonts.dart';
import '../../app/theme/sizes.dart';
import '../../util/utils.dart';
import 'gaps.dart';

class Button extends StatelessWidget {
  final bool disabled, loading;
  final String text;
  final VoidCallback? onPressed;
  final TextStyle textStyle;
  final ButtonStyle? buttonStyle;
  final Widget? prefix;
  final Widget? suffix;

  const Button(
      {Key? key,
      this.disabled = false,
      this.loading = false,
      required this.text,
      this.onPressed,
      required this.textStyle,
      this.buttonStyle,
      this.prefix,
      this.suffix})
      : super(key: key);

  factory Button.primary({
    Key? key,
    required String text,
    bool disabled = false,
    bool loading = false,
    Widget? prefix,
    Widget? suffix,
    VoidCallback? onPressed,
    Color color = ColorPalette.white,
    Color textColor = ColorPalette.black,
    double height = 50.0,
  }) {
    final textStyle = Fonts.smallTitle.copyWith(
      color: disabled && !loading ? ColorPalette.gray20 : textColor,
    );

    return Button(
      key: key,
      text: text,
      prefix: prefix,
      suffix: suffix,
      loading: loading,
      disabled: disabled,
      onPressed: onPressed,
      textStyle: textStyle,
      buttonStyle: ButtonStyle(
        minimumSize: MaterialStateProperty.all(Size.fromHeight(height)),
        shape: MaterialStateProperty.all(
          const BeveledRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(
                15,
              ),
            ),
            side: BorderSide(color: ColorPalette.gray10, width: 1.0),
          ),
        ),
        elevation: MaterialStateProperty.resolveWith<double>(
          (states) {
            return states.contains(MaterialState.disabled) ? 0.0 : 8.0;
          },
        ),
        foregroundColor: MaterialStateProperty.all(textColor),
        backgroundColor: MaterialStateProperty.resolveWith((states) {
          return states.contains(MaterialState.disabled)
              ? ColorPalette.grayDark
              : color;
        }),
        shadowColor: MaterialStateProperty.all(color.withOpacity(0.0)),
      ),
    );
  }

  factory Button.black({
    Key? key,
    required String text,
    bool disabled = false,
    bool loading = false,
    VoidCallback? onPressed,
    Color color = ColorPalette.black,
    Color textColor = ColorPalette.white,
    double height = 50.0,
    Widget? prefix,
    Widget? suffix,
  }) {
    final style = Fonts.smallTitle.copyWith(
      color: disabled && !loading ? ColorPalette.gray10 : textColor,
    );
    return Button(
      key: key,
      text: text,
      prefix: prefix,
      loading: loading,
      disabled: disabled,
      onPressed: onPressed,
      textStyle: style,
      buttonStyle: ButtonStyle(
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        minimumSize: MaterialStateProperty.all(Size.fromHeight(height)),
        shape: MaterialStateProperty.resolveWith((states) {
          return const BeveledRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(
                15,
              ),
            ),
          );
        }),
        elevation: MaterialStateProperty.all(0.0),
        foregroundColor: MaterialStateProperty.all(style.color),
        backgroundColor: MaterialStateProperty.resolveWith((states) {
          return states.contains(MaterialState.disabled)
              ? ColorPalette.grayDark
              : color;
        }),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final child = Text(
      text,
      style: textStyle,
      maxLines: 1,
      textAlign: TextAlign.center,
      overflow: TextOverflow.ellipsis,
    );
    return ElevatedButton(
      onPressed: loading || disabled ? null : onPressed,
      style: buttonStyle,
      child: AnimatedSwitcher(
        duration: Durations.mediumEnter,
        child: loading
            ? _ButtonLoadingIndicator(style: textStyle)
            : Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  if (prefix == null) ...[
                    child,
                  ] else ...[
                    prefix!,
                    const Hgap(12.0),
                    child,
                  ],
                  if (suffix != null) ...[
                    const Spacer(),
                    suffix!,
                  ]
                ],
              ),
      ),
    );
  }
}

class _ButtonLoadingIndicator extends StatelessWidget {
  final TextStyle style;

  const _ButtonLoadingIndicator({required this.style});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (_, constraints) {
      const text = 'Loading';
      final textWidth = calculateTextWidth(text, style);
      final showText = constraints.maxWidth > 20 + Sizes.medium + textWidth;

      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgress.small(color: style.color),
          if (showText) ...[
            Hgap.medium(),
            Text(text, style: style),
          ],
        ],
      );
    });
  }
}
