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
    return Dialog(
      insetPadding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.1),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.3,
        height: MediaQuery.of(context).size.height * 0.4,
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                widget.edicao ? 'Atualizar Cardápio' : 'Adicionar Cardápio',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40.0),
                child: Input(
                  controller: controller,
                  label: Text("Nome"),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('Cancelar'),
                  ),
                  SizedBox(width: 120),
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
                      style: TextStyle(color: Theme.of(context).colorScheme.onTertiary),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
