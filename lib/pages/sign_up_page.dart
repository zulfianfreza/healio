import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healio/shared/theme.dart';
import 'package:healio/widget/custom_button.dart';
import 'package:healio/widget/custom_text_form_field.dart';

import '../blocs/auth/auth_bloc.dart';
import '../shared/shared_methods.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

String gender = 'male';

final nameController = TextEditingController(text: '');
final emailController = TextEditingController(text: '');
final passwordController = TextEditingController(text: '');
String selectedDate = '';

class _SignUpPageState extends State<SignUpPage> {
  DateTime initialDate = DateTime.now();
  @override
  Widget build(BuildContext context) {
    bool validate() {
      if (emailController.text.isEmpty ||
          passwordController.text.isEmpty ||
          nameController.text.isEmpty ||
          selectedDate == '' ||
          gender == '') {
        return false;
      }
      return true;
    }

    Widget header() {
      return Container(
        margin: EdgeInsets.all(
          defaultMargin,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Daftar',
              style: blackTextStyle.copyWith(
                fontSize: 24,
                fontWeight: bold,
              ),
            ),
            Text(
              'Daftar untuk memantau kondisi kesehatanmu.',
              style: grayTextStyle,
            ),
          ],
        ),
      );
    }

    Widget form() {
      return Container(
        margin: EdgeInsets.symmetric(
          horizontal: defaultMargin,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomTextFormField(
              label: 'Nama',
              icon: 'assets/fi_user.png',
              controller: nameController,
            ),
            const SizedBox(height: 16),
            CustomTextFormField(
              label: 'Email',
              icon: 'assets/fi_mail.png',
              controller: emailController,
            ),
            const SizedBox(height: 16),
            CustomTextFormField(
              label: 'Password',
              icon: 'assets/fi_lock.png',
              isPassword: true,
              obscureText: true,
              controller: passwordController,
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
            Text(
              'Tanggal Lahir',
              style: blackTextStyle.copyWith(
                fontSize: 16,
                fontWeight: bold,
              ),
            ),
            const SizedBox(height: 10),
            GestureDetector(
              onTap: () {
                showDatePicker(
                  context: context,
                  initialDate: initialDate,
                  firstDate: DateTime(1950),
                  lastDate: DateTime(2050),
                ).then((value) {
                  if (value != null) {
                    setState(() {
                      selectedDate = value.toString();
                    });
                  }
                });
              },
              child: Container(
                height: 57,
                decoration: BoxDecoration(
                  color: kLightGrayColor,
                  borderRadius: BorderRadius.circular(
                    defaultRadius,
                  ),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                ),
                child: Row(
                  children: [
                    Image.asset(
                      'assets/fi_trello.png',
                      height: 16,
                      color: kGrayColor,
                    ),
                    const SizedBox(width: 10),
                    Text(
                      selectedDate,
                      style: grayTextStyle,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            BlocConsumer<AuthBloc, AuthState>(
              listener: (context, state) {
                if (state is AuthSuccess) {
                  Navigator.pushNamedAndRemoveUntil(
                      context, '/main', (route) => false);
                } else if (state is AuthFailed) {
                  customShowSnackBar(context, state.e);
                }
              },
              builder: (context, state) {
                if (state is AuthLoading) {
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
                      context.read<AuthBloc>().add(
                            AuthSignUp(
                              emailController.text,
                              passwordController.text,
                              nameController.text,
                              gender,
                              selectedDate,
                            ),
                          );
                    } else {
                      customShowSnackBar(context, 'Semua field harus diisi');
                    }
                  },
                  child: Text(
                    'Daftar',
                    style: whiteTextStyle.copyWith(
                      fontWeight: bold,
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 24),
            Center(
              child: Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  Text(
                    'Sudah punya akun? ',
                    style: grayTextStyle,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/sign-in');
                    },
                    child: Text(
                      'Masuk',
                      style: primaryTextStyle,
                    ),
                  ),
                ],
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
          form(),
        ],
      ),
    );
  }
}
