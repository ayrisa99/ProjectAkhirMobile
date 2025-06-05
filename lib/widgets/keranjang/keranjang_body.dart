import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:finalproject/cubit/app_state_cubit.dart';
import 'package:finalproject/widgets/keranjang/keranjang_empty.dart';
import 'package:finalproject/widgets/keranjang/keranjang_list.dart';
import 'package:finalproject/widgets/keranjang/keranjang_list_price.dart';

class KeranjangBody extends StatelessWidget {
  const KeranjangBody({super.key});

  @override
  Widget build(BuildContext context) {
    final shopItems = context.watch<AppStateCubit>().state.shopItems;

    if (shopItems.isEmpty) {
      return const KeranjangEmpty();
    }

    return Column(
      children: [
        Expanded(child: KeranjangList(items: shopItems)),
        KeranjangListPrice(items: shopItems),
      ],
    );
  }
}
