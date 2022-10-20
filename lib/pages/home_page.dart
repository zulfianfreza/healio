import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healio/models/article_model.dart';
import 'package:healio/pages/blood_oxygen_low_handling_page.dart';
import 'package:healio/pages/heart_rate_high_page.dart';
import 'package:healio/pages/heart_rate_low_page.dart';
import 'package:healio/shared/shared_methods.dart';
import 'package:healio/shared/theme.dart';
import 'package:healio/widget/article_card.dart';

import '../blocs/article/article_bloc.dart';
import '../blocs/auth/auth_bloc.dart';
import '../blocs/health/health_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

int age = 0;

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    context.read<HealthBloc>().add(HealthGetLandingPage());
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
    Widget header() {
      return BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          if (state is AuthSuccess) {
            age = calculateAge(DateTime.parse(state.user.dateOfBirth));
            return Container(
              margin: EdgeInsets.all(
                defaultMargin,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Halo,\n${state.user.name}',
                        style: blackTextStyle.copyWith(
                          fontSize: 26,
                          fontWeight: bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Bagaimana kesehatanmu hari ini?',
                        style: grayTextStyle.copyWith(),
                      ),
                    ],
                  ),
                  const Spacer(),
                  Container(
                    height: 64,
                    width: 64,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(
                          state.user.gender == 'male'
                              ? 'assets/avatar.png'
                              : 'assets/female.png',
                        ),
                      ),
                      shape: BoxShape.circle,
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

    Widget today() {
      return BlocBuilder<HealthBloc, HealthState>(
        builder: (context, state) {
          if (state is HealthLandingPageSuccess) {
            return Container(
              margin: EdgeInsets.symmetric(
                horizontal: defaultMargin,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Hari Ini',
                    style: blackTextStyle.copyWith(
                      fontSize: 16,
                      fontWeight: bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: kLightGrayColor,
                            borderRadius: BorderRadius.circular(
                              12,
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: 42,
                                width: 42,
                                decoration: BoxDecoration(
                                  color: kWhiteColor,
                                  shape: BoxShape.circle,
                                ),
                                padding: const EdgeInsets.all(12),
                                margin: const EdgeInsets.only(
                                  bottom: 10,
                                ),
                                child: Image.asset(
                                  'assets/fi_heart.png',
                                  color: kRedColor,
                                ),
                              ),
                              Text(
                                'Denyut Jantung',
                                style: grayTextStyle.copyWith(
                                  fontSize: 14,
                                ),
                              ),
                              const SizedBox(height: 5),
                              Wrap(
                                crossAxisAlignment: WrapCrossAlignment.end,
                                children: [
                                  Text(
                                    // '$newestHeartRate ',
                                    '${state.heartRate.isEmpty ? 0 : getValueFromHealthValue(state.heartRate.first.value)}',
                                    style: blackTextStyle.copyWith(
                                      fontSize: 20,
                                      fontWeight: bold,
                                    ),
                                  ),
                                  Text(
                                    'BPM',
                                    style: grayTextStyle.copyWith(
                                        fontWeight: bold),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Container(
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
                              Container(
                                height: 42,
                                width: 42,
                                decoration: BoxDecoration(
                                  color: kWhiteColor,
                                  shape: BoxShape.circle,
                                ),
                                padding: const EdgeInsets.all(12),
                                margin: const EdgeInsets.only(
                                  bottom: 10,
                                ),
                                child: Image.asset(
                                  'assets/fi_droplet.png',
                                  color: kPrimaryColor,
                                ),
                              ),
                              Text(
                                'Saturasi Oksigen',
                                style: grayTextStyle.copyWith(
                                  fontSize: 14,
                                ),
                              ),
                              const SizedBox(height: 5),
                              Wrap(
                                crossAxisAlignment: WrapCrossAlignment.center,
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
                    ],
                  ),
                ],
              ),
            );
          }
          return Container();
        },
      );
    }

    Widget announce() {
      return BlocBuilder<HealthBloc, HealthState>(
        builder: (context, state) {
          if (state is HealthLandingPageSuccess) {
            String hrCategory = state.heartRate.isNotEmpty
                ? setCategory(
                    getValueFromHealthValue(state.heartRate.first.value),
                    'heart_rate',
                    age,
                  )
                : 'empty';
            String boCategory = state.bloodOxygen.isNotEmpty
                ? setCategory(
                    getValueFromHealthValue(state.bloodOxygen.first.value),
                    'blood_oxygen',
                    age,
                  )
                : 'empty';
            int hrValue = state.heartRate.isNotEmpty
                ? getValueFromHealthValue(state.heartRate.first.value)
                : 0;
            int boValue = state.bloodOxygen.isNotEmpty
                ? getValueFromHealthValue(state.bloodOxygen.first.value)
                : 0;
            return Container(
              margin: EdgeInsets.all(defaultMargin),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Notifikasi',
                    style: blackTextStyle.copyWith(
                      fontSize: 16,
                      fontWeight: bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: kRedColor,
                      borderRadius: BorderRadius.circular(
                        defaultRadius,
                      ),
                    ),
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        Image.asset(
                          'assets/heart-rate-monitor.png',
                          height: 75,
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                hrCategory == 'tinggi'
                                    ? 'Denyut Jantung Tinggi'
                                    : hrCategory == 'rendah'
                                        ? 'Denyut Jantung Rendah'
                                        : hrCategory == 'normal'
                                            ? 'Denyut Jantung Normal'
                                            : 'Data Denyut Jantung Kosong',
                                style: whiteTextStyle.copyWith(
                                  fontSize: 16,
                                  fontWeight: bold,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                hrCategory == 'tinggi'
                                    ? 'Wah denyut jantung kamu tinggi 😟 Yuk baca tips berikut sebagai penanganan pertama pada kondisi kamu.'
                                    : hrCategory == 'rendah'
                                        ? 'Wah denyut jantung kamu rendah 😟 Yuk baca tips berikut sebagai penanganan pertama pada kondisi kamu.'
                                        : hrCategory == 'normal'
                                            ? 'Denyut Jantung kamu normal nih, tetap pertahankan ya.'
                                            : 'Data Denyut jantung masih kosong nih, yuk lakukan pengecekan pada smartwatch kamu.',
                                style: whiteTextStyle,
                              ),
                              const SizedBox(height: 10),
                              hrCategory == 'rendah' || hrCategory == 'tinggi'
                                  ? Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                            color: kWhiteColor,
                                            borderRadius: BorderRadius.circular(
                                              defaultRadius,
                                            ),
                                          ),
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 16,
                                            vertical: 10,
                                          ),
                                          child: GestureDetector(
                                            onTap: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (content) =>
                                                      hrCategory == 'rendah'
                                                          ? HeartRateLowPage(
                                                              heartRate:
                                                                  hrValue,
                                                            )
                                                          : HeartRateHighPage(
                                                              heartRate:
                                                                  hrValue,
                                                            ),
                                                ),
                                              );
                                            },
                                            child: Text(
                                              'Lihat',
                                              style: blackTextStyle.copyWith(
                                                fontWeight: bold,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                  : const SizedBox(),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: kPrimaryColor,
                      borderRadius: BorderRadius.circular(
                        defaultRadius,
                      ),
                    ),
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                boCategory == 'rendah'
                                    ? 'Saturasi Oksigen Rendah'
                                    : boCategory == 'normal'
                                        ? 'Saturasi Oksigen Normal'
                                        : 'Data Saturasi Oksigen Kosong',
                                style: whiteTextStyle.copyWith(
                                  fontSize: 16,
                                  fontWeight: bold,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                boCategory == 'rendah'
                                    ? 'Wah Saturasi Oksigen kamu rendah 😟 Yuk baca tips berikut sebagai penanganan pertama pada kondisi kamu.'
                                    : boCategory == 'normal'
                                        ? 'Saturasi Oksigen kamu normal nih, tetap pertahankan ya.'
                                        : 'Data Saturasi Oksigen masih kosong nih, yuk lakukan pengecekan pada smartwatch kamu.',
                                style: whiteTextStyle,
                              ),
                              boCategory == 'rendah'
                                  ? GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                BloodOxygenLowHandllingPage(
                                              bloodOxygen: boValue,
                                            ),
                                          ),
                                        );
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: kWhiteColor,
                                          borderRadius: BorderRadius.circular(
                                            defaultRadius,
                                          ),
                                        ),
                                        margin: const EdgeInsets.only(top: 10),
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 16,
                                          vertical: 10,
                                        ),
                                        child: Text(
                                          'Lihat',
                                          style: blackTextStyle.copyWith(
                                            fontWeight: bold,
                                          ),
                                        ),
                                      ),
                                    )
                                  : const SizedBox(),
                            ],
                          ),
                        ),
                        Image.asset(
                          'assets/announce2_image.png',
                          height: 75,
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

    Widget article() {
      return Container(
        margin: EdgeInsets.only(
          left: defaultMargin,
          right: defaultMargin,
          bottom: defaultMargin,
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Artikel',
                  style: blackTextStyle.copyWith(
                    fontSize: 16,
                    fontWeight: bold,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/article');
                  },
                  child: Text(
                    'Semua',
                    style: grayTextStyle.copyWith(
                      fontWeight: bold,
                    ),
                  ),
                ),
              ],
            ),
            Column(
              children: List.generate(
                5,
                (index) => ArticleCard(
                  listArticle[index],
                ),
              ),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      backgroundColor: kWhiteColor,
      body: ListView(
        children: [
          header(),
          today(),
          announce(),
          article(),
        ],
      ),
    );
  }
}
