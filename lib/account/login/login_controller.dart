import 'dart:convert';

import 'package:alla24/account/data/account_repository.dart';
import 'package:alla24/account/data/models/login.dart';
import 'package:alla24/app_route.dart';
import 'package:alla24/data/models/result.dart';
import 'package:alla24/shared/services/preferences_service.dart';
import 'package:alla24/shared/widgets/toaster.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:mobx/mobx.dart';

part 'login_controller.g.dart';

class LoginController = _LoginControllerBase with _$LoginController;

abstract class _LoginControllerBase with Store {
  PreferencesService _preferencesService = PreferencesService();
  AccountRepository _accountRepository = AccountRepository();

  @observable
  bool rememberMe = false;

  @observable
  bool showPassword = false;

  @observable
  bool loading = false;

  @observable
  bool autoValidate = false;

  // @observable
  // String lang = AppLocalization.defaultLang;
  //
  // @action
  // bool isRtl() => lang == AppLocalization.ar;

  @action
  void changeRememberMe() {
    rememberMe = !rememberMe;
  }

  Future init() async {
    autoValidate = false;
    // lang = await _preferencesService.lang;
    // AppLocalization.langStream.listen((value) {
    //   lang = value;
    // });
  }

  @observable
  LoginModel model = LoginModel();

  @action
  String checkEmail() {
    if (model.email.isEmpty)
      return "AppLocalization.emailRequired";
    else if (EmailValidator.validate(model.email))
      return null;
    else
      return "AppLocalization.emailNotValid";
  }

  @action
  String checkPassword() {
    if (model.password.isEmpty) return "AppLocalization.passwordRequired";
    if (model.password.length < 6 || model.password.length > 30)
      return "AppLocalization.passwordNotValid";
    else
      return null;
  }

  @action
  void changeViewPassword() {
    showPassword = !showPassword;
  }

  @action
  login(BuildContext context) async {
    loading = true;
    final result = await _accountRepository.login(model);
    if (result.state == ResultStatus.FAIL)
      Toaster.error(msg: result.errorMessage);
    else {
      final data = result.data as LoginResult;
      _preferencesService.token = data.response.token;
      // var a = await _preferencesService.token;
      _preferencesService.user = jsonEncode(data.user);
      // var b = User.fromJson(jsonDecode(await _preferencesService.user));
      Navigator.pushReplacementNamed(context, AppRoute.mainRoute);
    }
    loading = false;
  }
}
