import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:value_client/core/extensions/hex_colors.dart';
import 'package:value_client/models/check_box.dart';
import 'package:value_client/resources/colors/colors.dart';
import 'package:value_client/screens/search/cubit/search_cubit.dart';
import 'package:value_client/widgets/app_conditional_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Categories extends StatefulWidget {
  final Function onSelect;
  final CheckBoxModal selected;

  const Categories(
    this.onSelect,
    this.selected,
    Key? key,
  ) : super(key: key);
  @override
  _CategoriesState createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchCubit()..getCategories(),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: BlocBuilder<SearchCubit, SearchStates>(
          builder: (context, state) {
            return AppConditionalBuilder(
              loadingCondition: state is CategoriesLoadingState,
              emptyCondition:
                  state is CategoriesSuccessState && state.categories.isEmpty,
              errorCondition: state is CategoriesErrorState,
              errorMessage: state is CategoriesErrorState ? state.error : '',
              successCondition: state is CategoriesSuccessState,
              successBuilder: (context) => state is CategoriesSuccessState
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        InkWell(
                          onTap: () {
                            // this.setState(() {
                            //   selectedCategory:e
                            // });
                            widget.onSelect(
                              CheckBoxModal(id: -1, title: "All", count: ""),
                            );
                          },
                          child: Container(
                            width: 100,
                            height: 100,
                            margin: const EdgeInsets.only(right: 10),
                            // padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: AppColors.white,
                              border: Border.all(
                                color: widget.selected.id == -1
                                    ? AppColors.primaryL
                                    : AppColors.white,
                                width: widget.selected.id == -1 ? 2 : 0,
                              ),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  AppLocalizations.of(context)!.all,
                                  style: const TextStyle(
                                      color: AppColors.primaryL,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                          ),
                        ),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: state.categories
                                .map(
                                  (e) => InkWell(
                                    onTap: () {
                                      // this.setState(() {
                                      //   selectedCategory:e
                                      // });
                                      widget.onSelect(e);
                                    },
                                    child: Container(
                                      width: 100,
                                      height: 100,
                                      margin: const EdgeInsets.only(right: 10),
                                      // padding: const EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        color: AppColors.white,
                                        border: Border.all(
                                          color: widget.selected.id == e.id
                                              ? HexColor.fromHex(e.color)
                                              : AppColors.white,
                                          width: widget.selected.id == e.id
                                              ? 2
                                              : 0,
                                        ),
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: <Widget>[
                                          e.id != -1
                                              ? Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    SizedBox(
                                                        width: 45,
                                                        height: 40,
                                                        child: e.image != ''
                                                            ? Image.network(
                                                                e.image,
                                                              )
                                                            : Container()),
                                                    const SizedBox(height: 2),
                                                  ],
                                                )
                                              : Container(),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            e.title,
                                            maxLines: 2,
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: widget.selected.id == e.id
                                                  ? HexColor.fromHex(e.color)
                                                  : AppColors.primaryL,
                                              fontSize: 14,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                                .toList())
                      ],
                    )
                  : Container(),
            );
          },
        ),
      ),
    );
  }
}
