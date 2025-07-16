import 'dart:convert';
import 'dart:io';

Future<void> copyToClipboard(String text) async {
  if (Platform.isMacOS) {
    await Process.run('pbcopy', [], stdin: text);
  } else if (Platform.isLinux) {
    await Process.run('xclip', ['-selection', 'clipboard'], stdin: text);
  } else if (Platform.isWindows) {
    await Process.run('clip', [], stdin: text);
  } else {
    print('⚠️ Clipboard not supported on this platform');
  }
}

Future<void> main(List<String> args) async {
  final fileName = args.isNotEmpty ? args[0] : 'lib/l10n/intl_en.arb';
  final file = File(fileName);

  if (!file.existsSync()) {
    print('❌ File not found: $fileName');
    exit(1);
  }

  final jsonContent = json.decode(await file.readAsString()) as Map<String, dynamic>;

  final buffer = StringBuffer();
  buffer.writeln('Keys\ten');

  jsonContent.forEach((key, value) {
    if (!key.startsWith('@')) {
      buffer.writeln('$key\t$value');
    }
  });

  final output = buffer.toString();

  print(output);
  await copyToClipboard(output);
  print('✅ TSV copied to clipboard.');
}
