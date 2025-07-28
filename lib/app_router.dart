import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_breaking/business_logic/cubit/characters_cubit.dart';
import 'package:flutter_breaking/core/constants/strings.dart';
import 'package:flutter_breaking/data/models/characters.dart';
import 'package:flutter_breaking/data/repository/characters_repository.dart';
import 'package:flutter_breaking/data/web_servesies/characters_web_services.dart';
import 'package:flutter_breaking/presentaiton/screens/character.dart';
import 'package:flutter_breaking/presentaiton/screens/character_details.dart';

class AppRouter {
  final CharactersRepository charactersRepository = CharactersRepository(
    CharactersWebServices(),
  );

  Route? GenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AllCharactersScreenRoute:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (_) =>
                CharactersCubit(charactersRepository)..getAllCharacters(),
            child: const CharacterScreen(),
          ),
        );
      case CharactersDetailsScreenRoute:
        final character = settings.arguments as Character;
        return MaterialPageRoute(
          builder: (_) => CharacterDetailsScreen(character: character),
        );
    }
    return null;
  }
}
