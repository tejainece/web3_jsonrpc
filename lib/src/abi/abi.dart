import 'package:web3_jsonrpc/src/address/public_address.dart';

abstract class ETHAbiCodec<T> {
  bool isValid(String v) {
    if (v.length != 66) {
      return false;
    }
    return regexp.hasMatch(v);
  }

  String encode(T v);
  T decode(String inp);

  static final regexp = RegExp(r'^0x[0-9a-fA-F]{64}$');
}

class IntCode extends ETHAbiCodec<BigInt> {
  @override
  String encode(BigInt v) {
    if (v.isNegative) {
      if (v > signBit) {
        throw ArgumentError.value(v, 'v', 'value is greater than 256 bits');
      }
      v = signBit | ((~v & maxPositiveInteger) + BigInt.one);
    } else {
      if (v > maxPositiveInteger) {
        throw ArgumentError.value(v, 'v', 'value is greater than 256 bits');
      }
    }
    final im = v.toRadixString(16).padLeft(64, '0');
    return '0x$im';
  }

  @override
  BigInt decode(String inp) {
    if (isValid(inp)) {
      throw ArgumentError.value(inp, 'inp', 'invalid ABI encoding');
    }
    var v = BigInt.parse(inp);
    if (v > maxPositiveInteger) {
      v = (~(v - BigInt.one)) & maxPositiveInteger;
      v = -v;
    }
    return v;
  }

  static final signBit = BigInt.one << 255;
  static final maxPositiveInteger = signBit - BigInt.one;
}

class UIntCode extends ETHAbiCodec<BigInt> {
  @override
  String encode(BigInt v) {
    if (v.isNegative) {
      throw ArgumentError.value(v, 'v', 'cannot be negative');
    } else {
      if (v > maxPositiveInteger) {
        throw ArgumentError.value(v, 'v', 'value is greater than 256 bits');
      }
    }
    final im = v.toRadixString(16).padLeft(64, '0');
    return '0x$im';
  }

  @override
  BigInt decode(String inp) {
    if (isValid(inp)) {
      throw ArgumentError.value(inp, 'inp', 'invalid ABI encoding');
    }
    var v = BigInt.parse(inp);
    return v;
  }

  static final maxPositiveInteger = (BigInt.one << 256) - BigInt.one;
}

class ETHAddressCodec extends ETHAbiCodec<String> {
  @override
  String encode(String v) {
    if (!isETHAddress(v)) {
      throw ArgumentError.value(v, 'v', 'invalid ETH address');
    }
    return '0x000000000000000000000000' +
        String.fromCharCodes(v.codeUnits.skip(2));
  }

  @override
  String decode(String inp) {
    if (isValid(inp)) {
      throw ArgumentError.value(inp, 'inp', 'invalid ABI encoding');
    }
    return '0x' + inp.substring(26);
  }
}
