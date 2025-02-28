[![Stand With Palestine](https://raw.githubusercontent.com/TheBSD/StandWithPalestine/main/banner-no-action.svg)](https://thebsd.github.io/StandWithPalestine)

# Hijriyah Indonesia

Hijriyah Calendar Converter


#### Usage
```dart
//Suppose current gregorian data/time is: Fri September 9 00:27:33  2022
  var _today = Hijriyah.now();
  print(_today.hYear); // 1444
  print(_today.hMonth); // 2
  print(_today.hDay); // 14
  print(_today.getDayName()); // 14
  // Get month length in days
  print(_today.lengthOfMonth); // 30 days
  print(_today.toFormat("MMMM dd yyyy")); //Shafar 14 1444
```
 ##### Change Local
```dart
  String locale = 'id';
  Hijriyah.setLocal(locale);
```

##### Usage convert
```dart
  Hijriyah.fromDate(DateTime.parse(dateTime.toString()).toLocal()).toFormat("EEEE, dd MMMM yyyy"); // Jumat, 19 Safar 1446
  Hijriyah.fromDate(DateTime.parse(dateTime.toString()).toLocal()).toFormat("EE, dd MMMM yyyy") // Jum, 19 Safar 1446
```

 ##### Add New Locale
```dart
  Hijriyah.addLocale(locale, {
    'long': ...,
    'short': ...,
    'days': ...,
    'short_days': ...
  });
  Hijriyah.setLocal(locale);
```
  ##### From Gregorian to Ummalqura
  ```dart
  var h_date = Hijriyah.fromDate(DateTime(2018, 11, 12));
  print(h_date.toString()); //04/03/1444H
  print(h_date.getShortMonthName()); //Rab
  print(h_date.getLongMonthName()); //Rabiul Awwal
  print(h_date.lengthOfMonth); // 29 days
```
##### Check if date is valid
```dart
  //
  var _check_date = Hijriyah();
  _check_date.hYear = 1439;
  _check_date.hMonth = 11;
  _check_date.hDay = 30;
  print(_check_date.isValid()); // false -> This month is only 29 days
```
##### From Ummalqura to Gregorian
```dart
  //From Ummalqura to Gregorian
  var g_date = Hijriyah();
  print(g_date.hijriToGregorian(1444, 7, 27)); //2022-09-9 00:00:00.000
```
  ##### Format
```dart
  var _format = Hijriyah.now();
  print(_format.fullDate()); //Selasa, 14 Shaffar , 1444 h
  print(_format.toFormat("mm dd yy")); //09 14 39
```
  ##### Compare

```dart
  //Suppose current hijri data is: TSelasa, 14 Shaffar , 1444 h
  print(_today.isAfter(1440, 11, 12)); // false
  print(_today.isBefore(1440, 11, 12)); // true
  print(_today.isAtSameMomentAs(1440, 11, 12)); // false

  ```

