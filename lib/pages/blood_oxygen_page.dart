import 'dart:developer';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healio/blocs/health/health_bloc.dart';
import 'package:healio/shared/theme.dart';
import 'package:healio/widget/custom_app_bar.dart';
import 'package:healio/widget/health_data_item.dart';
import 'package:healio/widget/more_button.dart';
import 'package:health/health.dart';

import '../blocs/auth/auth_bloc.dart';
import '../models/health_model.dart';
import '../services/health_service.dart';
import '../services/push_notification_service.dart';
import '../shared/shared_methods.dart';

class BloodOxygenPage extends StatefulWidget {
  const BloodOxygenPage({Key? key}) : super(key: key);

  @override
  State<BloodOxygenPage> createState() => _BloodOxygenPageState();
}

late HealthModel boFromFirebase;

List<HealthDataPoint> dataBloodOxygen = [];

int age = 0;

String category = '';

class _BloodOxygenPageState extends State<BloodOxygenPage> {
  @override
  void initState() {
    super.initState();
    getDataFromFirebase();
    fetchData();
    getAge();
  }

  void fetchData() {
    context.read<HealthBloc>().add(HealthGetBloodOxygen());
    final healthState = context.read<HealthBloc>().state;
    if (healthState is HealthBloodOxygenSuccess) {
      dataBloodOxygen = healthState.bloodOxygen;
    }
  }

  void getAge() {
    final authState = context.read<AuthBloc>().state;
    if (authState is AuthSuccess) {
      age = calculateAge(DateTime.parse(authState.user.dateOfBirth));
    }
  }

  void getDataFromFirebase() async {
    boFromFirebase = await HealthService().getBloodOxygenFromFirebase();
  }

  void updateBloodOxygen() async {
    if (boFromFirebase.value ==
            getValueFromHealthValue(dataBloodOxygen.first.value) &&
        boFromFirebase.dateFrom == dataBloodOxygen.first.dateFrom.toString()) {
      log('Sama');
      log(age.toString());
    } else {
      log('beda');
      await HealthService().updateBloodOxygenFromFirebase(
          getValueFromHealthValue(dataBloodOxygen.first.value),
          dataBloodOxygen.first.dateFrom.toString());
      category = setCategory(
        getValueFromHealthValue(dataBloodOxygen.first.value),
        'blood_oxygen',
        age,
      );
      log(category);
      if (category == 'rendah') {
        customShowSnackBar(context, 'Saturasi oksigen kamu rendah');
        await PushNotificationService().pushNotification(
          'Saturasi Oksigen ${getValueFromHealthValue(dataBloodOxygen.first.value)}',
          'Saturasi Oksigen kamu dibawah nilai normal nih :(.',
        );
      }
    }
  }

  syncData() async {
    fetchData();
    getDataFromFirebase();
    updateBloodOxygen();
  }

  @override
  Widget build(BuildContext context) {
    Widget header() {
      return CustomAppBar(
        title: 'Saturasi Oksigen',
        action: GestureDetector(
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
      );
    }

    Widget report() {
      return BlocBuilder<HealthBloc, HealthState>(
        builder: (context, state) {
          if (state is HealthBloodOxygenSuccess) {
            List<int> listValue = state.bloodOxygen
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
                          'Rabu, 12 Juli',
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
                                'assets/fi_droplet.png',
                                color: kPrimaryColor,
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
                                              '${state.bloodOxygen.isEmpty ? 0 : listValue.reduce(math.min)}',
                                              style: blackTextStyle.copyWith(
                                                fontSize: 20,
                                                fontWeight: bold,
                                              ),
                                            ),
                                            Text(
                                              '%',
                                              style: grayTextStyle.copyWith(
                                                fontSize: 20,
                                              ),
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
                                              '${state.bloodOxygen.isEmpty ? 0 : getValueFromHealthValue(state.bloodOxygen.first.value)}',
                                              style: blackTextStyle.copyWith(
                                                fontSize: 20,
                                                fontWeight: bold,
                                              ),
                                            ),
                                            Text(
                                              '%',
                                              style: grayTextStyle.copyWith(
                                                fontSize: 20,
                                              ),
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
                                            '${state.bloodOxygen.isEmpty ? 0 : listValue.reduce(math.max)}',
                                            style: blackTextStyle.copyWith(
                                              fontSize: 20,
                                              fontWeight: bold,
                                            ),
                                          ),
                                          Text(
                                            '%',
                                            style: grayTextStyle.copyWith(
                                              fontSize: 20,
                                            ),
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
        text: 'Tentang Saturasi Oksigen',
        route: '/blood-oxygen-information',
      );
    }

    Widget history() {
      return BlocBuilder<HealthBloc, HealthState>(
        builder: (context, state) {
          if (state is HealthBloodOxygenSuccess) {
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
                          Navigator.pushNamed(context, '/all-blood-oxygen');
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
                  state.bloodOxygen.isEmpty
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
                                  'Data saturasi oksigen kamu hari ini masih kosong nih, yuk lakukan pengecekan pada smartwatch kamu.',
                                  style: grayTextStyle.copyWith(),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                        )
                      : Column(
                          children: state.bloodOxygen
                              .map(
                                (health) => HealthDataItem(
                                  health,
                                  category: 'blood_oxygen',
                                ),
                              )
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
