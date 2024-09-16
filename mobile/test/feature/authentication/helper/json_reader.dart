import 'dart:io';

String fixture(String name) =>
    File('test/feature/authentication/helper/fixtures/$name')
        .readAsStringSync();

String readJson(String name) {
  var dir = Directory.current.path;
  if (dir.endsWith('/test')) {
    dir = dir.replaceAll('/test', '');
  }
  return File('$dir/test/feature/authentication/$name').readAsStringSync();
}
