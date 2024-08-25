import 'package:flutter/foundation.dart';
import 'package:hijriyah_indonesia/hijriyah_indonesia.dart';

void main() {
  Hijriyah.setLocal('id');
  debugPrint(Hijriyah.fromDate(DateTime.parse('2024-08-23').toLocal())
      .toFormat("EE, dd MMMM yyyy")
      .toString());

  debugPrint(Hijriyah.fromDate(DateTime.parse('2024-08-24')).fullDate());
}
