import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:scoreboard/scores/main_provider.dart';
import 'package:scoreboard/services/auth.dart';
import 'package:scoreboard/shared/appbar.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool _isValidated = false;
  var errorText = '';

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();

    super.dispose();
  }

  String? validateMail(String? value) {
    var validated = EmailValidator.validate(value ?? '');
    _isValidated = validated;
    return validated ? null : "Please enter a valid email";
  }

  Future signIn(BuildContext context) async {
    try {
      await AuthService().loginUser(
          emailController.text.trim(), passwordController.text.trim());
    } catch (e) {
      setState(() {
        errorText = 'Die Emailadresse oder das Passwort ist falsch';
      });
    }

    if (AuthService().user == null) {
      return;
    }

    // ignore: use_build_context_synchronously
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const MainProvider()),
      (Route<dynamic> route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar(context),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  AutofillGroup(
                    child: Column(
                      children: [
                        Form(
                          autovalidateMode: AutovalidateMode.always,
                          child: TextFormField(
                            validator: (value) => validateMail(value),
                            controller: emailController,
                            autofillHints: const [AutofillHints.email],
                            keyboardType: TextInputType.emailAddress,
                            textInputAction: TextInputAction.next,
                            decoration: const InputDecoration(
                              labelText: 'Email',
                            ),
                          ),
                        ),
                        const Padding(padding: EdgeInsets.all(4)),
                        TextField(
                          controller: passwordController,
                          textInputAction: TextInputAction.done,
                          obscureText: true,
                          onSubmitted: (value) => signIn(context),
                          autofillHints: const [AutofillHints.password],
                          onEditingComplete: () =>
                              TextInput.finishAutofillContext(),
                          decoration: const InputDecoration(
                            labelText: 'Password',
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Padding(padding: EdgeInsets.all(10)),
                  Text(
                    errorText,
                    style:
                        TextStyle(color: Theme.of(context).colorScheme.error),
                  ),
                  const Padding(padding: EdgeInsets.all(10)),
                  ElevatedButton.icon(
                    onPressed: () => _isValidated ? signIn(context) : null,
                    icon: const Icon(Icons.lock_outline),
                    label: const Text('Login'),
                  ),
                ],
              ),
            ),
            TextButton(
              child: const Text('Passwort vergessen?'),
              onPressed: () async {
                if (!_isValidated) {
                  setState(() {
                    errorText = 'Bitte eine gültige Emailadresse eingeben';
                  });
                } else {
                  try {
                    await FirebaseAuth.instance.sendPasswordResetEmail(
                        email: emailController.text.trim());
                    // ignore: empty_catches
                  } on FirebaseAuthException {}
                  // ignore: use_build_context_synchronously
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text('Information'),
                        content: Text(
                            'Eine Email wurde an ${emailController.text.trim()} gesendet'),
                        actions: [
                          TextButton(
                            child: const Text('Okay'),
                            onPressed: () => Navigator.of(context).pop(),
                          ),
                        ],
                      );
                    },
                  );
                }
              },
            ),
            const Padding(padding: EdgeInsets.all(10)),
          ],
        ),
      ),
    );
  }
}
