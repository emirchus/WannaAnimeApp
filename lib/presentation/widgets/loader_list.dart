import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:wannaanime/presentation/ui/loading.dart';
import 'package:wannaanime/presentation/widgets/scroll_behaviour.dart';


class LoaderList<T> extends StatefulWidget {
  final Future<List<T>> Function(int start, int end) future;
  final Function(List<T>) onData;
  final Widget Function(BuildContext context, T item) builder;

  const LoaderList({Key? key, required this.future, required this.onData, required this.builder}) : super(key: key);


  @override
  State<LoaderList<T>> createState() => _LoaderListState<T>();
}

class _LoaderListState<T> extends State<LoaderList<T>> {

  Set<T> data = <T>{};
  ScrollController controller = ScrollController();
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    controller.addListener(onScroll);
  }

  @override
  void dispose() {
    controller.removeListener(onScroll);
    controller.dispose();
    super.dispose();
  }

  onScroll() async {
    if(controller.position.pixels == controller.position.maxScrollExtent) {
      await Loading.show(context, () async {
        setState(() {
          isLoading = true;
        });
        data.addAll(await widget.future(data.length, 20));
        widget.onData([]);
        log('onScroll ${data.length}');
        setState(() {
          isLoading = false;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<T>>(
      future: widget.future(1, 20),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: const <Widget>[
              Center(child: CircularProgressIndicator()),
            ],
          );
        } else if (snapshot.data == null || snapshot.data!.isEmpty) {
          return Column(
            children: const <Widget>[
              Text(
                "No Results Found TwT",
              ),
            ],
          );
        } else {
          data.addAll(snapshot.data!);
          return ScrollConfiguration(
            behavior: const NoGlowBehaviour(),
            child: ListView.builder(
              itemCount: data.length,
              controller: controller,
              itemBuilder: (context, index) {
                final object = data.toList()[index];
                return widget.builder(context, object);
              },
            ),
          );
        }
      },
    );
  }
}