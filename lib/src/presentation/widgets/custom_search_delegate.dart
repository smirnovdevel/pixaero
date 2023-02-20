import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pixaero/src/bloc/search_bloc/search_bloc.dart';
import 'package:pixaero/src/bloc/search_bloc/search_event.dart';
import 'package:pixaero/src/bloc/search_bloc/search_state.dart';
import 'package:pixaero/src/domain/entities/character_entity.dart';
import 'package:pixaero/src/presentation/widgets/search_result.dart';
import 'dart:developer' as console;

class CustomSearchDelegate extends SearchDelegate {
  CustomSearchDelegate() : super(searchFieldLabel: 'Search for characters...');

  final _suggestions = [
    'Rick',
    'Morty',
    'Summer',
    'Beth',
    'Jerry',
  ];

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          icon: const Icon(Icons.clear),
          onPressed: () {
            query = '';
            showSuggestions(context);
          })
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        icon: const Icon(Icons.arrow_back_outlined),
        tooltip: 'Back',
        onPressed: () => close(context, null));
  }

  @override
  Widget buildResults(BuildContext context) {
    console.log('Inside custom search delegate and search query is $query',
        name: 'CustomSearchDelegate');

    // событие
    BlocProvider.of<CharacterSearchBloc>(context, listen: false)
        .add(SearchCharacters(query));

    return BlocBuilder<CharacterSearchBloc, CharacterSearchState>(
      builder: (context, state) {
        // состояние - ищем
        if (state is CharacterSearchLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );

          // состояние - поиск закончен
        } else if (state is CharacterSearchLoaded) {
          final characters = state.characters;

          // если ничего не нашли выводим сообщение
          if (characters.isEmpty) {
            return _showErrorText('No Characters with that name found');
          }

          // если нашли - выводим результат поиска
          return Padding(
            padding: const EdgeInsets.only(left: 18.0, right: 18.0, top: 8.0),
            child: ListView.builder(
              itemCount: characters.isNotEmpty ? characters.length : 0,
              itemBuilder: (context, int index) {
                CharacterEntity result = characters[index];
                return SearchResult(characterResult: result);
              },
            ),
          );

          // что-то пошло не так
        } else if (state is CharacterSearchError) {
          return _showErrorText(state.message);
        } else {
          return const Center(
            child: Icon(Icons.now_wallpaper),
          );
        }
      },
    );
  }

  Widget _showErrorText(String errorMessage) {
    return Container(
      color: Colors.black,
      child: Center(
        child: Text(
          errorMessage,
          style: const TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isNotEmpty) {
      return Container();
    }

    return ListView.separated(
      padding: const EdgeInsets.all(10),
      itemBuilder: (context, index) {
        return Text(
          _suggestions[index],
          style: const TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.w400,
          ),
        );
      },
      separatorBuilder: (context, index) {
        return const Divider();
      },
      itemCount: _suggestions.length,
    );
  }
}
