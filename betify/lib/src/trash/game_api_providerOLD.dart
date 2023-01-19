/*import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:betify/src/models/gameOLD.dart';

class GameApiProvider {
  static final GameApiProvider _gameApiProvider = GameApiProvider._internal();

  GameApiProvider._internal();
  factory GameApiProvider() => _gameApiProvider;
  
  Future<List<Game>> fetchGames() async {
    final res = await http.get(Uri.parse('https://api.betify.gg/v1/games'));
    final List<dynamic> gamesRes = jsonDecode(res.body)['results'];
    
    final games = gamesRes.map((gameRes) => Game.fromJSON(gameRes)).take(2).toList();
      
    return games;
  }
}*/