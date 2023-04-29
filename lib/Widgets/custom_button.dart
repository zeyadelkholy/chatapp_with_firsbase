import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  CustomButton({required this.text  , this.ontap });

  String text;
  VoidCallback? ontap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap ,
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(8)),
        height: 60,
        width: double.infinity,
        child: Center(
          child: Text(text),
        ),
      ),
    );
  }
}
