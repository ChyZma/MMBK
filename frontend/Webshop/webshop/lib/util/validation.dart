class Rules<T> {
  final List<ValidationRule<T>> _validationRules;

  Rules(this._validationRules);

  bool isValid(T? value) {
    return _checkValue(value) == null;
  }

  /// Returns null if valid, or error string if not valid
  String? validate(T? value) {
    String? errorKey = _checkValue(value);
    return errorKey;
  }

  String? _checkValue(T? value) {
    String? error;
    for (int i = 0; i < _validationRules.length && error == null; i++) {
      String? errorKey = _validationRules[i].validate(value);
      error = errorKey;
    }
    return error;
  }
}

abstract class ValidationRule<T> {
  String? validate(T? value);
}

class NotEmptyRule implements ValidationRule<String> {
  final String key;
  NotEmptyRule({this.key = 'Nem lehet üres'});

  @override
  String? validate(String? value) {
    return value == null || value.isEmpty ? key : null;
  }
}

class RegexpRule implements ValidationRule<String> {
  final String? key;
  final RegExp? regExp;

  RegexpRule({this.key, this.regExp});

  @override
  String? validate(String? value) {
    return value != null && regExp!.hasMatch(value) ? null : key;
  }
}

class EmailRule extends RegexpRule {
  static RegExp _emailRegexp = RegExp(
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');

  EmailRule() : super(key: 'Rossz email formátum', regExp: _emailRegexp);
}

class PasswordRule extends RegexpRule {
  static RegExp _passwordRegexp = RegExp(
      r'^(?=.*[0-9])(?=.*[a-z])(?=.*[A-Z])(?=.*[\*\.!@$%^&(){}\[\]:;<>,\.\?\/~_\+\-=|]).{8,32}$');

  PasswordRule()
      : super(
            key: 'Min 1 szám, kisbetű, nagybetű, speciális karakter',
            regExp: _passwordRegexp);
}
