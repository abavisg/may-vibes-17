import 'package:flutter/material.dart';
import 'package:tweenvibes/utils/constants.dart';
import 'package:tweenvibes/utils/routes.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _birthdayController = TextEditingController();
  String? _selectedTimezone;

  // Sample list of timezones (in a real app, you'd have a more complete list)
  final List<String> _timezones = [
    'GMT-12',
    'GMT-11',
    'GMT-10',
    'GMT-9',
    'GMT-8',
    'GMT-7',
    'GMT-6',
    'GMT-5',
    'GMT-4',
    'GMT-3',
    'GMT-2',
    'GMT-1',
    'GMT+0',
    'GMT+1',
    'GMT+2',
    'GMT+3',
    'GMT+4',
    'GMT+5',
    'GMT+6',
    'GMT+7',
    'GMT+8',
    'GMT+9',
    'GMT+10',
    'GMT+11',
    'GMT+12',
  ];

  @override
  void dispose() {
    _emailController.dispose();
    _birthdayController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 40),
                  // App Logo and Title
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.star, color: Colors.amber),
                        const SizedBox(width: 8),
                        Text(
                          Constants.appName,
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 40),
                  // Create Account Header
                  Text(
                    'Create Your Account',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(height: 30),

                  // Email Field
                  Text(
                    Constants.emailLabel,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      hintText: Constants.emailPlaceholder,
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
                      }
                      if (!value.contains('@')) {
                        return 'Please enter a valid email';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),

                  // Birthday Field
                  Text(
                    Constants.birthdayLabel,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: _birthdayController,
                    keyboardType: TextInputType.datetime,
                    decoration: const InputDecoration(
                      hintText: Constants.birthdayPlaceholder,
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your birthday';
                      }
                      return null;
                    },
                    onTap: () async {
                      // Hide keyboard
                      FocusScope.of(context).requestFocus(FocusNode());

                      // Show date picker
                      final DateTime? picked = await showDatePicker(
                        context: context,
                        initialDate: DateTime(2000),
                        firstDate: DateTime(1900),
                        lastDate: DateTime.now(),
                      );

                      if (picked != null) {
                        setState(() {
                          _birthdayController.text =
                              '${picked.day.toString().padLeft(2, '0')}/${picked.month.toString().padLeft(2, '0')}/${picked.year}';
                        });
                      }
                    },
                  ),
                  const SizedBox(height: 20),

                  // Timezone Field
                  Text(
                    Constants.timezoneLabel,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 8),
                  DropdownButtonFormField<String>(
                    value: _selectedTimezone,
                    decoration: const InputDecoration(
                      hintText: Constants.timezonePlaceholder,
                    ),
                    items: _timezones.map((String timezone) {
                      return DropdownMenuItem<String>(
                        value: timezone,
                        child: Text(timezone),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedTimezone = newValue;
                      });
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please select your timezone';
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 40),

                  // Sign Up Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          // In a real app, you would handle the sign up process here
                          Navigator.pushNamed(context, AppRoutes.moodEntry);
                        }
                      },
                      child: const Text(Constants.signUpButton),
                    ),
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
