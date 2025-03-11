import 'package:aban_tether_challenge/core/theme/theme.dart';
import 'package:aban_tether_challenge/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:aban_tether_challenge/features/auth/presentation/bloc/auth_event.dart';
import 'package:aban_tether_challenge/features/auth/presentation/bloc/auth_state.dart';
import 'package:aban_tether_challenge/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) return 'Email is required';
    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
      return 'Enter a valid email';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) return 'Password is required';
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final appTheme = Theme.of(context);
    return Scaffold(
      appBar: _buildAppBar(appTheme),
      backgroundColor: appTheme.black,
      body: BlocProvider(
        create: (_) => serviceLocator<AuthBloc>(),
        child: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is GetTokenState) {
              context.go('/homePage');
            } else if (state is AuthError) {
              _showErrorDialog(context, state.message);
            }
          },
          builder: (context, state) {
            return _buildLoginForm(
              context: context,
              appTheme: appTheme,
              isLoading: state is AuthLoading,
            );
          },
        ),
      ),
    );
  }

  AppBar _buildAppBar(ThemeData appTheme) {
    return AppBar(
      title: Text(
        'Login',
        style: appTheme.medium20,
      ),
      backgroundColor: appTheme.black,
      centerTitle: true,
      elevation: 4.0,
    );
  }

  Widget _buildLoginForm({
    required BuildContext context,
    required ThemeData appTheme,
    required bool isLoading,
  }) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: _emailController,
              style: appTheme.medium16,
              decoration: InputDecoration(
                labelText: 'Email',
                labelStyle: appTheme.medium16,
                border: const OutlineInputBorder(),
              ),
              keyboardType: TextInputType.emailAddress,
              validator: _validateEmail,
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              controller: _passwordController,
              style: appTheme.medium16,
              decoration: InputDecoration(
                labelText: 'Password',
                labelStyle: appTheme.medium16,
                border: const OutlineInputBorder(),
              ),
              obscureText: true,
              validator: _validatePassword,
            ),
            const SizedBox(height: 24.0),
            isLoading
                ? CircularProgressIndicator(color: appTheme.white)
                : ElevatedButton(
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
                        BlocProvider.of<AuthBloc>(context).add(
                          LoginEvent(
                            email: _emailController.text.trim(),
                            password: _passwordController.text.trim(),
                          ),
                        );
                      }
                    },
                    child: Text(
                      'Login',
                      style: appTheme.medium16,
                    ),
                  ),
          ],
        ),
      ),
    );
  }

  void _showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Login Failed'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}
