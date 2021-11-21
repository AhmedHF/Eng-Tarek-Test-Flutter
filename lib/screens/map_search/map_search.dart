import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:value_client/cubit/app_cubit.dart';
import 'package:value_client/resources/index.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:value_client/widgets/index.dart';

class MapSearchScreen extends StatelessWidget {
  const MapSearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: AppColors.white,
            systemOverlayStyle: SystemUiOverlayStyle.dark,
            toolbarHeight: 0,
          ),
          body: NetworkSensitive(
            child: Stack(
              children: <Widget>[
                Image.asset(
                  AppImages.backgroundwhite,
                  height: double.infinity,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    DottedBorder(
                      color: AppColors.gray,
                      strokeWidth: 1,
                      dashPattern: [5, 3],
                      customPath: (size) {
                        return Path()
                          ..moveTo(0, size.height)
                          ..lineTo(size.width, size.height);
                      },
                      child: Container(
                        padding: EdgeInsets.only(
                            left: 10, right: 10, top: 50, bottom: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              AppLocalizations.of(context)!.find_address,
                              style: TextStyle(
                                color: AppColors.primaryDark,
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                            IconButton(
                              onPressed: () => {
                                Navigator.of(context).pop(),
                              },
                              icon: Icon(
                                AppIcons.close,
                                size: 16,
                                color: AppColors.primaryL,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(20),
                      color: AppColors.bg,
                      child: TextFormField(
                        onChanged: (value) {
                          AppCubit.get(context).getMaopSearchData(value);
                        },
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.zero,
                          hintText: AppLocalizations.of(context)!.search,
                          hintStyle: TextStyle(
                              color: AppColors.grayText, fontSize: 15),
                          prefixIcon: Icon(
                            AppIcons.search,
                            color: AppColors.grayText,
                            size: 16,
                          ),
                          fillColor: AppColors.bg,
                          labelStyle: TextStyle(
                            color: AppColors.grayText,
                            backgroundColor: AppColors.grayText,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide:
                                const BorderSide(color: AppColors.grayText),
                          ),
                          hoverColor: AppColors.bg,
                        ),
                      ),
                    ),
                    if (state is MapSearchLoadingState)
                      AppLoading(
                        color: AppColors.primaryL,
                      ),
                    if (state is MapSearchErrorState)
                      AppError(error: state.error),
                    if (state is MapSearchSuccessState)
                      Expanded(
                        child: ListView.separated(
                          itemBuilder: (context, index) => ListTile(
                            onTap: () {
                              Navigator.of(context).pop(state.locations[index]);
                              AppCubit.get(context)
                                  .emit(MapSearchEmptyListState([]));
                            },
                            leading: Icon(
                              AppIcons.location_pin,
                              color: AppColors.primaryL,
                            ),
                            minLeadingWidth: 20,
                            title: Text(
                              state.locations[index].formattedAddress
                                  .toString(),
                            ),
                          ),
                          separatorBuilder: (context, index) => lineBorder(),
                          itemCount: state.locations.length,
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
