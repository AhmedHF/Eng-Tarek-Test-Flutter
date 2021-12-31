import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:value_client/resources/index.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:value_client/widgets/index.dart';

import '../../core/services/dynamic_links_service.dart';

class SearchBreanchListScreen extends StatefulWidget {
  const SearchBreanchListScreen({Key? key}) : super(key: key);

  @override
  _SearchBreanchListScreenState createState() =>
      _SearchBreanchListScreenState();
}

class _SearchBreanchListScreenState extends State<SearchBreanchListScreen> {
  final TextEditingController search = TextEditingController();
  late List branches = [];
  late bool isFirst = true;
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> arguments =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    debugPrint('ARGUMENTS: ${arguments['workingFrom']}', wrapWidth: 1024);

    if (isFirst) {
      List all = arguments['branches'];
      for (var item in all) {
        item['isExpanded'] = false;
      }
      debugPrint('ALL: $all}', wrapWidth: 1024);

      setState(() {
        branches = all;
        //arguments['branches'];
        isFirst = false;
      });
    }
    return Scaffold(
      backgroundColor: AppColors.bg,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        toolbarHeight: 0,
      ),
      body: Stack(
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
                dashPattern: const [5, 3],
                customPath: (size) {
                  return Path()
                    ..moveTo(0, size.height)
                    ..lineTo(size.width, size.height);
                },
                child: Container(
                  padding: const EdgeInsets.only(
                      left: 10, right: 10, top: 50, bottom: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        AppLocalizations.of(context)!.branch_list,
                        style: const TextStyle(
                          color: AppColors.primaryDark,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      IconButton(
                        onPressed: () => {
                          Navigator.of(context).pop(),
                        },
                        icon: const Icon(
                          AppIcons.close,
                          size: 16,
                          color: AppColors.primaryL,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              arguments['branches'].length == 0
                  ? Container(
                      height: 50,
                    )
                  : Container(
                      padding: const EdgeInsets.all(20),
                      color: AppColors.bg,
                      child: TextFormField(
                        controller: search,
                        onChanged: (v) {
                          if (v == '') {
                            setState(() {
                              branches =
                                  List.from(arguments['branches']).toList();
                            });
                          } else {
                            List temp = arguments['branches'].where((element) {
                              if ((element['city']['name'].toUpperCase())
                                  .contains(v.trim().toUpperCase())) {
                                return true;
                              } else {
                                return false;
                              }
                            }).toList();
                            setState(() {
                              branches = List.from(temp);
                            });
                          }
                        },
                        onFieldSubmitted: (_) {},
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.zero,
                          hintText: AppLocalizations.of(context)!.search,
                          hintStyle: const TextStyle(
                              color: AppColors.grayText, fontSize: 15),
                          prefixIcon: const Icon(
                            AppIcons.search,
                            color: AppColors.grayText,
                            size: 16,
                          ),
                          fillColor: AppColors.bg,
                          labelStyle: const TextStyle(
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
              Expanded(
                flex: 5,
                child: SingleChildScrollView(
                  child: branches.isEmpty
                      ? Text(AppLocalizations.of(context)!.no_data)
                      : _buildPanel(
                          arguments['workingFrom'], arguments['workingTo']),
                ),
              ),
              Expanded(
                flex: 1,
                child: Center(
                  child: AppButton(
                    width: 280,
                    title: AppLocalizations.of(context)!.continue_btn,
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPanel(from, to) {
    return Theme(
      data: ThemeData().copyWith(
        canvasColor: Colors.transparent,
      ),
      child: ExpansionPanelList(
        expandedHeaderPadding: EdgeInsets.zero,
        animationDuration: const Duration(milliseconds: 1500),
        expansionCallback: (int index, bool isExpanded) {
          setState(() {
            branches[index]['isExpanded'] = !isExpanded;
          });
        },
        children: branches.map<ExpansionPanel>((item) {
          return ExpansionPanel(
            headerBuilder: (BuildContext context, bool isExpanded) {
              return ListTile(
                title: Text(
                  item['store_name'],
                  maxLines: 2,
                  softWrap: true,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.w600),
                ),
              );
            },
            body: NetworkSensitive(
              child: Column(
                children: [
                  ListTile(
                    title: Text(
                      item['city']['name'],
                      maxLines: 2,
                      softWrap: true,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                    subtitle: Text(
                      item['address'],
                      maxLines: 2,
                      softWrap: true,
                      overflow: TextOverflow.ellipsis,
                    ),
                    trailing: IconButton(
                      onPressed: () {
                        openURL(item['location']);
                      },
                      icon: const Icon(
                        AppIcons.location_pin,
                        color: AppColors.accentL,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 30,
                      right: 10,
                      bottom: 10,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: <Widget>[
                            const Icon(
                              Icons.access_time,
                              color: AppColors.primaryDark,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              AppLocalizations.of(context)!.work_time,
                              style: const TextStyle(
                                color: AppColors.primaryDark,
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            )
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Text(
                              ' ${AppLocalizations.of(context)!.from} $from',
                              style: const TextStyle(
                                  color: AppColors.primaryL, fontSize: 14),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              ' ${AppLocalizations.of(context)!.to} $to',
                              style: const TextStyle(
                                  color: AppColors.primaryL, fontSize: 14),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            isExpanded: item['isExpanded'],
            canTapOnHeader: true,
          );
        }).toList(),
      ),
    );
  }
}
