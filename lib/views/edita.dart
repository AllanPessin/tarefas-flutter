import 'package:flutter/material.dart';
import 'package:tarefas/models/tarefa.model.dart';
import 'package:tarefas/repositories/tarefas.repositories.dart';

class EditaPage extends StatelessWidget {
  final _formaKey = GlobalKey<FormState>();
  final _tarefa = Tarefa();
  final _repository = TarefaRepositories();

  onSave(BuildContext context, Tarefa tarefa) {
    if (_formaKey.currentState.validate()) {
      _formaKey.currentState.save(); //submit do form
      _repository.update(_tarefa, tarefa);
      Navigator.of(context).pop(true);
    }
  }

  @override
  Widget build(BuildContext context) {

    Tarefa tarefa = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.save_rounded),
            onPressed: () => onSave(context, tarefa),
          ),
          // FlatButton(
          //   onPressed: () => {},
          //   child: Text("Salver",
          //     style: TextStyle(),
          //   )
          // ),
        ],
        title: Text("Editar Tarefa"),
      ),
      body: Container(
        margin: EdgeInsets.all(16),
        child: Form(
          key: _formaKey,
          child: TextFormField(
            initialValue: tarefa.texto,
            decoration: InputDecoration(
              labelText: "Descrição da tarefa",
              border: OutlineInputBorder(),
            ),
            onSaved: (value) => _tarefa.texto = value,
            validator: (value) => value.isEmpty ? "Campo obrigatório" : null,
          ),
        ),
      ),
    );
  }
}
