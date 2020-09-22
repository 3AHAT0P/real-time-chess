import 'dart:io';

const environments = ['development', 'test', 'production'];

String resolvePath(List<String> folders, String filename) {
  final separator = Platform.isWindows ? '\\' : '/';
  var path = '';

  for (final String folder in folders) {
    path += '$folder$separator';
  }

  path += filename;

  return path;
}

Future<void> main() async {
  final File template = new File(resolvePath(['lib', 'configs'], '_template'));

  for (final env in environments) {
    final File config = await new File(resolvePath(['lib', 'configs'], '$env.dart')).create();
    final lines = await template.readAsLines();

    for (final line in lines) {
      final newLine = line
        .replaceAll(new RegExp(r'\{\{ENVIRONMENT\}\}'), env.replaceRange(0, 1, env[0].toUpperCase()))
        .replaceAll(new RegExp(r'\{\{environment\}\}'), env);
      await config.writeAsString('$newLine\n', mode: FileMode.append);
    }
  }
}