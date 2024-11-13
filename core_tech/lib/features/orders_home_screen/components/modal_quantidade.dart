import 'package:core_tech/features/food_menu/controller/food_menu_controller.dart';
import 'package:core_tech/global/components/input.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../controllers/orders_controller.dart';

class ModalQuantidade extends StatefulWidget {
  final bool edicao;
  final Map produto;
  final int index;
  const ModalQuantidade({super.key, this.edicao = false, required this.index, required this.produto});

  @override
  State<ModalQuantidade> createState() => _ModalQuantidadeState();
}

class _ModalQuantidadeState extends State<ModalQuantidade> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController controller = TextEditingController();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final orderController = context.watch<OrdersController>();
    return Dialog(
      insetPadding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.1),
      child: Container(
        constraints: BoxConstraints(
          minWidth: MediaQuery.of(context).size.width * 0.3,
          minHeight: MediaQuery.of(context).size.height * 0.4,
        ),
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.min,
              children: [
                Align(
                  child: Text(
                    widget.edicao ? 'Atualizar quantidade' : 'Adicionar quantidade',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                  ),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 0.0),
                  child: Input(
                    validator: (value) {
                      if (value != null && value.isNotEmpty) {
                        return null;
                      } else {
                        return "Informe uma quantidade valida";
                      }
                    },
                    controller: controller,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly, LengthLimitingTextInputFormatter(2)],
                    label: Text("Quantidade"),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text('Cancelar'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          widget.produto['quantidade'] = controller.text;
                          orderController.listaProdutosDoPedido.add(widget.produto);
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Produto adicionado com sucesso !")));
                          orderController.notifyListeners();
                          Navigator.pop(context);
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
      ),
    );
  }
}
