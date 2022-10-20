import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healio/shared/shared_methods.dart';
import 'package:healio/shared/theme.dart';

import '../blocs/auth/auth_bloc.dart';
import '../blocs/user/user_bloc.dart';

class EditDateOfBirthPage extends StatefulWidget {
  const EditDateOfBirthPage({required this.date, Key? key}) : super(key: key);

  final String date;

  @override
  State<EditDateOfBirthPage> createState() => _EditDateOfBirthPageState();
}

late DateTime initialDate;
late String selectedDate;

class _EditDateOfBirthPageState extends State<EditDateOfBirthPage> {
  User? user = FirebaseAuth.instance.currentUser;
  bool validate() {
    if (selectedDate.isEmpty) {
      return false;
    }
    return true;
  }

  @override
  void initState() {
    super.initState();
    initialDate = DateTime.parse(widget.date);
    selectedDate = widget.date;
  }

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
                    if (validate()) {
                      context.read<UserBloc>().add(
                          UserUpdate('date_of_birth', selectedDate, user!.uid));
                    } else {
                      customShowSnackBar(
                          context, 'Field nama tidak boleh kosong');
                    }
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
                decoration: BoxDecoration(
                  color: kLightGrayColor,
                  borderRadius: BorderRadius.circular(
                    defaultRadius,
                  ),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 10,
                ),
                height: 57,
                width: double.infinity,
                child: Row(
                  children: [
                    Text(
                      selectedDate,
                      style: grayTextStyle,
                    ),
                  ],
                ),
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
          body(),
        ],
      ),
    );
  }
}
