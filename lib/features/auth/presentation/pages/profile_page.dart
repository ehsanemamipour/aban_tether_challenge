import 'package:aban_tether_challenge/core/theme/theme.dart';
import 'package:aban_tether_challenge/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:aban_tether_challenge/features/auth/presentation/bloc/auth_event.dart';
import 'package:aban_tether_challenge/features/auth/presentation/bloc/auth_state.dart';
import 'package:aban_tether_challenge/features/auth/presentation/widgets/profile_form.dart';
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
    // Fetch user info when the widget is inserted in the widget tree.
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
        title: Text('Profile', style: appTheme.bold24),
        backgroundColor: appTheme.black,
        centerTitle: true,
        iconTheme: IconThemeData(color: appTheme.white),
      ),
      backgroundColor: appTheme.black,
      body: BlocConsumer<AuthBloc, AuthState>(
        listenWhen: (previous, current) => current is GetUserState || current is AuthError,
        listener: (context, state) {
          if (state is GetUserState) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Profile updated successfully!')),
            );
          } else if (state is AuthError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        buildWhen: (previous, current) =>
            current is AuthLoading || current is GetUserState || current is AuthError,
        builder: (context, state) {
          if (state is AuthLoading) {
            return Center(
              child: CircularProgressIndicator(
                color: appTheme.white,
              ),
            );
          } else if (state is GetUserState) {
            if (!_isPhoneInitialized) {
              _phoneController.text = state.user.phoneNumber ?? '';
              _isPhoneInitialized = true;
            }
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: ProfileForm(
                formKey: _formKey,
                phoneController: _phoneController,
                user: state.user,
                appTheme: appTheme,
                validatePhone: _validatePhone,
                onSave: () {
                  if (_formKey.currentState!.validate()) {
                    context.read<AuthBloc>().add(
                          AddUserPhoneEvent(
                            phone: _phoneController.text.trim(),
                          ),
                        );
                  }
                },
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
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
