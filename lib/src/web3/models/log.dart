import 'dart:typed_data';

class PendingLog {
  /// true when the log was removed, due to a chain reorganization. false if
  /// it's a valid log.
  final bool removed;

  // 20 Bytes - address from which this log originated.
  final String address;

  // data: contains one or more 32 Bytes non-indexed arguments of the log.
  final Uint8List data;

  // topics: Array of 0 to 4 32 Bytes of indexed log arguments. (In solidity: The
  // first topic is the hash of the signature of the event (e.g. Deposit(address,bytes32,uint256)),
  // except you declared the event with the anonymous specifier.)
  final List<Uint8List> topics;

  PendingLog(
      {required this.removed,
      required this.address,
      required this.data,
      required this.topics});
}

class Log extends PendingLog {
  /// integer of the log index position in the block. null when its pending log.
  final int? logIndex;

  // integer of the transactions index position log was created from. null when its pending log.
  final int? transactionIndex;

  // 32 Bytes - hash of the transactions this log was created from. null when its pending log.
  final String? transactionHash;

  // 32 Bytes - hash of the block where this log was in. null when its pending. null when its pending log.
  final String? blockHash;

  // the block number where this log was in. null when its pending. null when its pending log.
  final BigInt? blockNumber;

  Log(
      {required bool removed,
      required String address,
      required Uint8List data,
      required List<Uint8List> topics})
      : super(removed: removed, address: address, data: data, topics: topics);
}
