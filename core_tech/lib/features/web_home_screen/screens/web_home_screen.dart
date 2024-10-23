import 'package:core_tech/features/food_menu/screens/food_menu.dart';
import 'package:flutter/material.dart';

import '../components/botao_acao_rapida.dart';

class WebHomeScreen extends StatelessWidget {
  const WebHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 90,
        leadingWidth: 150,
        leading: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 8),
          child: Container(
            height: 100,
            width: 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: const DecorationImage(image: AssetImage('assets/images/logo.webp'), fit: BoxFit.fitWidth),
            ),
          ),
        ),
        actions: [
          const BotaoAcaoRapida(
            icon: Icon(Icons.savings_outlined, size: 30),
            label: "Relatorio",
          ),
          BotaoAcaoRapida(
            label: "Cardapio",
            icon: const Icon(Icons.local_pizza, size: 30),
            onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const FoodMenu(),
                )),
          ),
          const BotaoAcaoRapida(
            label: "Sair",
            icon: Icon(Icons.logout, size: 30),
          ),
        ],
        title: const Text("CoreTech"),
      ),
    );
  }
}
