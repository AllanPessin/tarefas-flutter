import 'package:flutter/material.dart';
import 'package:tarefas/models/tarefa.model.dart';
import 'package:tarefas/repositories/tarefas.repositories.dart';

class NovaPage extends StatelessWidget {
  final _formaKey = GlobalKey<FormState>();
  final _tarefa = Tarefa();
  final _repository = TarefaRepositories();

  onSave(BuildContext context) {
    if (_formaKey.currentState.validate()) {
      _formaKey.currentState.save(); //submit do form
      _repository.create(_tarefa);
      Navigator.of(context).pop(true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.save_rounded),
            onPressed: () => onSave(context),
          ),
          // FlatButton(
          //   onPressed: () => {},
          //   child: Text("Salver",
          //     style: TextStyle(),
          //   )
          // ),
        ],
        title: Text("Nova Tarefa"),
      ),
      body: Container(
        margin: EdgeInsets.all(16),
        child: Form(
          key: _formaKey,
          child: TextFormField(
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
