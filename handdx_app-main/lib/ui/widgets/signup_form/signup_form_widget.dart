import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:handdx/controllers/auth_controller.dart';
import 'package:handdx/controllers/forms/signup_form_controller.dart';
import 'package:handdx/ui/screens/home_screen.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:string_validator/string_validator.dart';
import 'package:local_auth/local_auth.dart';
import 'package:local_auth/error_codes.dart' as auth_error;
import 'package:flutter/services.dart';
import 'package:flutter_keychain/flutter_keychain.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

final Uri _privacyPolicyUrl =
    Uri.parse('https://handdx-privacy-policy.aqchen.com/');

class SignupForm extends HookConsumerWidget {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _password = TextEditingController();

  final bool _obscureText = true;

  final LocalAuthentication _auth = LocalAuthentication();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authExceptionState = ref.watch(authControllerExceptionProvider);
    final isMounted = useIsMounted();

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
                    // initialValue: 'Input text',
                    prefix: const Icon(CupertinoIcons.envelope),
                    placeholder: 'Email',
                    validator: (value) {
                      if (value!.isEmpty || !isEmail(value)) {
                        log('Return msg');
                        return 'Please enter a valid email address';
                      }
                      return null;
                    },
                    onSaved: (val) {
                      ref.read(signupEmailProvider.notifier).state =
                          val.toString();
                    },
                  ),
                ),

                // password
                CupertinoFormRow(
                  child: CupertinoTextFormFieldRow(
                    controller: _password,
                    prefix: const Icon(CupertinoIcons.lock),
                    placeholder: 'Password',
                    // initialValue: 'Input text',
                    obscureText: _obscureText,
                    onSaved: (val) {
                      ref.read(signupPasswordProvider.notifier).state =
                          val.toString();
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Password cannot be empty';
                      }
                      return null;
                    },
                  ),
                ),

                CupertinoFormRow(
                  child: CupertinoTextFormFieldRow(
                    prefix: const Icon(CupertinoIcons.lock),
                    placeholder: 'Confirm password',
                    // initialValue: 'Input text',
                    obscureText: _obscureText,
                    validator: (value) {
                      if (value != _password.text) {
                        return 'Password must match';
                      }
                      return null;
                    },
                  ),
                ),
              ]),
          const SizedBox(height: 30),
          SizedBox(
            height: 54,
            width: 184,
            child: CupertinoButton.filled(
              padding: const EdgeInsets.all(16),
              onPressed: () {
                // Respond to button press

                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();

                  ref
                      .read(authControllerProvider.notifier)
                      .createAccountWithEmailPassword(
                          ref.read(signupEmailProvider.notifier).state,
                          ref.read(signupPasswordProvider.notifier).state)
                      .then((value) async {
                    final authControllerState =
                        ref.read(authControllerProvider);
                    if (authControllerState?.uid != null &&
                        !authControllerState!.isAnonymous &&
                        isMounted()) {
                      final navigator = Navigator.of(context);
                      final prefs = await SharedPreferences.getInstance();
                      if (context.mounted) {
                        bool acceptedBiometrics =
                            await askBiometrics(context, ref);
                        if (acceptedBiometrics) {
                          await confirmBiometricsAndSaveAuth(ref, prefs);
                        }
                        navigator.popUntil((route) => route.isFirst);
                        navigator.pushReplacement(CupertinoPageRoute(
                            builder: (context) => const HomeScreen()));
                      } else {
                        // Navigator.of(context)
                        //     .popUntil((route) => route.isFirst);
                        // Navigator.pushReplacement(
                        //     context,
                        //     CupertinoPageRoute(
                        //         builder: (context) => const HomeScreen()));
                        navigator.popUntil((route) => route.isFirst);
                        navigator.pushReplacement(CupertinoPageRoute(
                            builder: (context) => const HomeScreen()));
                      }
                    }
                  });
                }
              },
              child: const Text(
                'Create Account',
              ),
            ),
          ),
          if (authExceptionState != null) ...[
            const SizedBox(height: 25),
            Center(
              child: Text(
                'Failed to login: ${authExceptionState.message}',
                style: const TextStyle(color: CupertinoColors.systemRed),
              ),
            )
          ],
          const SizedBox(height: 25),
          GestureDetector(
            onTap: () {
              _launchPrivacyPolicyUrl();
            },
            child: const Text(
              'By creating an account, you agree to our Privacy Policy.',
              style: TextStyle(color: CupertinoColors.activeBlue, fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }

  askBiometrics(context, ref) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('biometricsAsked', false);
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
    return false;
  }

  confirmBiometricsAndSaveAuth(WidgetRef ref, SharedPreferences prefs) async {
    // final prefs = await SharedPreferences.getInstance();
    try {
      final bool didAuthenticate = await _auth.authenticate(
          localizedReason: 'Please Authenticate Biometrics');
      if (didAuthenticate) {
        FlutterKeychain.put(
            key: 'handdxPassword',
            value: ref.read(signupPasswordProvider.notifier).state);
        FlutterKeychain.put(
            key: 'handdxEmail',
            value: ref.read(signupEmailProvider.notifier).state);
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

  Future<void> _launchPrivacyPolicyUrl() async {
    if (!await launchUrl(_privacyPolicyUrl)) {
      return;
    }
  }
}
