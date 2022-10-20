import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healio/blocs/health/health_bloc.dart';
import 'package:healio/shared/theme.dart';
import 'package:healio/widget/custom_app_bar.dart';
import 'package:healio/widget/health_data_item.dart';
import 'package:health/health.dart';

class AllBloodOxygenPage extends StatefulWidget {
  const AllBloodOxygenPage({Key? key}) : super(key: key);

  @override
  State<AllBloodOxygenPage> createState() => _AllBloodOxygenPageState();
}

class _AllBloodOxygenPageState extends State<AllBloodOxygenPage> {
  @override
  void initState() {
    super.initState();
    context.read<HealthBloc>().add(HealthGetAllBloodOxygen());
  }

  getValueFromString(HealthValue healthValue) {
    List<String> value = healthValue.toString().split('.');
    return int.parse(value[0]);
  }

  @override
  Widget build(BuildContext context) {
    Widget header() {
      return const CustomAppBar(
        title: 'Saturasi Oksigen',
      );
    }

    Widget body() {
      return BlocBuilder<HealthBloc, HealthState>(
        builder: (context, state) {
          if (state is HealthAllBloodOxygenSuccess) {
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
                    'Data Semua Saturasi Oksigen',
                    style: blackTextStyle.copyWith(
                      fontSize: 16,
                      fontWeight: bold,
                    ),
                  ),
                  Column(
                    children: state.allBloodOxygen
                        .map((health) => HealthDataItem(
                              health,
                              isAll: true,
                              category: 'blood_oxygen',
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
