import 'package:core_tech/features/auth_screen/controller/auth_controller.dart';
import 'package:core_tech/global/components/botao.dart';
import 'package:core_tech/global/components/input.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  @override
  Widget build(BuildContext context) {
    final controller = context.watch<AuthController>();
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
              width: defaultTargetPlatform == TargetPlatform.android || defaultTargetPlatform == TargetPlatform.iOS ? constraints.maxWidth * 0.9 : constraints.maxWidth / 2,
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
                    Form(
                      key: controller.formKey,
                      child: Column(
                        children: [
                          Input(
                            validator: (value) {
                              if (value != null && value.isNotEmpty) {
                                return null;
                              } else {
                                return "Informe um usuário válido";
                              }
                            },
                            label: Text("Usuario"),
                            controller: controller.controllerUsuario,
                            borderColor: Theme.of(context).colorScheme.onSurfaceVariant,
                          ),
                          SizedBox(
                            height: 32,
                          ),
                          Input(
                            validator: (value) {
                              if (value != null && value.isNotEmpty) {
                                return null;
                              } else {
                                return "Informe uma senha válida";
                              }
                            },
                            controller: controller.controllerSenha,
                            label: Text("Senha"),
                            senha: true,
                            borderColor: Theme.of(context).colorScheme.onSurfaceVariant,
                          ),
                        ],
                      ),
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
