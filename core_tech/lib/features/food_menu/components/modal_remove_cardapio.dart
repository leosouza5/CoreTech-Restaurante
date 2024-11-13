import 'package:core_tech/features/food_menu/controller/food_menu_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ModalRemoveCardapio extends StatelessWidget {
  final int id;
  const ModalRemoveCardapio({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Remover cardápio'),
      content: const Text("Tem certeza que deseja remover o cardápio ?"),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Cancelar'),
        ),
        ElevatedButton(
          onPressed: () {
            final controllerMenu = context.read<FoodMenuController>();

            controllerMenu.removerCardapio(context, id);
          },
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            backgroundColor: Theme.of(context).colorScheme.tertiary,
          ),
          child: Text(
            'Confirmar',
            style: TextStyle(
              color: Theme.of(context).colorScheme.onTertiary,
            ),
          ),
        ),
      ],
    );
  }
}
