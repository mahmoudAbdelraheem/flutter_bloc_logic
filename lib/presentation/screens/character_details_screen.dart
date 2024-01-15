import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_logic/bussiness_logic/cubit/characters_cubit.dart';
import 'package:flutter_bloc_logic/constants/my_colors.dart';
import 'package:flutter_bloc_logic/data/models/charactar.dart';

class CharactersDetailsScreen extends StatelessWidget {
  final Character selectedCharacter;
  const CharactersDetailsScreen({super.key, required this.selectedCharacter});

  Widget buildSliverAppBar() {
    return SliverAppBar(
      leading: const BackButton(color: MyColors.myWhite),
      expandedHeight: 600,
      pinned: true,
      stretch: true,
      backgroundColor: MyColors.myGrey,
      flexibleSpace: FlexibleSpaceBar(
        // centerTitle: true,
        title: Text(
          selectedCharacter.name,
          style: const TextStyle(
            color: MyColors.myWhite,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        background: Hero(
          tag: selectedCharacter.id,
          child: Image.network(
            selectedCharacter.image,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  Widget buildCharacterInfo(String title, String value) {
    return RichText(
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      text: TextSpan(
        children: [
          TextSpan(
            text: title,
            style: const TextStyle(
              color: MyColors.myWhite,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          TextSpan(
            text: value,
            style: const TextStyle(
              color: MyColors.myWhite,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildDivider(double endIndent) {
    return Divider(
      height: 30,
      endIndent: endIndent,
      thickness: 2,
      color: MyColors.myYellow,
    );
  }

  Widget checkIfQuotesAreLoaded(CharactersState state) {
    if (state is QuotesLoaded) {
      return displayRandomQuotsOrEmptySpace(state);
    } else {
      return const Center(
        child: CircularProgressIndicator(
          color: MyColors.myWhite,
          strokeWidth: 2,
        ),
      );
    }
  }

  //todo : next day
  Widget displayRandomQuotsOrEmptySpace(CharactersState state) {
    var quotes = (state).myQuote;
    if (quotes.length != 0) {
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.myGrey,
      body: CustomScrollView(
        slivers: [
          buildSliverAppBar(),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Container(
                  margin: const EdgeInsets.fromLTRB(15, 15, 15, 0),
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      buildCharacterInfo('status : ', selectedCharacter.status),
                      buildDivider(315),
                      buildCharacterInfo(
                          'species : ', selectedCharacter.species),
                      buildDivider(300),
                      buildCharacterInfo('gender : ', selectedCharacter.gender),
                      buildDivider(310),
                      buildCharacterInfo(
                          'episode : ', selectedCharacter.episode.join(' / ')),
                      buildDivider(300),
                      const SizedBox(height: 20),
                      BlocBuilder<CharactersCubit, CharactersState>(
                        builder: (context, state) {
                          return checkIfQuotesAreLoaded(state);
                        },
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 490),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
