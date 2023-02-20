import 'package:equatable/equatable.dart';
import 'package:pixaero/src/domain/entities/character_entity.dart';

abstract class CharacterListState extends Equatable {
  const CharacterListState();

  @override
  List<Object> get props => [];
}

class CharacterListEmpty extends CharacterListState {
  @override
  List<Object> get props => [];
}

class CharacterListLoading extends CharacterListState {
  final List<CharacterEntity> oldCharactersList;
  final bool isFirstFetch;

  const CharacterListLoading(this.oldCharactersList,
      {this.isFirstFetch = false});

  @override
  List<Object> get props => [oldCharactersList];
}

class CharacterListLoaded extends CharacterListState {
  final List<CharacterEntity> charactersList;

  const CharacterListLoaded(this.charactersList);

  @override
  List<Object> get props => [charactersList];
}

class CharacterListError extends CharacterListState {
  final String message;

  const CharacterListError({required this.message});

  @override
  List<Object> get props => [message];
}
