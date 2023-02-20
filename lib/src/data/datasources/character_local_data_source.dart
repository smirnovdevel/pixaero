import 'dart:convert';
import 'dart:developer' as console;

import 'package:pixaero/src/core/error/exception.dart';
import 'package:pixaero/src/data/models/character_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class CharacterLocalDataSource {
  /// Gets the cached [List<CharacterModel>] which was gotten the last time
  /// the user had an internet connection.
  ///
  /// Throws [CacheException] if no cached data is present.

  Future<List<CharacterModel>> getLastCharactersFromCache();
  Future<void> charactersToCache(List<CharacterModel> characters);
}

// ignore: constant_identifier_names
const CACHED_CHARACTERS_LIST = 'CACHED_CHARACTERS_LIST';

class CharacterLocalDataSourceImpl implements CharacterLocalDataSource {
  final SharedPreferences sharedPreferences;

  CharacterLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<List<CharacterModel>> getLastCharactersFromCache() {
    final jsonCharactersList =
        sharedPreferences.getStringList(CACHED_CHARACTERS_LIST);
    if (jsonCharactersList!.isNotEmpty) {
      console.log('Get Characters from Cache: ${jsonCharactersList.length}',
          name: 'CharacterLocalDataSourceImpl');
      return Future.value(jsonCharactersList
          .map((character) => CharacterModel.fromJson(json.decode(character)))
          .toList());
    } else {
      throw CacheException();
    }
  }

  @override
  Future<List<String>> charactersToCache(List<CharacterModel> characters) {
    final List<String> jsonCharactersList =
        characters.map((character) => json.encode(character.toJson())).toList();

    sharedPreferences.setStringList(CACHED_CHARACTERS_LIST, jsonCharactersList);
    console.log('Characters to write Cache: ${jsonCharactersList.length}',
        name: 'CharacterLocalDataSourceImpl');
    return Future.value(jsonCharactersList);
  }
}
