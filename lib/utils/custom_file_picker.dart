import 'dart:async';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';

abstract final class CustomFilePicker {
  static Future<Uint8List?> loadImageFromDevice({
    FileType type = FileType.image,
    String? dialogTitle,
  }) async {
    final FilePickerResult? result = await FilePicker.platform.pickFiles(
      withData: true,
      type: type,
      allowMultiple: false,
      dialogTitle: dialogTitle,
      // allowedExtensions: ['jpg', 'jpeg', 'png', 'webp', 'bmp'], // Avoiding GIF
    );

    if (result != null && result.files.isNotEmpty) {
      return result.files.single.bytes!;
    }
    return null;
  }
}
