import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/svg.dart';
import 'package:handdx/ui/util/ui_colors.dart';
import 'package:handdx/ui/widgets/login_form/login_form_widget.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class LoginScreen extends HookConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        /*leading: CupertinoButton(
          padding: EdgeInsets.zero,
          child: const Text('Back'),
          onPressed: () => Navigator.pop(context),
        ),*/
        middle: Text('Login'),
      ),
      child: ListView(
        children: <Widget>[
          // logo
          Container(
            padding: const EdgeInsets.only(top: 25.0, bottom: 25.0),
            alignment: Alignment.center,
            child: SvgPicture.asset(
              'lib/ui/assets/thought_process.svg',
              semanticsLabel: '',
              fit: BoxFit.fitHeight,
              height: 200,
            ),
          ),
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
                        'Welcome back!',
                        style: TextStyle(
                            fontSize: 38,
                            color: UiColors.accentAlt,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Text(
                        'Login to HandDx',
                        style: TextStyle(
                            fontSize: 22,
                            color: UiColors.textColor,
                            fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                ),
                LoginForm(),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
