import 'package:basic_flutter_app/player_model.dart';
import 'player_detail_page.dart';
import 'package:flutter/material.dart';

class PlayerCard extends StatefulWidget {
  final Player player;

  PlayerCard(this.player);

  @override
  _PlayerCardState createState() => _PlayerCardState(player);
}

class _PlayerCardState extends State<PlayerCard> {
  Player player;
  String renderUrl;

  _PlayerCardState(this.player);

  void initState() {
    super.initState();
    renderPlayerPic();
  }

  Widget get playerImage {
    var playerAvatar = new Hero(
      tag: player,
      child: new Container(
        width: 100.0,
        height: 100.0,
        decoration: new BoxDecoration(
            shape: BoxShape.circle,
            image: new DecorationImage(
                fit: BoxFit.cover, image: new NetworkImage(renderUrl ?? ''))),
      ),
    );

    var placeholder = new Container(
      width: 100.0,
      height: 100.0,
      decoration: new BoxDecoration(
          shape: BoxShape.circle,
          gradient: new LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Colors.black54, Colors.black, Colors.blueGrey[600]])),
      alignment: Alignment.center,
      child: new Text(
        'PLAYER',
        textAlign: TextAlign.center,
      ),
    );

    var crossFade = new AnimatedCrossFade(
      firstChild: placeholder,
      secondChild: playerAvatar,
      crossFadeState: renderUrl == null
          ? CrossFadeState.showFirst
          : CrossFadeState.showSecond,
      duration: new Duration(milliseconds: 1000),
    );

    return crossFade;
  }

  void renderPlayerPic() async {
    await player.getImageUrl();
    if (mounted) {
      setState(() {
        renderUrl = player.imageUrl;
      });
    }
  }

  Widget get playerCard {
    return new Positioned(
      right: 0.0,
      child: new Container(
        width: 290,
        height: 115,
        child: new Card(
          color: Colors.black87,
          child: new Padding(
            padding: const EdgeInsets.only(top: 8, bottom: 8, left: 64),
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                new Text(
                  widget.player.name,
                  style: Theme.of(context).textTheme.headline,
                ),
                new Text(
                  widget.player.position,
                  style: Theme.of(context).textTheme.subhead,
                ),
                new Row(
                  children: <Widget>[
                    new Icon(Icons.star),
                    new Text(': ${widget.player.rating}/10')
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  showPlayerDetailPage() {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return new PlayerDetailPage(player);
    }));
  }

  @override
  Widget build(BuildContext context) {
    return new InkWell(
      onTap: () => showPlayerDetailPage(),
      child: new Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: new Container(
          height: 115.0,
          child: new Stack(
            children: <Widget>[
              playerCard,
              new Positioned(top: 7.5, child: playerImage),
            ],
          ),
        ),
      ),
    );
  }
}
