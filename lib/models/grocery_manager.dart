import 'package:flutter/material.dart';

import 'grocery_item.dart';

class GroceryManager extends ChangeNotifier {
  // 1
  final _groceryItems = <GroceryItem>[];
  int _selectedIndex = -1;
  bool _createNewItem = false;

  // 2
  List<GroceryItem> get groceryItems => List.unmodifiable(_groceryItems);
  int get selectedIndex => _selectedIndex;
  GroceryItem? get selectedGroceryItem =>
      _selectedIndex != -1 ? _groceryItems[_selectedIndex] : null;
  bool get isCreatingNewItem => _createNewItem;

  void createNewItem() {
    _createNewItem = true;
    notifyListeners();
  }

  // 3
  void deleteItem(int index) {
    _groceryItems.removeAt(index);
    notifyListeners();
  }

  // 4
  void addItem(GroceryItem item) {
    _groceryItems.add(item);
    _createNewItem = false;
    notifyListeners();
  }

  // 5
  void updateItem(GroceryItem item, int index) {
    _groceryItems[index] = item;
    _createNewItem = false;
    _selectedIndex = -1;
    notifyListeners();
  }

  // 6
  void completeItem(int index, bool change) {
    final item = _groceryItems[index];
    _groceryItems[index] = item.copyWith(isComplete: change);
    notifyListeners();
  }

  void groceryItemTapped(int index) {
    _selectedIndex = index;
    _createNewItem = false;
    notifyListeners();
  }
}
