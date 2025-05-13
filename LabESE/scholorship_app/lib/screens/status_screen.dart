import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/scholarship_provider.dart';

class StatusScreen extends StatelessWidget {
  const StatusScreen({super.key});

  String _getRejectionReason(Map<String, dynamic> data) {
    double familyIncome = double.tryParse(data['familyIncome'] ?? '0') ?? 0;
    String caste = data['caste'] ?? '';

    if (caste.toLowerCase() == 'open') {
      return 'Scholarship is not available for Open category candidates.';
    }
    if (familyIncome >= 800000) {
      return 'Your family income exceeds the maximum limit of ₹8,00,000 per annum.';
    }
    if (!caste.toLowerCase().contains('sc') && 
        !caste.toLowerCase().contains('st') && 
        !caste.toLowerCase().contains('obc')) {
      return 'This scholarship is only available for SC/ST/OBC categories.';
    }
    return 'You do not meet the eligibility criteria for this scholarship.';
  }

  @override
  Widget build(BuildContext context) {
    // 60-30-10 color rule
    const Color primaryDark = Color(0xFF1A1A1A); // 60% - Main background
    const Color secondaryDark = Color(0xFF2D2D2D); // 30% - Secondary background
    const Color accentColor = Color(0xFF6C63FF); // 10% - Accent color

    return Scaffold(
      backgroundColor: primaryDark,
      appBar: AppBar(
        backgroundColor: secondaryDark,
        elevation: 0,
        title: const Text(
          'Application Status',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      body: Consumer<ScholarshipProvider>(
        builder: (context, provider, child) {
          if (!provider.isProcessed) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.description_outlined,
                    size: 64,
                    color: accentColor.withOpacity(0.5),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'No Application Submitted',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Please submit an application first',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
            );
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Card(
                  elevation: 8,
                  color: secondaryDark,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: provider.isEligible
                                ? const Color(0xFF4CAF50).withOpacity(0.1)
                                : const Color(0xFFE53935).withOpacity(0.1),
                            borderRadius: BorderRadius.circular(100),
                          ),
                          child: Icon(
                            provider.isEligible
                                ? Icons.check_circle_outline_rounded
                                : Icons.cancel_outlined,
                            size: 48,
                            color: provider.isEligible
                                ? const Color(0xFF4CAF50)
                                : const Color(0xFFE53935),
                          ),
                        ),
                        const SizedBox(height: 24),
                        Text(
                          provider.isEligible
                              ? 'Application Approved!'
                              : 'Application Not Eligible',
                          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                                color: provider.isEligible
                                    ? const Color(0xFF4CAF50)
                                    : const Color(0xFFE53935),
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          provider.isEligible
                              ? 'Your scholarship amount of ₹1,50,000 will be transferred to your bank account.'
                              : _getRejectionReason(provider.applicationData),
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                color: Colors.white70,
                              ),
                        ),
                        if (!provider.isEligible) ...[
                          const SizedBox(height: 16),
                          const Divider(color: Colors.white24),
                          const SizedBox(height: 16),
                          Text(
                            'Eligibility Criteria:',
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                          ),
                          const SizedBox(height: 8),
                          _buildCriteriaItem(context, 'Family income should be below ₹8,00,000 per annum'),
                          _buildCriteriaItem(context, 'Must belong to SC/ST/OBC category'),
                          _buildCriteriaItem(context, 'Must be a resident of Maharashtra'),
                          _buildCriteriaItem(context, 'Must be enrolled in a recognized educational institution'),
                        ],
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  'Application Details',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                Card(
                  elevation: 8,
                  color: secondaryDark,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildDetailRow(context, 'Name', provider.applicationData['fullName']),
                        _buildDetailRow(context, 'Caste', provider.applicationData['caste']),
                        _buildDetailRow(context, 'Family Income', '₹${provider.applicationData['familyIncome']}'),
                        _buildDetailRow(context, 'Institution', provider.applicationData['institutionName']),
                        _buildDetailRow(context, 'Course', provider.applicationData['courseName']),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildDetailRow(BuildContext context, String label, String? value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              label,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Colors.white70,
                  ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              value ?? 'N/A',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCriteriaItem(BuildContext context, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.circle,
            size: 8,
            color: const Color(0xFF6C63FF),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.white70,
                  ),
            ),
          ),
        ],
      ),
    );
  }
} 