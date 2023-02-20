import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pixaero/src/bloc/character_list_cubit/character_list_state.dart';
import 'package:pixaero/src/core/error/failure.dart';
import 'package:pixaero/src/domain/entities/character_entity.dart';
import 'package:pixaero/src/domain/usecases/get_all_characters.dart';
import 'dart:developer' as console;

const _serverFailureMessage = 'Server Failure';
const _cachedFailureMessage = 'Cache Failure';

class CharacterListCubit extends Cubit<CharacterListState> {
  final GetAllCharacters getAllCharacters;

  CharacterListCubit({required this.getAllCharacters})
      : super(CharacterListEmpty());

  int page = 1;

  void loadCharacted() async {
    if (state is CharacterListLoading) return;

    final currentState = state;

    var oldCharacters = <CharacterEntity>[];
    if (currentState is CharacterListLoaded) {
      oldCharacters = currentState.charactersList;
    }

    emit(CharacterListLoading(oldCharacters, isFirstFetch: page == 1));

    final failureOrCharacter =
        await getAllCharacters(PageCharacterParams(page: page));

    failureOrCharacter.fold(
        (error) =>
            emit(CharacterListError(message: _mapFailureToMessage(error))),
        (character) {
      page++;
      final characters = (state as CharacterListLoading).oldCharactersList;
      characters.addAll(character);
      console.log('List length: ${characters.length.toString()}',
          name: 'CharacterListCubit');
      emit(CharacterListLoaded(characters));
    });
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return _serverFailureMessage;
      case CacheFailure:
        return _cachedFailureMessage;
      default:
        return 'Unexpected Error';
    }
  }
}
