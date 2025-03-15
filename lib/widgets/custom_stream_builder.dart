import 'package:flutter/material.dart';
import 'package:scan_track/features/home/views/no_data_view.dart';

class CustomStreamBuilder<T> extends StatelessWidget {
  final Stream<List<T>>? stream; // Generic stream
  final Widget Function(List<T>) builderFunction; // Custom builder function

  const CustomStreamBuilder({
    Key? key,
    required this.stream,
    required this.builderFunction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<T>>(
      stream: stream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Padding(
              padding: EdgeInsets.all(50),
              child: Center(child: CircularProgressIndicator()));
        }
        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: NoDataView());
        }

        return builderFunction(snapshot.data!); // Return custom widget
      },
    );
  }
}
