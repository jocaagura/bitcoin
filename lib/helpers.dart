class Helpers {
  /// [validateUrl] checks if the url has a correct format

  static bool validateUrl(String url) {
    if (url.isEmpty) {
      return false;
    }
    Pattern pattern = r'^https?:\/\/[\w\-]+(\.[\w\-]+)+[/#?]?.*$';
    return RegExp(pattern as String).hasMatch(url);
  }

  /// formating
  /// money format
  /// Return a double number with money format to UI
  static String returnMoneyFormat(String valor, [numberOfdecimalsDigits = 2]) {
    String moneySymbol = r"$";
    String formattedNumber = "";
    double? tmp = double.tryParse(valor);
    if (tmp == null) {
      return r'$0';
    }
    final String integer = tmp.floor().toString();
    int check = 0;
    for (int i = integer.length - 1; i >= 0; i--) {
      if (check != 0 && check % 6 == 0) {
        formattedNumber = "'" + formattedNumber;
      } else if (check != 0 && check % 3 == 0) {
        formattedNumber = "." + formattedNumber;
      }
      check++;
      formattedNumber = integer[i] + formattedNumber;
    }

    if (numberOfdecimalsDigits > 0) {
      return '$moneySymbol $formattedNumber,${tmp.toStringAsFixed(numberOfdecimalsDigits).split('.')[1]}';
    }
    return 'moneySymbol + formattedNumber';
  }
}
