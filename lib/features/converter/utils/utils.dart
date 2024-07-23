import 'package:flutter/foundation.dart';

import '../../../main.dart';

bool get isDarkMode =>
    sharedPreferences.getBool("darkmode") ??
    PlatformDispatcher.instance.platformBrightness == Brightness.dark;
