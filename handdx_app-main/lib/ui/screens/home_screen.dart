import 'package:flutter/cupertino.dart';
import 'package:handdx/ui/widgets/decision_tree_list_widget.dart';
import 'package:handdx/ui/widgets/resources.dart'; 
import 'package:hooks_riverpod/hooks_riverpod.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _disclaimerShown = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _showDisclaimerDialogIfNeeded();
    });
  }

  void _showDisclaimerDialogIfNeeded() {
    if (!_disclaimerShown) {
      _showDisclaimerDialog();
    }
  }

  void _showDisclaimerDialog() {
    showCupertinoDialog(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: const Text("Disclaimer"),
          content: const Text("Disclaimer: While this app provides information, it is important to remember that it is not a substitute for professional medical advice, diagnosis, or treatment. The results provided by this app are for informational purposes only and should not be used as a definitive diagnosis. If you are experiencing any symptoms or have an injury, we strongly recommend seeking medical attention from a qualified healthcare professional. They can provide you with personalized advice and treatment options tailored to your specific situation. By using this app, you acknowledge that you understand and agree to the limitations of its information and that you will seek appropriate medical care when necessary."),
          actions: <Widget>[
            CupertinoDialogAction(
              child: const Text("OK"),
              onPressed: () {
                setState(() {
                  _disclaimerShown = true;
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text("Home"),
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

