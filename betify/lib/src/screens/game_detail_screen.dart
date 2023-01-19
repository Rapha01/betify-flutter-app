import 'package:betify/src/services/game_api_service.dart';
import 'package:flutter/material.dart';
import 'package:betify/src/widgets/bottom_navigation.dart';

import '../models/game.dart';

class GameDetailScreen extends StatefulWidget {
  static const String route = 'gameDetail';
  final String? id;
  final GameApiService api = GameApiService();

  GameDetailScreen({required this.id, Key? key}): super(key: key);

  @override
  State<StatefulWidget> createState() => GameDetailScreenState();
}


class GameDetailScreenState extends State<GameDetailScreen> {
  Game? game;

  @override
  void initState() {
    super.initState();
    _fetchGame();
  }

  _fetchGame() async {
    final Game game = await widget.api.fetchGameById(id: widget.id ?? '');
    //print('AAAAA');
    //print(game.title);

    setState(() {
      this.game = game;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: game != null ? 
        ListView(
          children: <Widget>[
            HeaderSection(game: game!),
            TitleSection(game: game!),
            AdditionalInformation(game: game!),
            Padding(
              padding: const EdgeInsets.all(32.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  game!.desc
                )
              )
            ),
            
          ]
        ) : 
        const SizedBox(width: 0, height: 0),
      appBar: AppBar(
        title: const Text('Game Detail')
      ),
      bottomNavigationBar: BottomNavigation(),
    );
  }
}

class AdditionalInformation extends StatelessWidget {
  final Game game;

  const AdditionalInformation({required this.game, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color color = Theme.of(context).primaryColor;

    buildColumn(String label, String text) {
      return Column(
        children: <Widget>[
          Text(
            label,
            style: TextStyle(
              fontSize: 13.0,
              fontWeight: FontWeight.w400,
              color: color
            )
          ),
          Text(
            text,
            style: TextStyle(
              fontSize: 25.0,
              fontWeight: FontWeight.w500,
              color: color
            )
          )
        ],
      );
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        buildColumn('Currency', game.currencyName),
        buildColumn('Language', game.language),
        buildColumn('Public', game.isPublic.toString())
      ]
    );
  }
}

class TitleSection extends StatelessWidget {
  final Game game;

  const TitleSection({required this.game, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color color = Theme.of(context).primaryColor;

    return Padding(
      padding: const EdgeInsets.all(30),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  game.title,
                  style: const TextStyle(fontWeight: FontWeight.bold)
                ),
                Text(
                  game.desc,
                  style: TextStyle(color: Colors.grey[500])
                )
              ],
            ),
          ),
          Icon(
            Icons.people,
            color: color
          ),
          Text('${game.memberCount} People')
        ],
      )
    );
  }
}



class HeaderSection extends StatelessWidget {
  final Game game;

  const HeaderSection({required this.game, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Stack(
      alignment: AlignmentDirectional.bottomStart,
      children: <Widget>[
        Image.network(game.bannerUrl, width: width, height: 240.0, fit: BoxFit.cover),
        Container(
          width: width,
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.3)
          ),
          child: Padding(
            padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
            child: ListTile(
              leading: const CircleAvatar(
                radius: 30.0,
                backgroundImage: NetworkImage('https://img.freepik.com/premium-vector/anonymous-user-circle-icon-vector-illustration-flat-style-with-long-shadow_520826-1931.jpg?w=2000'),
              ),
              title: Text(
                game.title,
                style: const TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white
                )
              ),
              subtitle: Text(
                game.desc,
                style: const TextStyle(
                  fontSize: 17.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white
                )
              ),
            )
          )
        )
      ]
    );
  }
}