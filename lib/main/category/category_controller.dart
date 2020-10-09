import 'package:alla24/account/data/account_repository.dart';
import 'package:alla24/shared/localization/app_localization.dart';
import 'package:alla24/shared/services/preferences_service.dart';
import 'package:mobx/mobx.dart';

part 'category_controller.g.dart';

class CategoryController = _CategoryControllerBase with _$CategoryController;

abstract class _CategoryControllerBase with Store {
  PreferencesService _preferencesService = PreferencesService();
  AccountRepository _accountRepository = AccountRepository();

  @observable
  bool showList = false;

  @observable
  bool loading = false;

  @observable
  String lang = AppLocalization.defaultLang;

  @action
  bool isRtl() => lang == AppLocalization.ar;

  Future init() async {
    lang = await _preferencesService.lang;
    AppLocalization.langStream.listen((value) {
      lang = value;
    });
  }

  @action
  void changeView() {
    showList = !showList;
  }
}
