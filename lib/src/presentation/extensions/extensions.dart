import 'dart:ui';

extension ContextExt on Object {}

extension HexColor on String {
  Color toColor() {
    var hex = replaceAll('#', '');
    if (hex.length == 6) {
      hex = 'FF$hex'; // thêm alpha nếu thiếu
    }
    return Color(int.parse('0x$hex'));
  }
}
