import 'dart:developer';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healio/models/health_model.dart';
import 'package:healio/services/health_service.dart';
import 'package:healio/shared/theme.dart';
import 'package:healio/widget/custom_app_bar.dart';
import 'package:healio/widget/health_data_item.dart';
import 'package:healio/widget/more_button.dart';
import 'package:health/health.dart';
import 'package:intl/intl.dart';

import '../blocs/auth/auth_bloc.dart';
import '../blocs/health/health_bloc.dart';
import '../services/push_notification_service.dart';
import '../shared/shared_methods.dart';

class HeartRatePage extends StatefulWidget {
  const HeartRatePage({Key? key}) : super(key: key);

  @override
  State<HeartRatePage> createState() => _HeartRatePageState();
}

late HealthModel hrFromFirebase;

List<HealthDataPoint> dataHeartRate = [];

int age = 0;

String category = '';

class _HeartRatePageState extends State<HeartRatePage> {
  @override
  void initState() {
    super.initState();
    getDataFromFirebase();
    fetchData();
    getAge();
  }

  void fetchData() {
    context.read<HealthBloc>().add(HealthGetHeartRate());
    final healthState = context.read<HealthBloc>().state;
    if (healthState is HealthHeartRateSuccess) {
      dataHeartRate = healthState.heartRate;
    }
  }

  void getDataFromFirebase() async {
    hrFromFirebase = await HealthService().getHeartRateFromFirebase();
  }

  void getAge() {
    final authState = context.read<AuthBloc>().state;
    if (authState is AuthSuccess) {
      age = calculateAge(DateTime.parse(authState.user.dateOfBirth));
    }
  }

  void updateHeartRate() async {
    if (hrFromFirebase.value ==
            getValueFromHealthValue(dataHeartRate.first.value) &&
        hrFromFirebase.dateFrom == dataHeartRate.first.dateFrom.toString()) {
      log('Sama');
      log(age.toString());
    } else {
      log('beda');
      await HealthService().updateHeartRateFromFirebase(
          getValueFromHealthValue(dataHeartRate.first.value),
          dataHeartRate.first.dateFrom.toString());
      category = setCategory(getValueFromHealthValue(dataHeartRate.first.value),
          'heart_rate', age);
      log(category);
      if (category == 'rendah') {
        customShowSnackBar(context, 'Denyut jantung kamu rendah');
        await PushNotificationService().pushNotification(
          'Denyut Jantung ${getValueFromHealthValue(dataHeartRate.first.value)}',
          'Denyut jantung kamu dibawah nilai normal nih :(.',
        );
      } else if (category == 'tinggi') {
        customShowSnackBar(context, 'Denyut jantung kamu tinggi');
        await PushNotificationService().pushNotification(
          'Denyut Jantung ${getValueFromHealthValue(dataHeartRate.first.value)}',
          'Denyut jantung kamu tinggi nih :(.',
        );
      }
    }
  }

  syncData() async {
    fetchData();
    getDataFromFirebase();
    updateHeartRate();
  }

