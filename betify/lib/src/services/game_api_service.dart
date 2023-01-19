import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:betify/src/models/game.dart';
import '../../config.dart';

class GameApiService {
  static final GameApiService _singleton = GameApiService._internal();
  factory GameApiService() => _singleton;
  GameApiService._internal();
  
  Future<List<Game>> fetchGames() async {
    try {
      final res = await http.get(Uri.parse('${Config().apiUrl}/games'));

      final List<dynamic> gamesRes = jsonDecode(res.body)['results'];
      
      final games = gamesRes.map((gameRes) => Game.fromJSON(gameRes)).toList();
        
      return games;
    } catch (e) {
      return [];
    }
  }

  Future<Game> fetchGameById({required String id}) async {
    final res = await http.get(Uri.parse('${Config().apiUrl}/games/$id'));
    final gameRes = jsonDecode(res.body);
    final game = Game.fromJSON(gameRes);

    return game;
  }
}