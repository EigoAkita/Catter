import 'package:catter_app/config/screen_loading.dart';
import 'package:catter_app/presentation/ranking/ranking_model.dart';
import 'package:catter_app/presentation/ranking/widgets/animated_ranking_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:provider/provider.dart';

class RankingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<RankingModel>(
      create: (_) => RankingModel()..fetchUsersRealTime(),
      child: Consumer<RankingModel>(
        builder: (context, model, child) {
          return Scaffold(
            body: Stack(
              children: <Widget>[
                AnimatedRankingList(
                  rankingModel: model,
                ),
                screenLoading(
                  isLoading: model.isLoading,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
