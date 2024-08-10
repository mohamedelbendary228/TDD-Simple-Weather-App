import 'dart:io';

// A Helper fucntion to read a json file from a give path
String readJson(String path) {
  var dir = Directory.current.path;
  if (dir.endsWith('/test')) {
    dir = dir.replaceAll('/test', '');
  }
  return File('$dir/test/$path').readAsStringSync();
}
