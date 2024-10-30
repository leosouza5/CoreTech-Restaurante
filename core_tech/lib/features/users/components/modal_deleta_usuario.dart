import 'package:core_tech/features/users/controller/users_controllers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ModalDeletaUsuario extends StatelessWidget {
  final int id;
  const ModalDeletaUsuario({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Remover usuário'),
      content: const Text("Tem certeza que deseja remover o usuário ?"),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Cancelar'),
        ),
        ElevatedButton(
          onPressed: () {
            final controllerMenu = context.read<UsersControllers>();

            controllerMenu.deletaUsuario(context, id);
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
