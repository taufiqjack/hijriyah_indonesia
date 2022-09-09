class DigitsConverter {
  static const List<String> easternArabicNumerals = [
    '٠',
    '١',
    '٢',
    '٣',
    '٤',
    '٥',
    '٦',
    '٧',
    '٨',
    '٩'
  ];

  static String convertWesternNumberToEastern(int? easternNumber) {
    String englishNumber = easternNumber.toString();
    StringBuffer stringBuffer = StringBuffer();
    for (var rune in englishNumber.runes) {
      String character = String.fromCharCode(rune);
      stringBuffer.write(easternArabicNumerals[int.parse(character)]);
    }
    return stringBuffer.toString();
  }
}
