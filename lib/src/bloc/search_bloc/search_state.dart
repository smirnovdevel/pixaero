import 'package:equatable/equatable.dart';
import 'package:pixaero/src/domain/entities/character_entity.dart';

abstract class CharacterSearchState extends Equatable {
  const CharacterSearchState();

  @override
  List<Object> get props => [];
}

// ничего не найдено
class CharacterSearchEmpty extends CharacterSearchState {}

//  ищем
class CharacterSearchLoading extends CharacterSearchState {}

// найдено
class CharacterSearchLoaded extends CharacterSearchState {
  final List<CharacterEntity> characters;

  const CharacterSearchLoaded({required this.characters});

  @override
  List<Object> get props => [characters];
}

// ошибка поиска
class CharacterSearchError extends CharacterSearchState {
  final String message;

  const CharacterSearchError({required this.message});

  @override
  List<Object> get props => [message];
}
