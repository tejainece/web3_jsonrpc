class Transaction {
  /// Hash of the transaction. 32 bytes.
  final String hash;

  /// The number of transactions made by the sender prior to this one.
  final BigInt nonce;

  /// Hash of the block where this transaction was in. null if pending.
  /// 32 bytes.
  final String? blockHash;

  /// Block number where this transaction was in. null if pending.
  final BigInt? blockNumber;

  /// Integer of the transactions index position in the block. null if pending.
  final int? transactionIndex;

  /// Address of the sender.
  final String from;

  /// Address of the receiver. null if it’s a contract creation transaction.
  final String? to;

  /// Value transferred in wei.
  final BigInt value;

  /// Gas price provided by the sender in wei.
  final BigInt gasPrice;

  /// Gas provided by the sender.
  final BigInt gas;

  /// The data sent along with the transaction.
  final String input;

  Transaction({
    required this.hash,
    required this.nonce,
    this.blockHash,
    this.blockNumber,
    this.transactionIndex,
    required this.from,
    this.to,
    required this.value,
    required this.gasPrice,
    required this.gas,
    required this.input,
  });

  @override
  String toString() => 'Tx $value $hash: $from -> $to';

  static Transaction fromMap(Map<String, dynamic> map) {
    // TODO
    return Transaction(
      hash: map['hash'],
      nonce: BigInt.parse(map['nonce']),
      blockHash: map['blockHash'],
      blockNumber: BigInt.parse(map['blockNumber']),
      transactionIndex: int.parse(map['transactionIndex']),
      from: map['from'],
      to: map['to'],
      value: BigInt.parse(map['value']),
      gasPrice: BigInt.parse(map['gasPrice']),
      gas: BigInt.parse(map['gas']),
      input: map['input'],
    );
  }
}
