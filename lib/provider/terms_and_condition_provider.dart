import 'package:flutter/cupertino.dart';

class TermsAndConditionsProvider extends ChangeNotifier {
  bool _agreeTerms = false;
  bool _agreePrivacy = false;

  bool get agreeTerms => _agreeTerms;

  bool get agreePrivacy => _agreePrivacy;

  void toggleAgreeTerms(bool value) {
    _agreeTerms = value;
    notifyListeners();
  }

  void toggleAgreePrivacy(bool value) {
    _agreePrivacy = value;
    notifyListeners();
  }

  void selectAll(bool value) {
    _agreeTerms = value;
    _agreePrivacy = value;
    notifyListeners();
  }

  bool get areBothAgreed => _agreeTerms && _agreePrivacy;
}
