import 'package:web3_jsonrpc/web3_jsonrpc.dart';

Future<void> main() async {
  final web3 = Web3(Uri.parse('http://127.0.0.1:8545/'));
  var bn = BigInt.from(5046188);
  while(true) {
    final block = await web3.eth.getBlockByNumber(BlockId(bn));
    for(final tx in block.transactions!) {
      final v = weiToEther(tx.value);
      print('Tx ${block.number} ${block.timestamp} ${tx.hash} ${tx.to} $v');
      /*if(v > 2.20 && v < 2.22) {
        print('found!');
      }*/
      if(v.toString() == '2.21994') {
        print('mega found!');
      }
    }
    bn = bn + BigInt.one;
  }
}