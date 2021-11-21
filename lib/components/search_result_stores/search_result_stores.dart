import 'package:flutter/material.dart';
import 'package:value_client/components/search_result_stores/search_result_card.dart';
import 'package:value_client/resources/colors/colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:value_client/routes/app_routes.dart';

class SearchResultStores extends StatefulWidget {
  final Map<String, Object> category;
  final bool isAll;
  final Function onSelect;

  const SearchResultStores(
    this.category,
    this.isAll,
    this.onSelect,
    Key? key,
  ) : super(key: key);
  @override
  _SearchResultStoresState createState() => _SearchResultStoresState();
}

class _SearchResultStoresState extends State<SearchResultStores> {
  List<Map<String, Object>> data = [
    {
      "name": "Noon",
      "upTo": "15",
      "valueType": "15",
      "city": "Riyadh",
      "area": "The Northern Area"
    },
    {
      "name": "HIBOBI",
      "upTo": "20",
      "valueType": "50",
      "city": "Damam",
      "area": "The Northern Area"
    },
    {
      "name": "PATPAT",
      "upTo": "10",
      "valueType": "25",
      "city": "Riyadh",
      "area": "The Northern Area"
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              AppLocalizations.of(context)!.search_result,
              style: const TextStyle(
                color: AppColors.primaryDark,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pushNamed(AppRoutes.sortByScreen);
              },
              child: Row(
                children: [
                  Text(
                    AppLocalizations.of(context)!.sort_by,
                    style: const TextStyle(
                      color: AppColors.grayText,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const Icon(
                    Icons.keyboard_arrow_down,
                    color: AppColors.grayText,
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 15,
        ),
        Column(
          children: data
              .map((e) => SearchResultCard(
                  name: e["name"] as String,
                  upTo: e["upTo"] as String,
                  valueType: e["valueType"] as String,
                  city: e["city"] as String,
                  area: e["area"] as String,
                  categoryColor: widget.category['color'] as Color))
              .toList(),
        ),
      ],
    );
  }
}
