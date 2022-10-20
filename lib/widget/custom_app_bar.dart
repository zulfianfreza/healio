import 'package:flutter/material.dart';

import '../shared/theme.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    required this.title,
    this.action = const SizedBox(),
    Key? key,
  }) : super(key: key);

  final String title;
  final Widget? action;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(
        defaultMargin,
      ),
      child: Row(
        children: [
          Row(
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
                      defaultRadius,
                    ),
                  ),
                  child: const Icon(
                    Icons.chevron_left,
                    size: 24,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Text(
                title,
                style: blackTextStyle.copyWith(
                  fontSize: 16,
                  fontWeight: bold,
                ),
              )
            ],
          ),
          const Spacer(),
          SizedBox(
            child: action,
          ),
        ],
      ),
    );
  }
}
