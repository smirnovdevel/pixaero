import 'package:flutter/material.dart';
import 'package:pixaero/src/common/values.dart';
import 'package:pixaero/src/presentation/widgets/characters_list_widget.dart';
import 'package:pixaero/src/presentation/widgets/custom_search_delegate.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('R&M API'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            color: kWhiteColor,
            onPressed: () {
              showSearch(context: context, delegate: CustomSearchDelegate());
            },
          )
        ],
      ),
      body: CharacterListWidget(),
    );
  }
}
