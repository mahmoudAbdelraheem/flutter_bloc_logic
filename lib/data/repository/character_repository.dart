import '../models/charactar.dart';
import '../models/quote.dart';
import '../web_services/character_web_services.dart';

class CharacterRepository {
  final CharacterWebServices characterWebServices;

  CharacterRepository(this.characterWebServices);

  Future<List<Character>> getAllCharacters() async {
    final characters = await characterWebServices.getAllCharacters();

    return characters
        .map((character) => Character.fromJson(character))
        .toList();
  }

  Future<List<Quote>> getRandomQuote(String category) async {
    final quotes = await characterWebServices.getRandomQuote(category);

    return quotes.map((quote) => Quote.fromJson(quote)).toList();
  }
}
