library hijri;

import 'package:hijriyah_indonesia/digits_converter.dart';
import 'package:hijriyah_indonesia/exstensions/word_extention.dart';
import 'hijriyah_array.dart';

class Hijriyah {
  static String language = 'en';
  bool? pasaran;
  bool? jv;
  late int lengthOfMonth;
  DateTime startKHGT = DateTime(2024, 7, 7);
  int hDay = 1;
  late int hMonth;
  late int hYear;
  int? wkDay;
  int jPasaran = 0;
  late String longMonthName;
  late String shortMonthName;
  late String dayWeName;
  late String pasaranName;
  late bool javanese;
  Map<int, int>? adjustments;

  static final Map<String, Map<String, Map<int, String>>> _local = {
    'en': {
      'long': monthNames,
      'short': monthShortNames,
      'days': wdNames,
      'short_days': shortWdNames,
      'pasaran': pasaranNames
    },
    'id': {
      'long': idMonthNames,
      'short': idMonthShortNames,
      'days': idWdNames,
      'short_days': idShortWdNames,
      'pasaran': pasaranNames
    },
    'jv': {
      'long': javaMonthNames,
      'short': javaMonthShortNames,
      'days': jvWdNames,
      'short_days': jvShortWdNames,
      'pasaran': pasaranNames
    },
    'ar': {
      'long': arMonthNames,
      'short': arMonthShortNames,
      'days': arWkNames,
      'short_days': arShortWdNames
    },
    'tr': {
      'long': trMonthNames,
      'short': trMonthShortNames,
      'days': trWkNames,
      'short_days': trShortWdNames
    },
  };

  // Consider switching to the factory pattern
  factory Hijriyah.setLocal(String locale) {
    language = locale;
    return Hijriyah();
  }

  Hijriyah();

  Hijriyah.fromDate(DateTime date, {bool isPasaran = false}) {
    gregorianToHijri(date.year, date.month, date.day);
    pasaran = isPasaran;
  }

  Hijriyah.now() {
    _now();
  }

  Hijriyah.addMonth(int year, int month) {
    hYear = month % 12 == 0 ? year - 1 : year;
    hMonth = month % 12 == 0 ? 12 : month % 12;
    hDay = 1;
  }

  Hijriyah.addLocale(String locale, Map<String, Map<int, String>> names) {
    _local[locale] = names;
  }

  String _now() {
    DateTime today = DateTime.now();
    return gregorianToHijri(today.year, today.month, today.day);
  }

  int getDaysInMonth(int year, int month) {
    int i = _getNewMoonMJDNIndex(year, month);
    return _ummalquraDataIndex(i)! - _ummalquraDataIndex(i - 1)!;
  }

  int _gMod(int n, int m) {
    // generalized modulo function (n mod m) also valid for negative values of n
    return ((n % m) + m) % m;
  }

  int _getNewMoonMJDNIndex(int hy, int hm) {
    int cYears = hy - 1, totalMonths = (cYears * 12) + 1 + (hm - 1);
    return totalMonths - 16260;
  }

  int lengthOfYear({int? year = 0}) {
    int total = 0;
    if (year == 0) year = hYear;
    for (int m = 0; m <= 11; m++) {
      total += getDaysInMonth(year!, m);
    }
    return total;
  }

  DateTime hijriToGregorian(year, month, day) {
    int iy = year;
    int im = month;
    int id = day;
    int ii = iy - 1;
    int iln = (ii * 12) + 1 + (im - 1);
    int i = iln - 16260;
    int mcjdn = id + _ummalquraDataIndex(i - 1)! - 1;
    int cjdn = mcjdn + 2400000;
    return julianToGregorian(cjdn);
  }

  DateTime julianToGregorian(julianDate) {
    //source from: http://keith-wood.name/calendars.html
    int z = (julianDate + 0.5).floor();
    int a = ((z - 1867216.25) / 36524.25).floor();
    a = z + 1 + a - (a / 4).floor();
    int b = a + 1524;
    int c = ((b - 122.1) / 365.25).floor();
    int d = (365.25 * c).floor();
    int e = ((b - d) / 30.6001).floor();
    int day = b - d - (e * 30.6001).floor();
    //var wd = _gMod(julianDate + 1, 7) + 1;
    int month = e - (e > 13.5 ? 13 : 1);
    int year = c - (month > 2.5 ? 4716 : 4715);
    if (year <= 0) {
      year--;
    } // No year zero
    return DateTime(year, (month), day);
  }

