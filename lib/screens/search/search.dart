import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:value_client/resources/index.dart';
import 'package:value_client/routes/app_routes.dart';
import 'package:value_client/widgets/index.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
                          AppLocalizations.of(context)!.search,
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
                Expanded(
                  child: Column(
                    children: [
                      lineBorder(),
                      Container(
                        padding: EdgeInsets.all(20),
                        color: AppColors.bg,
                        child: TextFormField(
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
                      lineBorder(),
                      ListTile(
                        title:
                            Text(AppLocalizations.of(context)!.store_category),
                        trailing: arrowIcon(),
                        onTap: () => Navigator.of(context)
                            .pushNamed(AppRoutes.storeCategoryScreen),
                      ),
                      lineBorder(),
                      ListTile(
                        title: Text(
                          AppLocalizations.of(context)!.city,
                        ),
                        trailing: arrowIcon(),
                        onTap: () => Navigator.of(context)
                            .pushNamed(AppRoutes.citiesScreen),
                      ),
                      lineBorder(),
                      ListTile(
                        title: Text(
                          AppLocalizations.of(context)!.area,
                        ),
                        trailing: arrowIcon(),
                        onTap: () => Navigator.of(context)
                            .pushNamed(AppRoutes.areaScreen),
                      ),
                      lineBorder(),
                      ListTile(
                        title: Text(
                          AppLocalizations.of(context)!.tags,
                        ),
                        trailing: arrowIcon(),
                        onTap: () => Navigator.of(context)
                            .pushNamed(AppRoutes.tagsScreen),
                      ),
                      lineBorder(),
                      ListTile(
                        title: Text(
                          AppLocalizations.of(context)!.value_type,
                        ),
                        trailing: arrowIcon(),
                        onTap: () => Navigator.of(context)
                            .pushNamed(AppRoutes.valueTypeScreen),
                      ),
                      lineBorder(),
                      const SizedBox(height: 100),
                      AppButton(
                        width: 280,
                        title: AppLocalizations.of(context)!.search1,
                        onPressed: () {
                          Navigator.of(context)
                              .pushNamed(AppRoutes.searchResultScreen);
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget arrowIcon() {
    return const Icon(
      Icons.arrow_forward_ios,
      color: AppColors.primaryDark,
      size: 20,
    );
  }
}
