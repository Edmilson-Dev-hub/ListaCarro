import 'package:flutter/material.dart';
import 'Carro.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Carro> listaDeCarros = [];

  var controllerNome = TextEditingController();
  var controllerAno = TextEditingController();
  var controllerPreco = TextEditingController();
  var controllerEdit = TextEditingController();

  // ADICIONAR ITEM NA LISTA
  void addItem(String nome, String ano, String preco) {
    setState(() {
      listaDeCarros.add(Carro(nome, ano, preco));
      controllerNome.clear();
      controllerAno.clear();
      controllerPreco.clear();
    });
  }

  // REMOVER ITEM DA LISTA
  void removerItem(int indexItem) {
    showDialog(
      context: context,
      builder: ((context) => AlertDialog(
        title: Text("Excluindo item"),
        content: Text(
          "Deseja remover o item ${listaDeCarros[indexItem].nome} ?",
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              setState(() {
                listaDeCarros.removeAt(indexItem);
              });
              Navigator.of(context).pop();
            },
            child: Text("Sim"),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text("Não"),
          ),
        ],
      )),
    );
  }

  // EDITAR ITEM DA LISTA
  void editarItem(int indiceItem) {
    setState(() {
      controllerEdit.text = listaDeCarros[indiceItem].nome;
    });
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Editar o item ${listaDeCarros[indiceItem].nome}?"),
        content: TextField(controller: controllerEdit),
        actions: [
          ElevatedButton(
            onPressed: () {
              String novoTexto = controllerEdit.text;
              setState(() {
                listaDeCarros[indiceItem].nome = novoTexto;
                Navigator.of(context).pop();
                controllerNome.clear();
              });
            },
            child: Text("atualizar"),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text("Cancelar"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Lista de carros 1.0")),
      body: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: controllerNome,
                  decoration: InputDecoration(hintText: "Nome"),
                ),
              ),
              Expanded(
                child: TextField(
                  controller: controllerAno,
                  decoration: InputDecoration(hintText: "Ano"),
                ),
              ),
              Expanded(
                child: TextField(
                  controller: controllerPreco,
                  decoration: InputDecoration(hintText: "Preço"),
                ),
              ),
              GestureDetector(
                child: Icon(Icons.add),
                onTap: () {
                  addItem(
                    controllerNome.text,
                    controllerAno.text,
                    controllerPreco.text,
                  );
                },
              ),
            ],
          ),
          Expanded(
            child: ListView.builder(
              itemCount: listaDeCarros.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(listaDeCarros[index].nome),
                  subtitle: Text(
                    "Ano: ${listaDeCarros[index].ano} | Preço: $listaDeCarros[index].preco}",
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () {
                          editarItem(index);
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          removerItem(index);
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
