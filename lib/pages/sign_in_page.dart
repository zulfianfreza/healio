import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healio/shared/theme.dart';
import 'package:healio/widget/custom_button.dart';
import 'package:healio/widget/custom_text_form_field.dart';

import '../blocs/auth/auth_bloc.dart';
import '../shared/shared_methods.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

final emailController = TextEditingController(text: '');
final passwordController = TextEditingController(text: '');

class _SignInPageState extends State<SignInPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool validate() {
      if (emailController.text.isEmpty || passwordController.text.isEmpty) {
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
              'Masuk',
              style: blackTextStyle.copyWith(
                fontSize: 24,
                fontWeight: bold,
              ),
            ),
            Text(
              'Masuk untuk memantau kondisi kesehatanmu.',
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
          children: [
            CustomTextFormField(
              label: 'Email',
              icon: 'assets/fi_mail.png',
              controller: emailController,
            ),
            const SizedBox(height: 10),
            CustomTextFormField(
              label: 'Password',
              icon: 'assets/fi_lock.png',
              isPassword: true,
              obscureText: true,
              controller: passwordController,
            ),
            const SizedBox(height: 24),
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
                            AuthSignIn(
                              emailController.text,
                              passwordController.text,
                            ),
                          );
                    } else {
                      customShowSnackBar(context, 'Semua field harus diisi');
                    }
                  },
                  child: Text(
                    'Masuk',
                    style: whiteTextStyle.copyWith(
                      fontWeight: bold,
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 24),
            Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                Text(
                  'Belum punya akun? ',
                  style: grayTextStyle,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/sign-up');
                  },
                  child: Text(
                    'Daftar',
                    style: primaryTextStyle,
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
          form(),
        ],
      ),
    );
  }
}
