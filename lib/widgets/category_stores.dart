import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:value_client/core/extensions/hex_colors.dart';
import 'package:value_client/cubit/app_cubit.dart';
import 'package:value_client/models/check_box.dart';
import 'package:value_client/resources/colors/colors.dart';
import 'package:value_client/screens/storesList/cubit/stores_cubit.dart';
import 'package:value_client/widgets/app_list.dart';
import 'package:value_client/widgets/store_card.dart';

class CategoryStores extends StatelessWidget {
  final CheckBoxModal category;
  final Function onSelect;
  CategoryStores(this.category, this.onSelect);

  @override
  Widget build(BuildContext context) {
    debugPrint('widget.category.id==> ${category.id}');
    return BlocProvider(
        create: (context) => StoresCubit(),
        child: BlocBuilder<StoresCubit, StoresState>(builder: (context, state) {
          StoresCubit cubit = StoresCubit.get(context);
          AppCubit appCubit = AppCubit.get(context);

          return Padding(
            padding: EdgeInsets.all(0),
            child: Container(
                child: AppList(
              key: const Key('Stores List'),
              fetchPageData: (query) {
                Map<String, dynamic> queryTemp = {};
                queryTemp.addAll(query);
                queryTemp.addAll({
                  'country_id': appCubit.countryId,
                });
                return cubit.getStores(queryTemp);
              },
              loadingListItems: state is StoresLoadingState,
              hasReachedEndOfResults: cubit.hasReachedEndOfResults,
              endLoadingFirstTime: cubit.endLoadingFirstTime,
              itemBuilder: (context, index) => StoreCard(
                id: cubit.stores[index]['id'] as String,
                name: cubit.stores[index]['name'] as String,
                image: cubit.stores[index]['image'] as String,
                upTo: cubit.stores[index]['up_to'].toString(),
                value: cubit.stores[index]['coupons_number'].toString(),
                featured: cubit.stores[index]['featured'],
                categoryColor: category.id == -1
                    ? AppColors.primaryL
                    : HexColor.fromHex(category.color),
              ),
              listItems: cubit.stores,
            )),
          );

          // AppConditionalBuilder(
          //     loadingCondition: state is StoresLoadingState,
          //     emptyCondition:
          //         state is StoresSuccessState && state.stores.isEmpty,
          //     errorCondition: state is StoresErrorState,
          //     errorMessage: state is StoresErrorState ? state.error : '',
          //     successCondition: state is StoresSuccessState,
          //     successBuilder: (context) => state is StoresSuccessState
          //         ? Column(
          //             crossAxisAlignment: CrossAxisAlignment.stretch,
          //             children: <Widget>[
          //               Text(
          //                 widget.category.title,
          //                 style: TextStyle(
          //                   color: AppColors.primaryDark,
          //                   fontWeight: FontWeight.bold,
          //                   fontSize: 25,
          //                 ),
          //               ),
          //               SizedBox(
          //                 height: 15,
          //               ),
          //               Container(
          //                 child: Column(
          //                   children: state.stores
          //                       .map(
          //                         (e) => StoreCard(
          //                             name: e['name'] as String,
          //                             image: e['image'] as String,
          //                             // TODO ask about 'upTo' and  'value' values form api and 'isAdv'
          //                             upTo: "20",
          //                             value: "15",
          //                             categoryColor: widget.category.id == -1
          //                                 ? AppColors.primaryL
          //                                 : HexColor.fromHex(
          //                                     widget.category.color),
          //                             isAdv: false),
          //                       )
          //                       .toList(),
          //                 ),
          //               ),
          //               // widget.category.id == -1
          //               //     ? TextButton(
          //               //         onPressed: () =>
          //               //             widget.onSelect(widget.category),
          //               //         child: Text(
          //               //           AppLocalizations.of(context)!.view_more,
          //               //           style: TextStyle(
          //               //               fontWeight: FontWeight.bold,
          //               //               fontSize: 18),
          //               //         ),
          //               //         style: TextButton.styleFrom(
          //               //             primary: AppColors.primaryDark))
          //               //     : Container()
          //               // ListView.builder(
          //               //   itemBuilder: (ctx, i) => StoreCard(
          //               //       name: data[i]["name"] as String,
          //               //       upTo: data[i]["upTo"] as String,
          //               //       value: data[i]["value"] as String),
          //               //   itemCount: 3,
          //               //   shrinkWrap: true,
          //               // )
          //             ],
          //           )
          //         : Container());
        }));
  }
}
