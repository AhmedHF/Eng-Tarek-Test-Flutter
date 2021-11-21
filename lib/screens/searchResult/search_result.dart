import 'package:flutter/material.dart';
import 'package:value_client/components/search_result_stores/search_result_stores.dart';
import 'package:value_client/resources/index.dart';
import 'package:value_client/widgets/index.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SearchResultScreen extends StatefulWidget {
  const SearchResultScreen({Key? key}) : super(key: key);

  @override
  _SearchResultScreenState createState() => _SearchResultScreenState();
}

class _SearchResultScreenState extends State<SearchResultScreen> {
  bool empty = false;

  List<Map<String, Object>> data = [
    {"name": "All", "iconName": Icons.settings, "color": AppColors.primaryL},
    {
      "name": "Beauty",
      "iconName": AppIcons.skincare,
      "color": AppColors.primaryL
    },
    {
      "name": "Electronics",
      "iconName": AppIcons.cpu,
      "color": AppColors.accentL
    },
    {
      "name": "Fitness",
      "iconName": AppIcons.dumbell,
      "color": Colors.blueAccent
    },
  ];

  @override
  Widget build(BuildContext context) {
    if (empty) {
      return emptyWidget(context);
    } else {
      return Scaffold(
        appBar: AppBar(
          title: Container(),
        ),
        body: NetworkSensitive(
          child: Stack(
            children: <Widget>[
              Image.asset(
                AppImages.background,
                height: double.infinity,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              SingleChildScrollView(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      AppImages.logo,
                      height: 70,
                      width: 120,
                      fit: BoxFit.contain,
                    ),
                    const SizedBox(height: 15),
                    // AppSwiper([]),
                    Column(
                      children: <Widget>[
                        Container(
                          decoration: ShapeDecoration(
                              shape: WeirdBorder(radius: 10, pathWidth: 1000),
                              color: AppColors.backgroundGrey),
                          margin: const EdgeInsets.only(bottom: 1, top: 5),
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Column(
                            children: <Widget>[
                              const SizedBox(height: 20),
                              Column(
                                children: <Widget>[
                                  SearchResultStores(
                                    data[1],
                                    true,
                                    () => {},
                                    const Key('SearchResultStores'),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      );
    }
  }

  Widget emptyWidget(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      resizeToAvoidBottomInset: false,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: TextFormField(
                  onTap: () {
                    FocusScope.of(context).requestFocus(FocusNode());
                    Navigator.of(context).pop();
                  },
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.zero,
                    hintText: AppLocalizations.of(context)!.search,
                    hintStyle:
                        const TextStyle(color: AppColors.white, fontSize: 16),
                    prefixIcon: const Icon(
                      AppIcons.search,
                      color: AppColors.white,
                      size: 16,
                    ),
                    suffixIcon: const Icon(
                      AppIcons.close,
                      color: AppColors.white,
                      size: 14,
                    ),
                    fillColor: AppColors.gray,
                    labelStyle: const TextStyle(
                      color: AppColors.grayText,
                      backgroundColor: AppColors.grayText,
                    ),
                    enabledBorder: OutlineInputBorder(
                      // width: 0.0 produces a thin "hairline" border
                      borderRadius: BorderRadius.circular(30),
                      borderSide: const BorderSide(color: AppColors.gray),
                    ),
                    // border: OutlineInputBorder(
                    //   borderRadius: BorderRadius.circular(30),
                    // ),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              Image.asset(
                AppImages.no_result,
                height: 200,
                width: 200,
                fit: BoxFit.cover,
              ),
              const SizedBox(height: 30),
              Text(
                AppLocalizations.of(context)!.sorry_not_match,
                style: Theme.of(context).textTheme.headline5,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              Text(
                AppLocalizations.of(context)!.please_searching_another_term,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(height: 50),
              AppButton(
                width: 280,
                title: AppLocalizations.of(context)!.back,
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
