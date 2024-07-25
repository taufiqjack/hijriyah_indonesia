import 'package:flutter/foundation.dart';
import 'package:hijriyah_indonesia/hijriyah_indonesia.dart';

void main() {
  debugPrint(Hijriyah.fromDate(DateTime.parse('20240725').toLocal())
      .toFormat("dd MMMM yyyy")
      .toString());
}