  String gregorianToHijri(int pYear, int pMonth, int pDay) {
    //This code the modified version of R.H. van Gent Code, it can be found at http://www.staff.science.uu.nl/~gent0113/islam/ummalqura.htm
    // read calendar data

    int day = (pDay);
    int month =
        (pMonth); // -1; // Here we enter the Index of the month (which starts with Zero)
    int year = (pYear);

    int m = month;
    int y = year;

    // append January and February to the previous year (i.e. regard March as
    // the first month of the year in order to simplify leapday corrections)

    if (m < 3) {
      y -= 1;
      m += 12;
    }

    // determine offset between Julian and Gregorian calendar

    int a = (y / 100).floor();
    int jgc = a - (a / 4.0).floor() - 2;

    // compute Chronological Julian Day Number (CJDN)

    int cjdn = (365.25 * (y + 4716)).floor() +
        (30.6001 * (m + 1)).floor() +
        day -
        jgc -
        1524;

    a = ((cjdn - 1867216.25) / 36524.25).floor();
    jgc = a - (a / 4.0).floor() + 1;
    int b = cjdn + jgc + 1524;
    int c = ((b - 122.1) / 365.25).floor();
    int d = (365.25 * c).floor();
    month = ((b - d) / 30.6001).floor();
    day = (b - d) - (30.6001 * month).floor();

    if (month > 13) {
      c += 1;
      month -= 12;
    }

    month -= 1;
    year = c - 4716;

    // compute Modified Chronological Julian Day Number (MCJDN)

    int mcjdn = cjdn - 2400000;

    // the MCJDN's of the start of the lunations in the Umm al-Qura calendar are stored in 'islamcalendar_dat.js'
    int i;
    for (i = 0; i < ummAlquraDateArray.length; i++) {
      if (_ummalquraDataIndex(i)! > mcjdn) break;
    }

    // compute and output the Umm al-Qura calendar date

    int iln = i + 16260;
    int ii = ((iln - 1) / 12).floor();
    int iy = ii + 1;
    int im = iln - 12 * ii;
    int id = mcjdn - _ummalquraDataIndex(i - 1)! + 1;
    int ml = _ummalquraDataIndex(i)! - _ummalquraDataIndex(i - 1)!;
    lengthOfMonth = ml;
    int wd = _gMod(cjdn + 1, 7);

    wkDay = wd == 0 ? 7 : wd;
    jPasaran = _getPasaran(year, month, day);
    return hDate(iy, im, id);
  }

  String hDate(int year, int month, int day) {
    hYear = year;
    hMonth = month;
    longMonthName = _local[language]!['long']![month]!;
    dayWeName = _local[language]!['days']![wkDay]!;
    shortMonthName = _local[language]!['short']![month]!;
    hDay = day;
    if (pasaran == true) {
      pasaranName = _local[language]!['pasaran']![jPasaran]!;
    }
    return format(hYear, hMonth, hDay, "dd/mm/yyyy");
  }

  String toFormat(String format) {
    return this.format(hYear, hMonth, hDay, format).toLowerCase().toTitleCase();
  }

  bool isPasaran(bool value) {
    return pasaran = value;
  }

  bool isJavanese(bool value) {
    return javanese = value;
  }

  String format(year, month, day, format) {
    String newFormat = format;

    String dayString;
    String monthString;
    String yearString;

    if (language == 'ar') {
      dayString = DigitsConverter.convertWesternNumberToEastern(day);
      monthString = DigitsConverter.convertWesternNumberToEastern(month);
      yearString = DigitsConverter.convertWesternNumberToEastern(year);
    } else {
      dayString = day.toString();
      monthString = month.toString();
      yearString = year.toString();
    }

    if (newFormat.contains("dd")) {
      newFormat = newFormat.replaceFirst("dd", dayString);
    } else {
      if (newFormat.contains("d")) {
        newFormat = newFormat.replaceFirst("d", day.toString());
      }
    }

    //=========== Day Name =============//
    // Friday
    if (newFormat.contains("EEEE")) {
      newFormat = newFormat.replaceFirst(
          "EEEE", "${_local[language]!['days']![wkDay ?? weekDay()]}");

      // Fri
    } else if (newFormat.contains("EE")) {
      newFormat = newFormat.replaceFirst(
          "EE", "${_local[language]!['short_days']![wkDay ?? weekDay()]}");
    }

    if (newFormat.contains("PP")) {
      newFormat = newFormat.replaceFirst(
          "PP", "${_local[language]!['pasaran']![jPasaran]}");
    }

    //============== Month ========================//
    // 1
    if (newFormat.contains("mm")) {
      newFormat = newFormat.replaceFirst("mm", monthString);
    } else {
      newFormat = newFormat.replaceFirst("m", monthString);
    }

    // Muharram
    if (newFormat.contains("MMMM")) {
      newFormat =
          newFormat.replaceFirst("MMMM", _local[language]!['long']![month]!);
    } else {
      if (newFormat.contains("MM")) {
        newFormat =
            newFormat.replaceFirst("MM", _local[language]!['short']![month]!);
      }
    }

    //================= Year ========================//
    if (newFormat.contains("yyyy")) {
      newFormat = newFormat.replaceFirst("yyyy", yearString);
    } else {
      newFormat = newFormat.replaceFirst("yy", yearString.substring(2, 4));
    }
    return newFormat;
  }

