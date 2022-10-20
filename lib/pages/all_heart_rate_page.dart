import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healio/blocs/health/health_bloc.dart';
import 'package:healio/shared/theme.dart';
import 'package:healio/widget/custom_app_bar.dart';
import 'package:healio/widget/health_data_item.dart';
import 'package:health/health.dart';

class AllHeartRatePage extends StatefulWidget {
  const AllHeartRatePage({Key? key}) : super(key: key);

  @override
  State<AllHeartRatePage> createState() => _AllHeartRatePageState();
}

class _AllHeartRatePageState extends State<AllHeartRatePage> {
  @override
  void initState() {
    super.initState();
    context.read<HealthBloc>().add(HealthGetHeartRate());
    context.read<HealthBloc>().add(HealthGetAllHeartRate());
  }

  getValueFromString(HealthValue healthValue) {
    List<String> value = healthValue.toString().split('.');
    return int.parse(value[0]);
  }

  @override
  Widget build(BuildContext context) {
    Widget header() {
      return const CustomAppBar(
        title: 'Denyut Jantung',
      );
    }

    Widget body() {
      return BlocBuilder<HealthBloc, HealthState>(
        builder: (context, state) {
          if (state is HealthAllHeartRateSuccess) {
            return Container(
              margin: EdgeInsets.only(
                left: defaultMargin,
                right: defaultMargin,
                bottom: defaultMargin,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Data Semua Denyut Jantung',
                    style: blackTextStyle.copyWith(
                      fontSize: 16,
                      fontWeight: bold,
                    ),
                  ),
                  Column(
                    children: state.allHeartRate
                        .map((health) => HealthDataItem(
                              health,
                              isAll: true,
                            ))
                        .toList(),
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
