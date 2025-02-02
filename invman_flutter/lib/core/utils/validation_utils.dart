class ValidationUtils {
  static bool isValidEmail(String email) {
    return RegExp(r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$').hasMatch(email);
  }

  static bool isValidUrl(String url) {
    var urlPattern = r"^(?:http(s)?:\/\/)?[\w.-]+(?:\.[\w\.-]+)+[\w\-\._~:/?#[\]@!\$&'\(\)\*\+,;=.]+$";
    return RegExp(urlPattern, caseSensitive: false).hasMatch(url);
  }

  static bool isValidPassword(String password) {
    return password.length >= 8 && password.length <= 128;
  }

  static bool isValidPhoneNumber(String value) {
    String patttern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
    RegExp regExp = RegExp(patttern);
    if (!regExp.hasMatch(value.replaceAll("+", ""))) {
      return false;
    }

    return true;
  }

  static String? formValidatorEmail(String? value) {
    if (value == null || value.isEmpty) {
      return "Email Required";
    }
    if (!isValidEmail(value)) {
      return "Invalid Email";
    }
    return null;
  }

  static String? formValidatorPhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return "Phone Number Required";
    }
    if (!isValidPhoneNumber(value)) {
      return "Invalid Phone Number";
    }
    return null;
  }

  static String? formValidatorPassword(String? value) {
    if (value == null || value.isEmpty) {
      return "Password Required";
    }

    if (!isValidPassword(value)) {
      return "Password Not Strong Enough";
    }

    return null;
  }

  static String? formValidatorNotEmpty(String? value, String label) {
    if (value == null || value.isEmpty) {
      return "$label Required";
    }

    return null;
  }

  static String? formValidatorUrl(String? value, String label, {bool valueRequired = true}) {
    if (value == null) {
      return "$label Required";
    }

    if (valueRequired) {
      if (value.isEmpty) {
        return "$label Required";
      }

      if (!isValidUrl(value)) {
        return "Invalid URL";
      }
    } else {
      if (value.isNotEmpty) {
        if (!isValidUrl(value)) {
          return "Invalid URL";
        }
      }
    }

    return null;
  }

  static String? formValidatorPrice(String? value) {
    if (value == null || value.isEmpty) {
      return "Price Required";
    }
    double? price = double.tryParse(value);
    if (price == null) {
      return "Invalid Price";
    }
    return null;
  }

  static String? formValidatorZip(String? value) {
    if (value == null || value.isEmpty) {
      return "Price Required";
    }
    if (value.length != 4) {
      return "Invalid Zip";
    }
    int? intZip = int.tryParse(value);
    if (intZip == null) {
      return "Invalid Zip";
    }

    return null;
  }
}
