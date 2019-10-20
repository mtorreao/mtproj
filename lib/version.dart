import 'package:mtproj/utils.dart';

void version() async {
  String version = await getVersion();
  print('''

██████████╗ ███████████╗ ████████╗ ████████╗       
██║ ██║ ██║     ██╔════╝ ██╔═══██║ ██╔═══██║       
██║ ██║ ██║     ██║      ████████║ ████████║       
██║ ██║ ██║     ██║      ██╔═════╝ ██╔═██╔═╝       
██║ ██║ ██║     ██║      ██║       ██║   ██╗       
╚═╝ ╚═╝ ╚═╝     ╚═╝      ╚═╝       ╚═╝   ╚═╝       
''');
  print("CLI command tools for my personal projects");
  print("");
  print("MTProj version: $version");
}
