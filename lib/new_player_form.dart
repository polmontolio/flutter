import 'package:basic_flutter_app/player_model.dart';
import 'package:flutter/material.dart';

class AddPlayerFormPage extends StatefulWidget {
  @override
  _AddPlayerFormPageState createState() => new _AddPlayerFormPageState();
}

class _AddPlayerFormPageState extends State<AddPlayerFormPage> {
  TextEditingController nameController = new TextEditingController();
  TextEditingController locationController = new TextEditingController();
  TextEditingController descriptionController = new TextEditingController();

  void submitPup(BuildContext context) {
    if (nameController.text.isEmpty) {
      Scaffold.of(context).showSnackBar(new SnackBar(
        backgroundColor: Colors.redAccent,
        content: new Text('Players neeed names!'),
      ));
    } else {
      var newPlayer = new Player(nameController.text, locationController.text,
          descriptionController.text);
      Navigator.of(context).pop(newPlayer);
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Add a new Player'),
        backgroundColor: Colors.black87,
      ),
      body: new Container(
        color: Colors.black54,
        child: new Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 32.0),
          child: new Column(children: [
            new Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: new TextField(
                controller: nameController,
                onChanged: (text) {},
                decoration: new InputDecoration(labelText: 'Nom del jugador'),
              ),
            ),
            new Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: new TextField(
                controller: locationController,
                onChanged: (text) {},
                decoration: new InputDecoration(labelText: "Posicions del jugador"),
              ),
            ),
            new Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: new TextField(
                controller: descriptionController,
                onChanged: (text) {},
                decoration: new InputDecoration(labelText: 'Descripcio del jugador'),
              ),
            ),
            new Padding(
              padding: const EdgeInsets.all(16.0),
              child: new Builder(
                builder: (context) {
                  return new RaisedButton(
                    onPressed: () => submitPup(context),
                    color: Colors.indigoAccent,
                    child: new Text('Enviar jugador'),
                  );
                },
              ),
            )
          ]),
        ),
      ),
    );
  }
}
