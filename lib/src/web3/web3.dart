import 'package:http/http.dart';
import 'package:web3_jsonrpc/src/jsonrpc/http.dart';
import 'package:web3_jsonrpc/src/jsonrpc/models.dart';

class Web3 {
  late JRPCHttpClient jrpc;

  late Web3ETH eth;

  Web3(Uri uri, {Client? client}) {
    jrpc = JRPCHttpClient(uri, client: client);
    eth = Web3ETH(jrpc);
  }
}

class BlockId {
  final BigInt? id;

  final bool isEarliest;

  final bool isLatest;

  final bool isPending;

  BlockId(this.id)
      : isEarliest = false,
        isLatest = false,
        isPending = false;

  BlockId.earliest()
      : id = null,
        isEarliest = true,
        isLatest = false,
        isPending = false;

  BlockId.latest()
      : id = null,
        isEarliest = false,
        isLatest = true,
        isPending = false;

  BlockId.pending()
      : id = null,
        isEarliest = false,
        isLatest = false,
        isPending = true;

  factory BlockId.fromInt(int id) {
    return BlockId(BigInt.from(id));
  }

  factory BlockId.fromString(String id) {
    if (id == 'earliest') {
      return BlockId.earliest();
    } else if (id == 'latest') {
      return BlockId.latest();
    } else if (id == 'pending') {
      return BlockId.pending();
    }
    return BlockId(BigInt.parse(id));
  }

  String encodeString() {
    if (isEarliest) return 'earliest';
    if (isLatest) return 'latest';
    if (isPending) return 'pending';
    return id!.toString();
  }
}

class Web3ETH {
  final JRPCClient jrpc;

  Web3ETH(this.jrpc);

  Future<String> getBalance(String address, BlockId blockId) async {
    final params = <dynamic>[address, blockId.encodeString()];
    final resp = await jrpc.callRPC(JRPCRequest(
        id: jrpc.nextId, method: 'eth_getBalance', params: params));
    if (resp.error != null) {
      throw resp.error!;
    }
    return resp.result as String;
  }
}
