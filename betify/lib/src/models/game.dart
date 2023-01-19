
class Game {
  final String id;
  final int serverId;
  final String title;
  final String desc;
  final String currencyName;
  final String language;
  final bool isEnded;
  final bool isPublic;
  final int betCount;
  final int memberCount;
  final double startCurrency;
  final String userId;
  final String bannerUrl;
  final List<dynamic> logs;

  final DateTime createdAt;
  final DateTime updatedAt;

  Game({
    required this.id, 
    required this.serverId, 
    required this.title, 
    required this.desc,
    required this.currencyName,
    required this.language,
    required this.isEnded,
    required this.isPublic,
    required this.betCount,
    required this.memberCount,
    required this.startCurrency,
    required this.userId,
    required this.bannerUrl,
    required this.logs,
    required this.createdAt,
    required this.updatedAt,
  });

  Game.fromJSON(Map<String, dynamic> parsedJson) :
    id = parsedJson['id'],
    serverId = parsedJson['serverId'],
    title = parsedJson['title'],
    desc = parsedJson['desc'],
    currencyName = parsedJson['currencyName'],
    language = parsedJson['language'],
    isEnded = parsedJson['isEnded'],
    isPublic = parsedJson['isPublic'],
    betCount = parsedJson['betCount'],
    memberCount = parsedJson['memberCount'],
    startCurrency = double.parse(parsedJson['startCurrency']['\$numberDecimal']),
    userId = parsedJson['userId'],
    bannerUrl = parsedJson['bannerUrl'],
    logs = parsedJson['logs'],
    createdAt = DateTime.parse(parsedJson['_createdAt']),
    updatedAt = DateTime.parse(parsedJson['_updatedAt']);
}