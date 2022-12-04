import 'package:flutter/material.dart';
import 'package:webshop/app/theme/fonts.dart';
import 'package:webshop/pages/signup/signup_model.dart';
import 'package:webshop/widget/gaps.dart';

import '../../app/ioc.dart';
import '../../app/theme/color_palette.dart';
import '../../app/theme/sizes.dart';
import '../../core/app_scaffold.dart';
import '../../core/display.dart';
import '../../util/validation.dart';
import '../../widget/button.dart';
import '../../widget/system_style.dart';

final _requiredRule = Rules([NotEmptyRule()]);
final _emailRules = Rules([EmailRule()]);
final _passwordRule = Rules([PasswordRule()]);

class SignUpPage extends StatefulWidget {
  SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  late double contentHeight;

  final registerFormKey = GlobalKey<FormState>();
  final fieldKey = GlobalKey<FormFieldState>();
  AutovalidateMode validateMode = AutovalidateMode.disabled;

  late final model = IoC.get<SignUpModel>();

  @override
  void didUpdateWidget(covariant SignUpPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      fieldKey.currentState?.validate();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SystemStyle.light(
      systemNavigationBarColor: ColorPalette.transparent,
      child: AppScaffold(
        uiHandler: model.uiHandler,
        backgroundColor: ColorPalette.black,
        body: Display.single(
            content: model.uiHandler.load,
            builder: (_, __) {
              return Padding(
                padding: const EdgeInsets.all(Sizes.medium),
                child: Form(
                  key: registerFormKey,
                  autovalidateMode: validateMode,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "regisztráció",
                        style: Fonts.h2.white,
                      ),
                      const Vgap(Sizes.huge),
                      FormField<String>(
                          validator: (v) => _requiredRule.validate(v),
                          builder: (state) {
                            return Container(
                              padding: const EdgeInsets.all(Sizes.tiny),
                              color: ColorPalette.white,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  TextField(
                                    keyboardType: TextInputType.emailAddress,
                                    decoration: const InputDecoration(
                                      labelText: "felhasználónév",
                                      contentPadding: EdgeInsets.symmetric(
                                          horizontal: Sizes.medium),
                                    ),
                                    onChanged: (String v) {
                                      model.profile.userName = v;
                                      state.didChange(v);
                                    },
                                  ),
                                  if (state.hasError) ...[
                                    const Vgap(Sizes.tiny),
                                    Text(
                                      state.errorText!,
                                      style: Fonts.tiny
                                          .copyWith(color: ColorPalette.error),
                                    ),
                                  ]
                                ],
                              ),
                            );
                          }),
                      const Vgap(Sizes.medium),
                      FormField<String>(
                          validator: (v) => _emailRules.validate(v),
                          builder: (state) {
                            return Container(
                              padding: const EdgeInsets.all(Sizes.tiny),
                              color: ColorPalette.white,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  TextField(
                                    keyboardType: TextInputType.emailAddress,
                                    decoration: const InputDecoration(
                                      labelText: "email",
                                      hintText: "name@example.com",
                                      contentPadding: EdgeInsets.symmetric(
                                          horizontal: Sizes.medium),
                                    ),
                                    onChanged: (String v) {
                                      model.profile.email = v;
                                      state.didChange(v);
                                    },
                                  ),
                                  if (state.hasError) ...[
                                    const Vgap(Sizes.tiny),
                                    Text(
                                      state.errorText!,
                                      style: Fonts.tiny
                                          .copyWith(color: ColorPalette.error),
                                    ),
                                  ]
                                ],
                              ),
                            );
                          }),
                      const Vgap(Sizes.medium),
                      FormField<String>(
                          validator: (v) => _passwordRule.validate(v),
                          builder: (state) {
                            return Container(
                              padding: const EdgeInsets.all(Sizes.tiny),
                              color: ColorPalette.white,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  TextField(
                                    keyboardType: TextInputType.emailAddress,
                                    decoration: const InputDecoration(
                                      labelText: "jelszó",
                                      contentPadding: EdgeInsets.symmetric(
                                          horizontal: Sizes.medium),
                                    ),
                                    obscureText: true,
                                    onChanged: (String v) {
                                      model.profile.password = v;
                                      state.didChange(v);
                                    },
                                  ),
                                  if (state.hasError) ...[
                                    const Vgap(Sizes.tiny),
                                    Text(
                                      state.errorText!,
                                      style: Fonts.tiny
                                          .copyWith(color: ColorPalette.error),
                                    ),
                                  ]
                                ],
                              ),
                            );
                          }),
                      const Vgap(Sizes.big),
                      Button.primary(
                        text: "regisztráció",
                        disabled: model.uiHandler.isLoading,
                        loading: model.uiHandler.isLoading,
                        onPressed: () {
                          _onSave();
                        },
                      ),
                    ],
                  ),
                ),
              );
            }),
      ),
    );
  }

  void _onSave() {
    if (registerFormKey.currentState!.validate()) {
      registerFormKey.currentState!.save();
      model.register();
    }
  }
}
