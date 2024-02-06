import 'dart:developer';

import 'package:animations/animations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:handdx/controllers/decision_tree_controller.dart';
import 'package:handdx/controllers/current_node_controller.dart';
import 'package:handdx/ui/util/ui_colors.dart';
import 'package:handdx/ui/widgets/node_view_widget.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class NodeScreen extends HookConsumerWidget {
  const NodeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentNode = ref.watch(currentNodeProvider);
    log(UiColors.backgroundColor.toString());

    return WillPopScope(
      onWillPop: () async {
        //ref.read(decisionTreeControllerProvider.notifier).deselectTree();
        log('HISTORY LEN: ${ref.read(currentNodeProvider.notifier).historyLength}');
        if (ref.read(currentNodeProvider.notifier).historyLength == 1) {
          //ref.read(decisionTreeControllerProvider.notifier).deselectTree();
          return true;
        }
        ref.read(movedForwardNodeProvider.notifier).state = false;
        ref.read(currentNodeProvider.notifier).moveToPreviousNode();
        return false;
      },
      child: CupertinoPageScaffold(
        backgroundColor: UiColors.backgroundColor,
        navigationBar: CupertinoNavigationBar(
          middle: Text(ref
                  .read(decisionTreeControllerProvider)
                  ?.decisionTree
                  .shortTreeName ??
              " "),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (currentNode.isLoading || currentNode.value == null)
                Container(
                    margin: const EdgeInsets.only(right: 8.0),
                    child: const CupertinoActivityIndicator()),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).popUntil((route) => route.isFirst);
                },
                child: const Text(
                  "Exit",
                  style: TextStyle(color: CupertinoColors.activeBlue),
                ),
              ),
            ],
          ),
        ),
        child: currentNode.when(
          data: (node) => node == null
              ? Container()
              : Container(
                  decoration: BoxDecoration(color: UiColors.backgroundColor),
                  child: PageTransitionSwitcher(
                    reverse: !ref.read(movedForwardNodeProvider),
                    transitionBuilder: (Widget child,
                        Animation<double> primaryAnimation,
                        Animation<double> secondaryAnimation) {
                      return SharedAxisTransition(
                        animation: primaryAnimation,
                        secondaryAnimation: secondaryAnimation,
                        transitionType: SharedAxisTransitionType.horizontal,
                        child: child,
                      );
                    },
                    // Key needs to be specified to allow switcher to determine when to animate
                    child: NodeView(key: Key(node.id!), node: node),
                  ),
                ),
          error: (e, s) => Text("Error: $e"),
          loading: () => const Center(
            child: CupertinoActivityIndicator(),
          ),
        ),
      ),
    );
  }
}
