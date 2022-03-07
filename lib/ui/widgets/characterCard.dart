import 'package:breaking_bad/data/models/character.dart';
import 'package:breaking_bad/helper/colorHelper.dart';
import 'package:breaking_bad/helper/navigateHelper.dart';
import 'package:breaking_bad/ui/screens/detailsScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CharacterCard {
  final Character character;

  CharacterCard(this.character);

  Widget builCharacterCard(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: ColorHelper.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: InkWell(
        onTap: () => navigateTo(context, DetailsScreen(character: character)),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Hero(
            tag: character.charId!,
            child: GridTile(
              child: character.img != null
                  ? FadeInImage.assetNetwork(
                      width: double.infinity,
                      height: double.infinity,
                      fit: BoxFit.cover,
                      placeholderFit: BoxFit.cover,
                      placeholder: 'assets/images/loader.gif',
                      image: character.img.toString(),
                    )
                  : Image.asset('assets/images/loader.gif'),
              footer: Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
                color: Colors.black54,
                alignment: Alignment.bottomCenter,
                child: Text(
                  '${character.name}',
                  style: TextStyle(
                    height: 1.3,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: ColorHelper.white,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
