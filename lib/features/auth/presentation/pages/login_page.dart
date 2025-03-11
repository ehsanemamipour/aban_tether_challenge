import 'package:aban_tether_challenge/core/theme/theme.dart';
import 'package:aban_tether_challenge/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:aban_tether_challenge/features/auth/presentation/bloc/auth_event.dart';
import 'package:aban_tether_challenge/features/auth/presentation/bloc/auth_state.dart';
import 'package:aban_tether_challenge/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    final formKey = GlobalKey<FormState>();

    return Scaffold(
      appBar: _buildAppBar(theme),
      backgroundColor: theme.black,
      body: BlocProvider(
        create: (_) => serviceLocator<AuthBloc>(),
        child: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is GetTokenState) {
              Navigator.pushReplacementNamed(context, '/home');
            } else if (state is AuthError) {
              _showErrorDialog(context, state.message);
            }
          },
          builder: (context, state) {
            return _buildLoginForm(
              context: context,
              theme: theme,
              emailController: emailController,
              passwordController: passwordController,
              formKey: formKey,
              isLoading: state is AuthLoading,
            );
          },
        ),
      ),
    );
  }


  AppBar _buildAppBar(ThemeData theme) {
    return AppBar(
      title: Text(
        'Login',
        style: theme.medium20,
      ),
      backgroundColor: theme.black,
      centerTitle: true,
      elevation: 4.0,
    );
  }


  Widget _buildLoginForm({
    required BuildContext context,
    required ThemeData theme,
    required TextEditingController emailController,
    required TextEditingController passwordController,
    required GlobalKey<FormState> formKey,
    required bool isLoading,
  }) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: emailController,
              style: theme.medium16,
              decoration: InputDecoration(
                labelText: 'Email',
                labelStyle: theme.medium16,
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.emailAddress,
              validator: (value) {
                if (value == null || value.isEmpty) return 'Email is required';
                if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                    .hasMatch(value)) {
                  return 'Enter a valid email';
                }
                return null;
              },
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              controller: passwordController,
              style: theme.medium16,
              decoration: InputDecoration(
                labelText: 'Password',
                labelStyle: theme.medium16,
                border: OutlineInputBorder(),
              ),
              obscureText: true,
              validator: (value) {
                if (value == null || value.isEmpty) return 'Password is required';
                return null;
              },
            ),
            const SizedBox(height: 24.0),
            isLoading
                ? CircularProgressIndicator(color: theme.white)
                : ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: theme.purple,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      padding: const EdgeInsets.symmetric(
                          vertical: 15.0, horizontal: 30.0),
                    ),
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        BlocProvider.of<AuthBloc>(context).add(
                          LoginEvent(
                            email: emailController.text.trim(),
                            password: passwordController.text.trim(),
                          ),
                        );
                      }
                    },
                    child: Text(
                      'Login',
                      style: theme.medium16,
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
      builder: (context) => AlertDialog(
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
