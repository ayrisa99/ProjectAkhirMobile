import 'package:finalproject/cubit/app_state_cubit.dart';
import 'package:finalproject/widgets/orderanku/orderanku_list.dart';
import 'package:finalproject/widgets/scaffold/custom_scaffold2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrderankuScreen extends StatefulWidget {
  const OrderankuScreen({super.key});

  @override
  State<OrderankuScreen> createState() => _OrderankuScreenState();
}

class _OrderankuScreenState extends State<OrderankuScreen> {
  @override
  Widget build(BuildContext context) {
    final cubit = context.watch<AppStateCubit>();
    return CustomScaffold2(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          "Orderanku",
          style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 22),
        ),
        leading: Padding(
          padding: const EdgeInsets.only(left: 20),
          child: IconButton(
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
            icon: Image.asset('assets/logo/back.png', width: 35, height: 35),
            onPressed: () => Navigator.pop(context),
          ),
        ),
      ),
      child: OrderankuList(
        items: cubit.selectedItems,
        pickUpTimes: cubit.pickUpTimes,
        totalPrices: cubit.totalPrices,
      ),
    );
  }
}
