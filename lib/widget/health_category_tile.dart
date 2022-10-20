import 'package:flutter/material.dart';
import 'package:healio/shared/theme.dart';

enum HealthCategory {
  heartrate,
  bloodoxygen,
}

class HealthCategoryTile extends StatelessWidget {
  const HealthCategoryTile({
    required this.healthCategory,
    Key? key,
  }) : super(key: key);

  final HealthCategory healthCategory;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          healthCategory == HealthCategory.heartrate
              ? '/heart-rate'
              : '/blood-oxygen',
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
        decoration: BoxDecoration(
          color: kLightGrayColor,
          borderRadius: BorderRadius.circular(
            12,
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              healthCategory == HealthCategory.heartrate
                  ? 'Denyut Jantung'
                  : 'Saturasi Oksigen',
              style: blackTextStyle,
            ),
            const Spacer(),
            Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                color: kWhiteColor,
                shape: BoxShape.circle,
              ),
              padding: const EdgeInsets.all(13),
              child: Image.asset(
                healthCategory == HealthCategory.heartrate
                    ? 'assets/fi_heart.png'
                    : 'assets/fi_droplet.png',
                color: healthCategory == HealthCategory.heartrate
                    ? kRedColor
                    : kPrimaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
