import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:handdx/controllers/auth_controller.dart';
import 'package:handdx/controllers/forms/login_form_controller.dart';
import 'package:handdx/ui/screens/home_screen.dart';
import 'package:handdx/ui/screens/signup_screen.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:string_validator/string_validator.dart';
import 'package:local_auth/local_auth.dart';
import 'package:local_auth/error_codes.dart' as auth_error;
import 'package:flutter/services.dart';
import 'package:flutter_keychain/flutter_keychain.dart';
import '../../../repositories/custom_exception.dart';

/// A widget for the login form.
///
/// Contains a email and password field, and a biomterics button.
/// Also handles prompting the user to enable or use biometrics.
class LoginForm extends HookConsumerWidget {
  final _formKey = GlobalKey<FormState>();

  /// If the text should be obscured or not.
  final bool _obscureText = true;

  /// Access to authentication with biometrics
  final LocalAuthentication _auth = LocalAuthentication();

  LoginForm({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authExceptionState = ref.watch(authControllerExceptionProvider);
    final isMounted = useIsMounted();
    final formEmailKey = GlobalKey<FormFieldState>();

    useBiometrics(context, ref);

    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          CupertinoFormSection(
            backgroundColor: const Color(0x00000000),
            children: <Widget>[
              // email
              CupertinoFormRow(
                child: CupertinoTextFormFieldRow(
                  key: formEmailKey,
                  // initialValue: 'Input text',
                  prefix: const Icon(CupertinoIcons.envelope),
                  placeholder: 'Email',
                  validator: (value) {
                    if (value!.isEmpty || !isEmail(value)) {
                      return 'Please enter a valid email address';
                    }
                    return null;
                  },
                  onSaved: (val) {
                    ref.read(loginEmailProvider.notifier).state =
                        val.toString();
                  },
                ),
              ),

              // password
              CupertinoFormRow(
                child: CupertinoTextFormFieldRow(
                  prefix: const Icon(CupertinoIcons.lock),
                  placeholder: 'Password',
                  // initialValue: 'Input text',
                  obscureText: _obscureText,
                  onSaved: (val) {
                    ref.read(loginPasswordProvider.notifier).state =
                        val.toString();
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Password cannot be empty';
                    }
                    return null;
                  },
                ),
              )
            ],
          ),
          const SizedBox(height: 30),
          SizedBox(
            height: 54,
            width: 184,
            child: CupertinoButton.filled(
              onPressed: () {
                // Respond to button press
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  ref
                      .read(authControllerProvider.notifier)
                      .signInWithEmailPassword(
                          ref.read(loginEmailProvider.notifier).state,
                          ref.read(loginPasswordProvider.notifier).state)
                      .then((value) async {
                    final authControllerState =
                        ref.read(authControllerProvider);
                    if (authControllerState?.uid != null &&
                        !authControllerState!.isAnonymous &&
                        isMounted()) {
                      final navigator = Navigator.of(context);
                      final prefs = await SharedPreferences.getInstance();
                      if (prefs.getBool('biometricsAsked') == true) {
                        ref.read(loginPasswordProvider.notifier).state = "";
                        ref.read(loginEmailProvider.notifier).state = "";
                        navigator.pushReplacement(CupertinoPageRoute(
                            builder: (context) => const HomeScreen()));
                      } else {
                        if (context.mounted) {
                          bool acceptedBiometrics =
                              await askBiometrics(context, ref);
                          if (acceptedBiometrics) {
                            bool confirmedBiometrics =
                                await confirmBiometricsAndSaveAuth(ref, prefs);
                            if (confirmedBiometrics) {
                              ref.read(loginPasswordProvider.notifier).state =
                                  "";
                              ref.read(loginEmailProvider.notifier).state = "";
                              navigator.pushReplacement(CupertinoPageRoute(
                                  builder: (context) => const HomeScreen()));
                            }
                          } else {
                            ref.read(loginPasswordProvider.notifier).state = "";
                            ref.read(loginEmailProvider.notifier).state = "";
                            navigator.pushReplacement(CupertinoPageRoute(
                                builder: (context) => const HomeScreen()));
                          }
                        }
                      }
                    }
                  });
                }
              },
              child: const Text(
                'Login',
              ),
            ),
          ),
          const SizedBox(height: 22),
          GestureDetector(
            onTap: () => Navigator.push(context,
                CupertinoPageRoute(builder: (context) => const SignupScreen())),
            child: const Text(
              'Sign Up',
              style: TextStyle(color: CupertinoColors.activeBlue),
            ),
          ),
          const SizedBox(height: 22),
          GestureDetector(
            onTap: () async {
              if (formEmailKey.currentState!.validate()) {
                formEmailKey.currentState!.save();

                String email = ref.read(loginEmailProvider.notifier).state;

                if (await forgotEmailConfirmation(context, ref, email)) {
                  try {
                    await ref
                        .read(authControllerProvider.notifier)
                        .forgotPasswordEmail(email);
                  } on CustomException catch (e) {
                    await popupMessage(context, ref, e.message ?? "Error");
                    return;
                  }
                  await popupMessage(context, ref, "Email has been sent.");
                }
              }
            },
            child: const Text(
              'Forgot Password',
              style: TextStyle(color: CupertinoColors.activeBlue),
            ),
          ),
          if (authExceptionState != null) ...[
            const SizedBox(height: 25),
            Center(
              child: Text(
                'Failed to login: ${authExceptionState.message}',
                style: const TextStyle(color: CupertinoColors.systemRed),
              ),
            ),
          ]
        ],
      ),
    );
  }

  forgotEmailConfirmation(BuildContext context, ref, String email) async {
    return await showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
          title: const Text('Forgot Password'),
          content: Text('Send a password reset link to $email?'),
          actions: <CupertinoDialogAction>[
            CupertinoDialogAction(
              onPressed: () => {Navigator.pop(context, false)},
              child: const Text('No'),
            ),
            CupertinoDialogAction(
              isDefaultAction: true,
              onPressed: () => {Navigator.pop(context, true)},
              child: const Text('Yes'),
            )
          ]),
    );
  }

  popupMessage(BuildContext context, ref, String message) async {
    return await showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
          title: const Text('Notice'),
          content: Text(message),
          actions: <CupertinoDialogAction>[
            CupertinoDialogAction(
              isDefaultAction: true,
              onPressed: () =>
                  {if (context.mounted) Navigator.pop(context, false)},
              child: const Text('Okay'),
            )
          ]),
    );
  }

  askBiometrics(context, ref) async {
    final prefs = await SharedPreferences.getInstance();
    //prefs.setBool('biometricsAsked', false);
    if (prefs.getBool('biometricsAsked') != true) {
      prefs.setBool('biometricsAsked', true);
      return await showCupertinoModalPopup<void>(
        context: context,
        builder: (BuildContext context) => CupertinoAlertDialog(
          title: const Text('Biometrics'),
          content: const Text('Enable Biometrics?'),
          actions: <CupertinoDialogAction>[
            CupertinoDialogAction(
              isDefaultAction: true,
              onPressed: () {
                prefs.setBool('useBiometrics', false);
                Navigator.pop(context, false);
              },
              child: const Text('No'),
            ),
            CupertinoDialogAction(
              isDestructiveAction: true,
              onPressed: () {
                // prefs.setString(
                //     "email", ref.read(loginEmailProvider.notifier).state);
                // prefs.setString(
                //     "pass", ref.read(loginPasswordProvider.notifier).state);

                Navigator.pop(context, true);
              },
              child: const Text('Yes'),
            ),
          ],
        ),
      );
    }
  }

  confirmBiometricsAndSaveAuth(WidgetRef ref, SharedPreferences prefs) async {
    // final prefs = await SharedPreferences.getInstance();
    try {
      final bool didAuthenticate = await _auth.authenticate(
          localizedReason: 'Please Authenticate Biometrics');
      if (didAuthenticate) {
        FlutterKeychain.put(
            key: 'handdxPassword',
            value: ref.read(loginPasswordProvider.notifier).state);
        FlutterKeychain.put(
            key: 'handdxEmail',
            value: ref.read(loginEmailProvider.notifier).state);
        prefs.setBool('useBiometrics', true);
        // prefs.setString("USER", userEmail);
        return true;
      }
    } on PlatformException catch (e) {
      prefs.setBool('useBiometrics', false);
      if (e.code == auth_error.notAvailable) {
        log(e.message.toString());
      }
    }
    return false;
  }

  useBiometrics(context, ref) async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.getBool('useBiometrics') == false) {
      return;
    }
    try {
      final bool didAuthenticate = await _auth.authenticate(
          localizedReason: 'Please Authenticate Biometrics');
      if (didAuthenticate) {
        String? email = await FlutterKeychain.get(key: 'handdxEmail');
        String? password = await FlutterKeychain.get(key: 'handdxPassword');
        if (email == null || password == null) {
          final prefs = await SharedPreferences.getInstance();
          prefs.setBool('useBiometrics', false);
          return;
        }
        log(email);
        log(password);
        ref.read(loginEmailProvider.notifier).state = email;
        ref.read(loginPasswordProvider.notifier).state = password;
        ref
            .read(authControllerProvider.notifier)
            .signInWithEmailPassword(
                ref.read(loginEmailProvider.notifier).state,
                ref.read(loginPasswordProvider.notifier).state)
            .then((value) {
          final authControllerState = ref.read(authControllerProvider);
          if (authControllerState?.uid != null &&
              !authControllerState!.isAnonymous) {
            ref.read(loginPasswordProvider.notifier).state = "";
            ref.read(loginEmailProvider.notifier).state = "";
            Navigator.pushReplacement(context,
                CupertinoPageRoute(builder: (context) => const HomeScreen()));
          }
        });
      }
    } on PlatformException catch (e) {
      if (e.code == auth_error.notAvailable) {
        log(e.message.toString());
      }
    }
  }
}
