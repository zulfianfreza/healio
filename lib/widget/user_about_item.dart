import 'package:flutter/material.dart';

import '../shared/theme.dart';

class UserAboutItem extends StatelessWidget {
  const UserAboutItem({
    required this.label,
    required this.value,
    required this.page,
    Key? key,
  }) : super(key: key);

  final String label;
  final String value;
  final Widget page;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 16,
      ),
      child: Row(
        children: [
          Text(
            label,
            style: blackTextStyle,
          ),
          const Spacer(),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => page,
                ),
              );
            },
            child: Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                Text(
                  value,
                  style: grayTextStyle,
                ),
                const SizedBox(width: 5),
                Icon(
                  Icons.chevron_right,
                  color: kGrayColor,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
