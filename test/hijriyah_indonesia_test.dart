import 'package:flutter/foundation.dart';
import 'package:hijriyah_indonesia/hijriyah_indonesia.dart';

void main() {
  // Hijriyah.setLocal('id');
  // Hijriyah.setLocal('jv'); //for javanese language
  // Hijriyah.setLocal('ace'); //for acehnesse language
  // Hijriyah.setLocal('pi'); //for pariamanesse language
  Hijriyah.setLocal('jv');

  debugPrint(Hijriyah.fromDate(
    DateTime.parse('2026-10-10'),
  ).toFormat("EE, dd MMMM yyyy").toString());

  // debugPrint(Hijriyah.fromDate(DateTime.parse('2025-06-16'), isPasaran: true)
  //     .fullDate()); //for javanese language

  debugPrint(Hijriyah.fromDate(DateTime.parse('2026-10-10'), isPasaran: true)
      .fullDate());
}
