import 'dart:convert';
import 'dart:io';

import 'package:alla24/account/data/account_repository.dart';
import 'package:alla24/account/data/models/login.dart';
import 'package:alla24/account/data/models/register.dart';
import 'package:alla24/app_route.dart';
import 'package:alla24/data/models/result.dart';
import 'package:alla24/shared/services/preferences_service.dart';
import 'package:alla24/shared/widgets/toaster.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:mobx/mobx.dart';

part 'register_controller.g.dart';

class RegisterController = _RegisterControllerBase with _$RegisterController;

abstract class _RegisterControllerBase with Store {
  PreferencesService _preferencesService = PreferencesService();
  AccountRepository _accountRepository = AccountRepository();

  Future init() async {
    autoValidate = false;
    city = 'محافظة كركوك';
    // lang = await _preferencesService.lang;
    // AppLocalization.langStream.listen((value) {
    //   lang = value;
    // });
  }

  @observable
  bool loading = false;
  @observable
  bool autoValidate = false;

  @observable
  String city = 'محافظة كركوك';

  @observable
  bool showPassword = false;

  @observable
  RegisterModel model = RegisterModel();

  // @action
  // bool isRtl() => lang == AppLocalization.ar;

  @action
  void selectedCity(String selectedCity) {
    city = selectedCity;
  }

  @action
  void changeViewPassword() {
    showPassword = !showPassword;
  }

  @action
  String checkFullName() {
    if (model.fullName.isEmpty) return "AppLocalization.userNameRequired";
    if (model.fullName.length < 4)
      return "AppLocalization.userNameNotValid";
    else
      return null;
  }

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
  String checkMatchPassword() {
    if (model.password.isEmpty) return "AppLocalization.passwordRequired";
    if (model.password != model.passwordConfirm)
      return "AppLocalization.passwordNotMatch";
    else
      return null;
  }

  @action
  String checkPhoneNumber() {
    if (model.phoneNumber.isEmpty) return "AppLocalization.phoneNumberRequired";
    if (model.phoneNumber.length < 11)
      return "AppLocalization.phoneNumberNotValid";
    else
      return null;
  }

  @action
  register(BuildContext context) async {
    loading = true;
    final result = await _accountRepository.register(model);
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
