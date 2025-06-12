import 'package:flutter/foundation.dart';
import 'package:hijriyah_indonesia/hijriyah_indonesia.dart';

void main() {
  Hijriyah.setLocal('id');
  debugPrint(Hijriyah.fromDate(DateTime.parse('2024-08-23').toLocal(),
          isPasaran: false)
      .toFormat("EE, dd MMMM yyyy")
      .toString());

  debugPrint(Hijriyah.fromDate(DateTime.parse('2025-06-12'), isPasaran: true)
      .fullDate());
}
