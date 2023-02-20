import 'package:equatable/equatable.dart';

abstract class CharacterSearchEvent extends Equatable {
  const CharacterSearchEvent();

  @override
  List<Object> get props => [];
}

// событие - поиск по запросу
class SearchCharacters extends CharacterSearchEvent {
  final String characterQuery;

  const SearchCharacters(this.characterQuery);
}
