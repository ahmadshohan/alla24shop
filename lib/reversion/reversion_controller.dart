import 'dart:io';

import 'package:alla24/data/models/result.dart';
import 'package:alla24/main/settings/profile/edit_profile/data/models/profile.dart';
import 'package:alla24/main/settings/profile/edit_profile/data/profile_repository.dart';
import 'package:alla24/shared/localization/app_localization.dart';
import 'package:alla24/shared/services/preferences_service.dart';
import 'package:alla24/shared/widgets/toaster.dart';
import 'package:email_validator/email_validator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobx/mobx.dart';

part 'reversion_controller.g.dart';

class ReversionPageController = _ReversionPageControllerBase
    with _$ReversionPageController;

abstract class _ReversionPageControllerBase with Store {
  PreferencesService _preferencesService = PreferencesService();
  ProfileRepository _profileRepository = ProfileRepository();

  Future init() async {
    lang = await _preferencesService.lang;
    AppLocalization.langStream.listen((value) {
      lang = value;
    });
  }

  @observable
  String reversionItem = 'سماعة';

  @observable
  bool loading = false;

  @observable
  String lang = AppLocalization.defaultLang;

  @observable
  File pictureFile;

  @observable
  bool autoValidate = false;

  @observable
  bool showPassword = false;

  @observable
  ProfileModel model = ProfileModel();

  @action
  bool isRtl() => lang == AppLocalization.ar;

  @action
  void reversionItemChange(String selectedItem) {
    reversionItem = selectedItem;
  }

  @action
  update() async {
    loading = true;
    final result = await _profileRepository.update(model);
    if (result.state == ResultStatus.FAIL)
      Toaster.error(msg: result.errorMessage);
    else {
      final data = result.data;
    }
    loading = false;
  }
}
