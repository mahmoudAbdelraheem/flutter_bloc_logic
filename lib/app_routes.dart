import 'package:flutter/material.dart';
import 'bussiness_logic/cubit/characters_cubit.dart';
import 'data/models/charactar.dart';
import 'data/repository/character_repository.dart';
import 'data/web_services/character_web_services.dart';
import 'presentation/screens/character_details_screen.dart';
import 'presentation/screens/characters_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'constants/strings.dart';

class AppRoute {
  late CharacterRepository characterRepository;
  late CharactersCubit charactersCubit;
  AppRoute() {
    characterRepository = CharacterRepository(CharacterWebServices());
    charactersCubit = CharactersCubit(characterRepository);
  }

  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case charactersScreen:
        return MaterialPageRoute(builder: (_) {
          return BlocProvider(
            create: (context) => charactersCubit,
            child: const CharactersScreen(),
          );
        });
      case charactersDetailsScreen:
        final selectedCharacter = settings.arguments as Character;
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => CharactersCubit(characterRepository),
            child: CharactersDetailsScreen(
              selectedCharacter: selectedCharacter,
            ),
          ),
        );
    }
    return null;
  }
}
