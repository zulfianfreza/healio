import 'package:flutter/material.dart';

import '../shared/theme.dart';

class MoreButton extends StatelessWidget {
  const MoreButton({
    required this.text,
    required this.route,
    Key? key,
  }) : super(key: key);

  final String text;
  final String route;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, route);
      },
      child: Container(
        margin: EdgeInsets.only(
          left: defaultMargin,
          right: defaultMargin,
          top: 10,
        ),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: kLightGrayColor,
          borderRadius: BorderRadius.circular(
            defaultRadius,
          ),
        ),
        child: Row(
          children: [
            Text(
              text,
              style: blackTextStyle.copyWith(
                fontSize: 14,
              ),
            ),
            const Spacer(),
            const Icon(
              Icons.chevron_right,
            ),
          ],
        ),
      ),
    );
  }
}
