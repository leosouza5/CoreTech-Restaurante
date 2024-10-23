import 'package:core_tech/global/components/botao.dart';
import 'package:core_tech/global/components/input.dart';
import 'package:flutter/material.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
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
              image: DecorationImage(image: AssetImage('assets/images/logo.webp'), fit: BoxFit.fitWidth),
            ),
          ),
        ),
        title: Text("CoreTech"),
      ),
      body: Center(
        child: LayoutBuilder(builder: (context, constraints) {
          return Card(
            elevation: 6,
            child: Container(
              height: constraints.maxHeight / 1.5,
              width: constraints.maxWidth / 2,
              decoration: BoxDecoration(color: Theme.of(context).colorScheme.surfaceContainerHigh, borderRadius: BorderRadius.circular(10)),
              padding: const EdgeInsets.all(16),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      "Bem-vindo a CoreTech",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Theme.of(context).colorScheme.onSurfaceVariant, fontSize: 28),
                    ),
                    Column(
                      children: [
                        Input(
                          label: Text("Usuario"),
                          borderColor: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                        SizedBox(
                          height: 32,
                        ),
                        Input(
                          label: Text("Senha"),
                          senha: true,
                          borderColor: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                      ],
                    ),
                    Align(alignment: Alignment.centerRight, child: Botao())
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
