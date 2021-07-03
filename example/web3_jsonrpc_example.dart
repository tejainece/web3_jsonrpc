import 'package:web3_jsonrpc/web3_jsonrpc.dart';

Future<void> main() async {
  final web3 = Web3(Uri.parse('http://127.0.0.1:8545/'));
  print(weiToEther(await web3.eth.getBalance(
      '0x00f98f97924026bb99093ffcc316ac77119f7ea1', BlockId.latest())));
  await web3.eth.getBlockByNumber(BlockId.latest());
}
