import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:pixaero/src/core/error/failure.dart';
import 'package:pixaero/src/core/usecases/usecase.dart';
import 'package:pixaero/src/domain/entities/character_entity.dart';
import 'package:pixaero/src/domain/repositories/character_repository.dart';

class SearchCharacter
    extends UseCase<List<CharacterEntity>, SearchCharacterParams> {
  final CharacterRepository characterRepository;

  SearchCharacter(this.characterRepository);

  @override
  Future<Either<Failure, List<CharacterEntity>>> call(
      SearchCharacterParams params) async {
    return await characterRepository.searchCharacter(params.query);
  }
}

class SearchCharacterParams extends Equatable {
  final String query;

  const SearchCharacterParams({required this.query});

  @override
  List<Object> get props => [query];
}
