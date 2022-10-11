import 'dart:io';

import 'package:flutter/material.dart';
import 'package:titlebar_buttons/titlebar_buttons.dart';
import 'package:window_manager/window_manager.dart';

class TitleBar extends StatelessWidget {
  const TitleBar({super.key});

  final ThemeType _currentThemeType = ThemeType.auto;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;

    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 40,
      child: Row(
        children: Platform.isMacOS
            ? [
                Row(
                  children: [
                    InkWell(
                      customBorder: const CircleBorder(side: BorderSide()),
                      mouseCursor: MouseCursor.defer,
                      onTap: () {},
                      onHover: (value) {},
                      child: DecoratedCloseButton(
                        type: _currentThemeType,
                        onPressed: () => windowManager.hide(),
                      ),
                    ),
                    InkWell(
                      customBorder: const CircleBorder(side: BorderSide()),
                      mouseCursor: MouseCursor.defer,
                      onTap: () {},
                      onHover: (value) {},
                      child: DecoratedMinimizeButton(
                        type: _currentThemeType,
                        onPressed: () => windowManager.minimize(),
                      ),
                    ),
                    InkWell(
                      customBorder: const CircleBorder(side: BorderSide()),
                      mouseCursor: MouseCursor.defer,
                      onTap: () {},
                      onHover: (value) {},
                      child: DecoratedMaximizeButton(
                        type: _currentThemeType,
                        onPressed: () async =>
                            await windowManager.isFullScreen()
                                ? windowManager.setFullScreen(false)
                                : windowManager.setFullScreen(true),
                      ),
                    ),
                  ],
                ),
                Flexible(
                    child: GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onPanStart: (details) {
                    windowManager.startDragging();
                  },
                  onDoubleTap: () async {
                    bool isMaximized = await windowManager.isMaximized();
                    if (!isMaximized) {
                      windowManager.maximize();
                    } else {
                      windowManager.unmaximize();
                    }
                  },
                )),
              ]
            : [
                Expanded(
                  child: GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onPanStart: (details) {
                      windowManager.startDragging();
                    },
                    onDoubleTap: () async {
                      bool isMaximized = await windowManager.isMaximized();
                      if (!isMaximized) {
                        windowManager.maximize();
                      } else {
                        windowManager.unmaximize();
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(12, 13, 0, 3),
                      child: Text(
                        'OpenHMS',
                        style: TextStyle(
                            color: theme.onBackground, fontSize: 16.0),
                      ),
                    ),
                  ),
                ),
                Row(
                  children: [
                    InkWell(
                      onTap: () {},
                      onHover: (value) {},
                      child: DecoratedMinimizeButton(
                        type: _currentThemeType,
                        onPressed: () => windowManager.minimize(),
                        height: 40,
                      ),
                    ),
                    InkWell(
                      onTap: () {},
                      onHover: (value) {},
                      child: DecoratedMaximizeButton(
                        type: _currentThemeType,
                        onPressed: () async => await windowManager.isMaximized()
                            ? windowManager.unmaximize()
                            : windowManager.maximize(),
                        height: 40,
                      ),
                    ),
                    InkWell(
                      onTap: () {},
                      onHover: (value) {},
                      child: DecoratedCloseButton(
                        type: _currentThemeType,
                        onPressed: () => windowManager.close(),
                        height: 40,
                      ),
                    ),
                  ],
                ),
              ],
      ),
    );
  }
}
