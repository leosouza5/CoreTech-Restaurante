import 'package:core_tech/features/food_menu/controller/food_menu_controller.dart';
import 'package:core_tech/global/components/input.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ModalNovoCardapio extends StatefulWidget {
  final bool edicao;
  final String? nomeCardapio;
  final int? idCardapio;
  const ModalNovoCardapio({super.key, this.edicao = false, this.nomeCardapio, this.idCardapio});

  @override
  State<ModalNovoCardapio> createState() => _ModalNovoCardapioState();
}

class _ModalNovoCardapioState extends State<ModalNovoCardapio> {
  final TextEditingController controller = TextEditingController();
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        controller.text = widget.nomeCardapio!;
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.edicao ? 'Atualizar Cardápio' : 'Adicionar Cardápio'),
      content: Input(
        controller: controller,
        label: Text("Nome"),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('Cancelar'),
        ),
        ElevatedButton(
          onPressed: () {
            final controllerMenu = context.read<FoodMenuController>();
            if (controller.text.isNotEmpty) {
              if (widget.edicao) {
                controllerMenu.editaCardapio(context, {"nome": controller.text}, widget.idCardapio!);
              } else {
                controllerMenu.novoCardapio(controller.text, context);
              }
            }
          },
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            backgroundColor: Theme.of(context).colorScheme.tertiary,
          ),
          child: Text(
            'Salvar',
            style: TextStyle(
              color: Theme.of(context).colorScheme.onTertiary,
            ),
          ),
        ),
      ],
    );
  }
}
