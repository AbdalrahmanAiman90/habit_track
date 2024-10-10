import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_track/core/theme/style.dart'; // Adjust this import as necessary
import 'package:habit_track/feature/Auth/ui/widget/custom_button.dart';
import 'package:habit_track/feature/Settings/widget/CustomTextWithHint.dart'; // Import your new widget here
import 'package:habit_track/feature/Auth/ui/widget/password_field.dart';
import 'package:habit_track/feature/Auth/cubit/cubit/auth_cubit.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _onUpdate() {
    if (_formKey.currentState!.validate()) {
      context.read<AuthCubit>().updateAccount(
        name: _nameController.text.isNotEmpty ? _nameController.text : "", // Optional field
        email: _emailController.text.isNotEmpty ? _emailController.text : "", // Optional field
        password: _passwordController.text, // Required field
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Account'),
      ),
      body: Padding(
        padding: EdgeInsets.all(25.0),
        child: BlocListener<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state is AuthFaileRegister) {
              // Handle failure
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.errorMassage)),
              );
            } else if (state is AuthRegisterSucsses) {
              // Handle success, you can show a message or navigate
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("Account updated successfully!")),
              );
            }
          },
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  // Name Field (Optional)
                  CustomTextWithHint(
                    hintNameInside: 'Gasser',
                    hintName: 'Name',
                    controller: _nameController,
                    validator: (value) {
                      // No validation since it's optional
                      return null;
                    },
                  ),
                  SizedBox(height: 10.0),
                  // Email Field (Optional)
                  CustomTextWithHint(
                    hintNameInside: 'gasser@gmail.com',
                    hintName: 'Email',
                    controller: _emailController,
                    validator: (value) {
                      if (value != null && value.isNotEmpty && !RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                        return 'Please enter a valid email';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 10.0),
                  // Password Field (Required)
                  PasswordField(
                    hintName: 'Password',
                    controller: _passwordController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a password';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 10.0),
                  // Confirm Password Field (Required)
                  PasswordField(
                    hintName: 'Confirm Password',
                    controller: _confirmPasswordController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please confirm your password';
                      } else if (value != _passwordController.text) {
                        return 'Passwords do not match';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20.0),
                  // Update Button
                  CustomButton(
                    buttonName: 'Update',
                    onPressed: _onUpdate,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
