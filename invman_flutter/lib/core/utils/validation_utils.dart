import 'package:invman_flutter/config/generated/l10n.dart';

class ValidationUtils {
  static bool isValidEmail(String email) {
    return RegExp(r'^.+@[a-zA-Z0-9]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$').hasMatch(email);
  }

  static bool isValidUrl(String url) {
    var urlPattern = r"^(?:http(s)?:\/\/)?[\w.-]+(?:\.[\w\.-]+)+[\w\-\._~:/?#[\]@!\$&'\(\)\*\+,;=.]+$";
    return RegExp(urlPattern, caseSensitive: false).hasMatch(url);
  }

  static bool isValidPassword(String password) {
    return password.length >= 8 && password.length <= 128;
  }

  static String? formValidatorEmail(String? value) {
    if (value == null || value.isEmpty) {
      return S.current.error_emailRequired;
    }
    if (!isValidEmail(value)) {
      return S.current.error_invalidEmail;
    }
    return null;
  }

  static String? formValidatorPassword(String? value) {
    if (value == null || value.isEmpty) {
      return S.current.error_passwordRequired;
    }

    if (!isValidPassword(value)) {
      return S.current.error_passwordNotStrongEnough;
    }

    return null;
  }

  static String? formValidatorNotEmpty(String? value, String label) {
    if (value == null || value.isEmpty) {
      return "$label ${S.current.core_required}";
    }

    return null;
  }

  static String? formValidatorAmount(String? value) {
    if (value == null || value.isEmpty) {
      return S.current.error_amountRequired;
    }
    double? price = double.tryParse(value);
    if (price == null) {
      return S.current.error_invalidAmount;
    }
    return null;
  }
}
