import 'package:decision_tree_creator/controllers/firebase_auth.dart';
import 'package:decision_tree_creator/controllers/generate_trees.dart';
import 'package:decision_tree_creator/views/login_view.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                'Click to genenate decision trees',
              ),
              FilledButton(
                onPressed: (() => GenerateTrees.generate().then((success) => {
                      if (success)
                        {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text(
                              'Generated trees!',
                              style: TextStyle(fontSize: 16),
                            ),
                          ))
                        }
                      else
                        {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text(
                              'Failed to generate trees. Check if user is an admin.',
                              style: TextStyle(fontSize: 16),
                            ),
                          ))
                        }
                    })),
                child: const Text('Generate'),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          AuthenticationHelper.signOut().then((_) => Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (contex) => Login()),
              ));
        },
        tooltip: 'Logout',
        child: const Icon(Icons.logout),
      ),
    );
  }
}
