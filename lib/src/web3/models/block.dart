import 'dart:typed_data';

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

class Block<T> {
  /// The block number. null if a pending block.
  final BigInt? number;

  /// Hash of the block. null if a pending block. 32 bytes long.
  final BigInt? hash;

  /// Hash of the parent block. 32 bytes long.
  final BigInt parentHash;

  /// Hash of the generated proof-of-work. null if a pending block. 8 bytes long.
  final BigInt? nonce;

  /// SHA3 of the uncles data in the block. 32 Bytes long.
  final Uint8List sha3Uncles;

  /// The bloom filter for the logs of the block. null if a pending block. 256 Bytes.
  final Uint8List? logsBloom;

  /// The root of the transaction trie of the block. 32 Bytes long.
  final String transactionsRoot;

  /// The root of the final state trie of the block. 32 bytes
  final BigInt stateRoot;

  /// The address of the beneficiary to whom the mining rewards were given.
  final String miner;

  /// Integer of the difficulty for this block.
  final int difficulty;

  /// Integer of the total difficulty of the chain until this block.
  final int totalDifficulty;

  /// The “extra data” field of this block.
  final BigInt extraData;

  /// Integer the size of this block in bytes.
  final int size;

  /// The maximum gas allowed in this block.
  final BigInt gasLimit;

  /// The total used gas by all transactions in this block.
  final BigInt gasUsed;

  /// The unix timestamp for when the block was collated.
  final DateTime timestamp;

  /// Array of transaction objects, or 32 Bytes transaction hashes depending on
  /// the returnTransactionObjects parameter.
  final List<T> transactions;

  /// Array of uncle hashes.
  final List uncles;

  Block({
    this.number,
    this.hash,
    required this.parentHash,
    this.nonce,
    required this.sha3Uncles,
    this.logsBloom,
    required this.transactionsRoot,
    required this.stateRoot,
    required this.miner,
    required this.difficulty,
    required this.totalDifficulty,
    required this.extraData,
    required this.size,
    required this.gasLimit,
    required this.gasUsed,
    required this.timestamp,
    required this.transactions,
    required this.uncles,
  });

  static Block fromMap(Map<String, dynamic> map) {
    BigInt? number;
    if (map['number'] != null) {
      number = BigInt.parse(map['number']);
    }
    BigInt? hash;
    if (map['hash'] != null) {
      hash = BigInt.parse(map['hash']);
    }
    BigInt? nonce;
    if (map['nonce'] != null) {
      nonce = BigInt.parse(map['nonce']);
    }
    return Block(
      number: number,
      hash: hash,
      parentHash: BigInt.parse(map['parentHash']),
      nonce: nonce,
      sha3Uncles: map['sha3Uncles'],
      logsBloom: map['logsBloom'],
      transactionsRoot: map['transactionsRoot'],
      stateRoot: BigInt.parse(map['stateRoot']),
      miner: map['miner'],
      difficulty: int.parse(map['difficulty']),
      totalDifficulty: int.parse(map['difficulty']),
      extraData: BigInt.parse(map['extraData']),
      size: int.parse(map['size']),
      gasLimit: BigInt.parse(map['gasLimit']),
      gasUsed: BigInt.parse(map['gasUsed']),
      timestamp: DateTime.fromMillisecondsSinceEpoch(
          int.parse(map['timestamp']) * 1000),
      transactions: [], // TODO transactions,
      uncles: [], // TODO uncles
    );
  }
}
