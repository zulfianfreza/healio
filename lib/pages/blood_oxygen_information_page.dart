import 'package:flutter/material.dart';
import 'package:healio/widget/custom_app_bar.dart';

import '../shared/theme.dart';

class BloodOxygenInformationPage extends StatelessWidget {
  const BloodOxygenInformationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget header() {
      return const CustomAppBar(
        title: 'Tentang Saturasi Oksigen',
      );
    }

    Widget content() {
      return Container(
        margin: EdgeInsets.only(
          right: defaultMargin,
          left: defaultMargin,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                'assets/bo_thumbnail.jpg',
              ),
            ),
            SizedBox(
              height: defaultMargin,
            ),
            Text(
              'Saturasi Oksigen',
              style: blackTextStyle.copyWith(
                fontSize: 18,
                fontWeight: semiBold,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              'Saturasi oksigen merupakan nilai yang menunjukkan kadar oksigen di dalam darah. Nilai ini sangat berpengaruh terhadap berbagai fungsi organ dan jaringan tubuh. Pengukuran nilai saturasi oksigen dapat dilakukan dengan 2 cara, yakni dengan analisis gas darah (AGD) atau menggunakan alat oximeter.\n\nHasil pengukuran saturasi oksigen yang dilakukan dengan analisis gas darah ditunjukkan dengan istilah PaO2 (tekanan parsial oksigen). Sementara itu, hasil pengukuran saturasi oksigen dengan menggunakan oximeter ditunjukkan dengan istilah SpO2.',
              style: blackTextStyle.copyWith(
                fontSize: 16,
              ),
            ),
            SizedBox(
              height: defaultMargin,
            ),
            Text(
              'Saturasi Oksigen Normal',
              style: blackTextStyle.copyWith(
                fontSize: 18,
                fontWeight: bold,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              'Berikut adalah nilai saturasi oksigen normal pada orang dengan kondisi paru-paru yang sehat atau tidak memiliki kondisi medis tertentu:',
              style: blackTextStyle.copyWith(
                fontSize: 16,
              ),
            ),
            Text(
              '     •  Analisis gas darah (PaO2): 80–100 mmHg\n     •  Oximeter (SpO2): 95–100%',
              style: blackTextStyle.copyWith(
                fontSize: 16,
              ),
            ),
            SizedBox(height: defaultMargin),
            Text(
              'Saturasi Oksigen Rendah',
              style: blackTextStyle.copyWith(
                fontSize: 18,
                fontWeight: bold,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              'Berikut adalah kriteria nilai saturasi oksigen rendah atau di bawah normal:',
              style: blackTextStyle.copyWith(
                fontSize: 16,
              ),
            ),
            Text(
              '     •  Analisis gas darah (PaO2): dibawah 80 mmHg\n     •  Oximeter (SpO2): dibawah 95%\n\nOrang yang memiliki saturasi oksigen rendah atau hipoksemia bisa merasakan berbagai gejala, seperti nyeri dada, sesak napas, batuk, sakit kepala, detak jantung cepat, kebingungan, dan kulit membiru.\n\nKendati demikian, orang yang mengalami hipoksemia juga bisa tidak merasakan gejala apa pun. Kondisi ini yang disebut dengan happy hypoxia ini bisa terjadi pasien COVID-19.\n\nHipoksemia, baik yang menimbulkan gejala maupun tidak, bisa menganggu kerja organ dan jaringan tubuh. Bila dibiarkan, hal ini dapat menyebabkan kerusakan pada organ vital, seperti jantung, otak, dan ginjal, dan berisiko menyebabkan komplikasi yang berbahaya.',
              style: blackTextStyle.copyWith(
                fontSize: 16,
              ),
            ),
            SizedBox(
              height: defaultMargin,
            ),
            const Divider(),
          ],
        ),
      );
    }

    Widget disclaimer() {
      return Container(
        margin: EdgeInsets.all(defaultMargin),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.warning,
                  size: 16,
                  color: kRedColor,
                ),
                const SizedBox(
                  width: 5,
                ),
                Text(
                  'Disclaimer',
                  style: blackTextStyle.copyWith(
                    fontSize: 18,
                    fontWeight: bold,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              'Harap diingat bahwa pemantauan saturasi oksigen hanya untuk kebugaran dan kesehatan, bukan untuk diagnosis atau perawatan kondisi medis apapun. Jika Anda memiliki kekhawatiran tentang jantung Anda, pastikan untuk berkonsultasi dengan profesional medis.',
              style: blackTextStyle.copyWith(
                fontSize: 16,
              ),
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
          disclaimer(),
        ],
      ),
    );
  }
}
