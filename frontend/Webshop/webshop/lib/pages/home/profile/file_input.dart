import 'package:flutter/material.dart';

import '../../../app/theme/sizes.dart';
import '../../../core/exceptions.dart';
import '../../../service/external_navigation.dart';
import '../../../widget/animated_changer.dart';
import '../../../widget/button.dart';
import '../../../widget/input_error_text.dart';
import 'dialogs.dart';

class FileInput extends StatelessWidget {
  final bool disabled;
  final String? initialValue;
  final ValueChanged<String?>? onChanged;
  final FormFieldSetter<String>? onSaved;
  final FormFieldValidator<String>? validator;

  const FileInput({
    Key? key,
    this.disabled = false,
    this.initialValue,
    this.onChanged,
    this.onSaved,
    this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FormField<String>(
      initialValue: initialValue,
      onSaved: onSaved,
      validator: validator,
      builder: (FormFieldState<String> fieldState) {
        return AnimatedChanger(
          child: Column(
            children: [
              Button.primary(
                text: 'Fájlkezelő',
                disabled: disabled,
                height: 70,
                onPressed: () {
                  _openFilePicker(context, fieldState);
                },
              ),
              InputErrorText(
                text: fieldState.errorText,
                padding: const EdgeInsets.all(Sizes.tiny),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _openFilePicker(
    BuildContext context,
    FormFieldState<String> state,
  ) async {
    try {
      final caff = await pickFile(context);
      final path = caff?.path;
      state.didChange(path);
      state.validate();
      onChanged?.call(path);
    } on ExternalStorageAccessException catch (e) {
      showStorageAccessDialog(context);
    } catch (e) {
      rethrow;
    }
  }
}
