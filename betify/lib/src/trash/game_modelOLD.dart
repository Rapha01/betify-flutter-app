/*import 'package:faker/faker.dart';
import 'package:scoped_model/scoped_model.dart';
import '../models/gameOLD.dart';
import '../services/game_api_providerOLD.dart';

class GameModel extends Model {
  List<Game> games = [];
  final testingState = 'Testing State';
  final GameApiProvider _api = GameApiProvider();

  GameModel() {
    _fetchPosts();
  }

  void _fetchPosts() async {
    List<Game> games = await _api.fetchGames();
    this.games = games;
    notifyListeners();
  }


  void addGame() {
    final String id = faker.randomGenerator.string(10000000);
    final String language = faker.food.dish();
    final String title = faker.food.dish();
    final newGame = Game(id: id, language: language, title: title);

    games.add(newGame);
    notifyListeners();
  }
}*/