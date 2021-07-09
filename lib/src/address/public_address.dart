import 'dart:typed_data';

import 'package:sha3/sha3.dart';

class EtherPublicKey {
  final Uint8List key;

  EtherPublicKey(this.key);

  Uint8List encode({bool compress = false, bool withHeader = false}) {
    // TODO
  }

  String encodeString({bool compress = false, bool withHeader = false}) {
    // TODO
  }

  String get address {
    final encoded = encode();
    keccak256.update(encoded);
    // TODO
  }
}


final keccak256 = SHA3(256, KECCAK_PADDING, 256);