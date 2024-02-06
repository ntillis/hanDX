import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:handdx/controllers/current_node_controller.dart';
import 'package:handdx/controllers/decision_tree_controller.dart';
import 'package:handdx/controllers/decision_tree_list_controller.dart';
import 'package:handdx/models/decision_tree_model.dart';
import 'package:handdx/ui/screens/node_screen.dart';
import 'package:handdx/ui/util/ui_colors.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class DecisionTreeList extends HookConsumerWidget {
  const DecisionTreeList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final decisionTreeListState = ref.watch(decisionTreeListControllerProvider);

    return decisionTreeListState.when(
        data: (trees) => trees.isEmpty
            ? const Center(
                child: Text(
                    "No Decision Trees. Contact the admins if you believe this is a mistake."),
              )
            : CupertinoListSection.insetGrouped(
                backgroundColor: Colors.transparent,
                header: const Text('Initial Condition'),
                children: _generateListItems(trees, context, ref),
              ),
        error: (e, s) => Text("Error: $e"),
        loading: () => Center(
                child: Column(
              children: const [
                SizedBox(
                  height: 16,
                ),
                CupertinoActivityIndicator(),
              ],
            )));
  }
}

List<Widget> _generateListItems(
    List<DecisionTree> trees, BuildContext context, WidgetRef ref) {
  return trees
      .map((tree) => CupertinoListTile(
            key: ValueKey(tree.id),
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  tree.longTreeName,
                  style: const TextStyle(fontWeight: FontWeight.w500),
                ),
                Text(
                  tree.treeDescription,
                  maxLines: 2,
                  style: const TextStyle(
                    color: CupertinoColors.inactiveGray,
                  ),
                ),
              ],
            ),
            trailing: Row(children: [
              Container(
                margin: const EdgeInsets.only(top: 8.0, bottom: 8.0, left: 8.0),
                width: 80,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(5.0)),
                clipBehavior: Clip.hardEdge,
                child: CachedNetworkImage(
                  imageUrl: tree.pictureUrl,
                  height: 50,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(
                width: 16,
              ),
              const CupertinoListTileChevron(),
            ]),
            onTap: () {
              ref.read(decisionTreeControllerProvider.notifier).deselectTree();
              ref.read(currentNodeProvider.notifier).clearHistory();
              ref
                  .read(currentNodeProvider.notifier)
                  .setCurrentNodeById(tree.id!, tree.rootNode);
              // ref
              //     .read(decisionTreeControllerProvider.notifier)
              //     .selectTree(tree: tree);
              Navigator.push(context,
                  CupertinoPageRoute(builder: (context) => const NodeScreen()));
            },
          ))
      .toList();
}

class DecisionTreeListError extends ConsumerWidget {
  final String message;

  const DecisionTreeListError({
    Key? key,
    required this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Center(
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Text(message),
        const SizedBox(
          height: 20.0,
        ),
        ElevatedButton(
          onPressed: () => ref
              .read(decisionTreeListControllerProvider.notifier)
              .retrieveDecisionTrees(isRefreshing: true),
          child: const Text("Retry"),
        ),
      ]),
    );
  }
}
