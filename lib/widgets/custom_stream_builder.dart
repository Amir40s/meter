import 'dart:developer';

import 'package:flutter/material.dart';

import 'custom_loading.dart';

/// `CustomStreamBuilder<T>` is a reusable widget that listens to a [Stream<T>] and
/// builds UI based on the stream's current state. It handles loading, error, and data states,
/// providing a simplified way to work with streams in Flutter apps.
///
/// ## Parameters:
/// - `stream`: The [Stream<T>] to listen to. It emits events of type [T].
/// - `builder`: A function that builds the widget's main UI part. It takes the [BuildContext] and
///   an optional data of type [T] (which can be null) as parameters.
/// - `loadingWidget`: The widget to display while the stream is in the process of emitting the first non-null value.
/// - `errorBuilder`: (Optional) A function that builds the widget to display in case of an error. It takes the [BuildContext]
///   and an error object as parameters. If not provided, a default error message is displayed.
/// - `defaultWidget`: (Optional) The widget to display before the stream emits any data or when the stream data is null.
///
/// ## Example Usage:
/// ```dart
/// CustomStreamBuilder<int>(
///   stream: myStream,
///   builder: (context, data) {
///     // Handle null data and build UI accordingly
///     if (data == null) return Center(child: Text('No data yet'));
///     return Center(child: Text('Data: $data'));
///   },
///   loadingWidget: CircularProgressIndicator(),
///   errorBuilder: (context, error) => Center(child: Text('Oops, something went wrong: $error')),
///   defaultWidget: Center(child: Text('Awaiting data...')),
/// )
/// ```
///
/// This widget abstracts away the common boilerplate associated with using `StreamBuilder`,
/// including handling loading states and errors, making your widget tree cleaner and more readable.

class CustomStreamBuilder<T> extends StatelessWidget {
  final Stream<T>? stream;
  final Widget Function(BuildContext context, T? data) builder;
  final Widget? loadingWidget;
  final Widget Function(BuildContext context, Object? error)? errorBuilder;
  final Widget? defaultWidget;

  const CustomStreamBuilder({
    super.key,
    required this.stream,
    this.errorBuilder,
    this.defaultWidget,
    required this.builder,
    this.loadingWidget,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<T>(
      stream: stream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // If a custom loading widget is provided, use it. Otherwise, use a default.
          return loadingWidget ?? const CustomLoading();
        }
        if (snapshot.hasError) {
          // If an error builder is provided, use it. Otherwise, display the error in a default widget.
          log("Error is ${snapshot.error}");
          return errorBuilder != null
              ? errorBuilder!(context, snapshot.error)
              : Center(child: Text('Error: ${snapshot.error}'));
        }
        if (snapshot.hasData) {
          // If there's data, and it's not null, use the builder to build the UI.
          // This part needs to ensure that the data is not null.
          T? data = snapshot.data;
          if (data != null) {
            return builder(context, data);
          }
        }
        // If the code reaches here, it means there's either no data or the data is null.
        // Display the defaultWidget if provided, or a default message.
        return defaultWidget ?? const Center(child: Text('No data available'));
      },
    );
  }
}
