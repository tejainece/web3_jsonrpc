import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';
import 'package:web3_jsonrpc/src/address/public_address.dart';

void main() {
  group('address', () {
    test('address1', () {
      final keyStr =
          '04345f1a86ebf24a6dbeff80f6a2a574d46efaa3ad3988de94aa68b695f09db9ddca37439f99548da0a1fe4acf4721a945a599a5d789c18a06b20349e803fdbbe3';
      final key = EtherPublicKey.decode(keyStr);
      expect(key.address, '0xd5e099c71b797516c10ed0f0d895f429c2781142');
    });
    test('address2', () {
      final keyStr =
          '04d8983063481aa301a495493f9c61e4a4121fde42b04ec59ad82fff8ac2544ed8eba3e5698084a62968b8f20147954b6d03739fb215f69e32ac9c114e75cf8b98';
      final key = EtherPublicKey.decode(keyStr);
      expect(key.address, '0x1E8614F9bCE3B6C2895e86f6b3328e56993F746E'.toLowerCase());
    });
  });
}
