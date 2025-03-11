import 'package:aban_tether_challenge/core/theme/theme.dart';
import 'package:aban_tether_challenge/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:aban_tether_challenge/features/auth/presentation/bloc/auth_event.dart';
import 'package:aban_tether_challenge/features/auth/presentation/bloc/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final TextEditingController _phoneController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isPhoneInitialized = false;

  @override
  void initState() {
    super.initState();
    context.read<AuthBloc>().add(GetUserInfoEvent());
  }

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  String? _validatePhone(String? value) {
    if (value == null || value.isEmpty) return 'Phone number is required';
    if (!RegExp(r'^(?:\+98|0)9\d{9}$').hasMatch(value)) {
      return 'Enter a valid phone number';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final appTheme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile', style: appTheme.medium20),
        backgroundColor: appTheme.black,
        centerTitle: true,
      ),
      backgroundColor: appTheme.black,
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is GetUserState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Profile updated successfully!')),
            );
          } else if (state is AuthError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        builder: (context, state) {
          if (state is AuthLoading) {
            return Center(
              child: CircularProgressIndicator(color: appTheme.white),
            );
          } else if (state is GetUserState) {
            if (!_isPhoneInitialized) {
              _phoneController.text = state.user.phoneNumber ?? '';
              _isPhoneInitialized = true;
            }
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: ListView(
                  children: [
                    TextFormField(
                      initialValue: state.user.name,
                      decoration: InputDecoration(
                        labelText: 'Name',
                        labelStyle: appTheme.medium16,
                        border: const OutlineInputBorder(),
                      ),
                      style: appTheme.medium16.copyWith(color: appTheme.white),
                      readOnly: true,
                    ),
                    const SizedBox(height: 16.0),
                    // Non-editable Email field.
                    TextFormField(
                      initialValue: state.user.email,
                      decoration: InputDecoration(
                        labelText: 'Email',
                        labelStyle: appTheme.medium16,
                        border: const OutlineInputBorder(),
                      ),
                      style: appTheme.medium16.copyWith(color: appTheme.white),
                      readOnly: true,
                    ),
                    const SizedBox(height: 16.0),
                    TextFormField(
                      controller: _phoneController,
                      decoration: InputDecoration(
                        labelText: 'Phone Number',
                        labelStyle: appTheme.medium16,
                        border: const OutlineInputBorder(),
                      ),
                      style: appTheme.medium16.copyWith(color: appTheme.white),
                      keyboardType: TextInputType.phone,
                      validator: _validatePhone,
                    ),
                    const SizedBox(height: 24.0),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: appTheme.purple,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        padding: const EdgeInsets.symmetric(
                          vertical: 15.0,
                          horizontal: 30.0,
                        ),
                      ),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          context.read<AuthBloc>().add(
                                AddUserPhoneEvent(
                                  phone: _phoneController.text.trim(),
                                ),
                              );
                        }
                      },
                      child: Text('Save', style: appTheme.medium16),
                    ),
                  ],
                ),
              ),
            );
          } else if (state is AuthError) {
            return Center(
              child: Text(
                state.message,
                style: appTheme.medium16.copyWith(color: Colors.red),
              ),
            );
          }
          return Container();
        },
      ),
    );
  }
}
