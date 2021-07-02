import 'package:web3_jsonrpc/web3_jsonrpc.dart';

Future<void> main() async {
  final web3 = Web3(Uri.parse('http://127.0.0.1:8545/'));
  print(await web3.eth.getBalance(
      '0x7ffc57839b00206d1ad20c69a1981b489f772031', BlockId.latest()));
}
