import 'dart:math';

final _random = Random.secure();

String uuidV7() {
  // 1. Timestamp in milliseconds since Unix epoch (48 bits)
  final timestamp = DateTime.now().millisecondsSinceEpoch;

  // 2. Convert timestamp to 48-bit hex
  final tsHex = timestamp.toRadixString(16).padLeft(12, '0');

  // 3. Random data for the remaining bits
  final randA = _random.nextInt(1 << 16); // 16 bits
  final randB = _random.nextInt(1 << 32); // 32 bits
  final randC = _random.nextInt(1 << 12); // 12 bits

  // 4. Build UUIDv7 (layout theo RFC 9562)
  final version = '7'; // version 7
  final variant = (0x8 | _random.nextInt(4)).toRadixString(16); // RFC4122 variant (10xx)

  // 5. Format UUID 8-4-4-4-12
  return '${tsHex.substring(0, 8)}-'
      '${tsHex.substring(8, 12)}-'
      '$version${randA.toRadixString(16).padLeft(3, '0')}-'
      '$variant${randB.toRadixString(16).padLeft(3, "0")}-'
      '${randC.toRadixString(16).padLeft(12, "0")}';
}
