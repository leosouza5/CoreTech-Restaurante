import 'package:core_tech/features/food_menu/controller/food_menu_controller.dart';
import 'package:core_tech/global/components/input.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ModalNovoProduto extends StatefulWidget {
  final bool edicao;
  final int idCardapio;
  final int? id;

  final String? nome;
  final String? descricao;
  final String? valor;
  const ModalNovoProduto({super.key, required this.idCardapio, this.edicao = false, this.nome, this.descricao, this.valor, this.id});

  @override
  State<ModalNovoProduto> createState() => _ModalNovoProdutoState();
}

class _ModalNovoProdutoState extends State<ModalNovoProduto> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController controllerNome = TextEditingController();

  final TextEditingController controllerDescricao = TextEditingController();

  final TextEditingController controllerValor = TextEditingController();
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        if (widget.edicao) {
          controllerNome.text = widget.nome!;
          controllerDescricao.text = widget.descricao!;
          controllerValor.text = widget.valor!;
        }
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(widget.nome);
    print(widget.descricao);
    print(widget.valor);
    return AlertDialog(
      title: Text(widget.edicao ? 'Atualizar Produto' : 'Adicionar Produto'),
      content: Form(
        key: formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Input(
              validator: (value) {
                if (value != null && value.isNotEmpty) {
                  return null;
                } else {
                  return "Informe um nome válido";
                }
              },
              controller: controllerNome,
              label: Text("Nome"),
            ),
            Input(
              validator: (value) {
                if (value != null && value.isNotEmpty) {
                  return null;
                } else {
                  return "Informe uma descrição válida";
                }
              },
              controller: controllerDescricao,
              label: Text("Descrição"),
            ),
            Input(
              validator: (value) {
                if (value != null && value.isNotEmpty) {
                  return null;
                } else {
                  return "Informe um valor válido";
                }
              },
              controller: controllerValor,
              label: Text("Valor"),
            ),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(); // Fecha o alerta
          },
          child: Text('Cancelar'),
        ),
        ElevatedButton(
          onPressed: () {
            final controllerMenu = context.read<FoodMenuController>();

            if (formKey.currentState!.validate()) {
              if (widget.edicao) {
                controllerMenu.editaProduto(
                  context,
                  {
                    "nome": controllerNome.text,
                    "descricao": controllerDescricao.text,
                    "valor": controllerValor.text,
                    "id_cardapio": widget.idCardapio,
                  },
                  widget.id!,
                );
              } else {
                controllerMenu.adicionarProdutoAoCardapio(context, {
                  "nome": controllerNome.text,
                  "descricao": controllerDescricao.text,
                  "valor": controllerValor.text,
                  "id_cardapio": widget.idCardapio,
                });
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