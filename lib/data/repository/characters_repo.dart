import 'package:breaking_bad/data/api/charactersApi.dart';
import 'package:breaking_bad/data/models/character.dart';

class CharactersReop {
  final CharacterApi characterApi;

  CharactersReop(this.characterApi);

  Future<List<Character>> getAllCharactersFromApi() async {
    final characters = await characterApi.getAllCharactersFromServer();
    var data = characters.map((item) => Character.fromJson(item)).toList();
    return data;
  }
}
