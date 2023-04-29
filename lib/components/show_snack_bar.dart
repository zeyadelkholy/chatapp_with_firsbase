import 'package:flutter/material.dart';

void ShowSnackBar(BuildContext context, String massage) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      padding: EdgeInsets.all(15),
      content: Text(massage),
    ),
  );
}