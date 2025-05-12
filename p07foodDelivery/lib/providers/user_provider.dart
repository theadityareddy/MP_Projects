import 'package:flutter/foundation.dart';

class UserProvider with ChangeNotifier {
  String? _profileImageUrl;
  String? _name;
  String? _email;
  String? _phoneNumber;
  List<String> _addresses = [];
  List<String> _paymentMethods = [];
  bool _isLoggedIn = false;

  String? get profileImageUrl => _profileImageUrl;
  String? get name => _name;
  String? get email => _email;
  String? get phoneNumber => _phoneNumber;
  List<String> get addresses => _addresses;
  List<String> get paymentMethods => _paymentMethods;
  bool get isLoggedIn => _isLoggedIn;

  Future<void> signIn({
    required String email,
    required String password,
  }) async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));
    
    // For demo purposes, we'll just set some default values
    _isLoggedIn = true;
    _email = email;
    _name = 'Demo User';
    _phoneNumber = '+1234567890';
    _profileImageUrl = 'https://via.placeholder.com/150';
    _addresses = ['123 Main St, City, Country'];
    _paymentMethods = ['Credit Card'];
    
    notifyListeners();
  }

  Future<void> updateProfile({
    String? name,
    String? phoneNumber,
    String? profileImageUrl,
  }) async {
    if (name != null) {
      _name = name;
    }

    if (phoneNumber != null) {
      _phoneNumber = phoneNumber;
    }

    if (profileImageUrl != null) {
      _profileImageUrl = profileImageUrl;
    }

    notifyListeners();
  }

  Future<void> addAddress(String address) async {
    _addresses.add(address);
    notifyListeners();
  }

  Future<void> addPaymentMethod(String paymentMethod) async {
    _paymentMethods.add(paymentMethod);
    notifyListeners();
  }

  Future<void> signOut() async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));
    
    _isLoggedIn = false;
    _profileImageUrl = null;
    _name = null;
    _email = null;
    _phoneNumber = null;
    _addresses = [];
    _paymentMethods = [];
    
    notifyListeners();
  }
} 