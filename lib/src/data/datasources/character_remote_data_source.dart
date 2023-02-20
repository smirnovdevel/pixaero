import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:pixaero/src/core/error/exception.dart';
import 'package:pixaero/src/data/models/character_model.dart';
import 'dart:developer' as console;

abstract class CharacterRemoteDataSource {
  /// Calls the https://rickandmortyapi.com/api/character/?page=1 endpoint.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<List<CharacterModel>> getAllCharacters(int page);

  /// Calls the https://rickandmortyapi.com/api/character/?name=rick endpoint.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<List<CharacterModel>> searchCharacter(String query);
}

class CharacterRemoteDataSourceImpl implements CharacterRemoteDataSource {
  final http.Client client;

  CharacterRemoteDataSourceImpl({required this.client});

  @override
  Future<List<CharacterModel>> getAllCharacters(int page) =>
      _getCharacterFromUrl(
          'https://rickandmortyapi.com/api/character/?page=$page');

  @override
  Future<List<CharacterModel>> searchCharacter(String query) =>
      _getCharacterFromUrl(
          'https://rickandmortyapi.com/api/character/?name=$query');

  Future<List<CharacterModel>> _getCharacterFromUrl(String url) async {
    console.log(url, name: 'CharacterRemoteDataSourceImpl');
    final response = await client
        .get(Uri.parse(url), headers: {'Content-Type': 'application/json'});
    if (response.statusCode == 200) {
      final characters = json.decode(response.body);
      return (characters['results'] as List)
          .map((character) => CharacterModel.fromJson(character))
          .toList();
    } else {
      throw ServerException();
    }
  }
}
