import 'package:bloc/bloc.dart';
import 'package:flutter_breaking/business_logic/cubit/characters_state.dart';
import 'package:flutter_breaking/data/models/characters.dart';
import 'package:flutter_breaking/data/repository/characters_repository.dart';

class CharactersCubit extends Cubit<CharactersState> {
  final CharactersRepository charactersRepository;
  late List<Character> characters;

  CharactersCubit(this.charactersRepository) : super(CharactersInitial());

  // جلب كل الشخصيات من الريبو
  Future<void> getAllCharacters() async {
    try {
      final characterModels = await charactersRepository.getAllCharacters();
      characters = characterModels
          .cast<Character>(); // تحويل البيانات إلى Character
      emit(CharactersLoaded(characters, characters)); // أول مره نحطهم كلهم
    } catch (e) {
      emit(CharactersError(e.toString()));
    }
  }

  // فلترة الشخصيات حسب الاسم أو الحالة
  void filterCharacters({required String search, required String status}) {
    final filtered = characters.where((character) {
      final matchesSearch = character.name.toLowerCase().contains(
        search.toLowerCase(),
      );
      final matchesStatus =
          status == 'All' ||
          character.status.toLowerCase() == status.toLowerCase();
      return matchesSearch && matchesStatus;
    }).toList();

    emit(CharactersLoaded(characters, filtered));
  }
}