  @override
  Widget build(BuildContext context) {
    String formattedDate = DateFormat("EEEE, d MMMM").format(DateTime.now());

    Widget header() {
      return CustomAppBar(
        title: 'Denyut Jantung',
        action: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: GestureDetector(
            onTap: () {
              syncData();
            },
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: kLightGrayColor,
                borderRadius: BorderRadius.circular(
                  defaultRadius,
                ),
              ),
              child: Image.asset(
                'assets/fi_refresh-cw.png',
                height: 20,
              ),
            ),
          ),
        ),
      );
    }

    Widget report() {
      return BlocBuilder<HealthBloc, HealthState>(
        builder: (context, state) {
          if (state is HealthHeartRateSuccess) {
            List<int> listValue = state.heartRate
                .map((e) => getValueFromHealthValue(e.value))
                .toList();
            return Container(
              margin: EdgeInsets.symmetric(
                horizontal: defaultMargin,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Ringkasan',
                    style: blackTextStyle.copyWith(
                      fontSize: 16,
                      fontWeight: bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: kLightGrayColor,
                      borderRadius: BorderRadius.circular(
                        defaultRadius,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          formattedDate,
                          style: grayTextStyle,
                        ),
                        const SizedBox(height: 24),
                        Column(
                          children: [
                            Container(
                              height: 56,
                              width: 56,
                              decoration: BoxDecoration(
                                color: kWhiteColor,
                                shape: BoxShape.circle,
                              ),
                              padding: const EdgeInsets.all(16),
                              child: Image.asset(
                                'assets/fi_heart.png',
                                color: kRedColor,
                              ),
                            ),
                            const SizedBox(height: 24),
                            Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      border: Border(
                                        right: BorderSide(
                                          width: 1,
                                          color: kGrayColor.withOpacity(0.3),
                                        ),
                                      ),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Minimum:',
                                          style: grayTextStyle.copyWith(
                                            fontSize: 12,
                                          ),
                                        ),
                                        Wrap(
                                          crossAxisAlignment:
                                              WrapCrossAlignment.end,
                                          children: [
                                            Text(
                                              '${state.heartRate.isEmpty ? 0 : listValue.reduce(math.min)}',
                                              // '',
                                              style: blackTextStyle.copyWith(
                                                fontSize: 20,
                                                fontWeight: bold,
                                              ),
                                            ),
                                            Text(
                                              'BPM',
                                              style: grayTextStyle.copyWith(),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      border: Border(
                                        right: BorderSide(
                                          width: 1,
                                          color: kGrayColor.withOpacity(0.3),
                                        ),
                                      ),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Terbaru:',
                                          style: grayTextStyle.copyWith(
                                            fontSize: 12,
                                          ),
                                        ),
                                        Wrap(
                                          crossAxisAlignment:
                                              WrapCrossAlignment.end,
                                          children: [
                                            Text(
                                              '${state.heartRate.isEmpty ? 0 : getValueFromHealthValue(state.heartRate.first.value)}',
                                              // '',
                                              style: blackTextStyle.copyWith(
                                                fontSize: 20,
                                                fontWeight: bold,
                                              ),
                                            ),
                                            Text(
                                              'BPM',
                                              style: grayTextStyle.copyWith(),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Maksimum:',
                                        style: grayTextStyle.copyWith(
                                          fontSize: 12,
                                        ),
                                      ),
                                      Wrap(
                                        crossAxisAlignment:
                                            WrapCrossAlignment.end,
                                        children: [
                                          Text(
                                            '${state.heartRate.isEmpty ? 0 : listValue.reduce(math.max)}',
                                            // '',
                                            style: blackTextStyle.copyWith(
                                              fontSize: 20,
                                              fontWeight: bold,
                                            ),
                                          ),
                                          Text(
                                            'BPM',
                                            style: grayTextStyle.copyWith(),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }
          return Container();
        },
      );
    }

    Widget more() {
      return const MoreButton(
        text: 'Tentang Denyut Jantung',
        route: '/heart-rate-information',
      );
    }

    Widget history() {
      return BlocBuilder<HealthBloc, HealthState>(
        builder: (context, state) {
          if (state is HealthHeartRateSuccess) {
            return Container(
              margin: EdgeInsets.all(
                defaultMargin,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        'Data',
                        style: blackTextStyle.copyWith(
                          fontSize: 16,
                          fontWeight: bold,
                        ),
                      ),
                      const Spacer(),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, '/all-heart-rate');
                        },
                        child: Text(
                          'Semua',
                          style: grayTextStyle.copyWith(
                            fontSize: 14,
                            fontWeight: bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  state.heartRate.isEmpty
                      ? Center(
                          child: Container(
                            margin: const EdgeInsets.only(
                              top: 56,
                            ),
                            padding: const EdgeInsets.symmetric(horizontal: 36),
                            child: Column(
                              children: [
                                Image.asset(
                                  'assets/document.png',
                                  height: 100,
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  'Data Kosong',
                                  style: blackTextStyle.copyWith(
                                    fontSize: 20,
                                    fontWeight: bold,
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  'Data denyut jantung kamu hari ini masih kosong nih, yuk lakukan pengecekan pada smartwatch kamu.',
                                  style: grayTextStyle.copyWith(),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                        )
                      : Column(
                          children: state.heartRate
                              .map((health) => HealthDataItem(health))
                              .toList(),
                        ),
                ],
              ),
            );
          }
          return Container();
        },
      );
    }

    return Scaffold(
      body: ListView(
        children: [
          header(),
          report(),
          more(),
          history(),
        ],
      ),
    );
  }
}
