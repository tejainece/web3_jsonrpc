import 'package:web3_jsonrpc/src/web3/models/models.dart';

class TransactionReceipt {
  /// 32 Bytes - hash of the transaction.
  final String transactionHash;

  /// integer of the transactions index position in the block.
  final int transactionIndex;

  /// 32 Bytes - hash of the block where this transaction was in.
  final String blockHash;

  /// block number where this transaction was in.
  final BigInt blockNumber;

  /// 20 Bytes - address of the sender.
  final String from;

  /// 20 Bytes - address of the receiver. Null when the transaction is a contract creation transaction.
  final String? to;

  /// the total amount of gas used when this transaction was executed in the block.
  final BigInt cumulativeGasUsed;

  /// the amount of gas used by this specific transaction alone.
  final BigInt gasUsed;

  /// 20 Bytes - the contract address created, if the transaction was a contract creation, otherwise - null.
  final String? contractAddress;

  /// Array of log objects, which this transaction generated.
  final List<Log> logs;

  /// 256 Bytes - Bloom filter for light clients to quickly retrieve related logs.
  final String logsBloom;

  TransactionReceipt(
      {required this.transactionHash,
      required this.transactionIndex,
      required this.blockHash,
      required this.blockNumber,
      required this.from,
      this.to,
      required this.cumulativeGasUsed,
      required this.gasUsed,
      this.contractAddress,
      required this.logs,
      required this.logsBloom});

  static TransactionReceipt fromMap(Map map) => TransactionReceipt(
      transactionHash: map['transactionHash'],
      transactionIndex: int.parse(map['transactionIndex']),
      blockHash: map['blockHash'],
      blockNumber: BigInt.parse(map['blockNumber']),
      from: map['from'],
      cumulativeGasUsed: BigInt.parse(map['cumulativeGasUsed']),
      gasUsed: BigInt.parse(map['gasUsed']),
      logs:
          (map['logs'] as List).cast<Map>().map((e) => Log.fromMap(e)).toList(),
      logsBloom: map['logsBloom']);
}
