import 'package:equatable/equatable.dart';

abstract class CharacterListEvent extends Equatable {
  const CharacterListEvent();

  @override
  List<Object> get props => [];
}

class CharacterListLoad extends CharacterListEvent {}
