import 'package:flutter/material.dart';
import 'package:healio/shared/theme.dart';
import 'package:healio/widget/health_category_tile.dart';

class HealthPage extends StatelessWidget {
  const HealthPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget header() {
      return Container(
        margin: EdgeInsets.all(defaultMargin),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Kesehatan',
              style: blackTextStyle.copyWith(
                fontSize: 26,
                fontWeight: bold,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              'Meliputi denyut jantung dan saturasi oksigen',
              style: grayTextStyle,
            ),
          ],
        ),
      );
    }

    Widget body() {
      return Container(
        margin: EdgeInsets.symmetric(
          horizontal: defaultMargin,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Kategori',
              style: blackTextStyle.copyWith(
                fontSize: 16,
                fontWeight: bold,
              ),
            ),
            const SizedBox(height: 10),
            const HealthCategoryTile(
              healthCategory: HealthCategory.heartrate,
            ),
            const SizedBox(height: 10),
            const HealthCategoryTile(
              healthCategory: HealthCategory.bloodoxygen,
            ),
            const SizedBox(height: 24),
            Text(
              'Lainnya',
              style: blackTextStyle.copyWith(
                fontSize: 16,
                fontWeight: bold,
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, '/heart-disease-check');
              },
              child: Container(
                decoration: BoxDecoration(
                  color: kLightGrayColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                margin: const EdgeInsets.only(top: 10),
                padding: const EdgeInsets.all(16),
                height: 57,
                child: Row(
                  children: [
                    Text(
                      'Prediksi Penyakit Jantung',
                      style: blackTextStyle,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      body: ListView(
        children: [
          header(),
          body(),
        ],
      ),
    );
  }
}
