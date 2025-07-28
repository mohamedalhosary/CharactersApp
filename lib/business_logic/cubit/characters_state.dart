import 'package:flutter_breaking/data/models/characters.dart';

abstract class CharactersState {}

class CharactersInitial extends CharactersState {}

class CharactersLoading extends CharactersState {}

class CharactersLoaded extends CharactersState {
  final List<Character> allCharacters;
  final List<Character> filteredCharacters;

  CharactersLoaded(this.allCharacters, this.filteredCharacters);
}

class CharactersError extends CharactersState {
  final String message;
  CharactersError(this.message);
}
