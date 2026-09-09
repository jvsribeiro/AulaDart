import 'dart:io';

class DesligarPC {
  static Future<void> desligar() async {
    if (!Platform.isWindows) {
      print('Desligamento automático configurado apenas para Windows.');
      return;
    }

    await Process.run(
      'shutdown',
      ['/s', '/t', '0'],
      runInShell: true,
    );
  }
}
