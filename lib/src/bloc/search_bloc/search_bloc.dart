import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pixaero/src/core/error/failure.dart';
import 'package:pixaero/src/domain/usecases/search_character.dart';

import 'search_event.dart';
import 'search_state.dart';

const _serverFailureMessage = 'Server Failure';
const _cachedFailureMessage = 'Cache Failure';

class CharacterSearchBloc
    extends Bloc<CharacterSearchEvent, CharacterSearchState> {
  final SearchCharacter searchCharacter;

  CharacterSearchBloc({required this.searchCharacter})
      : super(CharacterSearchEmpty()) {
    on<SearchCharacters>(_onEvent);
  }

  FutureOr<void> _onEvent(
      SearchCharacters event, Emitter<CharacterSearchState> emit) async {
    emit(CharacterSearchLoading());
    final failureOrCharacters = await searchCharacter(
        SearchCharacterParams(query: event.characterQuery));
    emit(failureOrCharacters.fold(
        (failure) =>
            CharacterSearchError(message: _mapFailureToMessage(failure)),
        (character) => CharacterSearchLoaded(characters: character)));
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
