import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healio/blocs/health/health_bloc.dart';
import 'package:health/health.dart';

import '../shared/theme.dart';

class HeartRateLowPage extends StatelessWidget {
  const HeartRateLowPage({required this.heartRate, Key? key}) : super(key: key);

  final int heartRate;

  @override
  Widget build(BuildContext context) {
    Widget header() {
      return Container(
        margin: EdgeInsets.all(defaultMargin),
        width: double.infinity,
        child: Row(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                padding: const EdgeInsets.all(7),
                decoration: BoxDecoration(
                  color: const Color(0xffefefef),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.chevron_left,
                  size: 21,
                ),
              ),
            ),
          ],
        ),
      );
    }

    Widget content() {
      return Container(
        margin: EdgeInsets.only(
          left: defaultMargin,
          right: defaultMargin,
          bottom: defaultMargin,
        ),
        child: Column(
          children: [
            Text(
              'Denyut Jantung Rendah',
              style: blackTextStyle.copyWith(
                fontSize: 20,
                fontWeight: semiBold,
              ),
            ),
            const SizedBox(height: 10),
            Image.asset(
              'assets/health-checkup-4034059-3337536.png',
              height: 100,
            ),
            const SizedBox(height: 10),
            Text(
              '$heartRate bpm',
              style: blackTextStyle.copyWith(
                fontSize: 20,
                fontWeight: semiBold,
              ),
            ),
            SizedBox(height: defaultMargin),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Denyut jantung kamu termasuk ke dalam kategori rendah, atau biasa disebut dengan istilah bradikardia. Bradikardia adalah kondisi ketika jantung berdetak lebih lambat dari biasanya.\n\nMelambatnya denyut jantung umumnya merupakan hal yang normal. Kondisi tersebut dapat terjadi pada orang yang sedang tidur, remaja, atau atlet. Namun, jika disertai dengan gejala pusing atau sesak nafas, denyut jantung yang melambat bisa menjadi tand adanya gangguan pada aktivitas listrik jantung.\n\n',
                  style: blackTextStyle.copyWith(
                    fontSize: 16,
                  ),
                ),
                Text(
                  'Pencegahan Bradikardia',
                  style: blackTextStyle.copyWith(
                    fontSize: 20,
                    fontWeight: semiBold,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'Bradikardia dapat dicegah dengan menghindari faktor-faktor yang dapat meningkatkan risiko terjadinya kondisi ini. Caranya adalah dengan mengubah gaya hidup agar lebih sehat, yaitu dengan melakukan langkah sederhana berikut ini:\n',
                  style: blackTextStyle.copyWith(
                    fontSize: 16,
                  ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '     •  ',
                      style: blackTextStyle.copyWith(
                        fontSize: 16,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        'Menghindari kebiasaan merokok.',
                        style: blackTextStyle.copyWith(
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '     •  ',
                      style: blackTextStyle.copyWith(
                        fontSize: 16,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        'Menghindari penggunaan NAPZA.',
                        style: blackTextStyle.copyWith(
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '     •  ',
                      style: blackTextStyle.copyWith(
                        fontSize: 16,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        'Membatasi konsumsi alkohol.',
                        style: blackTextStyle.copyWith(
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '     •  ',
                      style: blackTextStyle.copyWith(
                        fontSize: 16,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        'Menghindari stres.',
                        style: blackTextStyle.copyWith(
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '     •  ',
                      style: blackTextStyle.copyWith(
                        fontSize: 16,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        'Menjaga berat badan ideal.',
                        style: blackTextStyle.copyWith(
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '     •  ',
                      style: blackTextStyle.copyWith(
                        fontSize: 16,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        'Berolahraga secara rutin.',
                        style: blackTextStyle.copyWith(
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '     •  ',
                      style: blackTextStyle.copyWith(
                        fontSize: 16,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        'Mengonsumsi makanan bergizi seimbang dan rendah garam.',
                        style: blackTextStyle.copyWith(
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      );
    }

    return Scaffold(
      body: ListView(
        children: [
          header(),
          content(),
        ],
      ),
    );
  }
}
