import 'package:alla24/data/models/result.dart';
import 'package:alla24/data/repository.dart';
import 'package:alla24/main/settings/profile/edit_profile/data/models/profile.dart';
import 'package:alla24/shared/localization/app_localization.dart';
import 'package:dio/dio.dart';

class ProfileRepository extends Repository {
  String _path;

  ProfileRepository() {
    _path = '${apiUrl}api/';
  }

  Future<Result<dynamic>> update(ProfileModel model) async {
    try {
      final data = model.toJson();
      var formData = FormData.fromMap(data);
      final response = await dio.post('${_path}update',
          data: formData, options: Options(contentType: 'multipart/form-data'));
      if (response.statusCode == 200) {
        final data = response.data;
        return Result(ResultStatus.SUCCESS, data: ProfileModel.fromJson(data));
      } else
        return getError(response);
    } catch (e) {
      print(e);
      if (e is DioError)
        return getError(e.response);
      else
        return Result(ResultStatus.FAIL,
            errorMessage: AppLocalization.someError);
    }
  }

  logout() async {
    try {} catch (e) {
      print(e);
    }
  }
}
