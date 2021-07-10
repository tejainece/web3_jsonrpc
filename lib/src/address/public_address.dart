import 'dart:typed_data';

import 'package:ninja/ninja.dart';
import 'package:sha3/sha3.dart';

class EtherPublicKey {
  final BigInt x;

  final BigInt y;

  EtherPublicKey(this.x, this.y);

  factory EtherPublicKey.decode(String input) {
    if (!input.startsWith('04')) {
      throw Exception('invalid format');
    }
    if (input.length != 130) {
      throw ArgumentError.value(
          input, 'input', 'invalid public key string: incorrect length');
    }
    final xStr = input.substring(2 * 1, 2 * 33);
    final yStr = input.substring(2 * 33);
    final x = BigInt.parse(xStr, radix: 16);
    final y = BigInt.parse(yStr, radix: 16);
    return EtherPublicKey(x, y);
  }

  Uint8List encodeIntoBytes() {
    final pointLen = 32;
    final xBytes = bigIntToBytes(x, outLen: pointLen);

    final yBytes = bigIntToBytes(y, outLen: pointLen);
    final bytes = Uint8List(64);
    bytes.setRange(0, 32, xBytes);
    bytes.setRange(32, 64, yBytes);
    return bytes;
  }

  String get address {
    final encoded = encodeIntoBytes();
    final digest = (SHA3(256, KECCAK_PADDING, 256)
          ..update(encoded)
          ..finalize())
        .digest();
    return '0x' +
        digest.skip(12).map((e) => e.toRadixString(16).padLeft(2, '0')).join();
  }
}
