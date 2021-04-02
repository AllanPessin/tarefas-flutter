import 'package:flutter/material.dart';
import 'package:tarefas/models/tarefa.model.dart';
import 'package:tarefas/repositories/tarefas.repositories.dart';

class Lista extends StatefulWidget {
  @override
  _ListaState createState() => _ListaState();
}

class _ListaState extends State<Lista> {
  final repository = TarefaRepositories();

  List<Tarefa> tarefas;

  @override
  initState() {
    super.initState();
    this.tarefas = repository.read();
  }

  Future adicionarTarefa(BuildContext context) async {
    var result = await Navigator.of(context).pushNamed('/nova');
    if (result != null && result == true) {
      setState(() {
        this.tarefas = repository.read();
      });
    }
  }

  Future<bool> confirmDelete(BuildContext context) async {
    return showDialog(
      context: context,
      barrierDismissible: true,
      builder: (_) {
        return AlertDialog(
          title: Text("Confirmar exclusão?"),
          actions: [
            FlatButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: Text("NÃO")
            ),
            FlatButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: Text("SIM")
            ),
          ],
        );
      },
    );
  }

  var canEdit = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Lista de Tarefas"),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.edit), 
            onPressed: () => setState(() => canEdit = !canEdit)
          )
        ],
      ),
      body: ListView.builder(
        itemCount: tarefas.length,
        itemBuilder: (_, indice) {
          var tarefa = tarefas[indice];
          return Dismissible(
            key: Key(tarefa.texto),
            onDismissed: (_) {
              repository.delete(tarefa.texto);
              setState(() {
                this.tarefas.remove(tarefa);
              });
            },
            confirmDismiss: (_) => confirmDelete(context),
            background: Container(
              color: Colors.red,
            ),
            child: CheckboxListTile(
              title: Row(
                children: [
                  canEdit
                    ? IconButton(
                      icon: Icon(Icons.edit), 
                      onPressed: () async {
                        var result = await Navigator
                        .of(context)
                        .pushNamed('/edita', arguments: tarefa);
                      if (result) {
                        setState(() => this.tarefas = repository.read());
                      }
                    })
                    : Container (), 
                Text(
                  tarefa.texto,
                  style: TextStyle(
                    decoration: tarefa.finalizada
                        ? TextDecoration.lineThrough
                        : TextDecoration.none,
                    ), 
                  ),
                ]
              ),
              value: tarefa.finalizada,
              onChanged: (value) {
                setState(() => tarefa.finalizada = value);
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => adicionarTarefa(context),
        child: Icon(Icons.add),
      ),
    );
  }
}
