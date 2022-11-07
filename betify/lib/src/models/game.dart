
class Game {
  final String title;
  final String language;
  final String id;

  Game({required String title, required String language, required String id}) :
    this.title = title,
    this.language = language,
    this.id = id;

  Game.fromJSON(Map<String, dynamic> parsedJson) :
    title = parsedJson['title'],
    language = parsedJson['language'],
    id = parsedJson['id'];
  
}