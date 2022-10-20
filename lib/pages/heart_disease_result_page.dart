import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healio/models/heart_disease_form_model.dart';
import 'package:healio/shared/theme.dart';
import 'package:healio/widget/custom_app_bar.dart';

import '../blocs/heart_disease/heart_disease_bloc.dart';

class HeartDiseaseResultPage extends StatelessWidget {
  const HeartDiseaseResultPage({required this.data, Key? key})
      : super(key: key);

  final HeartDiseaseFormModel data;

  @override
  Widget build(BuildContext context) {
    Widget appBar() {
      return const CustomAppBar(title: 'Hasil Prediksi');
    }

    Widget body() {
      return BlocBuilder<HeartDiseaseBloc, HeartDiseaseState>(
        builder: (context, state) {
          if (state is HeartDiseaseSuccess) {
            return Container(
              margin: const EdgeInsets.only(
                left: 24,
                right: 24,
                bottom: 24,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: Column(
                      children: [
                        Image.asset(
                          'assets/health-checkup-4034059-3337536.png',
                          height: 100,
                        ),
                        const SizedBox(height: 24),
                        Text(
                          'Probabilitas',
                          style: blackTextStyle.copyWith(
                            fontSize: 16,
                            fontWeight: bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Wrap(
                          crossAxisAlignment: WrapCrossAlignment.center,
                          children: [
                            Text(
                              'Tidak memiliki: ',
                              style: blackTextStyle,
                            ),
                            Text(
                              state.data['probability'][0][0]
                                  .toStringAsFixed(3),
                              style: blackTextStyle.copyWith(
                                fontWeight: bold,
                              ),
                            ),
                          ],
                        ),
                        Wrap(
                          crossAxisAlignment: WrapCrossAlignment.center,
                          children: [
                            Text(
                              'Memiliki: ',
                              style: blackTextStyle,
                            ),
                            Text(
                              state.data['probability'][0][1]
                                  .toStringAsFixed(3),
                              style: blackTextStyle.copyWith(
                                fontWeight: bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: defaultMargin),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Data Masukan',
                          style: blackTextStyle.copyWith(
                            fontSize: 16,
                            fontWeight: bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Wrap(
                          crossAxisAlignment: WrapCrossAlignment.center,
                          children: [
                            Text(
                              'Umur: ',
                              style: blackTextStyle,
                            ),
                            Text(
                              data.age.toString(),
                              style: blackTextStyle.copyWith(
                                fontWeight: bold,
                              ),
                            ),
                          ],
                        ),
                        Wrap(
                          crossAxisAlignment: WrapCrossAlignment.center,
                          children: [
                            Text(
                              'Konsumsi Rokor per Hari: ',
                              style: blackTextStyle,
                            ),
                            Text(
                              data.cigs.toString(),
                              style: blackTextStyle.copyWith(
                                fontWeight: bold,
                              ),
                            ),
                          ],
                        ),
                        Wrap(
                          crossAxisAlignment: WrapCrossAlignment.center,
                          children: [
                            Text(
                              'Jenis Kelamin: ',
                              style: blackTextStyle,
                            ),
                            Text(
                              data.sex.toString(),
                              style: blackTextStyle.copyWith(
                                fontWeight: bold,
                              ),
                            ),
                          ],
                        ),
                        Wrap(
                          crossAxisAlignment: WrapCrossAlignment.center,
                          children: [
                            Text(
                              'Denyut Jantung: ',
                              style: blackTextStyle,
                            ),
                            Text(
                              data.hRate.toString(),
                              style: blackTextStyle.copyWith(
                                fontWeight: bold,
                              ),
                            ),
                          ],
                        ),
                        Wrap(
                          crossAxisAlignment: WrapCrossAlignment.center,
                          children: [
                            Text(
                              'Gula Darah: ',
                              style: blackTextStyle,
                            ),
                            Text(
                              data.gluc.toString(),
                              style: blackTextStyle.copyWith(
                                fontWeight: bold,
                              ),
                            ),
                          ],
                        ),
                        Wrap(
                          crossAxisAlignment: WrapCrossAlignment.center,
                          children: [
                            Text(
                              'Diabetes: ',
                              style: blackTextStyle,
                            ),
                            Text(
                              data.dia.toString(),
                              style: blackTextStyle.copyWith(
                                fontWeight: bold,
                              ),
                            ),
                          ],
                        ),
                        Wrap(
                          crossAxisAlignment: WrapCrossAlignment.center,
                          children: [
                            Text(
                              'Kolesterol: ',
                              style: blackTextStyle,
                            ),
                            Text(
                              data.chol.toString(),
                              style: blackTextStyle.copyWith(
                                fontWeight: bold,
                              ),
                            ),
                          ],
                        ),
                        Wrap(
                          crossAxisAlignment: WrapCrossAlignment.center,
                          children: [
                            Text(
                              'Sistolik: ',
                              style: blackTextStyle,
                            ),
                            Text(
                              data.sBP.toString(),
                              style: blackTextStyle.copyWith(
                                fontWeight: bold,
                              ),
                            ),
                          ],
                        ),
                        Wrap(
                          crossAxisAlignment: WrapCrossAlignment.center,
                          children: [
                            Text(
                              'Diastolik: ',
                              style: blackTextStyle,
                            ),
                            Text(
                              data.dBP.toString(),
                              style: blackTextStyle.copyWith(
                                fontWeight: bold,
                              ),
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

    return Scaffold(
      backgroundColor: kWhiteColor,
      body: ListView(
        children: [
          appBar(),
          body(),
        ],
      ),
    );
  }
}
