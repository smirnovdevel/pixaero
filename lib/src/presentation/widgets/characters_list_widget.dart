import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pixaero/src/bloc/character_list_cubit/character_list_cubit.dart';
import 'package:pixaero/src/bloc/character_list_cubit/character_list_state.dart';
import 'package:pixaero/src/common/values.dart';
import 'package:pixaero/src/domain/entities/character_entity.dart';
import 'package:pixaero/src/presentation/widgets/character_card_widget.dart';

class CharacterListWidget extends StatelessWidget {
  final scrollController = ScrollController();
  final int page = -1;

  CharacterListWidget({Key? key}) : super(key: key);
  void setupScrollController(BuildContext context) {
    scrollController.addListener(() {
      if (scrollController.position.atEdge) {
        if (scrollController.position.pixels != 0) {
          BlocProvider.of<CharacterListCubit>(context).loadCharacted();
          // context.read<CharacterListCubit>().loadCharacted();
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    setupScrollController(context);

    return BlocBuilder<CharacterListCubit, CharacterListState>(
        builder: (context, state) {
      List<CharacterEntity> characters = [];
      bool isLoading = false;

      if (state is CharacterListLoading && state.isFirstFetch) {
        return _loadingIndicator();
      } else if (state is CharacterListLoading) {
        characters = state.oldCharactersList;
        isLoading = true;
      } else if (state is CharacterListLoaded) {
        characters = state.charactersList;
      } else if (state is CharacterListError) {
        return Text(
          state.message,
          style: const TextStyle(color: Colors.white, fontSize: 25),
        );
      }
      return Padding(
        padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 8.0),
        child: ListView.separated(
          controller: scrollController,
          itemBuilder: (context, index) {
            if (index < characters.length) {
              return CharacterCard(character: characters[index]);
            } else {
              Timer(const Duration(milliseconds: 30), () {
                scrollController
                    .jumpTo(scrollController.position.maxScrollExtent);
              });
              return _loadingIndicator();
            }
          },
          separatorBuilder: (context, index) {
            return const Divider(
              height: 30.0,
              color: kBlackColor,
            );
          },
          itemCount: characters.length + (isLoading ? 1 : 0),
        ),
      );
    });
  }

  Widget _loadingIndicator() {
    return const Padding(
      padding: EdgeInsets.all(8.0),
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
