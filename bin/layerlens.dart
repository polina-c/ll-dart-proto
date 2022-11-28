import 'dart:io';

void main(List<String> args) {
  print('generating files');
  File('LAYERS.MD').writeAsStringSync(DateTime.now().toString() + '\n');
}
