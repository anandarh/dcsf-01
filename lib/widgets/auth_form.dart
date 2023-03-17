import 'package:flutter/material.dart';
import 'package:storyapp/widgets/loading_spinner.dart';

class AuthForm extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController? nameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final bool isLoading;
  final void Function() submitForm;
  final String buttonLabel;
  final String switchLabel;
  final String switchScreen;

  const AuthForm({
    super.key,
    required this.formKey,
    this.nameController,
    required this.emailController,
    required this.passwordController,
    required this.isLoading,
    required this.submitForm,
    required this.buttonLabel,
    required this.switchLabel,
    required this.switchScreen,
  });

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  bool _obscureText = true;

  void _toggleObscureText() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Column(
        children: [
          if (widget.nameController != null)
            TextFormField(
              controller: widget.nameController,
              decoration: const InputDecoration(labelText: 'Name'),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter your name';
                }
                return null;
              },
            ),
          TextFormField(
            controller: widget.emailController,
            decoration: const InputDecoration(labelText: 'Email'),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter your email';
              } else if (!value.contains('@')) {
                return 'Please enter a valid email address';
              }
              return null;
            },
          ),
          TextFormField(
            controller: widget.passwordController,
            decoration: InputDecoration(
              labelText: 'Password',
              suffixIcon: IconButton(
                icon: Icon(
                    _obscureText ? Icons.visibility : Icons.visibility_off),
                onPressed: _toggleObscureText,
              ),
            ),
            obscureText: _obscureText,
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter your password';
              } else if (value.length < 6) {
                return 'Password must be at least 6 characters long';
              }
              return null;
            },
          ),
          const SizedBox(height: 20),
          widget.isLoading
              ? const LoadingSpinner()
              : ElevatedButton(
                  onPressed: widget.submitForm,
                  child: Text(widget.buttonLabel),
                ),
          const SizedBox(height: 20),
          TextButton(
            onPressed: () {
              Navigator.of(context).pushReplacementNamed(widget.switchScreen);
            },
            child: Text(widget.switchLabel),
          ),
        ],
      ),
    );
  }
}
