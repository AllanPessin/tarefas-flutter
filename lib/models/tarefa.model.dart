class Tarefa {
  //Atributos
  String id;
  String texto;
  bool finalizada;

  //Construtor
  //todas obrigatorias (this.id, this.texto, this.finalizada) com chaves em volta
  //não é obrigatoria
  Tarefa({this.id,this.texto, this.finalizada = false});
}