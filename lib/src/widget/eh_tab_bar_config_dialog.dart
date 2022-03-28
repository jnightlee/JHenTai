import 'package:flukit/flukit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:jhentai/src/model/search_config.dart';
import 'package:jhentai/src/model/tab_bar_config.dart';
import 'package:jhentai/src/pages/home/tab_view/gallerys/gallerys_view_logic.dart';

import 'gallery_category_tag.dart';

enum EHTabBarConfigDialogType {
  /// update a tabBar config
  update,

  /// add a new tabBar
  addTabBar,

  /// in search page, filter the result
  filter,
}

class EHTabBarConfigDialog extends StatefulWidget {
  final TabBarConfig? tabBarConfig;
  final EHTabBarConfigDialogType type;

  const EHTabBarConfigDialog({Key? key, this.tabBarConfig, required this.type}) : super(key: key);

  @override
  _EHTabBarConfigDialogState createState() => _EHTabBarConfigDialogState();
}

class _EHTabBarConfigDialogState extends State<EHTabBarConfigDialog> {
  final GallerysViewLogic gallerysViewLogic = Get.find();
  late TabBarConfig tabBarConfig;

  @override
  void initState() {
    tabBarConfig = widget.tabBarConfig ?? TabBarConfig(name: '', searchConfig: SearchConfig());
    super.initState();
  }

