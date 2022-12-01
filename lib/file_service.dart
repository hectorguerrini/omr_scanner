import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:omr_scanner/omr.dart';

class FileService {
  // #region Singleton
  FileService._privateConstructor();

  static final FileService _instance = FileService._privateConstructor();

  static FileService get instance => _instance;

  // #endregion

  Future<OMRModel?> uploadFile(List<int> bytes) async {
    try {
      var client =
          Dio(BaseOptions(baseUrl: 'https://omr-scanner-maua.herokuapp.com'));
      var body = FormData.fromMap({
        'image': MultipartFile.fromBytes(bytes,
            filename: 'image-${DateTime.now().millisecondsSinceEpoch}.png'),
      });
      var res = await client.post('/process', data: body);
      if (res.statusCode == 200) {
        return OMRModel.fromJson(res.data);
      }
      return null;
    } on DioError catch (e) {
      return null;
    }
  }

  Future<List<int>?> getFile() async {
    try {
      var result = await FilePicker.platform.pickFiles();
      if (result != null) {
        PlatformFile file = result.files.first;
        return file.bytes;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }
}
