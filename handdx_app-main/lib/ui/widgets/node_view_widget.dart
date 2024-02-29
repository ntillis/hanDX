import 'dart:async';
import 'dart:developer';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:handdx/controllers/image_view_controller.dart';
import 'package:handdx/controllers/current_node_controller.dart';
import 'package:handdx/models/node_model.dart';
import 'package:handdx/ui/screens/image_viewer_screen.dart';
import 'package:handdx/ui/screens/node_screen.dart';
import 'package:handdx/ui/util/ui_colors.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class NodeView extends HookConsumerWidget {
  final Node? node;

  const NodeView({
    Key? key,
    required this.node,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return node == null
        ? const Text(
            "No Nodes in Decision Tree. Contact the admins if you believe this is a mistake.")
        : ListView(
            children: generateNodeViewList(node!, context, ref),
          );
  }
}

List<Widget> generateNodeViewList(
    Node node, BuildContext context, WidgetRef ref) {
  return [
    Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        children: [...generateDescriptionListItems(node, context, ref)],
      ),
    ),
    if (node.children != null)
      CupertinoListSection.insetGrouped(
        backgroundColor: Colors.transparent,
        children: generateOptionsListItems(node, context, ref),
      )
  ];
}

List<Widget> generateDescriptionListItems(
    Node node, BuildContext context, WidgetRef ref) {
  return [
    const SizedBox(
      height: 8.0,
    ),
    if (node.pictureUrl != null && node.pictureUrl!.isNotEmpty) ...[
      imageViewer(node.pictureUrl!, context, ref),
      const SizedBox(
        height: 10.0,
      )
    ],
    if (node.result != null)
      Text(
        node.result.toString(),
        style: TextStyle(
          fontSize: 28.0,
          fontWeight: FontWeight.bold,
          color: UiColors.textColor,
        ),
      ),
    if (node.treatment != null)
      Text(
        node.treatment.toString(),
        style: TextStyle(
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
          color: UiColors.textColor,
        ),
      ),
    if (node.question != null)
      Text(
        node.question.toString(),
        style: TextStyle(
          fontSize: 28.0,
          fontWeight: FontWeight.bold,
          color: UiColors.textColor,
        ),
      ),
  ];
}

List<Widget> generateOptionsListItems(
    Node node, BuildContext context, WidgetRef ref) {
  if (node.children == null) {
    return [];
  }
  return node.children!
      .map((e) => CupertinoListTile(
            title: Text(e['text'] ?? 'No text', maxLines: 5),
            trailing: const Icon(CupertinoIcons.arrow_right_circle),
            onTap: () {
              ref.read(movedForwardNodeProvider.notifier).state = true;
              ref
                  .read(currentNodeProvider.notifier)
                  .setCurrentNodeById(e['treeId'] ?? '', e['nodeId'] ?? '');
              // Navigator.push(context,
              //     CupertinoPageRoute(builder: (context) => const NodeScreen()));
            },
          ))
      .toList();
}

List<SliverList> generateSliverList(
    Node node, BuildContext context, WidgetRef ref) {
  final description = generateDescriptionListItems(node, context, ref);
  final options = generateOptionsListItems(node, context, ref);
  return [
    SliverList(
        delegate: SliverChildBuilderDelegate(
            (context, index) => Padding(
                  padding: const EdgeInsetsDirectional.only(
                      start: 20.0, top: 0.0, end: 14.0, bottom: 0.0),
                  child: description[index],
                ),
            childCount: description.length)),
    SliverList(
        delegate: SliverChildBuilderDelegate((context, index) => options[index],
            childCount: options.length))
  ];
}

List<Widget> generateListViews(Node node, BuildContext context, WidgetRef ref) {
  final description = generateDescriptionListItems(node, context, ref);
  final options = generateOptionsListItems(node, context, ref);
  return [
    ListView.builder(
      itemBuilder: (context, index) => Padding(
        padding: const EdgeInsetsDirectional.only(
            start: 20.0, top: 0.0, end: 14.0, bottom: 0.0),
        child: description[index],
      ),
      itemCount: description.length,
    ),
    ListView.builder(
      itemBuilder: (context, index) => options[index],
      itemCount: options.length,
    )
  ];
}

Widget imageViewer(String imageUrl, BuildContext context, WidgetRef ref) {
  return GestureDetector(
      onTap: () {
        ref.read(selectedImageProvider.notifier).state = imageUrl;
        Navigator.push(context,
            CupertinoPageRoute(builder: (context) => const ImageViewer()));
      },
      child: Hero(
        tag: imageUrl,
        child: Container(
          height: 200.0,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(20.0)),
          clipBehavior: Clip.hardEdge,
          child: CachedNetworkImage(
            imageUrl: imageUrl,
            fit: BoxFit.cover,
          ),
        ),
      ));
}
