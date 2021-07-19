import 'package:web3_jsonrpc/web3_jsonrpc.dart';

Future<void> main() async {
  final web3 = Web3(Uri.parse('http://127.0.0.1:8545/'));
  final logs = await web3.eth.getLogs(LogFilter(
      blockHash:
          '0xce48cd7522470cc75ff655b20647d572b35018dd12414ac81903b6fb84443173'));
  print(logs);
  print(logs.last.toJson());
}
