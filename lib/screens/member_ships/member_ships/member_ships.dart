import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:value_client/components/index.dart';
import 'package:value_client/resources/index.dart';
import 'package:value_client/widgets/index.dart';

import '../cubit/membership_cubit.dart';

class MemberShipScreen extends StatelessWidget {
  const MemberShipScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MembershipCubit(),
      child: BlocBuilder<MembershipCubit, MembershipState>(
        builder: (context, state) {
          MembershipCubit cubit = MembershipCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              title: Text(
                AppLocalizations.of(context)!.membership,
                style: const TextStyle(color: AppColors.black),
              ),
              backgroundColor: AppColors.backgroundLightGray,
              leading: const BackButton(color: AppColors.black),
            ),
            backgroundColor: AppColors.backgroundLightGray,
            body: NetworkSensitive(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: AppList(
                  loadingListItems: state is MemberShipsLoadingState,
                  hasReachedEndOfResults: cubit.hasReachedEndOfResults,
                  endLoadingFirstTime: cubit.endLoadingFirstTime,
                  listItems: cubit.memberships,
                  itemBuilder: (context, index) => MemberShipItem(
                    item: cubit.memberships[index],
                  ),
                  fetchPageData: (query) => cubit.getMemberShips({}),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
