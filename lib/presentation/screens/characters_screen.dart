import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_logic/bussiness_logic/cubit/characters_cubit.dart';
import 'package:flutter_bloc_logic/constants/my_colors.dart';

import 'package:flutter_bloc_logic/data/models/charactar.dart';

import '../widgets/character_item.dart';

class CharactersScreen extends StatefulWidget {
  const CharactersScreen({super.key});

  @override
  State<CharactersScreen> createState() => _CharactersScreenState();
}

class _CharactersScreenState extends State<CharactersScreen> {
  late List<Character> allCharacters;
  late List<Character> searchedCharacters;
  bool _isSearch = false;
  final TextEditingController _searchController = TextEditingController();

  Widget _buildSearchField() {
    return TextField(
      controller: _searchController,
      cursorColor: MyColors.myGrey,
      decoration: const InputDecoration(
        border: InputBorder.none,
        hintText: 'Find A Character',
        hintStyle: TextStyle(
          color: MyColors.myGrey,
          fontSize: 18,
        ),
      ),
      style: const TextStyle(
        color: MyColors.myGrey,
        fontSize: 18,
      ),
      onChanged: (searchedItem) {
        addItemToSearchedCharacters(searchedItem);
      },
    );
  }

  void addItemToSearchedCharacters(String searchedItem) {
    searchedCharacters = allCharacters
        .where((character) =>
            character.name.toLowerCase().startsWith(searchedItem))
        .toList();
    setState(() {});
  }

  List<Widget> _buildAppBarActions() {
    if (_isSearch) {
      return [
        IconButton(
          onPressed: () {
            _clearSearch();
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.clear,
            color: MyColors.myGrey,
          ),
        ),
      ];
    } else {
      return [
        IconButton(
          onPressed: _startSearch,
          icon: const Icon(
            Icons.search,
            color: MyColors.myGrey,
          ),
        ),
      ];
    }
  }

  void _startSearch() {
    ModalRoute.of(context)!
        .addLocalHistoryEntry(LocalHistoryEntry(onRemove: _stopSearch));
    setState(() {
      _isSearch = true;
    });
  }

  void _stopSearch() {
    _clearSearch();
    setState(() {
      _isSearch = false;
    });
  }

  void _clearSearch() {
    setState(() {
      _searchController.clear();
    });
  }

  @override
  void initState() {
    super.initState();

    BlocProvider.of<CharactersCubit>(context).getAllCharacters();
  }

  Widget buildBlocWidget() {
    return BlocBuilder<CharactersCubit, CharactersState>(
      builder: (context, state) {
        if (state is CharactersLoaded) {
          allCharacters = (state).myCharacters;
          return buildloadedListWidget();
        } else {
          return showLoading();
        }
      },
    );
  }

  Widget showLoading() {
    return const Center(
      child:
          CircularProgressIndicator(color: MyColors.myYellow, strokeWidth: 6),
    );
  }

  Widget buildloadedListWidget() {
    return SingleChildScrollView(
      child: Container(
        color: MyColors.myGrey,
        child: Column(
          children: <Widget>[
            buidCharactersList(),
          ],
        ),
      ),
    );
  }

  Widget buidCharactersList() {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 2 / 3,
        crossAxisSpacing: 1,
        mainAxisSpacing: 1,
      ),
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      padding: EdgeInsets.zero,
      itemCount: _searchController.text.isNotEmpty
          ? searchedCharacters.length
          : allCharacters.length,
      itemBuilder: ((context, index) {
        return CharacterItem(
          character: _searchController.text.isNotEmpty
              ? searchedCharacters[index]
              : allCharacters[index],
        );
      }),
    );
  }

  Widget _buildAppBarTitle() {
    return const Text(
      'characters',
      style: TextStyle(
        color: MyColors.myGrey,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyColors.myYellow,
        leading: _isSearch
            ? const BackButton(
                color: MyColors.myGrey,
              )
            : Container(),
        title: _isSearch ? _buildSearchField() : _buildAppBarTitle(),
        actions: _buildAppBarActions(),
      ),
      body: buildBlocWidget(),
    );
  }
}
