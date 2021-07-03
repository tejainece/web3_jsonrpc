import 'package:http/http.dart';
import 'package:web3_jsonrpc/src/jsonrpc/http.dart';
import 'package:web3_jsonrpc/src/jsonrpc/models.dart';

import 'models/models.dart';

export 'models/models.dart';

class Web3 {
  late JRPCHttpClient jrpc;

  late Web3ETH eth;

  Web3(Uri uri, {Client? client}) {
    jrpc = JRPCHttpClient(uri, client: client);
    eth = Web3ETH(jrpc);
  }
}

class Web3ETH {
  final JRPCClient jrpc;

  Web3ETH(this.jrpc);

  Future<BigInt> getBalance(String address, BlockId blockId) async {
    final params = <dynamic>[address, blockId.encodeString()];
    final resp = await jrpc.callRPC(
        JRPCRequest(id: jrpc.nextId, method: 'eth_getBalance', params: params));
    if (resp.error != null) {
      throw resp.error!;
    }
    return BigInt.parse(resp.result as String);
  }

  Future<Block> getBlockByNumber(BlockId blockId) async {
    final params = <dynamic>[blockId.encodeString(), true];
    final resp = await jrpc.callRPC(
        JRPCRequest(id: jrpc.nextId, method: 'eth_getBlockByNumber', params: params));
    if (resp.error != null) {
      throw resp.error!;
    }
    print(resp.result);
  }
}

double weiToEther(BigInt wei) {
  return wei / oneEtherInWei;
}

final BigInt oneEtherInWei = BigInt.parse('1000000000000000000');
