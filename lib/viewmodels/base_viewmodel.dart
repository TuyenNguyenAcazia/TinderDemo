import 'package:flutter/material.dart';

class BaseViewModel extends ChangeNotifier {
  bool _busy = false;

  bool _hasError = false;

  bool get busy => _busy;

  void setBusy(bool value) {
    _busy = value;
    notifyListeners();
  }

  bool get error => _hasError;

  void setError(bool value) {
    setBusy(false);
    _hasError = value;
    notifyListeners();
  }
}
