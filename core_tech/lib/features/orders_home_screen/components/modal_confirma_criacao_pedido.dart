import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../global/enum/enum.dart';
import '../controllers/orders_controller.dart';

class ModalConfirmaCriacaoPedido extends StatefulWidget {
  final bool edicao;
  final int? idPedido;
  const ModalConfirmaCriacaoPedido({super.key, this.edicao = false, this.idPedido});

  @override
  State<ModalConfirmaCriacaoPedido> createState() => _ModalConfirmaCriacaoPedidoState();
}

class _ModalConfirmaCriacaoPedidoState extends State<ModalConfirmaCriacaoPedido> {
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
          minHeight: MediaQuery.of(context).size.height * 0.3,
        ),
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.min,
            children: [
              Center(
                child: Text(
                  "Enviar pedido ?",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
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
                      orderController.enviaPedido(context, edicao: widget.edicao, idPedido: widget.idPedido);
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      backgroundColor: Theme.of(context).colorScheme.tertiary,
                    ),
                    child: orderController.enviaProdutosState == LocalState.loading
                        ? Center(
                            child: CircularProgressIndicator(),
                          )
                        : Text(
                            'Enviar',
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
