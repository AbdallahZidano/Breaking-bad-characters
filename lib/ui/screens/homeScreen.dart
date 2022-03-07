import 'package:breaking_bad/business_logic/cubit/characters_cubit.dart';
import 'package:breaking_bad/data/models/character.dart';
import 'package:breaking_bad/data/repository/characters_repo.dart';
import 'package:breaking_bad/helper/colorHelper.dart';
import 'package:breaking_bad/ui/widgets/characterCard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late CharactersReop charactersReop;
  List<Character> allCharacters = [];
  List<Character> searchedCharacters = [];
  bool isSearching = false;
  final TextEditingController textEditingController = TextEditingController();
  CharactersCubit? charactersCubit;

  @override
  void initState() {
    super.initState();
    charactersCubit = BlocProvider.of<CharactersCubit>(context);
    charactersCubit!.getAllCharactersFromRepo();
  }

  Future refresh() async {
    charactersCubit!.getAllCharactersFromRepo();
    await Future.delayed(const Duration(seconds: 3));
  }

  Widget buildBlocWidget() {
    return BlocBuilder<CharactersCubit, CharactersState>(
        builder: (context, state) {
      if (state is CharactersLoaded) {
        allCharacters = state.characters;
        return RefreshIndicator(
          color: ColorHelper.yellow,
          backgroundColor: ColorHelper.grey,
          onRefresh: refresh,
          child: GridView.builder(
            itemCount:
                isSearching ? searchedCharacters.length : allCharacters.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 2 / 3,
              crossAxisSpacing: 1,
              mainAxisSpacing: 1,
            ),
            itemBuilder: (context, index) => CharacterCard(isSearching
                    ? searchedCharacters[index]
                    : allCharacters[index])
                .builCharacterCard(context),
          ),
        );
      } else {
        return Center(
          child: Image.asset('assets/images/firstLoader.gif'),
        );
      }
    });
  }

  Widget buildSearchField() {
    return TextField(
      autofocus: true,
      controller: textEditingController,
      cursorColor: ColorHelper.grey,
      decoration: InputDecoration(
        hintText: 'Find a character...',
        border: InputBorder.none,
        hintStyle: TextStyle(
          fontSize: 18.sp,
          color: ColorHelper.grey,
        ),
      ),
      style: TextStyle(
        fontSize: 18.sp,
        color: ColorHelper.grey,
      ),
      onChanged: (value) {
        addSearchedItemtoList(value);
      },
    );
  }

  void addSearchedItemtoList(String shearchValue) {
    setState(() {
      searchedCharacters = allCharacters
          .where(
              (element) => element.name!.toLowerCase().startsWith(shearchValue))
          .toList();
    });
  }

  buildAppBar() {
    if (!isSearching) {
      return AppBar(
          backgroundColor: ColorHelper.yellow,
          title: const Text(
            'Characters',
            style: TextStyle(color: Colors.black),
          ),
          actions: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.w),
              child: IconButton(
                highlightColor: ColorHelper.grey,
                onPressed: () {
                  setState(() {
                    isSearching = !isSearching;
                  });
                },
                icon: Icon(
                  Icons.search_rounded,
                  size: 30.sp,
                  color: ColorHelper.grey,
                ),
              ),
            ),
          ]);
    } else {
      return AppBar(
        backgroundColor: ColorHelper.yellow,
        title: buildSearchField(),
        actions: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.w),
            child: IconButton(
              onPressed: () {
                setState(() {
                  textEditingController.text = '';
                  isSearching = !isSearching;
                  searchedCharacters.clear();
                });
              },
              icon: Icon(
                Icons.cancel_outlined,
                size: 30.sp,
                color: ColorHelper.grey,
              ),
            ),
          ),
        ],
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: buildAppBar(),
      body: buildBlocWidget(),
    );
  }
}
