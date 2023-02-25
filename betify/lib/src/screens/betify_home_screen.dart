import 'package:betify/src/services/auth_api_service.dart';
import 'package:flutter/material.dart';
import '../models/game.dart';
import '../models/users.dart';
import '../services/game_api_service.dart';
import 'package:go_router/go_router.dart';

class BetifyHomeScreen extends StatefulWidget {
  final GameApiService _api = GameApiService();
  

  BetifyHomeScreen({Key? key}): super(key: key);

  @override
  State<StatefulWidget> createState() => BetifyHomeScreenState();
}



class BetifyHomeScreenState extends State<BetifyHomeScreen> {
  List<Game> games = [];

  @override
  initState() {
    super.initState();
    _fetchGames();
  }

  _fetchGames() async {
    final List<Game> fetchedGames = await widget._api.fetchGames();

    setState(() {
      games = fetchedGames;
    });
  }

  @override
  Widget build (BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          _GameTitle(),
          _GameList(games: games)
        ]
      ),
      appBar: AppBar(
        title: const Text('Home')
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          
        },
      ),
    );
  }
}



class _GameTitle extends StatelessWidget {
  final AuthApiService auth = AuthApiService();

  Widget _buildUserWelcome() {
    return FutureBuilder<User?>(
      future: auth.getUser(),
      builder: (BuildContext context, AsyncSnapshot<User?> snapshot) {
        if (snapshot.hasData && snapshot.data != null) {
          final user = snapshot.data;

          return Container(
            margin: const EdgeInsets.only(top: 10.0),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(user!.avatarUrl != '' ? user.avatarUrl : ''),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 10.0),
                  child: Text('Welcome ${user.username}'),
                ),
                const Spacer(),
                Container(
                  margin: const EdgeInsets.only(left: 10.0),
                  child: GestureDetector(
                    onTap: () {
                      auth.logout().then((res) { context.go('/login'); });
                    }, 
                    child: Text(
                      'Logout',
                      style: TextStyle(
                        color: Theme.of(context).primaryColor
                      ),
                    )
                  ),
                )
              ],
            )
          );
        } else {
          return Container(width: 0, height: 0);
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Featured Games', style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold)),
          _buildUserWelcome()
        ],
      )
      
      
      
    );
  }
}



class _GameCard extends StatelessWidget {
  final Game game;

  const _GameCard({required this.game});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
             ListTile(
              leading: const Icon(Icons.gamepad, size: 80.0),
              title: Text(game.title),
              subtitle: Text(game.desc),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                TextButton(
                  child: const Text('♡'),
                  onPressed: () {/* ... */},
                ),
                const SizedBox(width: 8),
                TextButton(
                  child: const Text('PLAY'),
                  onPressed: () {context.go('/game/${game.id}');},
                ),
                const SizedBox(width: 8),
              ],
            ),
          ],
        ),
      ),
    );
  }
}



class _GameList extends StatelessWidget {
  final List<Game> games;

  const _GameList({required this.games});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: games.length,
        itemBuilder: (BuildContext context, int i) {
          return _GameCard(game: games[i]);
        }
      )
    );
  }
}