import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healio/shared/theme.dart';

import '../blocs/auth/auth_bloc.dart';
import '../blocs/user/user_bloc.dart';

class EditGenderPage extends StatefulWidget {
  const EditGenderPage({Key? key}) : super(key: key);

  @override
  State<EditGenderPage> createState() => _EditGenderPageState();
}

class _EditGenderPageState extends State<EditGenderPage> {
  String gender = 'male';
  User? user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    Widget header() {
      return Container(
        margin: EdgeInsets.all(
          defaultMargin,
        ),
        child: Row(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: kRedColor,
                  borderRadius: BorderRadius.circular(
                    defaultRadius,
                  ),
                ),
                child: Icon(
                  Icons.close,
                  size: 20,
                  color: kWhiteColor,
                ),
              ),
            ),
            const Spacer(),
            BlocConsumer<UserBloc, UserState>(
              listener: (context, state) {
                if (state is UserSuccess) {
                  context.read<AuthBloc>().add(AuthGetCurrentUser(user!.uid));
                  Navigator.pushNamed(context, '/main');
                }
              },
              builder: (context, state) {
                if (state is UserLoading) {
                  return Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: kPrimaryColor,
                      borderRadius: BorderRadius.circular(
                        defaultRadius,
                      ),
                    ),
                    child: SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                        color: kWhiteColor,
                      ),
                    ),
                  );
                }
                return GestureDetector(
                  onTap: () {
                    context
                        .read<UserBloc>()
                        .add(UserUpdate('gender', gender, user!.uid));
                  },
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: kPrimaryColor,
                      borderRadius: BorderRadius.circular(
                        defaultRadius,
                      ),
                    ),
                    child: Icon(
                      Icons.check,
                      size: 20,
                      color: kWhiteColor,
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      );
    }

    Widget body() {
      return Container(
        margin: EdgeInsets.symmetric(
          horizontal: defaultMargin,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
          ],
        ),
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
