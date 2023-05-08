import 'package:flutter/material.dart';

class DrawTile extends StatelessWidget {
   DrawTile({super.key, required this.icon, required this.text, required this.controller, required this.page});

  IconData icon;
  String text;
  PageController controller;
  int page;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          Navigator.of(context).pop();
          controller.jumpToPage(page);
        },
        child: Container(
          height: 60,
          child: Row(
            children: [
              Icon(icon, 
                size: 32,
                color: controller.page!.round() == page? Theme.of(context).primaryColor: Colors.white,),
               const SizedBox(width: 32),
              Text(text,
                style: TextStyle(
                  fontSize: 16,
                  color: controller.page!.round() == page? Theme.of(context).primaryColor: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}