import 'package:core_tech/features/food_menu/components/modal_novo_produto.dart';
import 'package:core_tech/features/food_menu/components/modal_remove_produto.dart';
import 'package:flutter/material.dart';

class ProdutoLinha extends StatelessWidget {
  final int id;
  final String nome;
  final String descricao;
  final String valor;
  const ProdutoLinha({super.key, required this.nome, required this.descricao, required this.valor, required this.id});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(children: [
          Expanded(
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 30.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(
                      'assets/images/comida.jpg',
                      height: 90,
                      width: 130,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text("Produto"),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              nome,
                              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Divider(color: Theme.of(context).colorScheme.onSurfaceVariant),
                        ],
                      ),
                    )),
                Expanded(
                    flex: 2,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text("Descrição"),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              descricao,
                              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Divider(color: Theme.of(context).colorScheme.onSurfaceVariant),
                        ],
                      ),
                    )),
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text("Valor"),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "R\$ $valor",
                            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Divider(color: Theme.of(context).colorScheme.onSurfaceVariant),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      RawMaterialButton(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        padding: const EdgeInsets.all(12),
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) => ModalRemoveProduto(id: id),
                          );
                        },
                        child: const Icon(Icons.delete),
                      ),
                      RawMaterialButton(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        padding: const EdgeInsets.all(12),
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) => ModalNovoProduto(
                              edicao: true,
                              nome: nome,
                              descricao: descricao,
                              valor: valor,
                              id: id,
                              idCardapio: 0,
                            ),
                          );
                        },
                        child: const Icon(Icons.edit),
                      ),
                    ],
                  ),
                )
              ],
            ),
          )
        ]));
  }
}
