[![Stand With Palestine](https://raw.githubusercontent.com/TheBSD/StandWithPalestine/main/banner-no-action.svg)](https://thebsd.github.io/StandWithPalestine)

# Hijriyah Indonesia


#### Usage
```dart
//Short Date
debugPrint(Hijriyah.fromDate(DateTime.parse('2025-05-12').toLocal(),
          isPasaran: false)
      .toFormat("EE, dd MMMM yyyy")
      .toString());   // Kam, 16 Zulh 1446

//Full Date
Hijriyah.fromDate(DateTime.parse('2025-06-12'), isPasaran: true)
      .fullDate(); // Kamis Kliwon, 16 Zulhijah 1446
```

##### Usage convert
```dart
  Hijriyah.fromDate(DateTime.parse(dateTime.toString()).toLocal()).toFormat("EEEE, dd MMMM yyyy"); // Jumat, 19 Safar 1446
  Hijriyah.fromDate(DateTime.parse(dateTime.toString()).toLocal()).toFormat("EE, dd MMMM yyyy") // Jum, 19 Safar 1446
```


