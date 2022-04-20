import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jhentai/src/config/global_config.dart';
import 'package:jhentai/src/routes/routes.dart';

import '../../../utils/route_util.dart';
import '../../../utils/screen_size_util.dart';
import '../../start_page.dart';
import '../read_page_logic.dart';

class ReadViewHelper extends StatelessWidget {
  final logic = Get.find<ReadPageLogic>();
  final state = Get.find<ReadPageLogic>().state;
  final Widget child;

  ReadViewHelper({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        _buildGestureRegion(),
        _buildTopMenu(context),
        _buildBottomMenu(context),
      ],
    );
  }

  /// turn page and pop menu gesture
  Widget _buildGestureRegion() {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: logic.toPrev,
            onDoubleTap: logic.toPrev,
          ),
        ),
        Expanded(
          flex: 4,
          child: Column(
            children: [
              const Expanded(flex: 1, child: SizedBox()),
              Expanded(
                flex: 2,
                child: GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: logic.toggleMenu,
                  onDoubleTap: logic.toggleMenu,
                ),
              ),
              const Expanded(flex: 1, child: SizedBox()),
            ],
          ),
        ),
        Expanded(
          flex: 1,
          child: GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: logic.toNext,
            onDoubleTap: logic.toNext,
          ),
        ),
      ],
    );
  }

  Widget _buildTopMenu(BuildContext context) {
    return GetBuilder<ReadPageLogic>(
      id: 'menu',
      builder: (logic) {
        return AnimatedPositioned(
          duration: const Duration(milliseconds: 200),
          curve: Curves.ease,
          height: state.isMenuOpen ? GlobalConfig.appBarHeight + context.mediaQuery.padding.top : 0,
          child: SizedBox(
            height: GlobalConfig.appBarHeight + context.mediaQuery.padding.top,
            width: fullScreenWidth,
            child: AppBar(
              iconTheme: const IconThemeData(color: Colors.white),
              actionsIconTheme: const IconThemeData(color: Colors.white),
              backgroundColor: Colors.black.withOpacity(0.8),
              actions: [
                IconButton(
                  onPressed: () => toNamed(Routes.settingRead, id: fullScreen),
                  icon: const Icon(Icons.settings),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildBottomMenu(BuildContext context) {
    return GetBuilder<ReadPageLogic>(
      id: 'menu',
      builder: (logic) {
        return AnimatedPositioned(
          duration: const Duration(milliseconds: 200),
          curve: Curves.ease,
          bottom: 0,
          height: state.isMenuOpen ? GlobalConfig.bottomMenuHeight : 0,
          child: ColoredBox(
            color: Colors.black.withOpacity(0.8),
            child: Column(
              children: [
                SizedBox(
                  width: fullScreenWidth,
                  child: Row(
                    children: [
                      Text(
                        (state.readIndexRecord + 1).toString(),
                        style: state.readPageTextStyle(),
                      ).marginSymmetric(horizontal: 16),
                      Expanded(
                        child: Material(
                          color: Colors.transparent,
                          child: Slider(
                            min: 1,
                            max: state.pageCount.toDouble(),
                            value: state.readIndexRecord + 1.0,
                            thumbColor: Colors.white,
                            onChanged: logic.handleSlide,
                            onChangeEnd: logic.handleSlideEnd,
                          ),
                        ),
                      ),
                      Text(
                        state.pageCount.toString(),
                        style: state.readPageTextStyle(),
                      ).marginSymmetric(horizontal: 16),
                    ],
                  ).marginOnly(top: 8),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}