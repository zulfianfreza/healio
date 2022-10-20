import 'package:flutter/material.dart';
import 'package:healio/models/article_model.dart';
import '../pages/webview_page.dart';
import '../shared/theme.dart';

class ArticleCard extends StatelessWidget {
  const ArticleCard(
    this.article, {
    Key? key,
  }) : super(key: key);

  final ArticleModel article;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: kGrayColor.withOpacity(0.1),
            offset: const Offset(3, 3),
            blurRadius: 10,
          ),
        ],
      ),
      width: double.infinity,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => WebviewPage(
                  url: article.link.toString(),
                ),
              ),
            );
          },
          child: Container(
            decoration: BoxDecoration(
              color: kWhiteColor,
              border: Border.all(
                color: kLightGrayColor,
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 96,
                  width: 144,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(
                        article.thumbnail.toString(),
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          article.title.toString(),
                          style: blackTextStyle.copyWith(
                            fontWeight: bold,
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          article.description!,
                          style: grayTextStyle.copyWith(
                            fontSize: 14,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
