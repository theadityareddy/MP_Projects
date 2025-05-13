import 'package:flutter/foundation.dart';

class ScholarshipProvider with ChangeNotifier {
  bool _isEligible = false;
  bool _isProcessed = false;
  Map<String, dynamic> _applicationData = {};

  bool get isEligible => _isEligible;
  bool get isProcessed => _isProcessed;
  Map<String, dynamic> get applicationData => _applicationData;

  void submitApplication(Map<String, dynamic> data) {
    _applicationData = data;
    
    // Check eligibility based on income and caste
    double familyIncome = double.tryParse(data['familyIncome'] ?? '0') ?? 0;
    String caste = data['caste'] ?? '';
    
    // Eligibility criteria: Income below 8 lakhs and belongs to reserved category
    _isEligible = familyIncome < 800000 && 
                 (caste.toLowerCase() != 'open') &&
                 (caste.toLowerCase().contains('sc') || 
                  caste.toLowerCase().contains('st') || 
                  caste.toLowerCase().contains('obc'));
    
    _isProcessed = true;
    notifyListeners();
  }

  void resetApplication() {
    _isEligible = false;
    _isProcessed = false;
    _applicationData = {};
    notifyListeners();
  }
} 