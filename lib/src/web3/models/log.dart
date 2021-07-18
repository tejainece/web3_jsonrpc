import 'dart:typed_data';

class PendingLog {
  /// true when the log was removed, due to a chain reorganization. false if
  /// it's a valid log.
  final bool removed;

  // 20 Bytes - address from which this log originated.
  final String address;

  // data: contains one or more 32 Bytes non-indexed arguments of the log.
  final String data;

  // topics: Array of 0 to 4 32 Bytes of indexed log arguments. (In solidity: The
  // first topic is the hash of the signature of the event (e.g. Deposit(address,bytes32,uint256)),
  // except you declared the event with the anonymous specifier.)
  final List<String> topics;

  PendingLog(
      {required this.removed,
      required this.address,
      required this.data,
      required this.topics});
}

class Log extends PendingLog {
  /// integer of the log index position in the block. null when its pending log.
  final int logIndex;

  // integer of the transactions index position log was created from. null when its pending log.
  final int transactionIndex;

  // 32 Bytes - hash of the transactions this log was created from. null when its pending log.
  final String transactionHash;

  // 32 Bytes - hash of the block where this log was in. null when its pending. null when its pending log.
  final String blockHash;

  // the block number where this log was in. null when its pending. null when its pending log.
  final BigInt blockNumber;

  Log(
      {required bool removed,
      required String address,
      required String data,
      required List<String> topics,
      required this.logIndex,
      required this.transactionIndex,
      required this.transactionHash,
      required this.blockHash,
      required this.blockNumber})
      : super(removed: removed, address: address, data: data, topics: topics);

  Map<String, dynamic> toJson() => {
        'removed': removed,
        'address': address,
        'data': data,
        'topics': topics,
        'logIndex': logIndex,
        'transactionIndex': transactionIndex,
        'transactionHash': transactionHash,
        'blockHash': blockHash,
        'blockNumber': blockNumber,
      };

  static Log fromMap(Map map) {
    return Log(
        removed: map['removed'],
        address: map['address'],
        data: map['data'],
        topics: (map['topics'] as List).cast<String>(),
        logIndex: int.parse(map['logIndex']),
        transactionIndex: int.parse(map['transactionIndex']),
        transactionHash: map['transactionHash'],
        blockHash: map['blockHash'],
        blockNumber: BigInt.parse(map['blockNumber']));
  }

  @override
  String toString() => 'Log $address $topics';
}

class LogFilter {
  final String? address;
  final String? fromBlock;
  final String? toBlock;
  final List<String>? topics;
  final String? blockHash;

  LogFilter(
      {this.address,
      this.fromBlock,
      this.toBlock,
      this.topics,
      this.blockHash});

  Map<String, dynamic> toJson() => {
        'address': address,
        'fromBlock': fromBlock,
        'toBlock': toBlock,
        'topics': topics,
        'blockHash': blockHash
      }..removeWhere((key, value) => value == null);
}
