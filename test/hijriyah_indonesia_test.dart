import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:hijriyah_indonesia/hijriyah_indonesia.dart';

void main() {
  test('adds one to input values', () {
    var today = DateTime.now();
    if (kDebugMode) {
      print(Hijriyah.fromDate(today).toFormat("dd MMMM yyyy"));
    }
  });
}
