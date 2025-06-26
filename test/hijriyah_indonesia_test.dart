import 'package:flutter/foundation.dart';
import 'package:hijriyah_indonesia/hijriyah_indonesia.dart';

void main() {
  Hijriyah.setLocal('id');
  // Hijriyah.setLocal('jv'); //for javanese language
  debugPrint(Hijriyah.fromDate(
    DateTime.parse('2024-08-23'),
  ).toFormat("EE, dd MMMM yyyy").toString());

  debugPrint(Hijriyah.fromDate(DateTime.parse('2025-06-16'), isPasaran: true)
      .fullDate());
}
