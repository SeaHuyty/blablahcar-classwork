import 'package:flutter/material.dart';

class BlaButton extends StatelessWidget {
  final bool isPrimary;
  final String title;
  final IconData? icon;
  final VoidCallback? onPressed;

  const BlaButton({
    super.key,
    required this.isPrimary,
    this.icon,
    required this.title,
    this.onPressed
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onPressed,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        width: double.infinity,
        decoration: BoxDecoration(
          color: isPrimary ? Colors.blue : Colors.white,
          border: isPrimary ? null : Border.all(color: const Color.fromARGB(255, 196, 196, 196)),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 8,
          children: [
            if (icon != null)
              Icon(icon, size: 18, color: isPrimary ? Colors.white : Colors.blue,),
            Text(
              title,
              style: TextStyle(color: isPrimary ? Colors.white : Colors.blue, fontSize: 15),
            ),
          ],
        ),
      ),
    );
  }
}
