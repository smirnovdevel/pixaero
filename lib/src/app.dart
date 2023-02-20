import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pixaero/di.dart';
import 'package:pixaero/src/bloc/search_bloc/search_bloc.dart';

import 'bloc/character_list_cubit/character_list_cubit.dart';
import 'presentation/screen/home_screen.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
    );
    return MultiBlocProvider(
      providers: [
        BlocProvider<CharacterListCubit>(
            create: (_) => di<CharacterListCubit>()..loadCharacted()),
        BlocProvider<CharacterSearchBloc>(
            create: (_) => di<CharacterSearchBloc>()),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomeScreen(),
      ),
    );
  }
}
