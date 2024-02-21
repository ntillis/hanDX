import 'package:flutter/cupertino.dart';
import 'package:handdx/controllers/auth_controller.dart';
import 'package:handdx/ui/screens/account_screen.dart';
import 'package:handdx/ui/widgets/decision_tree_list_widget.dart';
import 'package:handdx/ui/widgets/resources.dart'; // Import the footer link widget
import 'package:hooks_riverpod/hooks_riverpod.dart';

class HomeScreen extends HookConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authControllerState = ref.watch(authControllerProvider);

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
          Resources(), // Include the footer link widget here
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
