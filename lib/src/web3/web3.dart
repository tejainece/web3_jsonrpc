import 'dart:convert';

import 'package:http/http.dart';
import 'package:web3_jsonrpc/src/jsonrpc/http.dart';
import 'package:web3_jsonrpc/src/jsonrpc/models.dart';
import 'package:web3_jsonrpc/src/web3/models/transaction.dart';
import 'package:web3_jsonrpc/src/web3/models/transaction_receipt.dart';

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

  Future<BigInt> getBlockNumber() async {
    final resp = await jrpc
        .callRPC(JRPCRequest(id: jrpc.nextId, method: 'eth_blockNumber'));
    if (resp.error != null) {
      throw resp.error!;
    }
    return BigInt.parse(resp.result as String);
  }

  Future<Block> getBlockByHash(String blockHash) async {
    final params = <dynamic>[blockHash, true];
    final resp = await jrpc.callRPC(JRPCRequest(
        id: jrpc.nextId, method: 'eth_getBlockByHash', params: params));
    if (resp.error != null) {
      throw resp.error!;
    }
    return Block.fromMap(resp.result as Map<String, dynamic>);
  }

  Future<Block> getBlockByNumber(BlockId blockId) async {
    final params = <dynamic>[blockId.encodeString(), true];
    final resp = await jrpc.callRPC(JRPCRequest(
        id: jrpc.nextId, method: 'eth_getBlockByNumber', params: params));
    if (resp.error != null) {
      throw resp.error!;
    }
    return Block.fromMap(resp.result as Map<String, dynamic>);
  }

  Future<Transaction> getTransactionByHash(String txHash) async {
    final params = <dynamic>[txHash];
    final resp = await jrpc.callRPC(JRPCRequest(
        id: jrpc.nextId, method: 'eth_getTransactionByHash', params: params));
    if (resp.error != null) {
      throw resp.error!;
    }
    return Transaction.fromMap(resp.result as Map<String, dynamic>);
  }

  Future<List<Log>> getLogs(LogFilter filter) async {
    final params = <dynamic>[filter.toJson()];
    final resp = await jrpc.callRPC(
        JRPCRequest(id: jrpc.nextId, method: 'eth_getLogs', params: params));
    if (resp.error != null) {
      throw resp.error!;
    }
    return (resp.result as List)
        .cast<Map>()
        .map((e) => Log.fromMap(e))
        .toList();
  }

  Future<TransactionReceipt> getTransactionReceipt(String txhash) async {
    final params = <dynamic>[txhash];
    final resp = await jrpc.callRPC(JRPCRequest(
        id: jrpc.nextId, method: 'eth_getTransactionReceipt', params: params));
    if (resp.error != null) {
      throw resp.error!;
    }
    return TransactionReceipt.fromMap(resp.result as Map<String, dynamic>);
  }
}

double weiToEther(BigInt wei) {
  return wei / oneEtherInWei;
}

final BigInt oneEtherInWei = BigInt.parse('1000000000000000000');
