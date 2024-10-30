import 'package:core_tech/features/users/components/modal_deleta_usuario.dart';
import 'package:core_tech/features/users/components/modal_novo_usuario.dart';
import 'package:core_tech/features/users/controller/users_controllers.dart';
import 'package:core_tech/global/enum/enum.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../web_home_screen/components/botao_acao_rapida.dart';

class Users extends StatefulWidget {
  const Users({super.key});

  @override
  State<Users> createState() => UsersState();
}

class UsersState extends State<Users> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        context.read<UsersControllers>().recuperarUsuarios();
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<UsersControllers>();
    return Scaffold(
        extendBodyBehindAppBar: false,
        appBar: AppBar(
          toolbarHeight: 90,
          leadingWidth: 150,
          leading: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 8),
            child: Container(
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(image: AssetImage('assets/images/logo.webp'), fit: BoxFit.fitWidth),
              ),
            ),
          ),
          centerTitle: true,
          title: Text("Usuários"),
          actions: [
            BotaoAcaoRapida(
              icon: Icon(Icons.exit_to_app, size: 30),
              label: "Voltar",
              onPressed: () => Navigator.pop(context),
            ),
          ],
        ),
        body: Center(
          child: Container(
              width: MediaQuery.sizeOf(context).width * .8,
              height: MediaQuery.sizeOf(context).height * .8,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0), // Adiciona espaçamento ao redor do botão
                      child: ElevatedButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) => ModalNovoUsuario(),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            minimumSize: Size(150, 60),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                            backgroundColor: Theme.of(context).colorScheme.tertiary,
                          ),
                          child: Text(
                            "Novo Usuário",
                            style: TextStyle(color: Theme.of(context).colorScheme.onTertiary),
                          )),
                    ),
                  ),
                  Expanded(
                    child: Builder(
                      builder: (context) {
                        switch (controller.listaUserState) {
                          case LocalState.error:
                            return Center(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    controller.erro,
                                    style: TextStyle(fontSize: 25),
                                  ),
                                  SizedBox(height: 100),
                                  RawMaterialButton(
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                    padding: const EdgeInsets.all(12),
                                    onPressed: () {
                                      controller.recuperarUsuarios();
                                    },
                                    child: Icon(Icons.refresh),
                                  ),
                                ],
                              ),
                            );
                          case LocalState.loading:
                            return Center(child: CircularProgressIndicator());
                          case LocalState.idle:
                            return Container();
                          case LocalState.sucesso:
                            return ListView.builder(
                              itemCount: controller.usuarios.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                                  child: Card(
                                    child: ListTile(
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                      tileColor: Theme.of(context).colorScheme.surface,
                                      leading: Icon(Icons.person),
                                      trailing: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          IconButton(
                                              onPressed: () {
                                                showDialog(
                                                  context: context,
                                                  builder: (context) => ModalNovoUsuario(
                                                    edicao: true,
                                                    nome: controller.usuarios[index]['nome'],
                                                    tipoUsuario: controller.usuarios[index]['tipo_usuario'],
                                                    id: controller.usuarios[index]['id'],
                                                  ),
                                                );
                                              },
                                              icon: Icon(Icons.edit)),
                                          IconButton(
                                              onPressed: () {
                                                showDialog(
                                                  context: context,
                                                  builder: (context) => ModalDeletaUsuario(
                                                    id: controller.usuarios[index]['id'],
                                                  ),
                                                );
                                              },
                                              icon: Icon(Icons.delete)),
                                        ],
                                      ),
                                      title: Text("Nome Usuario"),
                                      subtitle: Text(controller.usuarios[index]['nome']),
                                    ),
                                  ),
                                );
                              },
                            );
                        }
                      },
                    ),
                  ),
                ],
              )),
        ));
  }
}
