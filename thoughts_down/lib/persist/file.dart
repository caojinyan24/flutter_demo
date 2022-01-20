import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:intl/intl.dart';

FileProcessor fileProcessor = FileProcessor();

class FileProcessor {
  Future<File> get _file async {
    final directory = await getApplicationDocumentsDirectory();
    final path = directory.path;
    print("filePath=" + path);
    String month = DateFormat('yyyy_MM').format(DateTime.now());
    return File("$path/thoughts_$month.md");
  }

  void appendData(String data) async {
    File f = await _file;
    f.writeAsStringSync(data, mode: FileMode.append);
  }

  void writeData(String data) async {
    File f = await _file;
    f.writeAsStringSync(data);
  }
}
