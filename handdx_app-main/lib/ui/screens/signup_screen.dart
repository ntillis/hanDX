import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/svg.dart';
import 'package:handdx/ui/util/ui_colors.dart';
import 'package:handdx/ui/widgets/signup_form/signup_form_widget.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SignupScreen extends HookConsumerWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        leading: CupertinoButton(
          padding: EdgeInsets.zero,
          child: const Text('Back'),
          onPressed: () => Navigator.pop(context),
        ),
        middle: const Text('Sign Up'),
      ),
      child: ListView(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Sign Up',
                        style: TextStyle(
                            fontSize: 38,
                            color: UiColors.accentAlt,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Text(
                        'Create an account',
                        style: TextStyle(
                            fontSize: 22,
                            color: UiColors.textColor,
                            fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                ),
                SignupForm(),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
