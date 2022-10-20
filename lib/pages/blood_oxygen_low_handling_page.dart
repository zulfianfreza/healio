import 'package:flutter/material.dart';

import '../shared/theme.dart';

class BloodOxygenLowHandllingPage extends StatelessWidget {
  const BloodOxygenLowHandllingPage({required this.bloodOxygen, Key? key})
      : super(key: key);

  final int bloodOxygen;

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
              'Saturasi Oksigen Rendah',
              style: blackTextStyle.copyWith(
                fontSize: 20,
                fontWeight: semiBold,
              ),
            ),
            const SizedBox(height: 10),
            Image.asset(
              'assets/doctor-checking-reports-of-patient-4999616-4171395.png',
              height: 150,
            ),
            const SizedBox(height: 10),
            Text(
              '$bloodOxygen%',
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
                  'Nilai saturasi oksigen kamu rendah nih.\n',
                  style: blackTextStyle.copyWith(
                    fontSize: 16,
                  ),
                ),
                Text(
                  'Penanganan Saturasi Oksigen Rendah',
                  style: blackTextStyle.copyWith(
                    fontSize: 20,
                    fontWeight: semiBold,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'Langkah pertama yang bisa dilakukan adalah dengan melakukan pengecekan ulang saturasi oksigen dengan menggunakan oximeter atau menggunakan smartwatch dalam kondisi jari yang tidak basah.\n\nKedua adalah melakukan prone atau tengkurep dengan meletakkan bantal atau guling di pergelangan kaki agar punggu terasa rileks. Berdasarkan hasil penelitian posisi ini dapat meningkatkan oksigenasi tubuh. Lakukan prone selama 30 menit.\n\nKetiga adalah posisikan tubuh anda setengah duduk, bisa dilakukan ditempat tidur. Hal ini bisa anda lakukan selama 30 menit.\n\nKeempat adalah latihan pengembangan dada atau chest expansion dengan cara tarik nafas melalui hidung dan buang lewat mulut. Lakukan secara perlahan 10 sampai 15 kali. Lakukan 4 hal ini secara bergantian dan anda bisa kembali mengecek saturasi oksigen kembali.',
                  style: blackTextStyle.copyWith(
                    fontSize: 16,
                  ),
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
