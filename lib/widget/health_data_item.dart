import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healio/pages/blood_oxygen_page.dart';
import 'package:health/health.dart';
import 'package:intl/intl.dart';
import 'package:healio/shared/shared_methods.dart';

import '../blocs/auth/auth_bloc.dart';
import '../shared/theme.dart';

int age = 0;

class HealthDataItem extends StatefulWidget {
  const HealthDataItem(
    this.healthDataPoint, {
    this.isAll = false,
    this.category = 'heart_rate',
    Key? key,
  }) : super(key: key);

  final HealthDataPoint healthDataPoint;
  final bool isAll;
  final String category;

  @override
  State<HealthDataItem> createState() => _HealthDataItemState();
}

class _HealthDataItemState extends State<HealthDataItem> {
  @override
  void initState() {
    super.initState();
    getAge();
  }

  void getAge() {
    final authState = context.read<AuthBloc>().state;
    if (authState is AuthSuccess) {
      age = calculateAge(DateTime.parse(authState.user.dateOfBirth));
    }
  }

  @override
  Widget build(BuildContext context) {
    String getTodayDate =
        DateFormat("Hm").format(widget.healthDataPoint.dateFrom);
    String getAllDate =
        DateFormat("d MMMM y h:m aaa").format(widget.healthDataPoint.dateFrom);

    String labelCategory = setCategory(
      getValueFromHealthValue(widget.healthDataPoint.value),
      widget.category,
      age,
    );

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 16,
      ),
      decoration: BoxDecoration(
        color: kLightGrayColor,
        borderRadius: BorderRadius.circular(
          defaultRadius,
        ),
        boxShadow: [
          BoxShadow(
            color: kLightGrayColor,
            offset: const Offset(3, 3),
            blurRadius: 10,
          ),
        ],
      ),
      margin: const EdgeInsets.only(
        top: 10,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Wrap(
                crossAxisAlignment: WrapCrossAlignment.end,
                children: [
                  Text(
                    '${getValueFromHealthValue(widget.healthDataPoint.value)}',
                    style: blackTextStyle.copyWith(
                      fontSize: 20,
                      fontWeight: bold,
                    ),
                  ),
                  Text(
                    widget.category == 'heart_rate' ? 'BPM' : '%',
                    style: grayTextStyle.copyWith(
                      fontSize: widget.category == 'heart_rate' ? 14 : 20,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 5),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 3,
                ),
                decoration: BoxDecoration(
                  color: (labelCategory == 'normal' ? kGreenColor : kRedColor)
                      .withOpacity(0.1),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Text(
                  labelCategory,
                  style: greenTextStyle.copyWith(
                    fontSize: 12,
                    color: labelCategory == 'normal' ? kGreenColor : kRedColor,
                  ),
                ),
              )
            ],
          ),
          const Spacer(),
          Text(
            widget.isAll ? getAllDate : getTodayDate,
            style: grayTextStyle,
          ),
        ],
      ),
    );
  }
}
