import 'dart:io';

import 'package:flutter/painting.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pedantic/pedantic.dart';

class ImageCacheManager extends BaseCacheManager {
  static const key = 'libCachedImageData';
  static ImageCacheManager _instance;

  factory ImageCacheManager() {
    return _instance ??= ImageCacheManager._();
  }

  ImageCacheManager._() : super(key);

  @override
  Future<String> getFilePath() async {
    final directory = await getTemporaryDirectory();
    return join(directory.path, key);
  }

  @override
  Future<File> getSingleFile(String url, {Map<String, String> headers}) async {
    final cacheFile = await getFileFromCache(url);
    if (cacheFile != null) {
      if (cacheFile.validTill.isBefore(DateTime.now())) {
        unawaited(webHelper.downloadFile(url, authHeaders: headers));
      }
      return cacheFile.file;
    }
    try {
      final download = await webHelper.downloadFile(url, authHeaders: headers);

      // try to parse if not it will return null.
      await PaintingBinding.instance
          .instantiateImageCodec(download.file.readAsBytesSync());

      return download.file;
    } catch (e) {
      print(e);

      return null;
    }
  }
}
