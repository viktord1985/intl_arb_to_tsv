import 'dart:convert';
import 'dart:io';

Future<void> copyToClipboard(String text) async {
  late Process process;

  if (Platform.isMacOS) {
    process = await Process.start('pbcopy', []);
  } else if (Platform.isLinux) {
    process = await Process.start('xclip', ['-selection', 'clipboard']);
  } else if (Platform.isWindows) {
    process = await Process.start('cmd', ['/c', 'clip']);
  } else {
    print('⚠️ Clipboard not supported on this platform');
    return;
  }

  process.stdin.write(text);
  await process.stdin.close();
  await process.exitCode;
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
