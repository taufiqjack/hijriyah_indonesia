import 'package:flutter/foundation.dart';
import 'package:hijriyah_indonesia/hijriyah_indonesia.dart';

String locale = 'ar';

void main() {
  HijriyahIndonesia today = HijriyahIndonesia.now();
  HijriyahIndonesia.setLocal(locale);
  if (kDebugMode) {
    print(today.hYear);
  } // 1441
  if (kDebugMode) {
    print(today.hMonth);
  } // 11
  if (kDebugMode) {
    print(today.hDay);
  } // 28
  if (kDebugMode) {
    print(today.getDayName());
  }
  // Get month length in days
  if (kDebugMode) {
    print(today.lengthOfMonth);
  } // 30 days
  if (kDebugMode) {
    print(today.toFormat("MMMM dd yyyy"));
  } // Ramadan 14  1444
  if (kDebugMode) {
    print(
        " 10 months from now ${HijriyahIndonesia.addMonth(1440, 12).fullDate()}");
  } //Ramadan 14 1439

  //From Gregorian to Ummalqura
  var hDate = HijriyahIndonesia.fromDate(DateTime(2018, 11, 12));

  if (kDebugMode) {
    print(hDate.fullDate());
  } //04/03/1440H
  if (kDebugMode) {
    print(hDate.getShortMonthName());
  } //Rab1
  if (kDebugMode) {
    print(hDate.getLongMonthName());
  } //Rabi' al-awwal
  if (kDebugMode) {
    print(hDate.lengthOfMonth);
  } // 29 days

  // check date is valid
  var checkDate = HijriyahIndonesia()
    ..hYear = 1430
    ..hMonth = 09
    ..hDay = 8;
  if (kDebugMode) {
    print(checkDate.isValid());
  } // false -> This month is only 29 days
  if (kDebugMode) {
    print(checkDate.fullDate());
  } // false -> This month is only 29 days

  //From Ummalqura to Gregorian
  var gDate = HijriyahIndonesia();
  if (kDebugMode) {
    print(gDate.hijriToGregorian(1440, 4, 19).toString());
  } //1994-12-29 00:00:00.000

  //Format
  var _format = HijriyahIndonesia.now();

  if (kDebugMode) {
    print(_format.fullDate());
  } //Thulatha, Ramadan 14, 1439 h
  if (kDebugMode) {
    print(_format.toFormat("mm dd yy"));
  } //09 14 39
  if (kDebugMode) {
    print(_format.toFormat("-- DD, MM dd --"));
  } //09 14 39

  //Compare
  //Suppose current hijri data is: Thulatha, Ramadan 14, 1439 h
  if (kDebugMode) {
    print(today.isAfter(1440, 11, 12));
  } // false
  if (kDebugMode) {
    print(today.isBefore(1440, 11, 12));
  } // true
  if (kDebugMode) {
    print(today.isAtSameMomentAs(1440, 11, 12));
  } // false

  //Adjustment
  var defCal = HijriyahIndonesia.fromDate(DateTime(2020, 8, 20));
  if (kDebugMode) {
    print("default ${defCal.fullDate()}");
  }
  var adjCal = HijriyahIndonesia();
  var adj = <int, int>{};
  adj[17292] = 59083; // 30 days instead of 29
  adjCal.setAdjustments(adj);
  adjCal.gregorianToHijri(2020, 8, 20);
  if (kDebugMode) {
    print("adjusted ${adjCal.fullDate()}");
  }
}
