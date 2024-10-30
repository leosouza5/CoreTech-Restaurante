import 'package:core_tech/features/users/controller/users_controllers.dart';
import 'package:core_tech/global/components/dropdown.dart';
import 'package:core_tech/global/components/input.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ModalNovoUsuario extends StatefulWidget {
  final bool edicao;
  final int? id;

  final String? nome;
  final String? tipoUsuario;
  const ModalNovoUsuario({super.key, this.edicao = false, this.id, this.nome, this.tipoUsuario});

  @override
  State<ModalNovoUsuario> createState() => _ModalNovoUsuarioState();
}

class _ModalNovoUsuarioState extends State<ModalNovoUsuario> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController controllerNome = TextEditingController();

  final TextEditingController controllerSenha = TextEditingController();
  String tipoUsuario = '';

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        if (widget.edicao) {
          controllerNome.text = widget.nome!;
          tipoUsuario = widget.tipoUsuario!;
        }
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.edicao ? 'Editar Usuário' : 'Criar Usuário'),
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
            if (!widget.edicao)
              Input(
                validator: (value) {
                  if (value != null && value.isNotEmpty) {
                    return null;
                  } else {
                    return "Informe uma senha válida";
                  }
                },
                controller: controllerSenha,
                label: Text("Senha"),
                senha: true,
              ),
            DropDown(
              value: widget.tipoUsuario,
              validator: (value) {
                if (value != null && value.isNotEmpty) {
                  return null;
                } else {
                  return "Escolha um tipo de Usuário";
                }
              },
              label: Text("Tipo de Usuário"),
              items: [
                DropdownMenuItem(child: Text("Garçom"), value: "G"),
                DropdownMenuItem(child: Text("Caixa"), value: "C"),
              ],
              onChanged: (value) {
                tipoUsuario = value!;
              },
            )
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
            final controller = context.read<UsersControllers>();

            if (formKey.currentState!.validate()) {
              if (widget.edicao) {
                controller.atualizaUsuario(
                    context,
                    {
                      "nome": controllerNome.text,
                      "tipo_usuario": tipoUsuario,
                    },
                    widget.id!);
              } else {
                controller.criarUsuario(context, {
                  "nome": controllerNome.text,
                  "senha": controllerSenha.text,
                  "tipo_usuario": tipoUsuario,
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
