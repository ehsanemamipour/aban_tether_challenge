import 'package:aban_tether_challenge/core/theme/theme.dart';
import 'package:aban_tether_challenge/features/auth/domain/entities/user.dart';
import 'package:flutter/material.dart';

class ProfileForm extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController phoneController;
  final User user; 
  final ThemeData appTheme;
  final String? Function(String?) validatePhone;
  final VoidCallback onSave;

  const ProfileForm({
    super.key,
    required this.formKey,
    required this.phoneController,
    required this.user,
    required this.appTheme,
    required this.validatePhone,
    required this.onSave,
  });

  Widget _buildReadOnlyField(String label, String? initialValue) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          initialValue: initialValue,
          decoration: InputDecoration(
            labelText: label,
            labelStyle: appTheme.medium16,
            border: const OutlineInputBorder(),
          ),
          style: appTheme.medium16,
          readOnly: true,
        ),
        const SizedBox(height: 16.0),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: ListView(
        children: [
          _buildReadOnlyField('Name', user.name),
          _buildReadOnlyField('Email', user.email),
          TextFormField(
            controller: phoneController,
            decoration: InputDecoration(
              labelText: 'Phone Number',
              labelStyle: appTheme.medium16,
              border: const OutlineInputBorder(),
            ),
            style: appTheme.medium16,
            keyboardType: TextInputType.phone,
            validator: validatePhone,
          ),
          const SizedBox(height: 24.0),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: appTheme.colorScheme.primary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              padding: const EdgeInsets.symmetric(
                vertical: 15.0,
                horizontal: 30.0,
              ),
            ),
            onPressed: onSave,
            child: Text('Save', style: appTheme.medium20),
          ),
        ],
      ),
    );
  }
}
