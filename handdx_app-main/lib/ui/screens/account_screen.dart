import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:handdx/ui/util/ui_colors.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../controllers/auth_controller.dart';
import '../../repositories/custom_exception.dart';
import 'login_screen.dart';

class AccountScreen extends HookConsumerWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        leading: CupertinoButton(
          padding: EdgeInsets.zero,
          child: const Text('Back'),
          onPressed: () => Navigator.pop(context),
        ),
        middle: const Text('Account'),
      ),
      child: ListView(
        children: const <Widget>[
          AccountOptions(),
        ],
      ),
    );
  }
}

class AccountOptions extends HookConsumerWidget {
  const AccountOptions({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CupertinoPageScaffold(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding:
              const EdgeInsets.only(left: 24, right: 24, top: 8, bottom: 8),
          child: Text(
            ref.read(authControllerProvider)?.email ?? 'No email found',
            style: TextStyle(
                fontSize: 28,
                color: UiColors.textColor,
                fontWeight: FontWeight.bold),
          ),
        ),
        CupertinoListSection.insetGrouped(
          backgroundColor: Colors.transparent,
          header: const Text('Account Options'),
          children: <CupertinoListTile>[
            CupertinoListTile.notched(
                title: const Text('Update Password'),
                leading: const SizedBox(
                  width: double.infinity,
                  height: double.infinity,
                ),
                trailing: const CupertinoListTileChevron(),
                onTap: () async {
                  String email = ref.read(authControllerProvider)?.email ?? "";

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
                }),
            CupertinoListTile.notched(
              title: const Text('Delete Account'),
              leading: const SizedBox(
                width: double.infinity,
                height: double.infinity,
              ),
              trailing: Icon(
                CupertinoIcons.delete_solid,
                color: UiColors.textColor,
                size: 30.0,
              ),
              onTap: () => Navigator.of(context).push(
                CupertinoPageRoute<void>(
                  builder: (BuildContext context) {
                    return const DeleteAccountPage();
                  },
                ),
              ),
            ),
          ],
        ),
        CupertinoListSection.insetGrouped(
            backgroundColor: Colors.transparent,
            children: <CupertinoListTile>[
              CupertinoListTile.notched(
                title: const Center(
                    child: Text(
                  'Sign Out',
                  style: TextStyle(color: CupertinoColors.destructiveRed),
                )),
                onTap: () async {
                  final prefs = await SharedPreferences.getInstance();
                  prefs.setBool('biometricsAsked', false);
                  prefs.setBool('useBiometrics', false);
                  ref
                      .read(authControllerProvider.notifier)
                      .signOut()
                      .then((value) => {
                            Navigator.pushAndRemoveUntil(
                                context,
                                CupertinoPageRoute(
                                    builder: (context) => const LoginScreen()),
                                ((route) => false))
                          });
                },
              ),
            ]),
      ],
    ));
  }
}

class DeleteAccountPage extends HookConsumerWidget {
  const DeleteAccountPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
            leading: CupertinoButton(
              padding: EdgeInsets.zero,
              child: const Text('Back'),
              onPressed: () => Navigator.pop(context),
            ),
            middle: const Text("Delete Account")),
        child: Container(
            padding: const EdgeInsets.only(left: 40, right: 40, bottom: 200),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                      padding: const EdgeInsets.only(bottom: 40),
                      child: Text(
                        'Are you sure you want to delete your account? You will not be able to undo this action.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 22,
                            color: UiColors.textColor,
                            fontWeight: FontWeight.w400),
                      )),
                  Center(
                    child: CupertinoButton(
                      color: CupertinoColors.destructiveRed,
                      child: const Text('Delete Account'),
                      onPressed: () async {
                        await ref
                            .read(authControllerProvider.notifier)
                            .deleteAccount()
                            .then((value) async {
                          final authControllerState =
                              ref.read(authControllerProvider);
                          // TODO: remove "|| true" - for some reason doesn't wait until after deletion complete
                          if (authControllerState?.uid == null || true) {
                            final navigator = Navigator.of(context);
                            final prefs = await SharedPreferences.getInstance();
                            prefs.setBool('biometricsAsked', false);
                            prefs.setBool('useBiometrics', false);
                            navigator.pushAndRemoveUntil(
                                CupertinoPageRoute(
                                    builder: (context) => const LoginScreen()),
                                ((route) => false));
                          }
                        });
                      },
                    ),
                  ),
                  const SizedBox(height: 15),
                  CupertinoButton(
                    color: UiColors.secondary,
                    child: const Text('Cancel'),
                    onPressed: () => Navigator.pop(context),
                  ),
                ])));
  }
}

forgotEmailConfirmation(BuildContext context, ref, String email) async {
  return await showCupertinoModalPopup<void>(
    context: context,
    builder: (BuildContext context) => CupertinoAlertDialog(
        title: const Text('Reset Password'),
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
