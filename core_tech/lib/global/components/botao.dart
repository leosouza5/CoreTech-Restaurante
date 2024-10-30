import 'package:core_tech/features/auth_screen/controller/auth_controller.dart';
import 'package:core_tech/global/enum/enum.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Botao extends StatelessWidget {
  const Botao({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<AuthController>();
    return ElevatedButton(
      onPressed: controller.authState == LocalState.loading
          ? null
          : () {
              controller.validaLogin(context);
            },
      style: ElevatedButton.styleFrom(
        backgroundColor: Theme.of(context).colorScheme.onSurfaceVariant,
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
        fixedSize: const Size(300, 50),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        elevation: 4,
      ),
      child: Builder(builder: (context) {
        if (controller.authState == LocalState.loading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return Text(
            "Entrar",
            style: TextStyle(color: Theme.of(context).colorScheme.surface),
          );
        }
      }),
    );
  }
}
