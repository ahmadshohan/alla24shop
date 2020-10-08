import 'package:alla24/account/data/models/forgotPassword.dart';
import 'package:alla24/account/data/models/login.dart';
import 'package:alla24/account/data/models/register.dart';
import 'package:alla24/data/models/result.dart';
import 'package:alla24/data/repository.dart';
import 'package:dio/dio.dart';

class AccountRepository extends Repository {
  String _path;

  AccountRepository() {
    _path = '$apiUrl';
  }

  Future<Result<dynamic>> login(LoginModel model) async {
    try {
      final response = await dio.post('${_path}login',
          data: FormData.fromMap(model.toJson()));
      if (response.statusCode == 200) {
        final data = response.data['data'];
        return Result(ResultStatus.SUCCESS, data: LoginResult.fromJson(data));
      } else
        return getError(response);
    } catch (e) {
      print(e);
      if (e is DioError)
        return getError(e.response);
      else
        return Result(ResultStatus.FAIL,
            errorMessage: " AppLocalization.someError");
    }
  }

  Future<Result<dynamic>> register(RegisterModel model) async {
    try {
      final data = model.toJson();
      var formData = FormData.fromMap(data);
      final response = await dio.post('${_path}register', data: formData);
      if (response.statusCode == 200) {
        final data = response.data['data'];
        return Result(ResultStatus.SUCCESS, data: LoginResult.fromJson(data));
      } else
        return getError(response);
    } catch (e) {
      print(e);
      if (e is DioError)
        return getError(e.response);
      else
        return Result(ResultStatus.FAIL,
            errorMessage: "AppLocalization.someError");
    }
  }

  Future<Result<dynamic>> forgotPassword(ForgotPasswordModel model) async {
    try {
      final response = await dio.post('${_path}forget_password',
          data: FormData.fromMap(model.toJson()));
      if (response.statusCode == 200) {
        final data = response.data;
        return Result(ResultStatus.SUCCESS);
      } else
        return getError(response);
    } catch (e) {
      print(e);
      if (e is DioError)
        return getError(e.response);
      else
        return Result(ResultStatus.FAIL,
            errorMessage: "AppLocalization.someError");
    }
  }

  logout() async {
    try {
      final response = await dio.post('${_path}log_out');
      if (response.statusCode == 200) {
        return Result(ResultStatus.SUCCESS);
      } else {
        return getError(response);
      }
    } catch (e) {
      print(e);
      if (e is DioError)
        return getError(e.response);
      else
        return Result(ResultStatus.FAIL,
            errorMessage: " AppLocalization.someError");
    }
  }
}
