import 'package:flutter/material.dart';
import 'package:storyapp/services/auth_service.dart';
import 'package:storyapp/services/token_service.dart';
import 'package:storyapp/widgets/auth_form.dart';

import 'home_screen.dart';
import 'register_screen.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = '/login';

  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;

  void _submitForm() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      try {
        final response = await AuthService.login(email, password);
        await TokenService.saveToken(response.loginResult?.token ?? '');
        if (context.mounted) {
          Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
        }
      } catch (error) {
        setState(() {
          _isLoading = false;
        });

        showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: const Text('An error occurred'),
            content: Text(error.toString()),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(ctx).pop();
                },
                child: const Text('OK'),
              )
            ],
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: AuthForm(
              formKey: _formKey,
              emailController: _emailController,
              passwordController: _passwordController,
              isLoading: _isLoading,
              submitForm: _submitForm,
              buttonLabel: 'Login',
              switchLabel: 'Don\'t have an account?',
              switchScreen: RegisterScreen.routeName,
            ),
          ),
        ),
      ),
    );
  }
}
