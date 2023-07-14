import 'dart:io';
import 'dart:typed_data';

import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

Future<File> writeFile(Uint8List data, String fileName) async {
  //REQUEST PERMISSION
  var status = await Permission.storage.status;
  if (!status.isGranted) {
    await Permission.storage.request();
  }
  //PATH KE FOLDER DOWNLOAD

  final Directory? downloadsDir = await getExternalStorageDirectory();
  print(downloadsDir);
  String tempPath = downloadsDir!.path;
  // String tempPath = '/storage/emulated/0';

  var filePath = tempPath + '/$fileName';

  //DATA (FILENYA)
  var bytes = ByteData.view(data.buffer);
  final buffer = bytes.buffer;
  //SIMPAN DATA KE PATH (DIREKTORI)
  return File(filePath).writeAsBytes(
    buffer.asUint8List(data.offsetInBytes, data.lengthInBytes),
  );
}
