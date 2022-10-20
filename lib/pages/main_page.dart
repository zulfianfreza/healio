import 'package:flutter/material.dart';
import 'package:healio/blocs/article/article_bloc.dart';
import 'package:healio/blocs/health/health_bloc.dart';
import 'package:healio/pages/health_page.dart';
import 'package:healio/pages/home_page.dart';
import 'package:healio/pages/user_page.dart';
import 'package:healio/shared/theme.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/page/page_cubit.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  void initState() {
    super.initState();
    fetchData();
  }

  fetchData() {
    context.read<HealthBloc>().add(HealthGetLandingPage());
    context.read<HealthBloc>().add(HealthGetHeartRate());
    context.read<HealthBloc>().add(HealthGetBloodOxygen());
    context.read<ArticleBloc>().add(const ArticleGet('heart rate'));
  }

  @override
  Widget build(BuildContext context) {
    List pages = const [
      HomePage(),
      HealthPage(),
      UserPage(),
    ];

    return BlocBuilder<PageCubit, int>(
      builder: (context, currentIndex) {
        return RefreshIndicator(
          onRefresh: _pullToRefresh,
          child: Scaffold(
            body: pages[currentIndex],
            bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              backgroundColor: Colors.white,
              onTap: (value) {
                context.read<PageCubit>().setPage(value);
              },
              currentIndex: currentIndex,
              showSelectedLabels: false,
              showUnselectedLabels: false,
              items: [
                BottomNavigationBarItem(
                  label: 'Home',
                  icon: Column(
                    children: [
                      Image.asset(
                        currentIndex == 0
                            ? 'assets/icon_home_active.png'
                            : 'assets/icon_home.png',
                        color: currentIndex == 0 ? kPrimaryColor : kGrayColor,
                        width: 20,
                        height: 20,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        'Home',
                        style: blackTextStyle.copyWith(
                          fontSize: 12,
                          fontWeight: currentIndex == 0 ? bold : reguler,
                          color: currentIndex == 0 ? kPrimaryColor : kGrayColor,
                        ),
                      ),
                    ],
                  ),
                ),
                BottomNavigationBarItem(
                  label: 'Kesehatan',
                  icon: Column(
                    children: [
                      Image.asset(
                        currentIndex == 1
                            ? 'assets/icon_heart_active.png'
                            : 'assets/icon_heart.png',
                        color: currentIndex == 1 ? kPrimaryColor : kGrayColor,
                        height: 20,
                        width: 20,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        'Kesehatan',
                        style: blackTextStyle.copyWith(
                          fontSize: 12,
                          fontWeight: currentIndex == 1 ? bold : reguler,
                          color: currentIndex == 1 ? kPrimaryColor : kGrayColor,
                        ),
                      ),
                    ],
                  ),
                ),
                BottomNavigationBarItem(
                  label: 'User',
                  icon: Column(
                    children: [
                      Image.asset(
                        currentIndex == 2
                            ? 'assets/icon_user_active.png'
                            : 'assets/icon_user.png',
                        color: currentIndex == 2 ? kPrimaryColor : kGrayColor,
                        width: 20,
                        height: 20,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        'Akun',
                        style: blackTextStyle.copyWith(
                          fontSize: 12,
                          fontWeight: currentIndex == 2 ? bold : reguler,
                          color: currentIndex == 2 ? kPrimaryColor : kGrayColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> _pullToRefresh() async {
    context.read<HealthBloc>().add(HealthGetLandingPage());
  }
}
