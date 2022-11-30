import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';

class FileService {
  // #region Singleton
  FileService._privateConstructor();

  static final FileService _instance = FileService._privateConstructor();

  static FileService get instance => _instance;

  // #endregion

  Future<String?> uploadFile(String content) async {
    try {
      var client =
          Dio(BaseOptions(baseUrl: 'https://omr-scanner-maua.herokuapp.com'));
      var body = FormData.fromMap({
        'image': MultipartFile.fromBytes(utf8.encode(content),
            filename: 'image-${DateTime.now().millisecondsSinceEpoch}.png'),
      });
      var res = await client.post('/process', data: body);
      if (res.statusCode == 200) {
        return res.data['attachment_id'];
      }
      return null;
    } on DioError catch (e) {
      return null;
    }
  }

  Future<String?> getFile() async {
    try {
      var result = await FilePicker.platform.pickFiles();
      if (result != null) {
        PlatformFile file = result.files.first;
        return base64Encode(file.bytes!);
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }
}
