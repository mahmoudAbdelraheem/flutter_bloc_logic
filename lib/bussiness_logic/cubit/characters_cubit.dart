import 'package:bloc/bloc.dart';
import 'package:flutter_bloc_logic/data/models/charactar.dart';
import 'package:flutter_bloc_logic/data/models/quote.dart';
import 'package:flutter_bloc_logic/data/repository/character_repository.dart';

part 'characters_state.dart';

class CharactersCubit extends Cubit<CharactersState> {
  final CharacterRepository characterRepository;
  List<Character> charactar = [];

  CharactersCubit(this.characterRepository) : super(CharactersInitial());

  List<Character> getAllCharacters() {
    characterRepository.getAllCharacters().then((characters) {
      emit(CharactersLoaded(characters));
      charactar = characters;
    });
    return charactar;
  }

  void getRandomQuote(String category) {
    characterRepository.getRandomQuote(category).then((quotes) {
      emit(QuotesLoaded(quotes));
    });
  }
}
