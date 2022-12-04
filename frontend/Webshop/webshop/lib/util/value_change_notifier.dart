import 'package:flutter/foundation.dart';

class ValueChangeNotifier<T> extends ChangeNotifier
    implements ValueListenable<T> {
  ValueChangeNotifier(this._value);

  T _value;

  @override
  T get value => _value;

  void setValue(T newValue, [bool notify = true]) {
    if (_value != newValue) {
      _value = newValue;
      if (notify) {
        notifyListeners();
      }
    }
  }

  @override
  String toString() => '${describeIdentity(this)}($value)';
}
