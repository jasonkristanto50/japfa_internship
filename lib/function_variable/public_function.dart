import 'package:flutter/material.dart';

void fadeNavigation(BuildContext context,
    {Duration? transitionDuration, required Widget targetNavigation}) {
  transitionDuration ??= const Duration(milliseconds: 500);

  Navigator.of(context).push(
    PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => targetNavigation,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: animation,
          child: child,
        );
      },
      transitionDuration: transitionDuration,
    ),
  );
}

Widget buildTextField(String label, TextEditingController controller,
    {bool isPassword = false}) {
  return TextField(
    controller: controller,
    obscureText: isPassword,
    decoration: InputDecoration(
      labelText: label,
      border: const OutlineInputBorder(),
    ),
    cursorColor: const Color.fromARGB(255, 48, 48, 48),
  );
}
