import 'package:bloc/bloc.dart';
import 'package:breaking_bad/data/models/character.dart';
import 'package:breaking_bad/data/repository/characters_repo.dart';

import 'package:meta/meta.dart';

part 'characters_state.dart';

class CharactersCubit extends Cubit<CharactersState> {
  final CharactersReop charactersReop;
  List<Character> characters = [];

  CharactersCubit(this.charactersReop) : super(CharactersInitial());

  List<Character> getAllCharactersFromRepo() {
    charactersReop.getAllCharactersFromApi().then((value) {
      emit(CharactersLoaded(value));
      characters = value;
    });
    return characters;
  }
}
