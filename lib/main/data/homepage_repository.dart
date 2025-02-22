import 'dart:convert';

import 'package:alla24/data/models/result.dart';
import 'package:alla24/data/repository.dart';
import 'package:alla24/main/data/models/slider.dart';
import 'package:dio/dio.dart';

class MusicRepository extends Repository {
  String _path;

  MusicRepository() {
    _path = '$apiUrl';
  }

  Future<Result<dynamic>> getSliderHomePage(String lang) async {
    try {
      final langData = jsonEncode({'lang': 'en'});
      final response =
          await dio.post('${_path}home_page_slider', data: langData);
      if (response.statusCode == 200) {
        final data = response.data;
        return Result(ResultStatus.SUCCESS, data: SliderResult.fromJson(data));
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

  // Future<Result<dynamic>> getLastAlbumsHomePage(String lang) async {
  //   try {
  //     final langData = jsonEncode({'lang': 'en'});
  //     final response =
  //         await dio.post('${_path}home_page_last_album', data: langData);
  //     if (response.statusCode == 200) {
  //       final data = response.data;
  //       return Result(ResultStatus.SUCCESS, data: AlbumsResult.fromJson(data));
  //     } else
  //       return getError(response);
  //   } catch (e) {
  //     print(e);
  //     if (e is DioError)
  //       return getError(e.response);
  //     else
  //       return Result(ResultStatus.FAIL,
  //           errorMessage: AppLocalization.someError);
  //   }
  // }
  //
  // Future<Result<dynamic>> getBestSongsHomePage(String lang) async {
  //   try {
  //     final langData = jsonEncode({'lang': 'tr'});
  //     final response =
  //         await dio.post('${_path}home_page_best_songs', data: langData);
  //     if (response.statusCode == 200) {
  //       final data = response.data;
  //       return Result(ResultStatus.SUCCESS, data: SongResult.fromJson(data));
  //     } else
  //       return getError(response);
  //   } catch (e) {
  //     print(e);
  //     if (e is DioError)
  //       return getError(e.response);
  //     else
  //       return Result(ResultStatus.FAIL,
  //           errorMessage: AppLocalization.someError);
  //   }
  // }
  //
  // Future<Result<dynamic>> getPlayListHomePage() async {
  //   try {
  //     final response = await dio.get('${_path}home_page_play_list');
  //     if (response.statusCode == 200) {
  //       final data = response.data;
  //       return Result(ResultStatus.SUCCESS, data: jsonDecode(data));
  //     } else
  //       return getError(response);
  //   } catch (e) {
  //     print(e);
  //     if (e is DioError)
  //       return getError(e.response);
  //     else
  //       return Result(ResultStatus.FAIL,
  //           errorMessage: AppLocalization.someError);
  //   }
  // }
}
