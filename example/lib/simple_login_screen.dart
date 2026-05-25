import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:smart_phone_parser/smart_phone_parser.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final SmartPhoneController _phoneController = SmartPhoneController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  
  final String _validationMessage = '';

  void _login() {
    if (_formKey.currentState!.validate()) {
      final phone = _phoneController.fullNumber;
      final password = _passwordController.text;
      
      log('Phone: $phone');
      log('Password: $password');
      log('Country: ${_phoneController.countryName}');
      log('Valid: ${_phoneController.isValid}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SmartPhoneField(
                controller: _phoneController,
                labelText: 'Phone Number',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Phone required';
                  }
                  
                  final rules = PhoneRules.getRules(_phoneController.countryCode);
                  if (rules != null) {
                    final isValid = PhoneRules.isValidNumber(
                      _phoneController.countryCode,
                      _phoneController.nationalNumber,
                    );
                    
                    if (!isValid) {
                      return PhoneRules.getErrorMessage(
                        _phoneController.countryCode,
                        _phoneController.nationalNumber,
                      );
                    }
                  }
                  
                  // if (!_phoneController.isValid) {
                  //   return 'Invalid phone number';
                  // }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                ),
                validator: (v) => v == null || v.isEmpty ? 'Password required' : null,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _login,
                child: const Text('Login'),
              ),
              const SizedBox(height: 16),
              if (_validationMessage.isNotEmpty)
                Text(
                  _validationMessage,
                  style: const TextStyle(color: Colors.red),
                ),
            ],
          ),
        ),
      ),
    );
  }
}