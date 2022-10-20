import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healio/blocs/page/page_cubit.dart';
import 'package:healio/pages/edit_date_of_birth_page.dart';
import 'package:healio/pages/edit_gender_page.dart';
import 'package:healio/pages/edit_name_page.dart';
import 'package:healio/shared/shared_methods.dart';
import 'package:healio/shared/theme.dart';
import 'package:healio/widget/custom_button.dart';
import 'package:healio/widget/user_about_item.dart';
import 'package:health/health.dart';
import 'package:intl/intl.dart';

import '../blocs/auth/auth_bloc.dart';

class UserPage extends StatelessWidget {
  const UserPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget header() {
      return Container(
        margin: EdgeInsets.all(
          defaultMargin,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Akun',
              style: blackTextStyle.copyWith(
                fontSize: 26,
                fontWeight: bold,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              'Informasi terkait akun kamu',
              style: grayTextStyle,
            ),
          ],
        ),
      );
    }

    Widget body() {
      return BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          if (state is AuthSuccess) {
            final date = DateTime.parse(state.user.dateOfBirth);
            String formattedDate = DateFormat('y-MM-d').format(date);
            return Container(
              margin: EdgeInsets.symmetric(
                horizontal: defaultMargin,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Column(
                      children: [
                        Container(
                          height: 84,
                          width: 84,
                          margin: const EdgeInsets.only(bottom: 10),
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(
                                state.user.gender == 'male'
                                    ? 'assets/avatar.png'
                                    : 'assets/female.png',
                              ),
                              fit: BoxFit.cover,
                            ),
                            shape: BoxShape.circle,
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              state.user.name,
                              style: blackTextStyle.copyWith(
                                fontSize: 24,
                                fontWeight: bold,
                              ),
                            ),
                            Text(
                              state.user.email,
                              style: grayTextStyle,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: defaultMargin,
                  ),
                  Text(
                    'Tentang',
                    style: blackTextStyle.copyWith(
                      fontSize: 16,
                      fontWeight: bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                      color: kLightGrayColor,
                      borderRadius: BorderRadius.circular(
                        defaultRadius,
                      ),
                    ),
                    margin: EdgeInsets.only(
                      bottom: defaultMargin,
                    ),
                    child: Column(
                      children: [
                        UserAboutItem(
                          label: 'Nama',
                          value: state.user.name,
                          page: EditNamePage(
                            name: state.user.name,
                          ),
                        ),
                        UserAboutItem(
                          label: 'Jenis Kelamin',
                          value: state.user.gender == 'male'
                              ? 'Laki-laki'
                              : 'Perempuan',
                          page: const EditGenderPage(),
                        ),
                        UserAboutItem(
                          label: 'Tanggal Lahir',
                          value: formattedDate,
                          page: EditDateOfBirthPage(
                            date: state.user.dateOfBirth,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  BlocConsumer<AuthBloc, AuthState>(
                    listener: (context, state) {
                      if (state is AuthFailed) {
                        customShowSnackBar(context, state.e);
                      } else if (state is AuthInitial) {
                        Navigator.pushNamedAndRemoveUntil(
                            context, '/sign-in', (route) => false);
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
                          context.read<AuthBloc>().add(AuthSignOut());
                          context.read<PageCubit>().setPage(0);
                          Navigator.pushNamedAndRemoveUntil(
                              context, '/sign-in', (route) => false);
                        },
                        child: Wrap(
                          crossAxisAlignment: WrapCrossAlignment.center,
                          children: [
                            Image.asset(
                              'assets/fi_log-out.png',
                              height: 16,
                              color: kWhiteColor,
                            ),
                            const SizedBox(width: 10),
                            Text(
                              'Logout',
                              style: whiteTextStyle.copyWith(
                                fontWeight: bold,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
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
          body(),
        ],
      ),
    );
  }
}
