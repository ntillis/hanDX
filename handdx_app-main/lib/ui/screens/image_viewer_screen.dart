import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:handdx/controllers/image_view_controller.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ImageViewer extends HookConsumerWidget {
  const ImageViewer({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final imageUrl = ref.watch(selectedImageProvider.notifier).state;

    if (imageUrl == null) {
      return const Text("No image selected");
    }

    return WillPopScope(
        child: CupertinoPageScaffold(
          navigationBar: const CupertinoNavigationBar(middle: Text("Image")),
          child: Center(
            child: InteractiveViewer(
                constrained: false,
                child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    child: Center(
                        child: Hero(
                      tag: imageUrl,
                      child: Container(
                          clipBehavior: Clip.none,
                          child: CachedNetworkImage(imageUrl: imageUrl)),
                    )))),
          ),
        ),
        onWillPop: () async {
          ref.read(selectedImageProvider.notifier).state = null;
          return true;
        });
  }
}
