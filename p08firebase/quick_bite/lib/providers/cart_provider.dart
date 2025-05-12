import 'package:flutter/foundation.dart';

class CartProvider with ChangeNotifier {
  final List<Map<String, dynamic>> _cartItems = [];
  double _totalAmount = 0.0;

  List<Map<String, dynamic>> get cartItems => _cartItems;
  double get totalAmount => _totalAmount;

  void addToCart(Map<String, dynamic> item) {
    final existingItemIndex = _cartItems.indexWhere((element) => element['id'] == item['id']);
    
    if (existingItemIndex != -1) {
      _cartItems[existingItemIndex]['quantity'] = (_cartItems[existingItemIndex]['quantity'] ?? 1) + 1;
    } else {
      _cartItems.add({...item, 'quantity': 1});
    }
    
    _calculateTotal();
    notifyListeners();
  }

  void removeFromCart(String itemId) {
    _cartItems.removeWhere((item) => item['id'] == itemId);
    _calculateTotal();
    notifyListeners();
  }

  void updateQuantity(String itemId, int quantity) {
    final itemIndex = _cartItems.indexWhere((element) => element['id'] == itemId);
    if (itemIndex != -1) {
      if (quantity > 0) {
        _cartItems[itemIndex]['quantity'] = quantity;
      } else {
        _cartItems.removeAt(itemIndex);
      }
      _calculateTotal();
      notifyListeners();
    }
  }

  void clearCart() {
    _cartItems.clear();
    _totalAmount = 0.0;
    notifyListeners();
  }

  void _calculateTotal() {
    _totalAmount = _cartItems.fold(0.0, (sum, item) {
      return sum + (item['price'] * (item['quantity'] ?? 1));
    });
  }
} 