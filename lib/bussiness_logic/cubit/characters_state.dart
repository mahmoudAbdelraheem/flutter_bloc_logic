part of 'characters_cubit.dart';

sealed class CharactersState {}

final class CharactersInitial extends CharactersState {}

final class CharactersLoaded extends CharactersState {
  final List<Character> myCharacters;

  CharactersLoaded(this.myCharacters);
}
