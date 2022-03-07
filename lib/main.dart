import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'business_logic/cubit/characters_cubit.dart';
import 'data/api/charactersApi.dart';
import 'data/repository/characters_repo.dart';
import 'helper/colorHelper.dart';
import 'ui/screens/homeScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  CharactersReop? charactersReop;
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      builder: () => MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primaryColor: ColorHelper.yellow),
        home: BlocProvider(
          create: (BuildContext context) => CharactersCubit(
            charactersReop ?? CharactersReop(CharacterApi()),
          ),
          child: HomeScreen(),
        ),
      ),
    );
  }
}
