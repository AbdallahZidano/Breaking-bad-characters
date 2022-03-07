// ignore_for_file: use_key_in_widget_constructors

import 'package:breaking_bad/data/models/character.dart';
import 'package:breaking_bad/helper/colorHelper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DetailsScreen extends StatelessWidget {
  final Character character;

  const DetailsScreen({required this.character});
  Widget buildSliverAppBar() {
    return SliverAppBar(
      expandedHeight: 600.h,
      pinned: true,
      stretch: true,
      backgroundColor: ColorHelper.grey,
      flexibleSpace: FlexibleSpaceBar(
        // centerTitle: true,
        title: Text(
          character.name.toString(),
          style: const TextStyle(
            color: ColorHelper.white,
          ),
        ),
        background: Hero(
          tag: character.charId!,
          child: Image.network(
            character.img.toString(),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  Widget characterInfo(String title, String value) {
    return RichText(
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      text: TextSpan(
        children: [
          TextSpan(
            text: title,
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
              color: ColorHelper.white,
            ),
          ),
          TextSpan(
            text: value,
            style: TextStyle(
              fontSize: 16.sp,
              color: ColorHelper.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildDivider(double endIndent) {
    return Divider(
      endIndent: endIndent,
      height: 30.h,
      color: ColorHelper.yellow,
      thickness: 2,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorHelper.grey,
      body: CustomScrollView(
        slivers: [
          buildSliverAppBar(),
          SliverList(
              delegate: SliverChildListDelegate(
            [
              Container(
                margin: EdgeInsets.fromLTRB(14.w, 14.h, 14.w, 0),
                padding: const EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    characterInfo('Job: ', character.occupation!.join(' / ')),
                    buildDivider(330.w),
                    characterInfo('Appeared in: ', character.category!),
                    buildDivider(270.w),
                    characterInfo(
                        'Seasons: ', character.appearance!.join(' / ')),
                    buildDivider(295.w),
                    characterInfo('Status: ', character.status!),
                    buildDivider(310.w),
                    character.betterCallSaulAppearance!.isEmpty
                        ? Container()
                        : characterInfo('better call saul Seasons: ',
                            character.betterCallSaulAppearance!.join(' / ')),
                    character.betterCallSaulAppearance!.isEmpty
                        ? Container()
                        : buildDivider(150.w),
                    characterInfo('Actor /Actress: ', character.portrayed!),
                    buildDivider(245.w),
                  ],
                ),
              ),
              SizedBox(
                height: 500.h,
              )
            ],
          ))
        ],
      ),
    );
  }
}
