import 'package:flutter/cupertino.dart';

class UserSelectionProvider extends ChangeNotifier {
  List<int> _selectedOptions = [];

  List<int> get selectedOptions => _selectedOptions;

  void toggleOption(int index) {
    if (_selectedOptions.contains(index)) {
      _selectedOptions.remove(index);
    } else {
      _selectedOptions.add(index);
    }
    notifyListeners(); // Notify listeners when the selection changes
  }

  bool isSelected(int index) {
    return _selectedOptions.contains(index);
  }
}
