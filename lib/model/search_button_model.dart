import 'package:flutter/material.dart';

class SearchButtonModel extends StatelessWidget {
  final String titleButton;
  final Color colorButton;
  final void Function() functionButton;

  const SearchButtonModel({
    super.key,
    required this.titleButton,
    required this.colorButton,
    required this.functionButton,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: double.infinity,
      margin: const EdgeInsets.symmetric(
        horizontal: 40,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: colorButton,
          ),
          onPressed: functionButton,
          child: Text(
            titleButton,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
