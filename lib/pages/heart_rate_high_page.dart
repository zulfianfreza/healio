import 'package:flutter/material.dart';

import '../shared/theme.dart';

class HeartRateHighPage extends StatelessWidget {
  const HeartRateHighPage({required this.heartRate, Key? key})
      : super(key: key);

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
              'Denyut Jantung Tinggi',
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
                  'Denyut jantung kamu termasuk ke dalam kategori tinggi, atau biasa disebut dengan istilah takikardia. Takikardia terjadi jika denyut jantung melebihi 100 kali per menit atau bpm. Kondisi ini terjadi karena adanya gangguan listrik di jantung yangn berperan dalam mengontrol irama denyut jantung.\nTakikardia bisa muncul tanpa menimbulkan komplikasi. Namun, jika tidak ditangani, denyut jantung yang tinggi bisa menyebabkan komplikasi serius, seperti stroke, gagal jantung, hentin jantung, dan bahkan kematian.\n',
                  style: blackTextStyle.copyWith(
                    fontSize: 16,
                  ),
                ),
                Text(
                  'Penanganan Denyut Jantung Tinggi',
                  style: blackTextStyle.copyWith(
                    fontSize: 20,
                    fontWeight: semiBold,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'Denyut jantung tinggi yang terjadi bukan karena penyakit, umumnya tidak membutuhkan pengobatan karena dapat membaik dengan sendirinya. Jika disebabkan oleh kondisi medis tertentu, penanganan denyut jantung tinggi akan disesuaikan dengan faktor penyebabnya.\nPenanganan yang dilakukan bertujuan untuk memperlambat denyut jantung tinggi hingga kembali de dalam batas normal, mencegah denyut jantung tinggi kembali, menekan risiko komplikasi, dan mengobati penyakit mendasar yang dapat menyebabkan takikardia.\n\nPenanganan untuk takikardia meliputi:\n',
                  style: blackTextStyle.copyWith(
                    fontSize: 16,
                  ),
                ),
                Text(
                  'Tindakan',
                  style: blackTextStyle.copyWith(
                    fontSize: 20,
                    fontWeight: semiBold,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'Untuk meredakan denyut jantung tinggi, kamu bisa melakukan tindakan Manuver Vagal, yaitu melakukan gerakan seperti batuk, mengejan sebagaimana tengah buang air besar, dan menaruh es pada wajah untuk mempengaruhi saraf vagus yang mengatur denyut jantung.\n',
                  style: blackTextStyle.copyWith(
                    fontSize: 16,
                  ),
                ),
                Text(
                  'Obat-obatan',
                  style: blackTextStyle.copyWith(
                    fontSize: 20,
                    fontWeight: semiBold,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'Untuk menormalkan denyut jantung tinggi atau cepat, dokter kemungkinan akan memberikan obat-obatan lain, seperti:\n',
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
                        'Obat aniaritmia, untuk mengembalikan denyut jantung normal. Obat ini diberikan jika Menuver Vagal tidak berhasil meredakan denyut jantung tinggi.',
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
                        'Penghambat saluran kalsium dan penghambat beta, untuk mencegah denyut jantung tinggi teradi lagi.',
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
                        'Obat pengencer darah, untuk membantu menurunkan risiko penggumpalan darah.\n',
                        style: blackTextStyle.copyWith(
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),
                Text(
                  'Menerapkan Gaya Hidup Sehat',
                  style: blackTextStyle.copyWith(
                    fontSize: 20,
                    fontWeight: semiBold,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'Menerapkan gaya hidup sehat, seperti menjaga berat badan ideal, tetap aktif bergerak, mengurangi stress, dan menghindari rokok, merupakan beberapa cara agar jantung tetap sehat dan terhindar dari denyut jantung tinggi.\n\nJika denyut jantung tinggi terjadi secara berkelanjutan dan tidak diketahui dengan pasti apa penyebabnya, konsultasikan dengan dokter untuk mendapatkan pemeriksaan lebih lanjut.',
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