  bool isBefore(int year, int month, int day) {
    return hijriToGregorian(hYear, hMonth, hDay).millisecondsSinceEpoch <
        hijriToGregorian(year, month, day).millisecondsSinceEpoch;
  }

  bool isAfter(int year, int month, int day) {
    return hijriToGregorian(hYear, hMonth, hDay).millisecondsSinceEpoch >
        hijriToGregorian(year, month, day).millisecondsSinceEpoch;
  }

  bool isAtSameMomentAs(int year, int month, int day) {
    return hijriToGregorian(hYear, hMonth, hDay).millisecondsSinceEpoch ==
        hijriToGregorian(year, month, day).millisecondsSinceEpoch;
  }

  void setAdjustments(Map<int, int> adj) {
    adjustments = adj;
  }

  int? _ummalquraDataIndex(int index) {
    if (index < 0 || index >= ummAlquraDateArray.length) {
      throw ArgumentError(
          "Valid date should be between 1356 AH (14 March 1937 CE) to 1500 AH (16 November 2077 CE)");
    }

    if (adjustments != null && adjustments!.containsKey(index + 16260)) {
      return adjustments![index + 16260];
    }

    return ummAlquraDateArray[index];
  }

  int weekDay() {
    DateTime wkDay = hijriToGregorian(hYear, hMonth, hDay);
    return wkDay.weekday;
  }

  @override
  String toString() {
    String dateFormat = "dd/mm/yyyy";
    if (language == "ar") dateFormat = "yyyy/mm/dd";

    return format(hYear, hMonth, hDay, dateFormat);
  }

  List<int?> toList() => [hYear, hMonth, hDay];

  String fullDate() {
    if (pasaran == true) {
      return format(hYear, hMonth, hDay, "EEEE PP, dd MMMM yyyy").toTitleCase();
    } else {
      return format(hYear, hMonth, hDay, "EEEE, MMMM dd, yyyy").toTitleCase();
    }
  }

  bool isValid() {
    if (validateHijri(hYear, hMonth, hDay)) {
      if (hDay <= getDaysInMonth(hYear, hMonth)) {
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }

  bool validateHijri(int year, int month, int day) {
    if (month < 1 || month > 12) return false;

    if (day < 1 || day > 30) return false;
    return true;
  }

  String getLongMonthName() {
    return _local[language]!['long']![hMonth]!;
  }

  String getShortMonthName() {
    return _local[language]!['short']![hMonth]!;
  }

  String getDayName() {
    return _local[language]!['days']![wkDay]!;
  }

  // to get all month names in long format
  Map<int, String> getMonths() {
    return _local[language]!['long']!;
  }

  // to get specific month days on map of date and day name
  Map<int, String> getMonthDays(int month, int year) {
    Map<int, String> calender = {};
    int d = hijriToGregorian(year, month, 1).weekday;
    int daysInMonth = getDaysInMonth(year, month);
    for (int i = 1; i <= daysInMonth; i++) {
      calender.putIfAbsent(i, () => _local[language]!['days']![d]!);
      d = d < 7 ? d + 1 : 1;
    }
    return calender;
  }

  int _getPasaran(int year, int month, int day) {
    //offset pasaran dari tanggal 7,7,2024 adalah kliwon
    //bandingkan tanggal hari ini dengan base startKHGT
    int diff = DateTime(year, month, day).difference(startKHGT).inDays;
    int pasaran = _gMod(diff, 5) == 0 ? 5 : _gMod(diff, 5);

    return pasaran;
  }
}
