import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healio/models/article_model.dart';
import 'package:healio/pages/webview_page.dart';
import 'package:healio/widget/article_card.dart';

import '../blocs/article/article_bloc.dart';
import '../shared/theme.dart';

class ArticlePage extends StatelessWidget {
  const ArticlePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget header() {
      return Container(
        padding: const EdgeInsets.all(24),
        child: Row(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: kLightGrayColor,
                  borderRadius: BorderRadius.circular(
                    12,
                  ),
                ),
                margin: const EdgeInsets.only(right: 10),
                child: const Icon(
                  Icons.chevron_left,
                  size: 24,
                ),
              ),
            ),
            Text(
              'Artikel',
              style: blackTextStyle.copyWith(
                fontSize: 16,
                fontWeight: bold,
              ),
            ),
          ],
        ),
      );
    }

    Widget article() {
      return Container(
        margin: const EdgeInsets.only(
          left: 24,
          right: 24,
          bottom: 24,
        ),
        child: Column(
          children: listArticle.map((article) {
            return ArticleCard(article);
          }).toList(),
        ),
      );
    }

    return Scaffold(
      body: ListView(
        children: [
          header(),
          article(),
        ],
      ),
    );
  }
}
