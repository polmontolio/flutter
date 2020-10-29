import 'package:basic_flutter_app/player_card.dart';
import 'package:flutter/material.dart';

import 'player_model.dart';

class PlayerList extends StatelessWidget {
  final List<Player> players;
  PlayerList(this.players);

  @override
  Widget build(BuildContext context) {
    return _buildList(context);
  }

  ListView _buildList(context) {
    return new ListView.builder(
      itemCount: players.length,
      itemBuilder: (context, int) {
        return new PlayerCard(players[int]);
      },
    );
  }
}
