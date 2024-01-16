import 'dart:math';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bussiness_logic/cubit/characters_cubit.dart';
import '../../constants/my_colors.dart';
import '../../constants/strings.dart';

import '../../data/models/charactar.dart';
import '../../data/models/quote.dart';

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
  Widget displayRandomQuotsOrEmptySpace(state) {
    List<Quote> quotes = (state).myQuote;
    if (quotes.isNotEmpty) {
      return Center(
        child: DefaultTextStyle(
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 20,
            color: MyColors.myWhite,
            shadows: [
              Shadow(
                color: MyColors.myYellow,
                blurRadius: 7,
                offset: Offset(0, 0),
              )
            ],
          ),
          child: AnimatedTextKit(
            repeatForever: true,
            animatedTexts: [
              FlickerAnimatedText(quotes[0].quote),
            ],
          ),
        ),
      );
    } else {
      return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    int randomQuoteCategory = Random().nextInt(myQuotesCategory.length - 1);
    BlocProvider.of<CharactersCubit>(context)
        .getRandomQuote(myQuotesCategory[randomQuoteCategory]);
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
