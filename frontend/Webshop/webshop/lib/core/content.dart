import 'package:flutter/material.dart';

import '../util/value_change_notifier.dart';

class Content<T> {
  final ValueChangeNotifier<T?> _notifier;

  Content([T? initialValue])
      : _notifier = ValueChangeNotifier<T?>(initialValue);

  Listenable get notifier => _notifier;
  T? get value => _notifier.value;
  set value(T? v) => _notifier.setValue(v);

  void changeValue(T? v, {bool notify = true}) {
    _notifier.setValue(v, notify);
  }

  void addListener(void Function() listener) {
    _notifier.addListener(listener);
  }

  void removeListener(void Function() listener) {
    _notifier.removeListener(listener);
  }
}
