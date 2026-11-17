[![Stand With Palestine](https://raw.githubusercontent.com/TheBSD/StandWithPalestine/main/banner-no-action.svg)](https://thebsd.github.io/StandWithPalestine)

# Hijriyah Indonesia


#### Usage
```dart
//Short Date
Hijriyah.fromDate(DateTime.parse('2026-10-10').toLocal(),
          isPasaran: false)
      .toFormat("EE, dd MMMM yyyy")
      .toString();   // Kam, 16 Zulh 1446


// acehnese format
Hijriyah.setLocal('ace');
Hijriyah.fromDate(DateTime.parse('2026-10-10').toLocal()).toFormat("EE, dd MMMM yyyy").toString(); //Sat, 29 Moelot Teungoh 1448

// pariamanese format
Hijriyah.setLocal('pi');
Hijriyah.fromDate(DateTime.parse('2026-10-10').toLocal()).toFormat("EE, dd MMMM yyyy").toString(); //Sat, 29 Adiak Muluik 1448


//Full Date Javanesse
Hijriyah.setLocal('jv');
Hijriyah.fromDate(DateTime.parse('2026-10-10'), isPasaran: true)
      .fullDate(); //Setu Kliwon, 29 Bakda Mulud 1448
```

##### Usage convert
```dart
  Hijriyah.fromDate(DateTime.parse(dateTime.toString()).toLocal()).toFormat("EEEE, dd MMMM yyyy"); // Jumat, 19 Safar 1446
  Hijriyah.fromDate(DateTime.parse(dateTime.toString()).toLocal()).toFormat("EE, dd MMMM yyyy") // Jum, 19 Safar 1446
```


