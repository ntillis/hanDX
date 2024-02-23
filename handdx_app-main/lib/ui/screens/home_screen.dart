import 'package:flutter/cupertino.dart';
import 'package:handdx/controllers/auth_controller.dart';
import 'package:handdx/ui/screens/account_screen.dart';
import 'package:handdx/ui/widgets/decision_tree_list_widget.dart';
import 'package:handdx/ui/widgets/resources.dart'; 
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';

class HomeScreen extends HookConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authController = ref.watch(authControllerProvider.notifier);


if (authController.notify) {
  Fluttertoast.showToast(
    msg: "Disclaimer: While this app provides information, it is important to remember that it is not a substitute for professional medical advice, diagnosis, or treatment. The results provided by this app are for informational purposes only and should not be used as a definitive diagnosis. If you are experiencing any symptoms or have an injury, we strongly recommend seeking medical attention from a qualified healthcare professional. They can provide you with personalized advice and treatment options tailored to your specific situation. By using this app, you acknowledge that you understand and agree to the limitations of its information and that you will seek appropriate medical care when necessary.",
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.CENTER,
    timeInSecForIosWeb: 10,
    fontSize: 16.0,
  );
  // Update the first login flag to false
  authController.setNotify(false);
}


    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: const Text("Home"),
        trailing: accountWidget(context, ref),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: ListView(
              children: const [DecisionTreeList()],
            ),
          ),
          Resources(),
        ],
      ),
    );
  }
}

Widget accountWidget(BuildContext context, WidgetRef ref) {
  return CupertinoButton(
    padding: EdgeInsets.zero,
    onPressed: () {
      Navigator.push(
        context,
        CupertinoPageRoute(builder: (context) => const AccountScreen()),
      );
    },
    child: const Text('Account'),
  );
}

