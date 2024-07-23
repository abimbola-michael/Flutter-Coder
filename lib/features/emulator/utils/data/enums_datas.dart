import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';

dynamic enumsDatas(String name, String value) {
  return {
    "AndroidOverscrollIndicator": {
      "stretch": AndroidOverscrollIndicator.stretch,
      "glow": AndroidOverscrollIndicator.glow,
    },
    "AnimationBehavior": {
      "normal": AnimationBehavior.normal,
      "preserve": AnimationBehavior.preserve,
    },
    "AnimationStatus": {
      "dismissed": AnimationStatus.dismissed,
      "forward": AnimationStatus.forward,
      "reverse": AnimationStatus.reverse,
      "completed": AnimationStatus.completed,
    },
    "Assertiveness": {
      "polite": Assertiveness.polite,
      "assertive": Assertiveness.assertive,
    },
    "AutofillContextAction": {
      "commit": AutofillContextAction.commit,
      "cancel": AutofillContextAction.cancel,
    },
    "AutovalidateMode": {
      "disabled": AutovalidateMode.disabled,
      "always": AutovalidateMode.always,
      "onUserInteraction": AutovalidateMode.onUserInteraction,
    },
    "Axis": {
      "horizontal": Axis.horizontal,
      "vertical": Axis.vertical,
    },
    "AxisDirection": {
      "up": AxisDirection.up,
      "right": AxisDirection.right,
      "down": AxisDirection.down,
      "left": AxisDirection.left,
    },
    "BannerLocation": {
      "topStart": BannerLocation.topStart,
      "topEnd": BannerLocation.topEnd,
      "bottomStart": BannerLocation.bottomStart,
      "bottomEnd": BannerLocation.bottomEnd,
    },
    "BlurStyle": {
      "normal": BlurStyle.normal,
      "solid": BlurStyle.solid,
      "outer": BlurStyle.outer,
      "inner": BlurStyle.inner,
    },
    "BorderStyle": {
      "none": BorderStyle.none,
      "solid": BorderStyle.solid,
    },
    "BottomNavigationBarLandscapeLayout": {
      "spread": BottomNavigationBarLandscapeLayout.spread,
      "centered": BottomNavigationBarLandscapeLayout.centered,
      "linear": BottomNavigationBarLandscapeLayout.linear,
    },
    "BottomNavigationBarType": {
      "fixed": BottomNavigationBarType.fixed,
      "shifting": BottomNavigationBarType.shifting,
    },
    "BoxFit": {
      "fill": BoxFit.fill,
      "contain": BoxFit.contain,
      "cover": BoxFit.cover,
      "fitWidth": BoxFit.fitWidth,
      "fitHeight": BoxFit.fitHeight,
      "none": BoxFit.none,
      "scaleDown": BoxFit.scaleDown,
    },
    "BoxHeightStyle": {
      "tight": BoxHeightStyle.tight,
      "max": BoxHeightStyle.max,
      "includeLineSpacingMiddle": BoxHeightStyle.includeLineSpacingMiddle,
      "includeLineSpacingTop": BoxHeightStyle.includeLineSpacingTop,
      "includeLineSpacingBottom": BoxHeightStyle.includeLineSpacingBottom,
      "strut": BoxHeightStyle.strut,
    },
    "BoxShape": {
      "rectangle": BoxShape.rectangle,
      "circle": BoxShape.circle,
    },
    "BoxWidthStyle": {
      "tight": BoxWidthStyle.tight,
      "max": BoxWidthStyle.max,
    },
    "Brightness": {
      "dark": Brightness.dark,
      "light": Brightness.light,
    },
    "ButtonBarLayoutBehavior": {
      "constrained": ButtonBarLayoutBehavior.constrained,
      "padded": ButtonBarLayoutBehavior.padded,
    },
    "ButtonTextTheme": {
      "normal": ButtonTextTheme.normal,
      "accent": ButtonTextTheme.accent,
      "primary": ButtonTextTheme.primary,
    },
    "CacheExtentStyle": {
      "pixel": CacheExtentStyle.pixel,
      "viewport": CacheExtentStyle.viewport,
    },
    "Clip": {
      "none": Clip.none,
      "hardEdge": Clip.hardEdge,
      "antiAlias": Clip.antiAlias,
      "antiAliasWithSaveLayer": Clip.antiAliasWithSaveLayer,
    },
    "ClipOp": {
      "difference": ClipOp.difference,
      "intersect": ClipOp.intersect,
    },
    "ClipboardStatus": {
      "pasteable": ClipboardStatus.pasteable,
      "unknown": ClipboardStatus.unknown,
      "notPasteable": ClipboardStatus.notPasteable,
    },
    "CollapseMode": {
      "parallax": CollapseMode.parallax,
      "pin": CollapseMode.pin,
      "none": CollapseMode.none,
    },
    "ColorSpace": {
      "sRGB": ColorSpace.sRGB,
      "extendedSRGB": ColorSpace.extendedSRGB,
    },
    "ConnectionState": {
      "none": ConnectionState.none,
      "waiting": ConnectionState.waiting,
      "active": ConnectionState.active,
      "done": ConnectionState.done,
    },
    "ContextMenuButtonType": {
      "cut": ContextMenuButtonType.cut,
      "copy": ContextMenuButtonType.copy,
      "paste": ContextMenuButtonType.paste,
      "selectAll": ContextMenuButtonType.selectAll,
      "delete": ContextMenuButtonType.delete,
      "custom": ContextMenuButtonType.custom,
    },
    "CrossAxisAlignment": {
      "start": CrossAxisAlignment.start,
      "end": CrossAxisAlignment.end,
      "center": CrossAxisAlignment.center,
      "stretch": CrossAxisAlignment.stretch,
      "baseline": CrossAxisAlignment.baseline,
    },
    "CrossFadeState": {
      "showFirst": CrossFadeState.showFirst,
      "showSecond": CrossFadeState.showSecond,
    },
    "CupertinoDatePickerMode": {
      "time": CupertinoDatePickerMode.time,
      "date": CupertinoDatePickerMode.date,
      "dateAndTime": CupertinoDatePickerMode.dateAndTime,
    },
    "CupertinoListSectionType": {
      "base": CupertinoListSectionType.base,
      "insetGrouped": CupertinoListSectionType.insetGrouped,
    },
    "CupertinoTimerPickerMode": {
      "hm": CupertinoTimerPickerMode.hm,
      "ms": CupertinoTimerPickerMode.ms,
      "hms": CupertinoTimerPickerMode.hms,
    },
    "CupertinoUserInterfaceLevelData": {
      "base": CupertinoUserInterfaceLevelData.base,
      "elevated": CupertinoUserInterfaceLevelData.elevated,
    },
    "DatePickerDateOrder": {
      "dmy": DatePickerDateOrder.dmy,
      "mdy": DatePickerDateOrder.mdy,
      "ymd": DatePickerDateOrder.ymd,
      "ydm": DatePickerDateOrder.ydm,
    },
    "DatePickerDateTimeOrder": {
      "date_time_dayPeriod": DatePickerDateTimeOrder.date_time_dayPeriod,
      "date_dayPeriod_time": DatePickerDateTimeOrder.date_dayPeriod_time,
      "time_dayPeriod_date": DatePickerDateTimeOrder.time_dayPeriod_date,
      "dayPeriod_time_date": DatePickerDateTimeOrder.dayPeriod_time_date,
    },
    "DatePickerEntryMode": {
      "calendar": DatePickerEntryMode.calendar,
      "input": DatePickerEntryMode.input,
      "calendarOnly": DatePickerEntryMode.calendarOnly,
      "inputOnly": DatePickerEntryMode.inputOnly,
    },
    "DatePickerMode": {
      "day": DatePickerMode.day,
      "year": DatePickerMode.year,
    },
    "DayPeriod": {
      "am": DayPeriod.am,
      "pm": DayPeriod.pm,
    },
    "DebugSemanticsDumpOrder": {
      "inverseHitTest": DebugSemanticsDumpOrder.inverseHitTest,
      "traversalOrder": DebugSemanticsDumpOrder.traversalOrder,
    },
    "DecorationPosition": {
      "background": DecorationPosition.background,
      "foreground": DecorationPosition.foreground,
    },
    "DeviceOrientation": {
      "portraitUp": DeviceOrientation.portraitUp,
      "landscapeLeft": DeviceOrientation.landscapeLeft,
      "portraitDown": DeviceOrientation.portraitDown,
      "landscapeRight": DeviceOrientation.landscapeRight,
    },
    "DiagnosticLevel": {
      "hidden": DiagnosticLevel.hidden,
      "fine": DiagnosticLevel.fine,
      "debug": DiagnosticLevel.debug,
      "info": DiagnosticLevel.info,
      "warning": DiagnosticLevel.warning,
      "hint": DiagnosticLevel.hint,
      "summary": DiagnosticLevel.summary,
      "error": DiagnosticLevel.error,
      "off": DiagnosticLevel.off,
    },
    "DiagnosticsTreeStyle": {
      "none": DiagnosticsTreeStyle.none,
      "sparse": DiagnosticsTreeStyle.sparse,
      "offstage": DiagnosticsTreeStyle.offstage,
      "dense": DiagnosticsTreeStyle.dense,
      "transition": DiagnosticsTreeStyle.transition,
      "error": DiagnosticsTreeStyle.error,
      "whitespace": DiagnosticsTreeStyle.whitespace,
      "flat": DiagnosticsTreeStyle.flat,
      "singleLine": DiagnosticsTreeStyle.singleLine,
      "errorProperty": DiagnosticsTreeStyle.errorProperty,
      "shallow": DiagnosticsTreeStyle.shallow,
      "truncateChildren": DiagnosticsTreeStyle.truncateChildren,
    },
    "DismissDirection": {
      "vertical": DismissDirection.vertical,
      "horizontal": DismissDirection.horizontal,
      "endToStart": DismissDirection.endToStart,
      "startToEnd": DismissDirection.startToEnd,
      "up": DismissDirection.up,
      "down": DismissDirection.down,
      "none": DismissDirection.none,
    },
    "DragStartBehavior": {
      "down": DragStartBehavior.down,
      "start": DragStartBehavior.start,
    },
    "DrawerAlignment": {
      "start": DrawerAlignment.start,
      "end": DrawerAlignment.end,
    },
    "FilterQuality": {
      "none": FilterQuality.none,
      "low": FilterQuality.low,
      "medium": FilterQuality.medium,
      "high": FilterQuality.high,
    },
    "FlexFit": {
      "tight": FlexFit.tight,
      "loose": FlexFit.loose,
    },
    "FloatingCursorDragState": {
      "Start": FloatingCursorDragState.Start,
      "Update": FloatingCursorDragState.Update,
      "End": FloatingCursorDragState.End,
    },
    "FloatingLabelBehavior": {
      "never": FloatingLabelBehavior.never,
      "auto": FloatingLabelBehavior.auto,
      "always": FloatingLabelBehavior.always,
    },
    "FlutterLogoStyle": {
      "markOnly": FlutterLogoStyle.markOnly,
      "horizontal": FlutterLogoStyle.horizontal,
      "stacked": FlutterLogoStyle.stacked,
    },
    "FocusHighlightMode": {
      "touch": FocusHighlightMode.touch,
      "traditional": FocusHighlightMode.traditional,
    },
    "FocusHighlightStrategy": {
      "automatic": FocusHighlightStrategy.automatic,
      "alwaysTouch": FocusHighlightStrategy.alwaysTouch,
      "alwaysTraditional": FocusHighlightStrategy.alwaysTraditional,
    },
    "FontStyle": {
      "normal": FontStyle.normal,
      "italic": FontStyle.italic,
    },
    "FoundationServiceExtensions": {
      "reassemble": FoundationServiceExtensions.reassemble,
      "exit": FoundationServiceExtensions.exit,
      "connectedVmServiceUri":
          FoundationServiceExtensions.connectedVmServiceUri,
      "activeDevToolsServerAddress":
          FoundationServiceExtensions.activeDevToolsServerAddress,
      "platformOverride": FoundationServiceExtensions.platformOverride,
      "brightnessOverride": FoundationServiceExtensions.brightnessOverride,
    },
    "GestureDisposition": {
      "accepted": GestureDisposition.accepted,
      "rejected": GestureDisposition.rejected,
    },
    "GestureRecognizerState": {
      "ready": GestureRecognizerState.ready,
      "possible": GestureRecognizerState.possible,
      "defunct": GestureRecognizerState.defunct,
    },
    "GrowthDirection": {
      "forward": GrowthDirection.forward,
      "reverse": GrowthDirection.reverse,
    },
    "HeroFlightDirection": {
      "push": HeroFlightDirection.push,
      "pop": HeroFlightDirection.pop,
    },
    "HitTestBehavior": {
      "deferToChild": HitTestBehavior.deferToChild,
      "opaque": HitTestBehavior.opaque,
      "translucent": HitTestBehavior.translucent,
    },
    "HourFormat": {
      "HH": HourFormat.HH,
      "H": HourFormat.H,
      "h": HourFormat.h,
    },
    "ImageByteFormat": {
      "rawRgba": ImageByteFormat.rawRgba,
      "rawStraightRgba": ImageByteFormat.rawStraightRgba,
      "rawUnmodified": ImageByteFormat.rawUnmodified,
      "rawExtendedRgba128": ImageByteFormat.rawExtendedRgba128,
      "png": ImageByteFormat.png,
    },
    "ImageRepeat": {
      "repeat": ImageRepeat.repeat,
      "repeatX": ImageRepeat.repeatX,
      "repeatY": ImageRepeat.repeatY,
      "noRepeat": ImageRepeat.noRepeat,
    },
    "KeyDataTransitMode": {
      "rawKeyData": KeyDataTransitMode.rawKeyData,
      "keyDataThenRawKeyData": KeyDataTransitMode.keyDataThenRawKeyData,
    },
    "KeyEventResult": {
      "handled": KeyEventResult.handled,
      "ignored": KeyEventResult.ignored,
      "skipRemainingHandlers": KeyEventResult.skipRemainingHandlers,
    },
    "KeyEventType": {
      "down": KeyEventType.down,
      "up": KeyEventType.up,
      "repeat": KeyEventType.repeat,
    },
//  "KeyboardLockMode":
//  {"numLock._(LogicalKeyboardKey.numLock)": KeyboardLockMode.numLock._(LogicalKeyboardKey.numLock),"scrollLock._(LogicalKeyboardKey.scrollLock)": KeyboardLockMode.scrollLock._(LogicalKeyboardKey.scrollLock),"capsLock._(LogicalKeyboardKey.capsLock),": KeyboardLockMode.capsLock._(LogicalKeyboardKey.capsLock),,},
    "KeyboardSide": {
      "any": KeyboardSide.any,
      "left": KeyboardSide.left,
      "right": KeyboardSide.right,
      "all": KeyboardSide.all,
    },
    "ListTileControlAffinity": {
      "leading": ListTileControlAffinity.leading,
      "trailing": ListTileControlAffinity.trailing,
      "platform": ListTileControlAffinity.platform,
    },
    "ListTileStyle": {
      "list": ListTileStyle.list,
      "drawer": ListTileStyle.drawer,
    },
    "ListTileTitleAlignment": {
      "threeLine": ListTileTitleAlignment.threeLine,
      "titleHeight": ListTileTitleAlignment.titleHeight,
      "top": ListTileTitleAlignment.top,
      "center": ListTileTitleAlignment.center,
      "bottom": ListTileTitleAlignment.bottom,
    },
    "MainAxisAlignment": {
      "start": MainAxisAlignment.start,
      "end": MainAxisAlignment.end,
      "center": MainAxisAlignment.center,
      "spaceBetween": MainAxisAlignment.spaceBetween,
      "spaceAround": MainAxisAlignment.spaceAround,
      "spaceEvenly": MainAxisAlignment.spaceEvenly,
    },
    "MainAxisSize": {
      "min": MainAxisSize.min,
      "max": MainAxisSize.max,
    },
    "MaterialBannerClosedReason": {
      "dismiss": MaterialBannerClosedReason.dismiss,
      "swipe": MaterialBannerClosedReason.swipe,
      "hide": MaterialBannerClosedReason.hide,
      "remove": MaterialBannerClosedReason.remove,
    },
    "MaterialState": {
      "hovered": MaterialState.hovered,
      "focused": MaterialState.focused,
      "pressed": MaterialState.pressed,
      "dragged": MaterialState.dragged,
      "selected": MaterialState.selected,
      "scrolledUnder": MaterialState.scrolledUnder,
      "disabled": MaterialState.disabled,
      "error": MaterialState.error,
    },
    "MaterialTapTargetSize": {
      "padded": MaterialTapTargetSize.padded,
      "shrinkWrap": MaterialTapTargetSize.shrinkWrap,
    },
    "MaterialType": {
      "canvas": MaterialType.canvas,
      "card": MaterialType.card,
      "circle": MaterialType.circle,
      "button": MaterialType.button,
      "transparency": MaterialType.transparency,
    },
    "MaxLengthEnforcement": {
      "none": MaxLengthEnforcement.none,
      "enforced": MaxLengthEnforcement.enforced,
      "truncateAfterCompositionEnds":
          MaxLengthEnforcement.truncateAfterCompositionEnds,
    },
    "ModifierKey": {
      "controlModifier": ModifierKey.controlModifier,
      "shiftModifier": ModifierKey.shiftModifier,
      "altModifier": ModifierKey.altModifier,
      "metaModifier": ModifierKey.metaModifier,
      "capsLockModifier": ModifierKey.capsLockModifier,
      "numLockModifier": ModifierKey.numLockModifier,
      "scrollLockModifier": ModifierKey.scrollLockModifier,
      "functionModifier": ModifierKey.functionModifier,
      "symbolModifier": ModifierKey.symbolModifier,
    },
    "NavigationDestinationLabelBehavior": {
      "alwaysShow": NavigationDestinationLabelBehavior.alwaysShow,
      "alwaysHide": NavigationDestinationLabelBehavior.alwaysHide,
      "onlyShowSelected": NavigationDestinationLabelBehavior.onlyShowSelected,
    },
    "NavigationMode": {
      "traditional": NavigationMode.traditional,
      "directional": NavigationMode.directional,
    },
    "NavigationRailLabelType": {
      "none": NavigationRailLabelType.none,
      "selected": NavigationRailLabelType.selected,
      "all": NavigationRailLabelType.all,
    },
    "Orientation": {
      "portrait": Orientation.portrait,
      "landscape": Orientation.landscape,
    },
    "OverflowBarAlignment": {
      "start": OverflowBarAlignment.start,
      "end": OverflowBarAlignment.end,
      "center": OverflowBarAlignment.center,
    },
    "OverlayVisibilityMode": {
      "never": OverlayVisibilityMode.never,
      "editing": OverlayVisibilityMode.editing,
      "notEditing": OverlayVisibilityMode.notEditing,
      "always": OverlayVisibilityMode.always,
    },
    "PaintingStyle": {
      "fill": PaintingStyle.fill,
      "stroke": PaintingStyle.stroke,
    },
    "PanAxis": {
      "horizontal": PanAxis.horizontal,
      "vertical": PanAxis.vertical,
      "aligned": PanAxis.aligned,
      "free": PanAxis.free,
    },
    "PathFillType": {
      "nonZero": PathFillType.nonZero,
      "evenOdd": PathFillType.evenOdd,
    },
    "PathOperation": {
      "difference": PathOperation.difference,
      "intersect": PathOperation.intersect,
      "union": PathOperation.union,
      "xor": PathOperation.xor,
      "reverseDifference": PathOperation.reverseDifference,
    },
    "PerformanceOverlayOption": {
      "displayRasterizerStatistics":
          PerformanceOverlayOption.displayRasterizerStatistics,
      "visualizeRasterizerStatistics":
          PerformanceOverlayOption.visualizeRasterizerStatistics,
      "displayEngineStatistics":
          PerformanceOverlayOption.displayEngineStatistics,
      "visualizeEngineStatistics":
          PerformanceOverlayOption.visualizeEngineStatistics,
    },
    "PixelFormat": {
      "rgba8888": PixelFormat.rgba8888,
      "bgra8888": PixelFormat.bgra8888,
      "rgbaFloat32": PixelFormat.rgbaFloat32,
    },
    "PlaceholderAlignment": {
      "baseline": PlaceholderAlignment.baseline,
      "aboveBaseline": PlaceholderAlignment.aboveBaseline,
      "belowBaseline": PlaceholderAlignment.belowBaseline,
      "top": PlaceholderAlignment.top,
      "bottom": PlaceholderAlignment.bottom,
      "middle": PlaceholderAlignment.middle,
    },
    "PlatformProvidedMenuItemType": {
      "about": PlatformProvidedMenuItemType.about,
      "quit": PlatformProvidedMenuItemType.quit,
      "servicesSubmenu": PlatformProvidedMenuItemType.servicesSubmenu,
      "hide": PlatformProvidedMenuItemType.hide,
      "hideOtherApplications":
          PlatformProvidedMenuItemType.hideOtherApplications,
      "showAllApplications": PlatformProvidedMenuItemType.showAllApplications,
      "startSpeaking": PlatformProvidedMenuItemType.startSpeaking,
      "stopSpeaking": PlatformProvidedMenuItemType.stopSpeaking,
      "toggleFullScreen": PlatformProvidedMenuItemType.toggleFullScreen,
      "minimizeWindow": PlatformProvidedMenuItemType.minimizeWindow,
      "zoomWindow": PlatformProvidedMenuItemType.zoomWindow,
      "arrangeWindowsInFront":
          PlatformProvidedMenuItemType.arrangeWindowsInFront,
    },
    "PlatformViewHitTestBehavior": {
      "opaque": PlatformViewHitTestBehavior.opaque,
      "translucent": PlatformViewHitTestBehavior.translucent,
      "transparent": PlatformViewHitTestBehavior.transparent,
    },
    "PointMode": {
      "points": PointMode.points,
      "lines": PointMode.lines,
      "polygon": PointMode.polygon,
    },
    "PointerChange": {
      "cancel": PointerChange.cancel,
      "add": PointerChange.add,
      "remove": PointerChange.remove,
      "hover": PointerChange.hover,
      "down": PointerChange.down,
      "move": PointerChange.move,
      "up": PointerChange.up,
      "panZoomStart": PointerChange.panZoomStart,
      "panZoomUpdate": PointerChange.panZoomUpdate,
      "panZoomEnd": PointerChange.panZoomEnd,
    },
    "PointerDeviceKind": {
      "touch": PointerDeviceKind.touch,
      "mouse": PointerDeviceKind.mouse,
      "stylus": PointerDeviceKind.stylus,
      "invertedStylus": PointerDeviceKind.invertedStylus,
      "trackpad": PointerDeviceKind.trackpad,
      "unknown": PointerDeviceKind.unknown,
    },
    // "PointerPreferredStylusAuxiliaryAction":
    //    {
    //     "ignore": PointerPreferredStylusAuxiliaryAction.ignore,
    //     "showColorPalette":
    //         PointerPreferredStylusAuxiliaryAction.showColorPalette,
    //     "switchEraser": PointerPreferredStylusAuxiliaryAction.switchEraser,
    //     "switchPrevious": PointerPreferredStylusAuxiliaryAction.switchPrevious,
    //     "unknown": PointerPreferredStylusAuxiliaryAction.unknown,
    //   },
    "PointerSignalKind": {
      "none": PointerSignalKind.none,
      "scroll": PointerSignalKind.scroll,
      "scrollInertiaCancel": PointerSignalKind.scrollInertiaCancel,
      "scale": PointerSignalKind.scale,
      //"stylusAuxiliaryAction": PointerSignalKind.stylusAuxiliaryAction,
      "unknown": PointerSignalKind.unknown,
    },

    "PopupMenuPosition": {
      "over": PopupMenuPosition.over,
      "under": PopupMenuPosition.under,
    },
    "RefreshIndicatorMode": {
      "inactive": RefreshIndicatorMode.inactive,
      "drag": RefreshIndicatorMode.drag,
      "armed": RefreshIndicatorMode.armed,
      "refresh": RefreshIndicatorMode.refresh,
      "done": RefreshIndicatorMode.done,
    },
    "RefreshIndicatorTriggerMode": {
      "anywhere": RefreshIndicatorTriggerMode.anywhere,
      "onEdge": RefreshIndicatorTriggerMode.onEdge,
    },
    "RenderAnimatedSizeState": {
      "start": RenderAnimatedSizeState.start,
      "stable": RenderAnimatedSizeState.stable,
      "changed": RenderAnimatedSizeState.changed,
      "unstable": RenderAnimatedSizeState.unstable,
    },
    "RenderComparison": {
      "identical": RenderComparison.identical,
      "metadata": RenderComparison.metadata,
      "paint": RenderComparison.paint,
      "layout": RenderComparison.layout,
    },
    "RenderingServiceExtensions": {
      "invertOversizedImages": RenderingServiceExtensions.invertOversizedImages,
      "debugPaint": RenderingServiceExtensions.debugPaint,
      "debugPaintBaselinesEnabled":
          RenderingServiceExtensions.debugPaintBaselinesEnabled,
      "repaintRainbow": RenderingServiceExtensions.repaintRainbow,
      "debugDumpLayerTree": RenderingServiceExtensions.debugDumpLayerTree,
      "debugDisableClipLayers":
          RenderingServiceExtensions.debugDisableClipLayers,
      "debugDisablePhysicalShapeLayers":
          RenderingServiceExtensions.debugDisablePhysicalShapeLayers,
      "debugDisableOpacityLayers":
          RenderingServiceExtensions.debugDisableOpacityLayers,
      "debugDumpRenderTree": RenderingServiceExtensions.debugDumpRenderTree,
      "debugDumpSemanticsTreeInTraversalOrder":
          RenderingServiceExtensions.debugDumpSemanticsTreeInTraversalOrder,
      "debugDumpSemanticsTreeInInverseHitTestOrder": RenderingServiceExtensions
          .debugDumpSemanticsTreeInInverseHitTestOrder,
      "profileRenderObjectPaints":
          RenderingServiceExtensions.profileRenderObjectPaints,
      "profileRenderObjectLayouts":
          RenderingServiceExtensions.profileRenderObjectLayouts,
    },
    "ResizeImagePolicy": {
      "exact": ResizeImagePolicy.exact,
      "fit": ResizeImagePolicy.fit,
    },
    "RouteInformationReportingType": {
      "none": RouteInformationReportingType.none,
      "neglect": RouteInformationReportingType.neglect,
      "navigate": RouteInformationReportingType.navigate,
    },
    "RoutePopDisposition": {
      "pop": RoutePopDisposition.pop,
      "doNotPop": RoutePopDisposition.doNotPop,
      "bubble": RoutePopDisposition.bubble,
    },
    "SchedulerPhase": {
      "idle": SchedulerPhase.idle,
      "transientCallbacks": SchedulerPhase.transientCallbacks,
      "midFrameMicrotasks": SchedulerPhase.midFrameMicrotasks,
      "persistentCallbacks": SchedulerPhase.persistentCallbacks,
      "postFrameCallbacks": SchedulerPhase.postFrameCallbacks,
    },
    "SchedulerServiceExtensions": {
      "timeDilation": SchedulerServiceExtensions.timeDilation,
    },
    "ScriptCategory": {
      "englishLike": ScriptCategory.englishLike,
      "dense": ScriptCategory.dense,
      "tall": ScriptCategory.tall,
    },
    "ScrollDecelerationRate": {
      "normal": ScrollDecelerationRate.normal,
      "fast": ScrollDecelerationRate.fast,
    },
    "ScrollDirection": {
      "idle": ScrollDirection.idle,
      "forward": ScrollDirection.forward,
      "reverse": ScrollDirection.reverse,
    },
    "ScrollIncrementType": {
      "line": ScrollIncrementType.line,
      "page": ScrollIncrementType.page,
    },
    "ScrollPositionAlignmentPolicy": {
      "explicit": ScrollPositionAlignmentPolicy.explicit,
      "keepVisibleAtEnd": ScrollPositionAlignmentPolicy.keepVisibleAtEnd,
      "keepVisibleAtStart": ScrollPositionAlignmentPolicy.keepVisibleAtStart,
    },
    "ScrollViewKeyboardDismissBehavior": {
      "manual": ScrollViewKeyboardDismissBehavior.manual,
      "onDrag": ScrollViewKeyboardDismissBehavior.onDrag,
    },
    "ScrollbarOrientation": {
      "left": ScrollbarOrientation.left,
      "right": ScrollbarOrientation.right,
      "top": ScrollbarOrientation.top,
      "bottom": ScrollbarOrientation.bottom,
    },
    "SelectionEventType": {
      "startEdgeUpdate": SelectionEventType.startEdgeUpdate,
      "endEdgeUpdate": SelectionEventType.endEdgeUpdate,
      "clear": SelectionEventType.clear,
      "selectAll": SelectionEventType.selectAll,
      "selectWord": SelectionEventType.selectWord,
      "granularlyExtendSelection": SelectionEventType.granularlyExtendSelection,
      "directionallyExtendSelection":
          SelectionEventType.directionallyExtendSelection,
    },
    "SelectionExtendDirection": {
      "previousLine": SelectionExtendDirection.previousLine,
      "nextLine": SelectionExtendDirection.nextLine,
      "forward": SelectionExtendDirection.forward,
      "backward": SelectionExtendDirection.backward,
    },
    "SelectionResult": {
      "next": SelectionResult.next,
      "previous": SelectionResult.previous,
      "end": SelectionResult.end,
      "pending": SelectionResult.pending,
      "none": SelectionResult.none,
    },
    "SelectionStatus": {
      "uncollapsed": SelectionStatus.uncollapsed,
      "collapsed": SelectionStatus.collapsed,
      "none": SelectionStatus.none,
    },
    "ServicesServiceExtensions": {
      "evict": ServicesServiceExtensions.evict,
    },
    "ShowValueIndicator": {
      "onlyForDiscrete": ShowValueIndicator.onlyForDiscrete,
      "onlyForContinuous": ShowValueIndicator.onlyForContinuous,
      "always": ShowValueIndicator.always,
      "never": ShowValueIndicator.never,
    },
    "SmartDashesType": {
      "disabled": SmartDashesType.disabled,
      "enabled": SmartDashesType.enabled,
    },
    "SmartQuotesType": {
      "disabled": SmartQuotesType.disabled,
      "enabled": SmartQuotesType.enabled,
    },
    "SnackBarBehavior": {
      "fixed": SnackBarBehavior.fixed,
      "floating": SnackBarBehavior.floating,
    },
    "SnackBarClosedReason": {
      "action": SnackBarClosedReason.action,
      "dismiss": SnackBarClosedReason.dismiss,
      "swipe": SnackBarClosedReason.swipe,
      "hide": SnackBarClosedReason.hide,
      "remove": SnackBarClosedReason.remove,
      "timeout": SnackBarClosedReason.timeout,
    },
    "SnapshotMode": {
      "permissive": SnapshotMode.permissive,
      "normal": SnapshotMode.normal,
      "forced": SnapshotMode.forced,
    },
    "StackFit": {
      "loose": StackFit.loose,
      "expand": StackFit.expand,
      "passthrough": StackFit.passthrough,
    },
    "StepState": {
      "indexed": StepState.indexed,
      "editing": StepState.editing,
      "complete": StepState.complete,
      "disabled": StepState.disabled,
      "error": StepState.error,
    },
    "StepperType": {
      "vertical": StepperType.vertical,
      "horizontal": StepperType.horizontal,
    },
    "StretchMode": {
      "zoomBackground": StretchMode.zoomBackground,
      "blurBackground": StretchMode.blurBackground,
      "fadeTitle": StretchMode.fadeTitle,
    },
    "StrokeCap": {
      "butt": StrokeCap.butt,
      "round": StrokeCap.round,
      "square": StrokeCap.square,
    },
    "StrokeJoin": {
      "miter": StrokeJoin.miter,
      "round": StrokeJoin.round,
      "bevel": StrokeJoin.bevel,
    },
    "SystemSoundType": {
      "click": SystemSoundType.click,
      "alert": SystemSoundType.alert,
    },
    "SystemUiMode": {
      "leanBack": SystemUiMode.leanBack,
      "immersive": SystemUiMode.immersive,
      "immersiveSticky": SystemUiMode.immersiveSticky,
      "edgeToEdge": SystemUiMode.edgeToEdge,
      "manual": SystemUiMode.manual,
    },
    "SystemUiOverlay": {
      "top": SystemUiOverlay.top,
      "bottom": SystemUiOverlay.bottom,
    },
    "TabBarIndicatorSize": {
      "tab": TabBarIndicatorSize.tab,
      "label": TabBarIndicatorSize.label,
    },
    "TargetPlatform": {
      "android": TargetPlatform.android,
      "fuchsia": TargetPlatform.fuchsia,
      "iOS": TargetPlatform.iOS,
      "linux": TargetPlatform.linux,
      "macOS": TargetPlatform.macOS,
      "windows": TargetPlatform.windows,
    },
    "TextAffinity": {
      "upstream": TextAffinity.upstream,
      "downstream": TextAffinity.downstream,
    },
    "TextAlign": {
      "left": TextAlign.left,
      "right": TextAlign.right,
      "center": TextAlign.center,
      "justify": TextAlign.justify,
      "start": TextAlign.start,
      "end": TextAlign.end,
    },
    "TextBaseline": {
      "alphabetic": TextBaseline.alphabetic,
      "ideographic": TextBaseline.ideographic,
    },
    "TextCapitalization": {
      "words": TextCapitalization.words,
      "sentences": TextCapitalization.sentences,
      "characters": TextCapitalization.characters,
      "none": TextCapitalization.none,
    },
    "TextDecorationStyle": {
      "solid": TextDecorationStyle.solid,
      "double": TextDecorationStyle.double,
      "dotted": TextDecorationStyle.dotted,
      "dashed": TextDecorationStyle.dashed,
      "wavy": TextDecorationStyle.wavy,
    },
    "TextDirection": {
      "rtl": TextDirection.rtl,
      "ltr": TextDirection.ltr,
    },
    "TextGranularity": {
      "character": TextGranularity.character,
      "word": TextGranularity.word,
      "line": TextGranularity.line,
      "document": TextGranularity.document,
    },
    "TextLeadingDistribution": {
      "proportional": TextLeadingDistribution.proportional,
      "even": TextLeadingDistribution.even,
    },
    "TextOverflow": {
      "clip": TextOverflow.clip,
      "fade": TextOverflow.fade,
      "ellipsis": TextOverflow.ellipsis,
      "visible": TextOverflow.visible,
    },
    "TextSelectionHandleType": {
      "left": TextSelectionHandleType.left,
      "right": TextSelectionHandleType.right,
      "collapsed": TextSelectionHandleType.collapsed,
    },
    "TextWidthBasis": {
      "parent": TextWidthBasis.parent,
      "longestLine": TextWidthBasis.longestLine,
    },
    "ThemeMode": {
      "system": ThemeMode.system,
      "light": ThemeMode.light,
      "dark": ThemeMode.dark,
    },
    "Thumb": {
      "start": Thumb.start,
      "end": Thumb.end,
    },
    "TileMode": {
      "clamp": TileMode.clamp,
      "repeated": TileMode.repeated,
      "mirror": TileMode.mirror,
      "decal": TileMode.decal,
    },
    "TimeOfDayFormat": {
      "HH_colon_mm": TimeOfDayFormat.HH_colon_mm,
      "HH_dot_mm": TimeOfDayFormat.HH_dot_mm,
      "frenchCanadian": TimeOfDayFormat.frenchCanadian,
      "H_colon_mm": TimeOfDayFormat.H_colon_mm,
      "h_colon_mm_space_a": TimeOfDayFormat.h_colon_mm_space_a,
      "a_space_h_colon_mm": TimeOfDayFormat.a_space_h_colon_mm,
    },
    "TimePickerEntryMode": {
      "dial": TimePickerEntryMode.dial,
      "input": TimePickerEntryMode.input,
      "dialOnly": TimePickerEntryMode.dialOnly,
      "inputOnly": TimePickerEntryMode.inputOnly,
    },
    "TooltipTriggerMode": {
      "manual": TooltipTriggerMode.manual,
      "longPress": TooltipTriggerMode.longPress,
      "tap": TooltipTriggerMode.tap,
    },
    "TraversalDirection": {
      "up": TraversalDirection.up,
      "right": TraversalDirection.right,
      "down": TraversalDirection.down,
      "left": TraversalDirection.left,
    },
    "TraversalEdgeBehavior": {
      "closedLoop": TraversalEdgeBehavior.closedLoop,
      "leaveFlutterView": TraversalEdgeBehavior.leaveFlutterView,
    },
    "UndoDirection": {
      "undo": UndoDirection.undo,
      "redo": UndoDirection.redo,
    },
    "UnfocusDisposition": {
      "scope": UnfocusDisposition.scope,
      "previouslyFocusedChild": UnfocusDisposition.previouslyFocusedChild,
    },
    "VertexMode": {
      "triangles": VertexMode.triangles,
      "triangleStrip": VertexMode.triangleStrip,
      "triangleFan": VertexMode.triangleFan,
    },
    "VerticalDirection": {
      "up": VerticalDirection.up,
      "down": VerticalDirection.down,
    },
    "WidgetInspectorServiceExtensions": {
      "structuredErrors": WidgetInspectorServiceExtensions.structuredErrors,
      "show": WidgetInspectorServiceExtensions.show,
      "trackRebuildDirtyWidgets":
          WidgetInspectorServiceExtensions.trackRebuildDirtyWidgets,
      "trackRepaintWidgets":
          WidgetInspectorServiceExtensions.trackRepaintWidgets,
      "disposeAllGroups": WidgetInspectorServiceExtensions.disposeAllGroups,
      "disposeGroup": WidgetInspectorServiceExtensions.disposeGroup,
      "isWidgetTreeReady": WidgetInspectorServiceExtensions.isWidgetTreeReady,
      "disposeId": WidgetInspectorServiceExtensions.disposeId,
      "setPubRootDirectories":
          WidgetInspectorServiceExtensions.setPubRootDirectories,
      "addPubRootDirectories":
          WidgetInspectorServiceExtensions.addPubRootDirectories,
      "removePubRootDirectories":
          WidgetInspectorServiceExtensions.removePubRootDirectories,
      "getPubRootDirectories":
          WidgetInspectorServiceExtensions.getPubRootDirectories,
      "setSelectionById": WidgetInspectorServiceExtensions.setSelectionById,
      "getParentChain": WidgetInspectorServiceExtensions.getParentChain,
      "getProperties": WidgetInspectorServiceExtensions.getProperties,
      "getChildren": WidgetInspectorServiceExtensions.getChildren,
      "getChildrenSummaryTree":
          WidgetInspectorServiceExtensions.getChildrenSummaryTree,
      "getChildrenDetailsSubtree":
          WidgetInspectorServiceExtensions.getChildrenDetailsSubtree,
      "getRootWidget": WidgetInspectorServiceExtensions.getRootWidget,
      // "getRootRenderObject":
      //     WidgetInspectorServiceExtensions.getRootRenderObject,
      "getRootWidgetSummaryTree":
          WidgetInspectorServiceExtensions.getRootWidgetSummaryTree,
      "getRootWidgetSummaryTreeWithPreviews":
          WidgetInspectorServiceExtensions.getRootWidgetSummaryTreeWithPreviews,
      "getDetailsSubtree": WidgetInspectorServiceExtensions.getDetailsSubtree,
      // "getSelectedRenderObject":
      //     WidgetInspectorServiceExtensions.getSelectedRenderObject,
      "getSelectedWidget": WidgetInspectorServiceExtensions.getSelectedWidget,
      "getSelectedSummaryWidget":
          WidgetInspectorServiceExtensions.getSelectedSummaryWidget,
      "isWidgetCreationTracked":
          WidgetInspectorServiceExtensions.isWidgetCreationTracked,
      "screenshot": WidgetInspectorServiceExtensions.screenshot,
      "getLayoutExplorerNode":
          WidgetInspectorServiceExtensions.getLayoutExplorerNode,
      "setFlexFit": WidgetInspectorServiceExtensions.setFlexFit,
      "setFlexFactor": WidgetInspectorServiceExtensions.setFlexFactor,
      "setFlexProperties": WidgetInspectorServiceExtensions.setFlexProperties,
    },
    "WidgetsServiceExtensions": {
      "debugDumpApp": WidgetsServiceExtensions.debugDumpApp,
      "debugDumpFocusTree": WidgetsServiceExtensions.debugDumpFocusTree,
      "showPerformanceOverlay": WidgetsServiceExtensions.showPerformanceOverlay,
      "didSendFirstFrameEvent": WidgetsServiceExtensions.didSendFirstFrameEvent,
      "didSendFirstFrameRasterizedEvent":
          WidgetsServiceExtensions.didSendFirstFrameRasterizedEvent,
      "fastReassemble": WidgetsServiceExtensions.fastReassemble,
      "profileWidgetBuilds": WidgetsServiceExtensions.profileWidgetBuilds,
      "profileUserWidgetBuilds":
          WidgetsServiceExtensions.profileUserWidgetBuilds,
      "debugAllowBanner": WidgetsServiceExtensions.debugAllowBanner,
    },
    "WrapAlignment": {
      "start": WrapAlignment.start,
      "end": WrapAlignment.end,
      "center": WrapAlignment.center,
      "spaceBetween": WrapAlignment.spaceBetween,
      "spaceAround": WrapAlignment.spaceAround,
      "spaceEvenly": WrapAlignment.spaceEvenly,
    },
    "WrapCrossAlignment": {
      "start": WrapCrossAlignment.start,
      "end": WrapCrossAlignment.end,
      "center": WrapCrossAlignment.center,
    },
  }[name]?[value];
}
