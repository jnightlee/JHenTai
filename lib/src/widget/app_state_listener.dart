import 'package:blur/blur.dart';
import 'package:flutter/material.dart';
import 'package:flutter_windowmanager/flutter_windowmanager.dart';
import 'package:get/get.dart';

import '../routes/routes.dart';
import '../setting/security_setting.dart';
import '../setting/style_setting.dart';
import '../utils/log.dart';
import '../utils/route_util.dart';

typedef DidChangePlatformBrightnessCallback = void Function();
typedef DidChangeAppLifecycleStateCallback = void Function(AppLifecycleState state);
typedef AppLaunchCallback = void Function(BuildContext context);

class AppStateListener extends StatefulWidget {
  static final List<DidChangePlatformBrightnessCallback> _didChangePlatformBrightnessCallbacks = [];
  static final List<DidChangeAppLifecycleStateCallback> _didChangeAppLifecycleStateCallbacks = [];
  static final List<AppLaunchCallback> _appLaunchCallbacks = [];

  final Widget child;

  const AppStateListener({Key? key, required this.child}) : super(key: key);

  @override
  State<AppStateListener> createState() => _AppStateListenerState();

  static void registerDidChangePlatformBrightnessCallback(DidChangePlatformBrightnessCallback callback) {
    _didChangePlatformBrightnessCallbacks.add(callback);
  }

  static void unRegisterDidChangePlatformBrightnessCallback(DidChangePlatformBrightnessCallback callback) {
    _didChangePlatformBrightnessCallbacks.remove(callback);
  }

  static void registerDidChangeAppLifecycleStateCallback(DidChangeAppLifecycleStateCallback callback) {
    _didChangeAppLifecycleStateCallbacks.add(callback);
  }

  static void unRegisterDidChangeAppLifecycleStateCallback(DidChangeAppLifecycleStateCallback callback) {
    _didChangeAppLifecycleStateCallbacks.remove(callback);
  }

  static void registerAppLaunchCallback(AppLaunchCallback callback) {
    _appLaunchCallbacks.add(callback);
  }

  static void unRegisterAppLaunchCallback(AppLaunchCallback callback) {
    _appLaunchCallbacks.remove(callback);
  }
}

class _AppStateListenerState extends State<AppStateListener> with WidgetsBindingObserver {
  DateTime? lastInactiveTime;
  bool inBlur = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    AppStateListener.registerAppLaunchCallback(_addSecureFlagForAndroid);
    AppStateListener.registerDidChangePlatformBrightnessCallback(_changeTheme);
    AppStateListener.registerDidChangeAppLifecycleStateCallback(_lockAfterResume);

    for (var callback in AppStateListener._appLaunchCallbacks) {
      callback.call(context);
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangePlatformBrightness() {
    for (DidChangePlatformBrightnessCallback callback in AppStateListener._didChangePlatformBrightnessCallbacks) {
      callback.call();
    }
    super.didChangePlatformBrightness();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    for (DidChangeAppLifecycleStateCallback callback in AppStateListener._didChangeAppLifecycleStateCallbacks) {
      callback.call(state);
    }
    super.didChangeAppLifecycleState(state);
  }

  @override
  Widget build(BuildContext context) {
    return inBlur ? Blur(blur: 100, colorOpacity: 1, child: widget.child) : widget.child;
  }

  /// for Android, blur is invalid when switch app to background(app is still clearly visible in switcher),
  /// so i choose to set FLAG_SECURE to do the same effect.
  void _addSecureFlagForAndroid(BuildContext context) {
    if (GetPlatform.isAndroid && (SecuritySetting.enableAuthOnResume.isTrue || SecuritySetting.enableBlur.isTrue)) {
      FlutterWindowManager.addFlags(FlutterWindowManager.FLAG_SECURE);
    }
  }

  void _changeTheme() {
    if (StyleSetting.themeMode.value != ThemeMode.system) {
      return;
    }
    Get.changeThemeMode(
      WidgetsBinding.instance.window.platformBrightness == Brightness.light ? ThemeMode.light : ThemeMode.dark,
    );
  }

  void _lockAfterResume(AppLifecycleState state) {
    Log.debug("App state change: -> $state");

    if (state == AppLifecycleState.inactive || state == AppLifecycleState.paused) {
      if (SecuritySetting.enableAuthOnResume.isTrue) {
        lastInactiveTime ??= DateTime.now();
      }

      if ((SecuritySetting.enableAuthOnResume.isTrue || SecuritySetting.enableBlur.isTrue) && !inBlur && !isRouteAtTop(Routes.lock)) {
        setState(() => inBlur = true);
      }
    }

    if (state == AppLifecycleState.resumed) {
      if (!inBlur) {
        return;
      }

      if (SecuritySetting.enableBlur.isFalse) {
        return;
      }

      if (SecuritySetting.enableAuthOnResume.isFalse) {
        setState(() => inBlur = false);
        return;
      }

      if (SecuritySetting.enablePasswordAuth.isTrue || SecuritySetting.enableBiometricAuth.isTrue) {
        toRoute(Routes.lock);
        Future.delayed(const Duration(milliseconds: 500), () => setState(() => inBlur = false));
        lastInactiveTime = null;
      } else {
        setState(() => inBlur = false);
        return;
      }
    }
  }
}
