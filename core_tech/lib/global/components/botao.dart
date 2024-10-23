import 'package:core_tech/features/web_home_screen/screens/web_home_screen.dart';
import 'package:flutter/material.dart';

class Botao extends StatelessWidget {
  const Botao({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => WebHomeScreen(),
            ));
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Theme.of(context).colorScheme.onSurfaceVariant,
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
        fixedSize: const Size(300, 50),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        elevation: 4,
      ),
      child: Text(
        "Entrar",
        style: TextStyle(color: Theme.of(context).colorScheme.surface),
      ),
    );
  }
}
