import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healio/models/heart_disease_form_model.dart';
import 'package:healio/shared/shared_methods.dart';
import 'package:healio/shared/theme.dart';
import 'package:healio/widget/custom_app_bar.dart';
import 'package:healio/widget/custom_button.dart';

import '../blocs/auth/auth_bloc.dart';
import '../blocs/health/health_bloc.dart';
import '../blocs/heart_disease/heart_disease_bloc.dart';
import '../widget/custom_text_form_field.dart';
import 'heart_disease_result_page.dart';

class HeartDiseaseCheckPage extends StatefulWidget {
  const HeartDiseaseCheckPage({Key? key}) : super(key: key);

  @override
  State<HeartDiseaseCheckPage> createState() => _HeartDiseaseCheckPageState();
}

final ageController = TextEditingController(text: '');
final heartRateController = TextEditingController(text: '');
final cigarettesController = TextEditingController(text: '');
final glucoseController = TextEditingController(text: '');
final diabetesController = TextEditingController(text: '');
final cholesterolController = TextEditingController(text: '');
final systolicController = TextEditingController(text: '');
final diastolicController = TextEditingController(text: '');
String gender = 'male';

class _HeartDiseaseCheckPageState extends State<HeartDiseaseCheckPage> {
  @override
  void initState() {
    super.initState();
    fetchData();

    final healthState = context.read<HealthBloc>().state;
    if (healthState is HealthHeartRateSuccess) {
      heartRateController.text =
          getValueFromHealthValue(healthState.heartRate.first.value).toString();
    }

    final authState = context.read<AuthBloc>().state;
    if (authState is AuthSuccess) {
      ageController.text =
          calculateAge(DateTime.parse(authState.user.dateOfBirth)).toString();
    }
  }

  fetchData() {
    context.read<HealthBloc>().add(HealthGetHeartRate());
  }

  @override
  Widget build(BuildContext context) {
    bool validate() {
      if (ageController.text.isEmpty ||
          heartRateController.text.isEmpty ||
          cigarettesController.text.isEmpty ||
          glucoseController.text.isEmpty ||
          diabetesController.text.isEmpty ||
          cholesterolController.text.isEmpty ||
          systolicController.text.isEmpty ||
          diastolicController.text.isEmpty) {
        return false;
      }
      return true;
    }

    Widget appBar() {
      return const CustomAppBar(title: 'Prediksi Penyakit Jantung');
    }

    Widget body() {
      return Container(
        margin: EdgeInsets.only(
          left: defaultMargin,
          right: defaultMargin,
          bottom: defaultMargin,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomTextFormField(
              label: 'Umur',
              controller: ageController,
            ),
            const SizedBox(height: 16),
            Text(
              'Jenis Kelamin',
              style: blackTextStyle.copyWith(
                fontSize: 16,
                fontWeight: bold,
              ),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: 46,
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          gender = 'male';
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        primary:
                            gender == 'male' ? kPrimaryColor : kLightGrayColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            defaultRadius,
                          ),
                        ),
                      ),
                      child: Wrap(
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          Icon(
                            Icons.male,
                            size: 20,
                            color: gender == 'male' ? kWhiteColor : kGrayColor,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Laki-laki',
                            style: whiteTextStyle.copyWith(
                              color:
                                  gender == 'male' ? kWhiteColor : kGrayColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: SizedBox(
                    height: 46,
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          gender = 'female';
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        primary:
                            gender == 'female' ? kRedColor : kLightGrayColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            defaultRadius,
                          ),
                        ),
                      ),
                      child: Wrap(
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          Icon(
                            Icons.female,
                            size: 20,
                            color:
                                gender == 'female' ? kWhiteColor : kGrayColor,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Perempuan',
                            style: whiteTextStyle.copyWith(
                              color:
                                  gender == 'female' ? kWhiteColor : kGrayColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            CustomTextFormField(
              label: 'Konsumsi Rokok per Hari',
              controller: cigarettesController,
            ),
            const SizedBox(height: 16),
            CustomTextFormField(
              label: 'Denyut Jantung',
              controller: heartRateController,
            ),
            const SizedBox(height: 16),
            CustomTextFormField(
              label: 'Gula Darah',
              controller: glucoseController,
            ),
            const SizedBox(height: 16),
            CustomTextFormField(
              label: 'Diabetes',
              controller: diabetesController,
            ),
            const SizedBox(height: 16),
            CustomTextFormField(
              label: 'Kolesterol',
              controller: cholesterolController,
            ),
            const SizedBox(height: 16),
            CustomTextFormField(
              label: 'Sistolik',
              controller: systolicController,
            ),
            const SizedBox(height: 16),
            CustomTextFormField(
              label: 'Diastolik',
              controller: diastolicController,
            ),
            const SizedBox(height: 16),
            BlocConsumer<HeartDiseaseBloc, HeartDiseaseState>(
              listener: (context, state) {
                if (state is HeartDiseaseSuccess) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HeartDiseaseResultPage(
                        data: HeartDiseaseFormModel(
                          age: int.parse(ageController.text),
                          cigs: int.parse(cigarettesController.text),
                          hRate: int.parse(heartRateController.text),
                          gluc: int.parse(glucoseController.text),
                          dia: int.parse(diabetesController.text),
                          chol: int.parse(cholesterolController.text),
                          sBP: int.parse(systolicController.text),
                          dBP: int.parse(diastolicController.text),
                          sex: gender == 'male' ? 1 : 0,
                        ),
                      ),
                    ),
                  );
                } else if (state is HeartDiseaseFailed) {
                  customShowSnackBar(context, state.e);
                }
              },
              builder: (context, state) {
                if (state is HeartDiseaseLoading) {
                  return CustomButton(
                    onPressed: () {},
                    child: SizedBox(
                      height: 21,
                      width: 21,
                      child: CircularProgressIndicator(
                        color: kWhiteColor,
                      ),
                    ),
                  );
                }
                return CustomButton(
                  onPressed: () {
                    if (validate()) {
                      context.read<HeartDiseaseBloc>().add(
                            HeartDiseasePrediction(
                              HeartDiseaseFormModel(
                                age: int.parse(ageController.text),
                                cigs: int.parse(cigarettesController.text),
                                hRate: int.parse(heartRateController.text),
                                gluc: int.parse(glucoseController.text),
                                dia: int.parse(diabetesController.text),
                                chol: int.parse(cholesterolController.text),
                                sBP: int.parse(systolicController.text),
                                dBP: int.parse(diastolicController.text),
                                sex: gender == 'male' ? 1 : 0,
                              ),
                            ),
                          );
                    } else {
                      customShowSnackBar(context, 'Semua field harus diisi.');
                    }
                  },
                  child: Text(
                    'Cek',
                    style: whiteTextStyle.copyWith(
                      fontWeight: bold,
                    ),
                  ),
                );
              },
            ),
          ],
        ),
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