  @override
  void deactivate() {
    /// notify listeners to rebuild page and save new config
    if (widget.type == EHTabBarConfigDialogType.update) {
      gallerysViewLogic.handleUpdateTab(tabBarConfig);
    } else if (widget.type == EHTabBarConfigDialogType.addTabBar) {
      gallerysViewLogic.handleAddTab(tabBarConfig);
    }

    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      insetPadding: const EdgeInsets.symmetric(horizontal: 60.0, vertical: 24.0),
      child: SizedBox(
        height: 500,
        child: Column(
          children: [
            Center(
              child: Text(
                _buildTitleText(),
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ).marginOnly(bottom: 12),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    if (widget.type != EHTabBarConfigDialogType.filter)
                      TextField(
                        decoration: InputDecoration(
                          isDense: true,
                          alignLabelWithHint: true,
                          labelText: 'tabBarName'.tr,
                          labelStyle: const TextStyle(fontSize: 12),
                        ),
                        controller: TextEditingController(text: tabBarConfig.name),
                        onChanged: (title) {
                          tabBarConfig.name = title;
                        },
                      ).marginOnly(left: 16, right: 16),
                    CupertinoSlidingSegmentedControl<SearchType>(
                      groupValue: tabBarConfig.searchConfig.searchType,
                      children: {
                        SearchType.gallery: Text('gallery'.tr).paddingSymmetric(horizontal: 10),
                        SearchType.favorite: Text('favorite'.tr).paddingSymmetric(horizontal: 10),
                        SearchType.watched: Text('watched'.tr).paddingSymmetric(horizontal: 10),
                      },
                      onValueChanged: (type) {
                        setState(() {
                          tabBarConfig.searchConfig.searchType = type!;
                        });
                      },
                    ).marginOnly(top: 24),
                    if (tabBarConfig.searchConfig.searchType == SearchType.gallery ||
                        tabBarConfig.searchConfig.searchType == SearchType.watched)
                      Column(
                        children: [
                          _buildCategoryTags().marginOnly(top: 20),
                          if (widget.type != EHTabBarConfigDialogType.filter)
                            TextField(
                              decoration: InputDecoration(
                                isDense: true,
                                alignLabelWithHint: true,
                                labelText: 'keyword'.tr,
                                labelStyle: const TextStyle(fontSize: 12),
                              ),
                              controller: TextEditingController(text: tabBarConfig.searchConfig.keyword),
                              onChanged: (keyword) {
                                tabBarConfig.searchConfig.keyword = keyword;
                              },
                            ).marginOnly(left: 16, right: 16, top: 16),
                          ListTile(
                            title: Text('searchGalleryName'.tr, style: const TextStyle(fontSize: 15)),
                            dense: true,
                            trailing: Switch(
                              value: tabBarConfig.searchConfig.searchGalleryName,
                              onChanged: (bool value) {
                                setState(() {
                                  tabBarConfig.searchConfig.searchGalleryName = value;
                                });
                              },
                            ),
                          ).marginOnly(top: 24),
                          ListTile(
                            title: Text('searchGalleryTags'.tr, style: const TextStyle(fontSize: 15)),
                            dense: true,
                            trailing: Switch(
                              value: tabBarConfig.searchConfig.searchGalleryTags,
                              onChanged: (bool value) {
                                setState(() {
                                  tabBarConfig.searchConfig.searchGalleryTags = value;
                                });
                              },
                            ),
                          ),
                          ListTile(
                            title: Text('searchGalleryDescription'.tr, style: const TextStyle(fontSize: 15)),
                            dense: true,
                            trailing: Switch(
                              value: tabBarConfig.searchConfig.searchGalleryDescription,
                              onChanged: (bool value) {
                                setState(() {
                                  tabBarConfig.searchConfig.searchGalleryDescription = value;
                                });
                              },
                            ),
                          ),
                          ListTile(
                            title: Text('searchExpungedGalleries'.tr, style: const TextStyle(fontSize: 15)),
                            dense: true,
                            trailing: Switch(
                              value: tabBarConfig.searchConfig.searchExpungedGalleries,
                              onChanged: (bool value) {
                                setState(() {
                                  tabBarConfig.searchConfig.searchExpungedGalleries = value;
                                });
                              },
                            ),
                          ),
                          ListTile(
                            title: Text('pagesBetween'.tr, style: const TextStyle(fontSize: 15)),
                            dense: true,
                            trailing: SizedBox(
                              width: 110,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    width: 40,
                                    child: CupertinoTextField(
                                      controller: TextEditingController(
                                          text: tabBarConfig.searchConfig.pageAtLeast?.toString()),
                                      inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'\d'))],
                                      textAlign: TextAlign.center,
                                      onChanged: (value) => tabBarConfig.searchConfig.pageAtLeast =
                                          value.isEmpty ? null : int.parse(value),
                                    ),
                                  ),
                                  Text('to'.tr),
                                  SizedBox(
                                    width: 40,
                                    child: CupertinoTextField(
                                      controller:
                                          TextEditingController(text: tabBarConfig.searchConfig.pageAtMost?.toString()),
                                      inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'\d'))],
                                      textAlign: TextAlign.center,
                                      onChanged: (value) => tabBarConfig.searchConfig.pageAtMost =
                                          value.isEmpty ? null : int.parse(value),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          ListTile(
                            title: Text('minimumRating'.tr, style: const TextStyle(fontSize: 15)),
                            dense: true,
                            trailing: SizedBox(
                              width: 50,
                              child: DropdownButton<int>(
                                value: tabBarConfig.searchConfig.minimumRating,
                                elevation: 4,
                                onChanged: (int? newValue) {
                                  setState(() {
                                    tabBarConfig.searchConfig.minimumRating = newValue!;
                                  });
                                },
                                items: const [
                                  DropdownMenuItem(
                                    child: Text('1'),
                                    value: 1,
                                  ),
                                  DropdownMenuItem(
                                    child: Text('2'),
                                    value: 2,
                                  ),
                                  DropdownMenuItem(
                                    child: Text('3'),
                                    value: 3,
                                  ),
                                  DropdownMenuItem(
                                    child: Text('4'),
                                    value: 4,
                                  ),
                                  DropdownMenuItem(
                                    child: Text('5'),
                                    value: 5,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          ListTile(
                            title: Text('disableFilterForLanguage'.tr, style: const TextStyle(fontSize: 15)),
                            dense: true,
                            trailing: Switch(
                              value: tabBarConfig.searchConfig.disableFilterForLanguage,
                              onChanged: (bool value) {
                                setState(() {
                                  tabBarConfig.searchConfig.disableFilterForLanguage = value;
                                });
                              },
                            ),
                          ),
                          ListTile(
                            title: Text('disableFilterForUploader'.tr, style: const TextStyle(fontSize: 15)),
                            dense: true,
                            trailing: Switch(
                              value: tabBarConfig.searchConfig.disableFilterForUploader,
                              onChanged: (bool value) {
                                setState(() {
                                  tabBarConfig.searchConfig.disableFilterForUploader = value;
                                });
                              },
                            ),
                          ),
                          ListTile(
                            title: Text('disableFilterForTags'.tr, style: const TextStyle(fontSize: 15)),
                            dense: true,
                            trailing: Switch(
                              value: tabBarConfig.searchConfig.disableFilterForTags,
                              onChanged: (bool value) {
                                setState(() {
                                  tabBarConfig.searchConfig.disableFilterForTags = value;
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    if (tabBarConfig.searchConfig.searchType == SearchType.favorite)
                      Column(
                        children: [
                          ListTile(
                            key: const Key('searchName'),
                            title: Text('searchName'.tr, style: const TextStyle(fontSize: 15)),
                            dense: true,
                            trailing: KeepAliveWrapper(
                              child: Switch(
                                value: tabBarConfig.searchConfig.searchFavoriteName,
                                onChanged: (bool value) {
                                  setState(() {
                                    tabBarConfig.searchConfig.searchFavoriteName = value;
                                  });
                                },
                              ),
                            ),
                          ).marginOnly(top: 24),
                          ListTile(
                            key: const Key('searchTags'),
                            title: Text('searchTags'.tr, style: const TextStyle(fontSize: 15)),
                            dense: true,
                            trailing: Switch(
                              value: tabBarConfig.searchConfig.searchFavoriteTags,
                              onChanged: (bool value) {
                                setState(() {
                                  tabBarConfig.searchConfig.searchFavoriteTags = value;
                                });
                              },
                            ),
                          ),
                          ListTile(
                            key: const Key('searchNote'),
                            title: Text('searchNote'.tr, style: const TextStyle(fontSize: 15)),
                            dense: true,
                            trailing: Switch(
                              value: tabBarConfig.searchConfig.searchFavoriteNote,
                              onChanged: (bool value) {
                                setState(() {
                                  tabBarConfig.searchConfig.searchFavoriteNote = value;
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                  ],
                ),
              ),
            ),
          ],
        ).marginOnly(top: 22, bottom: 22),
      ),
    );
  }

  String _buildTitleText() {
    switch (widget.type) {
      case EHTabBarConfigDialogType.update:
        return 'updateTabBar'.tr;
      case EHTabBarConfigDialogType.addTabBar:
        return 'addTabBar'.tr;
      case EHTabBarConfigDialogType.filter:
        return 'filterConfig'.tr;
    }
  }

  Widget _buildCategoryTags() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildCategoryTag(
              category: 'Doujinshi',
              enabled: tabBarConfig.searchConfig.includeDoujinshi,
              onTap: () {
                setState(() {
                  tabBarConfig.searchConfig.includeDoujinshi = !tabBarConfig.searchConfig.includeDoujinshi;
                });
              },
            ),
            _buildCategoryTag(
              category: 'Manga',
              enabled: tabBarConfig.searchConfig.includeManga,
              onTap: () {
                setState(() {
                  tabBarConfig.searchConfig.includeManga = !tabBarConfig.searchConfig.includeManga;
                });
              },
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildCategoryTag(
              category: 'Image Set',
              enabled: tabBarConfig.searchConfig.includeImageSet,
              onTap: () {
                setState(() {
                  tabBarConfig.searchConfig.includeImageSet = !tabBarConfig.searchConfig.includeImageSet;
                });
              },
            ),
            _buildCategoryTag(
              category: 'Game CG',
              enabled: tabBarConfig.searchConfig.includeGameCg,
              onTap: () {
                setState(() {
                  tabBarConfig.searchConfig.includeGameCg = !tabBarConfig.searchConfig.includeGameCg;
                });
              },
            ),
          ],
        ).marginOnly(top: 4),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildCategoryTag(
              category: 'Artist CG',
              enabled: tabBarConfig.searchConfig.includeArtistCG,
              onTap: () {
                setState(() {
                  tabBarConfig.searchConfig.includeArtistCG = !tabBarConfig.searchConfig.includeArtistCG;
                });
              },
            ),
            _buildCategoryTag(
              category: 'Cosplay',
              enabled: tabBarConfig.searchConfig.includeCosplay,
              onTap: () {
                setState(() {
                  tabBarConfig.searchConfig.includeCosplay = !tabBarConfig.searchConfig.includeCosplay;
                });
              },
            ),
          ],
        ).marginOnly(top: 4),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildCategoryTag(
              category: 'Non-H',
              enabled: tabBarConfig.searchConfig.includeNonH,
              onTap: () {
                setState(() {
                  tabBarConfig.searchConfig.includeNonH = !tabBarConfig.searchConfig.includeNonH;
                });
              },
            ),
            _buildCategoryTag(
              category: 'Asian Porn',
              enabled: tabBarConfig.searchConfig.includeAsianPorn,
              onTap: () {
                setState(() {
                  tabBarConfig.searchConfig.includeAsianPorn = !tabBarConfig.searchConfig.includeAsianPorn;
                });
              },
            ),
          ],
        ).marginOnly(top: 4),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildCategoryTag(
              category: 'Western',
              enabled: tabBarConfig.searchConfig.includeWestern,
              onTap: () {
                setState(() {
                  tabBarConfig.searchConfig.includeWestern = !tabBarConfig.searchConfig.includeWestern;
                });
              },
            ),
            _buildCategoryTag(
              category: 'Misc',
              enabled: tabBarConfig.searchConfig.includeMisc,
              onTap: () {
                setState(() {
                  tabBarConfig.searchConfig.includeMisc = !tabBarConfig.searchConfig.includeMisc;
                });
              },
            ),
          ],
        ).marginOnly(top: 4),
      ],
    ).paddingSymmetric(horizontal: 16);
  }

  Widget _buildCategoryTag({required String category, required bool enabled, VoidCallback? onTap}) {
    return GalleryCategoryTag(
      category: category,
      width: 115,
      height: 30,
      enabled: enabled,
      textStyle: const TextStyle(height: 1, fontSize: 16, color: Colors.white),
      onTap: onTap,
    );
  }
}
