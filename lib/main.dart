import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math';

import 'player_model.dart';
import 'player_list.dart';
import 'new_player_form.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Valoramos jugadores',
      theme: ThemeData(brightness: Brightness.dark),
      home: MyHomePage(
        title: 'Valoramos jugadores',
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;
  MyHomePage({Key key, this.title}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  var list;
  var refreshKey = GlobalKey<RefreshIndicatorState>();

  @override
  void initState() {
    super.initState();
    refreshList();
  }

  Future<Null> refreshList() async {
    refreshKey.currentState?.show(atTop: false);
    await Future.delayed(Duration(seconds: 0));

    setState(() {
      list = initialPlayers;
    });

    return null;
  }

  List<Player> initialPlayers = []
    ..add(Player('Ter Stegen', 'POR', 'Marc-André ter Stegen, más conocido como Ter Stegen, es un futbolista alemán, juega como guardameta en el'
        ' F. C. Barcelona de la Primera División de España, y es la selección alemana, con el que es internacional absoluto.'))
    ..add(Player('Jordi Alba', 'LI', 'Jorge Alba Ramos, más conocido como Jordi Alba, o simplemente Alba, es un futbolista español que juega como'
        ' defensa en el Fútbol Club Barcelona de la Primera División de España. '))
    ..add(Player('Gerard Pique', 'DFC', 'Gerard Piqué Bernabéu es un futbolista español. Juega como defensa y su equipo actual es el Fútbol Club'
        ' Barcelona de la Primera División de España.'))
    ..add(Player('Clement Lenglet', 'DFC',
        'Clément Nicolas Laurent Lenglet es un futbolista francés. Juega como defensa y su equipo actual es el Fútbol Club Barcelona de la LaLiga '
            'Santander de España.​'))
    ..add(Player('Sergi Roberto', 'LD/MC', 'Sergi Roberto Carnicer, más conocido como Sergi Roberto, es un futbolista español que juega como defensa'
        ' o centrocampista en el Fútbol Club Barcelona de la Primera División de España, del cual es cuarto capitán.'))
    ..add(Player('Frenkie De Jong', 'MC/MCD', 'Frenkie de Jong es un futbolista neerlandés. Juega como centrocampista y su equipo actual es el Fútbol'
        ' Club Barcelona de la Primera División de España.​'))
    ..add(Player('Sergio Busquets', 'MCD/MC', 'Sergio Busquets Burgos es un futbolista español que juega como centrocampista en el Fútbol Club Barcelona'
        ' de la Primera División de España, del que es además segundo capitán.​'))
    ..add(Player('Leo Messi', 'ED/DC/MCO','Lionel Andrés Messi Cuccittini, conocido como Leo Messi, es un futbolista argentino que juega como delantero'
        ' o centrocampista'
      'en el FC Barcelona y en la selección Argentina.'));

  Future _showNewPlayerForm() async {
    Player newPlayer = await Navigator.of(context)
        .push(MaterialPageRoute(builder: (BuildContext context) {
      return AddPlayerFormPage();
    }));
    if (newPlayer != null) {
      initialPlayers.add(newPlayer);
    }
  }

  @override
  Widget build(BuildContext context) {
    var key = new GlobalKey<ScaffoldState>();
    return new Scaffold(
      key: key,
      appBar: new AppBar(
        title: new Text(widget.title),
        backgroundColor: Colors.red,
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.only(right: 5.0),
            child: new IconButton(
              icon: new Icon(Icons.refresh),
              onPressed: refreshList,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(right: 5.0),
            child: new IconButton(
              icon: new Icon(Icons.add),
              onPressed: _showNewPlayerForm,
            ),
          ),
        ],
      ),
      body: new Container(
          key: refreshKey,
          decoration: new BoxDecoration(
              gradient: new LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  stops: [
                .1,
                .5,
                .7,
                .9
              ],
                  colors: [
                Colors.indigo[800],
                Colors.indigo[700],
                Colors.red[800],
                Colors.red[900]
              ])),
          child: new Center(
            child: new PlayerList(initialPlayers),
          )),
    );
  }
}
