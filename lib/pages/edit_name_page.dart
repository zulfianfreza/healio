import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healio/blocs/user/user_bloc.dart';

import '../blocs/auth/auth_bloc.dart';
import '../shared/shared_methods.dart';
import '../shared/theme.dart';

class EditNamePage extends StatelessWidget {
  const EditNamePage({required this.name, Key? key}) : super(key: key);

  final String name;

  @override
  Widget build(BuildContext context) {
    final nameController = TextEditingController(text: name);
    User? user = FirebaseAuth.instance.currentUser;

    validate() {
      if (nameController.text.isEmpty) {
        return false;
      }
      return true;
    }

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
                          UserUpdate('name', nameController.text, user!.uid));
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
              'Nama',
              style: blackTextStyle.copyWith(
                fontSize: 16,
                fontWeight: bold,
              ),
            ),
            const SizedBox(height: 10),
            Container(
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
              child: Center(
                child: TextFormField(
                  controller: nameController,
                  style: blackTextStyle,
                  decoration: InputDecoration.collapsed(
                    hintText: 'Nama',
                    hintStyle: grayTextStyle,
                  ),
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
