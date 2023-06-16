import 'package:flutter/material.dart';

class EmptyWidget extends StatelessWidget {
  const EmptyWidget({
    super.key,
    required this.message,
  });

  final String message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Tidak ada post',
        style: Theme.of(context).textTheme.bodyLarge,
      ),
    );
  }
}
