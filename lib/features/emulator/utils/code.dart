String codeString = "Container("
    "\n\tdecoration: BoxDecoration("
    "color: context.isDarkMode ? lightestWhite : lightestBlack,"
    "borderRadius: BorderRadius.circular(20)),"
    "padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),"
    "margin: const EdgeInsets.all(4),"
    "child: Text("
    "widget.text,"
    "style: const TextStyle("
    "fontSize: 16,"
    "fontWeight: FontWeight.bold,"
    "),"
    "),"
    "),";

String materialButtonString = """
// Copyright 2014 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:ui';

import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

import 'button.dart';
import 'button_theme.dart';
import 'constants.dart';
import 'ink_well.dart';
import 'material.dart';
import 'theme.dart';
import 'theme_data.dart';

/// A utility class for building Material buttons that depend on the
/// ambient [ButtonTheme] and [Theme].
///
/// This class is planned to be deprecated in a future release.
/// Please use one or more of these buttons and associated themes instead:
///
///  * [TextButton], [TextButtonTheme], [TextButtonThemeData],
///  * [ElevatedButton], [ElevatedButtonTheme], [ElevatedButtonThemeData],
///  * [OutlinedButton], [OutlinedButtonTheme], [OutlinedButtonThemeData]
///
/// The button's size will expand to fit the child widget, if necessary.
///
/// MaterialButtons whose [onPressed] and [onLongPress] callbacks are null will be disabled. To have
/// an enabled button, make sure to pass a non-null value for [onPressed] or [onLongPress].
///
/// To create a button directly, without inheriting theme defaults, use
/// [RawMaterialButton].
///
/// If you want an ink-splash effect for taps, but don't want to use a button,
/// consider using [InkWell] directly.
///
/// See also:
///
///  * [IconButton], to create buttons that contain icons rather than text.
class MaterialButton extends StatelessWidget {
  /// Creates a Material Design button.
  ///
  /// To create a custom Material button consider using [TextButton],
  /// [ElevatedButton], or [OutlinedButton].
  ///
  /// The [autofocus] and [clipBehavior] arguments must not be null.
  /// Additionally,  [elevation], [hoverElevation], [focusElevation],
  /// [highlightElevation], and [disabledElevation] must be non-negative, if
  /// specified.
  const MaterialButton({
    super.key,
    required this.onPressed,
    this.onLongPress,
    this.onHighlightChanged,
    this.mouseCursor,
    this.textTheme,
    this.textColor,
    this.disabledTextColor,
    this.color,
    this.disabledColor,
    this.focusColor,
    this.hoverColor,
    this.highlightColor,
    this.splashColor,
    this.colorBrightness,
    this.elevation,
    this.focusElevation,
    this.hoverElevation,
    this.highlightElevation,
    this.disabledElevation,
    this.padding,
    this.visualDensity,
    this.shape,
    this.clipBehavior = Clip.none,
    this.focusNode,
    this.autofocus = false,
    this.materialTapTargetSize,
    this.animationDuration,
    this.minWidth,
    this.height,
    this.enableFeedback = true,
    this.child,
  }) : assert(elevation == null || elevation >= 0.0),
       assert(focusElevation == null || focusElevation >= 0.0),
       assert(hoverElevation == null || hoverElevation >= 0.0),
       assert(highlightElevation == null || highlightElevation >= 0.0),
       assert(disabledElevation == null || disabledElevation >= 0.0);

  /// The callback that is called when the button is tapped or otherwise activated.
  ///
  /// If this callback and [onLongPress] are null, then the button will be disabled.
  ///
  /// See also:
  ///
  ///  * [enabled], which is true if the button is enabled.
  final VoidCallback? onPressed;

  /// The callback that is called when the button is long-pressed.
  ///
  /// If this callback and [onPressed] are null, then the button will be disabled.
  ///
  /// See also:
  ///
  ///  * [enabled], which is true if the button is enabled.
  final VoidCallback? onLongPress;

  /// Called by the underlying [InkWell] widget's [InkWell.onHighlightChanged]
  /// callback.
  ///
  /// If [onPressed] changes from null to non-null while a gesture is ongoing,
  /// this can fire during the build phase (in which case calling
  /// [State.setState] is not allowed).
  final ValueChanged<bool>? onHighlightChanged;

  /// {@macro flutter.material.RawMaterialButton.mouseCursor}
  ///
  /// If this property is null, [MaterialStateMouseCursor.clickable] will be used.
  final MouseCursor? mouseCursor;

  /// Defines the button's base colors, and the defaults for the button's minimum
  /// size, internal padding, and shape.
  ///
  /// Defaults to `ButtonTheme.of(context).textTheme`.
  final ButtonTextTheme? textTheme;

  /// The color to use for this button's text.
  ///
  /// The button's [Material.textStyle] will be the current theme's button text
  /// style, [TextTheme.labelLarge] of [ThemeData.textTheme], configured with this
  /// color.
  ///
  /// The default text color depends on the button theme's text theme,
  /// [ButtonThemeData.textTheme].
  ///
  /// If [textColor] is a [MaterialStateProperty<Color>], [disabledTextColor]
  /// will be ignored.
  ///
  /// See also:
  ///
  ///  * [disabledTextColor], the text color to use when the button has been
  ///    disabled.
  final Color? textColor;

  /// The color to use for this button's text when the button is disabled.
  ///
  /// The button's [Material.textStyle] will be the current theme's button text
  /// style, [TextTheme.labelLarge] of [ThemeData.textTheme], configured with this
  /// color.
  ///
  /// The default value is the theme's disabled color,
  /// [ThemeData.disabledColor].
  ///
  /// If [textColor] is a [MaterialStateProperty<Color>], [disabledTextColor]
  /// will be ignored.
  ///
  /// See also:
  ///
  ///  * [textColor] - The color to use for this button's text when the button is [enabled].
  final Color? disabledTextColor;

  /// The button's fill color, displayed by its [Material], while it
  /// is in its default (unpressed, [enabled]) state.
  ///
  /// See also:
  ///
  ///  * [disabledColor] - the fill color of the button when the button is disabled.
  final Color? color;

  /// The fill color of the button when the button is disabled.
  ///
  /// The default value of this color is the theme's disabled color,
  /// [ThemeData.disabledColor].
  ///
  /// See also:
  ///
  ///  * [color] - the fill color of the button when the button is [enabled].
  final Color? disabledColor;

  /// The splash color of the button's [InkWell].
  ///
  /// The ink splash indicates that the button has been touched. It
  /// appears on top of the button's child and spreads in an expanding
  /// circle beginning where the touch occurred.
  ///
  /// The default splash color is the current theme's splash color,
  /// [ThemeData.splashColor].
  ///
  /// The appearance of the splash can be configured with the theme's splash
  /// factory, [ThemeData.splashFactory].
  final Color? splashColor;

  /// The fill color of the button's [Material] when it has the input focus.
  ///
  /// The button changed focus color when the button has the input focus. It
  /// appears behind the button's child.
  final Color? focusColor;

  /// The fill color of the button's [Material] when a pointer is hovering over
  /// it.
  ///
  /// The button changes fill color when a pointer is hovering over the button.
  /// It appears behind the button's child.
  final Color? hoverColor;

  /// The highlight color of the button's [InkWell].
  ///
  /// The highlight indicates that the button is actively being pressed. It
  /// appears on top of the button's child and quickly spreads to fill
  /// the button, and then fades out.
  ///
  /// If [textTheme] is [ButtonTextTheme.primary], the default highlight color is
  /// transparent (in other words the highlight doesn't appear). Otherwise it's
  /// the current theme's highlight color, [ThemeData.highlightColor].
  final Color? highlightColor;

  /// The z-coordinate at which to place this button relative to its parent.
  ///
  /// This controls the size of the shadow below the raised button.
  ///
  /// Defaults to 2, the appropriate elevation for raised buttons. The value
  /// is always non-negative.
  ///
  /// See also:
  ///
  ///  * [TextButton], a button with no elevation or fill color.
  ///  * [focusElevation], the elevation when the button is focused.
  ///  * [hoverElevation], the elevation when a pointer is hovering over the
  ///    button.
  ///  * [disabledElevation], the elevation when the button is disabled.
  ///  * [highlightElevation], the elevation when the button is pressed.
  final double? elevation;

  /// The elevation for the button's [Material] when the button
  /// is [enabled] and a pointer is hovering over it.
  ///
  /// Defaults to 4.0. The value is always non-negative.
  ///
  /// See also:
  ///
  ///  * [elevation], the default elevation.
  ///  * [focusElevation], the elevation when the button is focused.
  ///  * [disabledElevation], the elevation when the button is disabled.
  ///  * [highlightElevation], the elevation when the button is pressed.
  final double? hoverElevation;

  /// The elevation for the button's [Material] when the button
  /// is [enabled] and has the input focus.
  ///
  /// Defaults to 4.0. The value is always non-negative.
  ///
  /// See also:
  ///
  ///  * [elevation], the default elevation.
  ///  * [hoverElevation], the elevation when a pointer is hovering over the
  ///    button.
  ///  * [disabledElevation], the elevation when the button is disabled.
  ///  * [highlightElevation], the elevation when the button is pressed.
  final double? focusElevation;

  /// The elevation for the button's [Material] relative to its parent when the
  /// button is [enabled] and pressed.
  ///
  /// This controls the size of the shadow below the button. When a tap
  /// down gesture occurs within the button, its [InkWell] displays a
  /// [highlightColor] "highlight".
  ///
  /// Defaults to 8.0. The value is always non-negative.
  ///
  /// See also:
  ///
  ///  * [elevation], the default elevation.
  ///  * [focusElevation], the elevation when the button is focused.
  ///  * [hoverElevation], the elevation when a pointer is hovering over the
  ///    button.
  ///  * [disabledElevation], the elevation when the button is disabled.
  final double? highlightElevation;

  /// The elevation for the button's [Material] relative to its parent when the
  /// button is not [enabled].
  ///
  /// Defaults to 0.0. The value is always non-negative.
  ///
  /// See also:
  ///
  ///  * [elevation], the default elevation.
  ///  * [highlightElevation], the elevation when the button is pressed.
  final double? disabledElevation;

  /// The theme brightness to use for this button.
  ///
  /// Defaults to the theme's brightness in [ThemeData.brightness]. Setting
  /// this value determines the button text's colors based on
  /// [ButtonThemeData.getTextColor].
  ///
  /// See also:
  ///
  ///  * [ButtonTextTheme], uses [Brightness] to determine text color.
  final Brightness? colorBrightness;

  /// The button's label.
  ///
  /// Often a [Text] widget in all caps.
  final Widget? child;

  /// Whether the button is enabled or disabled.
  ///
  /// Buttons are disabled by default. To enable a button, set its [onPressed]
  /// or [onLongPress] properties to a non-null value.
  bool get enabled => onPressed != null || onLongPress != null;

  /// The internal padding for the button's [child].
  ///
  /// Defaults to the value from the current [ButtonTheme],
  /// [ButtonThemeData.padding].
  final EdgeInsetsGeometry? padding;

  /// Defines how compact the button's layout will be.
  ///
  /// {@macro flutter.material.themedata.visualDensity}
  ///
  /// See also:
  ///
  ///  * [ThemeData.visualDensity], which specifies the [visualDensity] for all
  ///    widgets within a [Theme].
  final VisualDensity? visualDensity;

  /// The shape of the button's [Material].
  ///
  /// The button's highlight and splash are clipped to this shape. If the
  /// button has an elevation, then its drop shadow is defined by this
  /// shape as well.
  ///
  /// Defaults to the value from the current [ButtonTheme],
  /// [ButtonThemeData.shape].
  final ShapeBorder? shape;

  /// {@macro flutter.material.Material.clipBehavior}
  ///
  /// Defaults to [Clip.none], and must not be null.
  final Clip clipBehavior;

  /// {@macro flutter.widgets.Focus.focusNode}
  final FocusNode? focusNode;

  /// {@macro flutter.widgets.Focus.autofocus}
  final bool autofocus;

  /// Defines the duration of animated changes for [shape] and [elevation].
  ///
  /// The default value is [kThemeChangeDuration].
  final Duration? animationDuration;

  /// Configures the minimum size of the tap target.
  ///
  /// Defaults to [ThemeData.materialTapTargetSize].
  ///
  /// See also:
  ///
  ///  * [MaterialTapTargetSize], for a description of how this affects tap targets.
  final MaterialTapTargetSize? materialTapTargetSize;

  /// The smallest horizontal extent that the button will occupy.
  ///
  /// Defaults to the value from the current [ButtonTheme].
  final double? minWidth;

  /// The vertical extent of the button.
  ///
  /// Defaults to the value from the current [ButtonTheme].
  final double? height;

  /// Whether detected gestures should provide acoustic and/or haptic feedback.
  ///
  /// For example, on Android a tap will produce a clicking sound and a
  /// long-press will produce a short vibration, when feedback is enabled.
  ///
  /// See also:
  ///
  ///  * [Feedback] for providing platform-specific feedback to certain actions.
  final bool enableFeedback;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ButtonThemeData buttonTheme = ButtonTheme.of(context);

    return RawMaterialButton(
      onPressed: onPressed,
      onLongPress: onLongPress,
      enableFeedback: enableFeedback,
      onHighlightChanged: onHighlightChanged,
      mouseCursor: mouseCursor,
      fillColor: buttonTheme.getFillColor(this),
      textStyle: theme.textTheme.labelLarge!.copyWith(color: buttonTheme.getTextColor(this)),
      focusColor: focusColor ?? buttonTheme.getFocusColor(this),
      hoverColor: hoverColor ?? buttonTheme.getHoverColor(this),
      highlightColor: highlightColor ?? theme.highlightColor,
      splashColor: splashColor ?? theme.splashColor,
      elevation: buttonTheme.getElevation(this),
      focusElevation: buttonTheme.getFocusElevation(this),
      hoverElevation: buttonTheme.getHoverElevation(this),
      highlightElevation: buttonTheme.getHighlightElevation(this),
      padding: buttonTheme.getPadding(this),
      visualDensity: visualDensity ?? theme.visualDensity,
      constraints: buttonTheme.getConstraints(this).copyWith(
        minWidth: minWidth,
        minHeight: height,
      ),
      shape: buttonTheme.getShape(this),
      clipBehavior: clipBehavior,
      focusNode: focusNode,
      autofocus: autofocus,
      animationDuration: buttonTheme.getAnimationDuration(this),
      materialTapTargetSize: materialTapTargetSize ?? theme.materialTapTargetSize,
      disabledElevation: disabledElevation ?? 0.0,
      child: child,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(FlagProperty('enabled', value: enabled, ifFalse: 'disabled'));
    properties.add(DiagnosticsProperty<ButtonTextTheme>('textTheme', textTheme, defaultValue: null));
    properties.add(ColorProperty('textColor', textColor, defaultValue: null));
    properties.add(ColorProperty('disabledTextColor', disabledTextColor, defaultValue: null));
    properties.add(ColorProperty('color', color, defaultValue: null));
    properties.add(ColorProperty('disabledColor', disabledColor, defaultValue: null));
    properties.add(ColorProperty('focusColor', focusColor, defaultValue: null));
    properties.add(ColorProperty('hoverColor', hoverColor, defaultValue: null));
    properties.add(ColorProperty('highlightColor', highlightColor, defaultValue: null));
    properties.add(ColorProperty('splashColor', splashColor, defaultValue: null));
    properties.add(DiagnosticsProperty<Brightness>('colorBrightness', colorBrightness, defaultValue: null));
    properties.add(DiagnosticsProperty<EdgeInsetsGeometry>('padding', padding, defaultValue: null));
    properties.add(DiagnosticsProperty<VisualDensity>('visualDensity', visualDensity, defaultValue: null));
    properties.add(DiagnosticsProperty<ShapeBorder>('shape', shape, defaultValue: null));
    properties.add(DiagnosticsProperty<FocusNode>('focusNode', focusNode, defaultValue: null));
    properties.add(DiagnosticsProperty<MaterialTapTargetSize>('materialTapTargetSize', materialTapTargetSize, defaultValue: null));
  }
}

/// The distinguished type of [MaterialButton].
///
/// This class is deprecated and will be removed in a future release.
///
/// This mixin only exists to give the "label and icon" button widgets a distinct
/// type for the sake of [ButtonTheme].
@Deprecated(
  'This was used to differentiate types of FlatButton, RaisedButton, and OutlineButton in ButtonTheme. '
  'These buttons have been replaced with TextButton, ElevatedButton, and OutlinedButton, each of which have their own respective themes now. '
  'Use one of these button classes instead. '
  'This feature was deprecated after v2.11.0-0.0.pre.',
)
mixin MaterialButtonWithIconMixin { }
""";

String columnString = """
// Copyright 2014 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:math' as math;
import 'dart:ui' as ui show Image, ImageFilter, TextHeightBehavior;

import 'package:flutter/animation.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';

import 'binding.dart';
import 'debug.dart';
import 'framework.dart';
import 'localizations.dart';
import 'visibility.dart';
import 'widget_span.dart';

export 'package:flutter/animation.dart';
export 'package:flutter/foundation.dart' show
  ChangeNotifier,
  FlutterErrorDetails,
  Listenable,
  TargetPlatform,
  ValueNotifier;
export 'package:flutter/painting.dart';
export 'package:flutter/rendering.dart' show
  AlignmentGeometryTween,
  AlignmentTween,
  Axis,
  BoxConstraints,
  BoxConstraintsTransform,
  CrossAxisAlignment,
  CustomClipper,
  CustomPainter,
  CustomPainterSemantics,
  DecorationPosition,
  FlexFit,
  FlowDelegate,
  FlowPaintingContext,
  FractionalOffsetTween,
  HitTestBehavior,
  LayerLink,
  MainAxisAlignment,
  MainAxisSize,
  MouseCursor,
  MultiChildLayoutDelegate,
  PaintingContext,
  PointerCancelEvent,
  PointerCancelEventListener,
  PointerDownEvent,
  PointerDownEventListener,
  PointerEvent,
  PointerMoveEvent,
  PointerMoveEventListener,
  PointerUpEvent,
  PointerUpEventListener,
  RelativeRect,
  SemanticsBuilderCallback,
  ShaderCallback,
  ShapeBorderClipper,
  SingleChildLayoutDelegate,
  StackFit,
  SystemMouseCursors,
  TextOverflow,
  ValueChanged,
  ValueGetter,
  WrapAlignment,
  WrapCrossAlignment;
export 'package:flutter/services.dart' show
  AssetBundle;

// Examples can assume:
// class TestWidget extends StatelessWidget { const TestWidget({super.key}); @override Widget build(BuildContext context) => const Placeholder(); }
// late WidgetTester tester;
// late bool _visible;
// class Sky extends CustomPainter { @override void paint(Canvas c, Size s) {} @override bool shouldRepaint(Sky s) => false; }
// late BuildContext context;
// String userAvatarUrl = '';

// BIDIRECTIONAL TEXT SUPPORT

/// An [InheritedElement] that has hundreds of dependencies but will
/// infrequently change. This provides a performance tradeoff where building
/// the [Widget]s is faster but performing updates is slower.
///
/// |                     | _UbiquitousInheritedElement | InheritedElement |
/// |---------------------|------------------------------|------------------|
/// | insert (best case)  | O(1)                         | O(1)             |
/// | insert (worst case) | O(1)                         | O(n)             |
/// | search (best case)  | O(n)                         | O(1)             |
/// | search (worst case) | O(n)                         | O(n)             |
///
/// Insert happens when building the [Widget] tree, search happens when updating
/// [Widget]s.
class _UbiquitousInheritedElement extends InheritedElement {
  /// Creates an element that uses the given widget as its configuration.
  _UbiquitousInheritedElement(super.widget);

  @override
  void setDependencies(Element dependent, Object? value) {
    // This is where the cost of [InheritedElement] is incurred during build
    // time of the widget tree. Omitting this bookkeeping is where the
    // performance savings come from.
    assert(value == null);
  }

  @override
  Object? getDependencies(Element dependent) {
    return null;
  }

  @override
  void notifyClients(InheritedWidget oldWidget) {
    _recurseChildren(this, (Element element) {
      if (element.doesDependOnInheritedElement(this)) {
        notifyDependent(oldWidget, element);
      }
    });
  }

  static void _recurseChildren(Element element, ElementVisitor visitor) {
    element.visitChildren((Element child) {
      _recurseChildren(child, visitor);
    });
    visitor(element);
  }
}

/// See also:
///
///  * [_UbiquitousInheritedElement], the [Element] for [_UbiquitousInheritedWidget].
abstract class _UbiquitousInheritedWidget extends InheritedWidget {
  const _UbiquitousInheritedWidget({super.key, required super.child});

  @override
  InheritedElement createElement() => _UbiquitousInheritedElement(this);
}

/// A widget that determines the ambient directionality of text and
/// text-direction-sensitive render objects.
///
/// For example, [Padding] depends on the [Directionality] to resolve
/// [EdgeInsetsDirectional] objects into absolute [EdgeInsets] objects.
class Directionality extends _UbiquitousInheritedWidget {
  /// Creates a widget that determines the directionality of text and
  /// text-direction-sensitive render objects.
  ///
  /// The [textDirection] and [child] arguments must not be null.
  const Directionality({
    super.key,
    required this.textDirection,
    required super.child,
  });

  /// The text direction for this subtree.
  final TextDirection textDirection;

  /// The text direction from the closest instance of this class that encloses
  /// the given context.
  ///
  /// If there is no [Directionality] ancestor widget in the tree at the given
  /// context, then this will throw a descriptive [FlutterError] in debug mode
  /// and an exception in release mode.
  ///
  /// Typical usage is as follows:
  ///
  /// ```dart
  /// TextDirection textDirection = Directionality.of(context);
  /// ```
  ///
  /// See also:
  ///
  ///  * [maybeOf], which will return null if no [Directionality] ancestor
  ///    widget is in the tree.
  static TextDirection of(BuildContext context) {
    assert(debugCheckHasDirectionality(context));
    final Directionality widget = context.dependOnInheritedWidgetOfExactType<Directionality>()!;
    return widget.textDirection;
  }

  /// The text direction from the closest instance of this class that encloses
  /// the given context.
  ///
  /// If there is no [Directionality] ancestor widget in the tree at the given
  /// context, then this will return null.
  ///
  /// Typical usage is as follows:
  ///
  /// ```dart
  /// TextDirection? textDirection = Directionality.maybeOf(context);
  /// ```
  ///
  /// See also:
  ///
  ///  * [of], which will throw if no [Directionality] ancestor widget is in the
  ///    tree.
  static TextDirection? maybeOf(BuildContext context) {
    final Directionality? widget = context.dependOnInheritedWidgetOfExactType<Directionality>();
    return widget?.textDirection;
  }

  @override
  bool updateShouldNotify(Directionality oldWidget) => textDirection != oldWidget.textDirection;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(EnumProperty<TextDirection>('textDirection', textDirection));
  }
}


// PAINTING NODES

/// A widget that makes its child partially transparent.
///
/// This class paints its child into an intermediate buffer and then blends the
/// child back into the scene partially transparent.
///
/// For values of opacity other than 0.0 and 1.0, this class is relatively
/// expensive because it requires painting the child into an intermediate
/// buffer. For the value 0.0, the child is not painted at all. For the
/// value 1.0, the child is painted immediately without an intermediate buffer.
///
/// The presence of the intermediate buffer which has a transparent background
/// by default may cause some child widgets to behave differently. For example
/// a [BackdropFilter] child will only be able to apply its filter to the content
/// between this widget and the backdrop child and may require adjusting the
/// [BackdropFilter.blendMode] property to produce the desired results.
///
/// {@youtube 560 315 https://www.youtube.com/watch?v=9hltevOHQBw}
///
/// {@tool snippet}
///
/// This example shows some [Text] when the `_visible` member field is true, and
/// hides it when it is false:
///
/// ```dart
/// Opacity(
///   opacity: _visible ? 1.0 : 0.0,
///   child: const Text("Now you see me, now you don't!"),
/// )
/// ```
/// {@end-tool}
///
/// This is more efficient than adding and removing the child widget from the
/// tree on demand.
///
/// ## Performance considerations for opacity animation
///
/// Animating an [Opacity] widget directly causes the widget (and possibly its
/// subtree) to rebuild each frame, which is not very efficient. Consider using
/// one of these alternative widgets instead:
///
///  * [AnimatedOpacity], which uses an animation internally to efficiently
///    animate opacity.
///  * [FadeTransition], which uses a provided animation to efficiently animate
///    opacity.
///
/// ## Transparent image
///
/// If only a single [Image] or [Color] needs to be composited with an opacity
/// between 0.0 and 1.0, it's much faster to directly use them without [Opacity]
/// widgets.
///
/// For example, `Container(color: Color.fromRGBO(255, 0, 0, 0.5))` is much
/// faster than `Opacity(opacity: 0.5, child: Container(color: Colors.red))`.
///
/// {@tool snippet}
///
/// The following example draws an [Image] with 0.5 opacity without using
/// [Opacity]:
///
/// ```dart
/// Image.network(
///   'https://raw.githubusercontent.com/flutter/assets-for-api-docs/master/packages/diagrams/assets/blend_mode_destination.jpeg',
///   color: const Color.fromRGBO(255, 255, 255, 0.5),
///   colorBlendMode: BlendMode.modulate
/// )
/// ```
///
/// {@end-tool}
///
/// Directly drawing an [Image] or [Color] with opacity is faster than using
/// [Opacity] on top of them because [Opacity] could apply the opacity to a
/// group of widgets and therefore a costly offscreen buffer will be used.
/// Drawing content into the offscreen buffer may also trigger render target
/// switches and such switching is particularly slow in older GPUs.
///
/// See also:
///
///  * [Visibility], which can hide a child more efficiently (albeit less
///    subtly, because it is either visible or hidden, rather than allowing
///    fractional opacity values). Specifically, the [Visibility.maintain]
///    constructor is equivalent to using an opacity widget with values of
///    `0.0` or `1.0`.
///  * [ShaderMask], which can apply more elaborate effects to its child.
///  * [Transform], which applies an arbitrary transform to its child widget at
///    paint time.
///  * [SliverOpacity], the sliver version of this widget.
class Opacity extends SingleChildRenderObjectWidget {
  /// Creates a widget that makes its child partially transparent.
  ///
  /// The [opacity] argument must not be null and must be between 0.0 and 1.0
  /// (inclusive).
  const Opacity({
    super.key,
    required this.opacity,
    this.alwaysIncludeSemantics = false,
    super.child,
  }) : assert(opacity >= 0.0 && opacity <= 1.0);

  /// The fraction to scale the child's alpha value.
  ///
  /// An opacity of 1.0 is fully opaque. An opacity of 0.0 is fully transparent
  /// (i.e., invisible).
  ///
  /// The opacity must not be null.
  ///
  /// Values 1.0 and 0.0 are painted with a fast path. Other values
  /// require painting the child into an intermediate buffer, which is
  /// expensive.
  final double opacity;

  /// Whether the semantic information of the children is always included.
  ///
  /// Defaults to false.
  ///
  /// When true, regardless of the opacity settings the child semantic
  /// information is exposed as if the widget were fully visible. This is
  /// useful in cases where labels may be hidden during animations that
  /// would otherwise contribute relevant semantics.
  final bool alwaysIncludeSemantics;

  @override
  RenderOpacity createRenderObject(BuildContext context) {
    return RenderOpacity(
      opacity: opacity,
      alwaysIncludeSemantics: alwaysIncludeSemantics,
    );
  }

  @override
  void updateRenderObject(BuildContext context, RenderOpacity renderObject) {
    renderObject
      ..opacity = opacity
      ..alwaysIncludeSemantics = alwaysIncludeSemantics;
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DoubleProperty('opacity', opacity));
    properties.add(FlagProperty('alwaysIncludeSemantics', value: alwaysIncludeSemantics, ifTrue: 'alwaysIncludeSemantics'));
  }
}

/// A widget that applies a mask generated by a [Shader] to its child.
///
/// For example, [ShaderMask] can be used to gradually fade out the edge
/// of a child by using a [ui.Gradient.linear] mask.
///
/// {@youtube 560 315 https://www.youtube.com/watch?v=7sUL66pTQ7Q}
///
/// {@tool snippet}
///
/// This example makes the text look like it is on fire:
///
/// ```dart
/// ShaderMask(
///   shaderCallback: (Rect bounds) {
///     return RadialGradient(
///       center: Alignment.topLeft,
///       radius: 1.0,
///       colors: <Color>[Colors.yellow, Colors.deepOrange.shade900],
///       tileMode: TileMode.mirror,
///     ).createShader(bounds);
///   },
///   child: const Text('I’m burning the memories'),
/// )
/// ```
/// {@end-tool}
///
/// See also:
///
///  * [Opacity], which can apply a uniform alpha effect to its child.
///  * [CustomPaint], which lets you draw directly on the canvas.
///  * [DecoratedBox], for another approach at decorating child widgets.
///  * [BackdropFilter], which applies an image filter to the background.
class ShaderMask extends SingleChildRenderObjectWidget {
  /// Creates a widget that applies a mask generated by a [Shader] to its child.
  ///
  /// The [shaderCallback] and [blendMode] arguments must not be null.
  const ShaderMask({
    super.key,
    required this.shaderCallback,
    this.blendMode = BlendMode.modulate,
    super.child,
  });

  /// Called to create the [dart:ui.Shader] that generates the mask.
  ///
  /// The shader callback is called with the current size of the child so that
  /// it can customize the shader to the size and location of the child.
  ///
  /// Typically this will use a [LinearGradient], [RadialGradient], or
  /// [SweepGradient] to create the [dart:ui.Shader], though the
  /// [dart:ui.ImageShader] class could also be used.
  final ShaderCallback shaderCallback;

  /// The [BlendMode] to use when applying the shader to the child.
  ///
  /// The default, [BlendMode.modulate], is useful for applying an alpha blend
  /// to the child. Other blend modes can be used to create other effects.
  final BlendMode blendMode;

  @override
  RenderShaderMask createRenderObject(BuildContext context) {
    return RenderShaderMask(
      shaderCallback: shaderCallback,
      blendMode: blendMode,
    );
  }

  @override
  void updateRenderObject(BuildContext context, RenderShaderMask renderObject) {
    renderObject
      ..shaderCallback = shaderCallback
      ..blendMode = blendMode;
  }
}

/// A widget that applies a filter to the existing painted content and then
/// paints [child].
///
/// The filter will be applied to all the area within its parent or ancestor
/// widget's clip. If there's no clip, the filter will be applied to the full
/// screen.
///
/// The results of the filter will be blended back into the background using
/// the [blendMode] parameter.
/// {@template flutter.widgets.BackdropFilter.blendMode}
/// The only value for [blendMode] that is supported on all platforms is
/// [BlendMode.srcOver] which works well for most scenes. But that value may
/// produce surprising results when a parent of the [BackdropFilter] uses a
/// temporary buffer, or save layer, as does an [Opacity] widget. In that
/// situation, a value of [BlendMode.src] can produce more pleasing results,
/// but at the cost of incompatibility with some platforms, most notably the
/// html renderer for web applications.
/// {@endtemplate}
///
/// {@youtube 560 315 https://www.youtube.com/watch?v=dYRs7Q1vfYI}
///
/// {@tool snippet}
/// If the [BackdropFilter] needs to be applied to an area that exactly matches
/// its child, wraps the [BackdropFilter] with a clip widget that clips exactly
/// to that child.
///
/// ```dart
/// Stack(
///   fit: StackFit.expand,
///   children: <Widget>[
///     Text('0' * 10000),
///     Center(
///       child: ClipRect(  // <-- clips to the 200x200 [Container] below
///         child: BackdropFilter(
///           filter: ui.ImageFilter.blur(
///             sigmaX: 5.0,
///             sigmaY: 5.0,
///           ),
///           child: Container(
///             alignment: Alignment.center,
///             width: 200.0,
///             height: 200.0,
///             child: const Text('Hello World'),
///           ),
///         ),
///       ),
///     ),
///   ],
/// )
/// ```
/// {@end-tool}
///
/// This effect is relatively expensive, especially if the filter is non-local,
/// such as a blur.
///
/// If all you want to do is apply an [ImageFilter] to a single widget
/// (as opposed to applying the filter to everything _beneath_ a widget), use
/// [ImageFiltered] instead. For that scenario, [ImageFiltered] is both
/// easier to use and less expensive than [BackdropFilter].
///
/// {@tool snippet}
///
/// This example shows how the common case of applying a [BackdropFilter] blur
/// to a single sibling can be replaced with an [ImageFiltered] widget. This code
/// is generally simpler and the performance will be improved dramatically for
/// complex filters like blurs.
///
/// The implementation below is unnecessarily expensive.
///
/// ```dart
///  Widget buildBackdrop() {
///    return Stack(
///      children: <Widget>[
///        Positioned.fill(child: Image.asset('image.png')),
///        Positioned.fill(
///          child: BackdropFilter(
///            filter: ui.ImageFilter.blur(sigmaX: 6, sigmaY: 6),
///          ),
///        ),
///      ],
///    );
///  }
/// ```
/// {@end-tool}
/// {@tool snippet}
/// Instead consider the following approach which directly applies a blur
/// to the child widget.
///
/// ```dart
///  Widget buildFilter() {
///    return ImageFiltered(
///      imageFilter: ui.ImageFilter.blur(sigmaX: 6, sigmaY: 6),
///      child: Image.asset('image.png'),
///    );
///  }
/// ```
///
/// {@end-tool}
///
/// See also:
///
///  * [ImageFiltered], which applies an [ImageFilter] to its child.
///  * [DecoratedBox], which draws a background under (or over) a widget.
///  * [Opacity], which changes the opacity of the widget itself.
///  * https://flutter.dev/go/ios-platformview-backdrop-filter-blur for details and restrictions when an iOS PlatformView needs to be blurred.
class BackdropFilter extends SingleChildRenderObjectWidget {
  /// Creates a backdrop filter.
  ///
  /// The [filter] argument must not be null.
  /// The [blendMode] argument will default to [BlendMode.srcOver] and must not be
  /// null if provided.
  const BackdropFilter({
    super.key,
    required this.filter,
    super.child,
    this.blendMode = BlendMode.srcOver,
  });

  /// The image filter to apply to the existing painted content before painting the child.
  ///
  /// For example, consider using [ImageFilter.blur] to create a backdrop
  /// blur effect.
  final ui.ImageFilter filter;

  /// The blend mode to use to apply the filtered background content onto the background
  /// surface.
  ///
  /// {@macro flutter.widgets.BackdropFilter.blendMode}
  final BlendMode blendMode;

  @override
  RenderBackdropFilter createRenderObject(BuildContext context) {
    return RenderBackdropFilter(filter: filter, blendMode: blendMode);
  }

  @override
  void updateRenderObject(BuildContext context, RenderBackdropFilter renderObject) {
    renderObject
      ..filter = filter
      ..blendMode = blendMode;
  }
}

/// A widget that provides a canvas on which to draw during the paint phase.
///
/// When asked to paint, [CustomPaint] first asks its [painter] to paint on the
/// current canvas, then it paints its child, and then, after painting its
/// child, it asks its [foregroundPainter] to paint. The coordinate system of the
/// canvas matches the coordinate system of the [CustomPaint] object. The
/// painters are expected to paint within a rectangle starting at the origin and
/// encompassing a region of the given size. (If the painters paint outside
/// those bounds, there might be insufficient memory allocated to rasterize the
/// painting commands and the resulting behavior is undefined.) To enforce
/// painting within those bounds, consider wrapping this [CustomPaint] with a
/// [ClipRect] widget.
///
/// Painters are implemented by subclassing [CustomPainter].
///
/// {@youtube 560 315 https://www.youtube.com/watch?v=kp14Y4uHpHs}
///
/// Because custom paint calls its painters during paint, you cannot call
/// `setState` or `markNeedsLayout` during the callback (the layout for this
/// frame has already happened).
///
/// Custom painters normally size themselves to their child. If they do not have
/// a child, they attempt to size themselves to the [size], which defaults to
/// [Size.zero]. [size] must not be null.
///
/// [isComplex] and [willChange] are hints to the compositor's raster cache.
///
/// {@tool snippet}
///
/// This example shows how the sample custom painter shown at [CustomPainter]
/// could be used in a [CustomPaint] widget to display a background to some
/// text.
///
/// ```dart
/// CustomPaint(
///   painter: Sky(),
///   child: const Center(
///     child: Text(
///       'Once upon a time...',
///       style: TextStyle(
///         fontSize: 40.0,
///         fontWeight: FontWeight.w900,
///         color: Color(0xFFFFFFFF),
///       ),
///     ),
///   ),
/// )
/// ```
/// {@end-tool}
///
/// See also:
///
///  * [CustomPainter], the class to extend when creating custom painters.
///  * [Canvas], the class that a custom painter uses to paint.
class CustomPaint extends SingleChildRenderObjectWidget {
  /// Creates a widget that delegates its painting.
  const CustomPaint({
    super.key,
    this.painter,
    this.foregroundPainter,
    this.size = Size.zero,
    this.isComplex = false,
    this.willChange = false,
    super.child,
  }) : assert(painter != null || foregroundPainter != null || (!isComplex && !willChange));

  /// The painter that paints before the children.
  final CustomPainter? painter;

  /// The painter that paints after the children.
  final CustomPainter? foregroundPainter;

  /// The size that this [CustomPaint] should aim for, given the layout
  /// constraints, if there is no child.
  ///
  /// Defaults to [Size.zero].
  ///
  /// If there's a child, this is ignored, and the size of the child is used
  /// instead.
  final Size size;

  /// Whether the painting is complex enough to benefit from caching.
  ///
  /// The compositor contains a raster cache that holds bitmaps of layers in
  /// order to avoid the cost of repeatedly rendering those layers on each
  /// frame. If this flag is not set, then the compositor will apply its own
  /// heuristics to decide whether the layer containing this widget is complex
  /// enough to benefit from caching.
  ///
  /// This flag can't be set to true if both [painter] and [foregroundPainter]
  /// are null because this flag will be ignored in such case.
  final bool isComplex;

  /// Whether the raster cache should be told that this painting is likely
  /// to change in the next frame.
  ///
  /// This hint tells the compositor not to cache the layer containing this
  /// widget because the cache will not be used in the future. If this hint is
  /// not set, the compositor will apply its own heuristics to decide whether
  /// the layer is likely to be reused in the future.
  ///
  /// This flag can't be set to true if both [painter] and [foregroundPainter]
  /// are null because this flag will be ignored in such case.
  final bool willChange;

  @override
  RenderCustomPaint createRenderObject(BuildContext context) {
    return RenderCustomPaint(
      painter: painter,
      foregroundPainter: foregroundPainter,
      preferredSize: size,
      isComplex: isComplex,
      willChange: willChange,
    );
  }

  @override
  void updateRenderObject(BuildContext context, RenderCustomPaint renderObject) {
    renderObject
      ..painter = painter
      ..foregroundPainter = foregroundPainter
      ..preferredSize = size
      ..isComplex = isComplex
      ..willChange = willChange;
  }

  @override
  void didUnmountRenderObject(RenderCustomPaint renderObject) {
    renderObject
      ..painter = null
      ..foregroundPainter = null;
  }
}

/// A widget that clips its child using a rectangle.
///
/// By default, [ClipRect] prevents its child from painting outside its
/// bounds, but the size and location of the clip rect can be customized using a
/// custom [clipper].
///
/// [ClipRect] is commonly used with these widgets, which commonly paint outside
/// their bounds:
///
///  * [CustomPaint]
///  * [CustomSingleChildLayout]
///  * [CustomMultiChildLayout]
///  * [Align] and [Center] (e.g., if [Align.widthFactor] or
///    [Align.heightFactor] is less than 1.0).
///  * [OverflowBox]
///  * [SizedOverflowBox]
///
/// {@tool snippet}
///
/// For example, by combining a [ClipRect] with an [Align], one can show just
/// the top half of an [Image]:
///
/// ```dart
/// ClipRect(
///   child: Align(
///     alignment: Alignment.topCenter,
///     heightFactor: 0.5,
///     child: Image.network(userAvatarUrl),
///   ),
/// )
/// ```
/// {@end-tool}
///
/// See also:
///
///  * [CustomClipper], for information about creating custom clips.
///  * [ClipRRect], for a clip with rounded corners.
///  * [ClipOval], for an elliptical clip.
///  * [ClipPath], for an arbitrarily shaped clip.
class ClipRect extends SingleChildRenderObjectWidget {
  /// Creates a rectangular clip.
  ///
  /// If [clipper] is null, the clip will match the layout size and position of
  /// the child.
  ///
  /// The [clipBehavior] argument must not be null. If [clipBehavior] is
  /// [Clip.none], no clipping will be applied.
  const ClipRect({
    super.key,
    this.clipper,
    this.clipBehavior = Clip.hardEdge,
    super.child,
  });

  /// If non-null, determines which clip to use.
  final CustomClipper<Rect>? clipper;

  /// {@macro flutter.rendering.ClipRectLayer.clipBehavior}
  ///
  /// Defaults to [Clip.hardEdge].
  final Clip clipBehavior;

  @override
  RenderClipRect createRenderObject(BuildContext context) {
    return RenderClipRect(clipper: clipper, clipBehavior: clipBehavior);
  }

  @override
  void updateRenderObject(BuildContext context, RenderClipRect renderObject) {
    renderObject
      ..clipper = clipper
      ..clipBehavior = clipBehavior;
  }

  @override
  void didUnmountRenderObject(RenderClipRect renderObject) {
    renderObject.clipper = null;
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<CustomClipper<Rect>>('clipper', clipper, defaultValue: null));
  }
}

/// A widget that clips its child using a rounded rectangle.
///
/// By default, [ClipRRect] uses its own bounds as the base rectangle for the
/// clip, but the size and location of the clip can be customized using a custom
/// [clipper].
///
/// {@youtube 560 315 https://www.youtube.com/watch?v=eI43jkQkrvs}
///
/// {@tool dartpad}
/// This example shows various [ClipRRect]s applied to containers.
///
/// ** See code in examples/api/lib/widgets/basic/clip_rrect.0.dart **
/// {@end-tool}
///
/// ## Troubleshooting
///
/// ### Why doesn't my [ClipRRect] child have rounded corners?
///
/// When a [ClipRRect] is bigger than the child it contains, its rounded corners
/// could be drawn in unexpected positions. Make sure that [ClipRRect] and its child
/// have the same bounds (by shrinking the [ClipRRect] with a [FittedBox] or by
/// growing the child).
///
/// {@tool dartpad}
/// This example shows a [ClipRRect] that adds round corners to an image.
///
/// ** See code in examples/api/lib/widgets/basic/clip_rrect.1.dart **
/// {@end-tool}
///
/// See also:
///
///  * [CustomClipper], for information about creating custom clips.
///  * [ClipRect], for more efficient clips without rounded corners.
///  * [ClipOval], for an elliptical clip.
///  * [ClipPath], for an arbitrarily shaped clip.
class ClipRRect extends SingleChildRenderObjectWidget {
  /// Creates a rounded-rectangular clip.
  ///
  /// The [borderRadius] defaults to [BorderRadius.zero], i.e. a rectangle with
  /// right-angled corners.
  ///
  /// If [clipper] is non-null, then [borderRadius] is ignored.
  ///
  /// The [clipBehavior] argument must not be null. If [clipBehavior] is
  /// [Clip.none], no clipping will be applied.
  const ClipRRect({
    super.key,
    this.borderRadius = BorderRadius.zero,
    this.clipper,
    this.clipBehavior = Clip.antiAlias,
    super.child,
  }) : assert(borderRadius != null || clipper != null);

  /// The border radius of the rounded corners.
  ///
  /// Values are clamped so that horizontal and vertical radii sums do not
  /// exceed width/height.
  ///
  /// This value is ignored if [clipper] is non-null.
  final BorderRadiusGeometry? borderRadius;

  /// If non-null, determines which clip to use.
  final CustomClipper<RRect>? clipper;

  /// {@macro flutter.rendering.ClipRectLayer.clipBehavior}
  ///
  /// Defaults to [Clip.antiAlias].
  final Clip clipBehavior;

  @override
  RenderClipRRect createRenderObject(BuildContext context) {
    return RenderClipRRect(
      borderRadius: borderRadius!,
      clipper: clipper,
      clipBehavior: clipBehavior,
      textDirection: Directionality.maybeOf(context),
    );
  }

  @override
  void updateRenderObject(BuildContext context, RenderClipRRect renderObject) {
    renderObject
      ..borderRadius = borderRadius!
      ..clipBehavior = clipBehavior
      ..clipper = clipper
      ..textDirection = Directionality.maybeOf(context);
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<BorderRadiusGeometry>('borderRadius', borderRadius, showName: false, defaultValue: null));
    properties.add(DiagnosticsProperty<CustomClipper<RRect>>('clipper', clipper, defaultValue: null));
  }
}

/// A widget that clips its child using an oval.
///
/// {@youtube 560 315 https://www.youtube.com/watch?v=vzWWDO6whIM}
///
/// By default, inscribes an axis-aligned oval into its layout dimensions and
/// prevents its child from painting outside that oval, but the size and
/// location of the clip oval can be customized using a custom [clipper].
///
/// See also:
///
///  * [CustomClipper], for information about creating custom clips.
///  * [ClipRect], for more efficient clips without rounded corners.
///  * [ClipRRect], for a clip with rounded corners.
///  * [ClipPath], for an arbitrarily shaped clip.
class ClipOval extends SingleChildRenderObjectWidget {
  /// Creates an oval-shaped clip.
  ///
  /// If [clipper] is null, the oval will be inscribed into the layout size and
  /// position of the child.
  ///
  /// The [clipBehavior] argument must not be null. If [clipBehavior] is
  /// [Clip.none], no clipping will be applied.
  const ClipOval({
    super.key,
    this.clipper,
    this.clipBehavior = Clip.antiAlias,
    super.child,
  });

  /// If non-null, determines which clip to use.
  ///
  /// The delegate returns a rectangle that describes the axis-aligned
  /// bounding box of the oval. The oval's axes will themselves also
  /// be axis-aligned.
  ///
  /// If the [clipper] delegate is null, then the oval uses the
  /// widget's bounding box (the layout dimensions of the render
  /// object) instead.
  final CustomClipper<Rect>? clipper;

  /// {@macro flutter.rendering.ClipRectLayer.clipBehavior}
  ///
  /// Defaults to [Clip.antiAlias].
  final Clip clipBehavior;

  @override
  RenderClipOval createRenderObject(BuildContext context) {
    return RenderClipOval(clipper: clipper, clipBehavior: clipBehavior);
  }

  @override
  void updateRenderObject(BuildContext context, RenderClipOval renderObject) {
    renderObject
      ..clipper = clipper
      ..clipBehavior = clipBehavior;
  }

  @override
  void didUnmountRenderObject(RenderClipOval renderObject) {
    renderObject.clipper = null;
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<CustomClipper<Rect>>('clipper', clipper, defaultValue: null));
  }
}

/// A widget that clips its child using a path.
///
/// Calls a callback on a delegate whenever the widget is to be
/// painted. The callback returns a path and the widget prevents the
/// child from painting outside the path.
///
/// {@youtube 560 315 https://www.youtube.com/watch?v=oAUebVIb-7s}
///
/// Clipping to a path is expensive. Certain shapes have more
/// optimized widgets:
///
///  * To clip to a rectangle, consider [ClipRect].
///  * To clip to an oval or circle, consider [ClipOval].
///  * To clip to a rounded rectangle, consider [ClipRRect].
///
/// To clip to a particular [ShapeBorder], consider using either the
/// [ClipPath.shape] static method or the [ShapeBorderClipper] custom clipper
/// class.
class ClipPath extends SingleChildRenderObjectWidget {
  /// Creates a path clip.
  ///
  /// If [clipper] is null, the clip will be a rectangle that matches the layout
  /// size and location of the child. However, rather than use this default,
  /// consider using a [ClipRect], which can achieve the same effect more
  /// efficiently.
  ///
  /// The [clipBehavior] argument must not be null. If [clipBehavior] is
  /// [Clip.none], no clipping will be applied.
  const ClipPath({
    super.key,
    this.clipper,
    this.clipBehavior = Clip.antiAlias,
    super.child,
  });

  /// Creates a shape clip.
  ///
  /// Uses a [ShapeBorderClipper] to configure the [ClipPath] to clip to the
  /// given [ShapeBorder].
  static Widget shape({
    Key? key,
    required ShapeBorder shape,
    Clip clipBehavior = Clip.antiAlias,
    Widget? child,
  }) {
    return Builder(
      key: key,
      builder: (BuildContext context) {
        return ClipPath(
          clipper: ShapeBorderClipper(
            shape: shape,
            textDirection: Directionality.maybeOf(context),
          ),
          clipBehavior: clipBehavior,
          child: child,
        );
      },
    );
  }

  /// If non-null, determines which clip to use.
  ///
  /// The default clip, which is used if this property is null, is the
  /// bounding box rectangle of the widget. [ClipRect] is a more
  /// efficient way of obtaining that effect.
  final CustomClipper<Path>? clipper;

  /// {@macro flutter.rendering.ClipRectLayer.clipBehavior}
  ///
  /// Defaults to [Clip.antiAlias].
  final Clip clipBehavior;

  @override
  RenderClipPath createRenderObject(BuildContext context) {
    return RenderClipPath(clipper: clipper, clipBehavior: clipBehavior);
  }

  @override
  void updateRenderObject(BuildContext context, RenderClipPath renderObject) {
    renderObject
      ..clipper = clipper
      ..clipBehavior = clipBehavior;
  }

  @override
  void didUnmountRenderObject(RenderClipPath renderObject) {
    renderObject.clipper = null;
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<CustomClipper<Path>>('clipper', clipper, defaultValue: null));
  }
}

/// A widget representing a physical layer that clips its children to a shape.
///
/// {@youtube 560 315 https://www.youtube.com/watch?v=XgUOSS30OQk}
///
/// Physical layers cast shadows based on an [elevation] which is nominally in
/// logical pixels, coming vertically out of the rendering surface.
///
/// For shapes that cannot be expressed as a rectangle with rounded corners use
/// [PhysicalShape].
///
/// See also:
///
///  * [AnimatedPhysicalModel], which animates property changes smoothly over
///    a given duration.
///  * [DecoratedBox], which can apply more arbitrary shadow effects.
///  * [ClipRect], which applies a clip to its child.
class PhysicalModel extends SingleChildRenderObjectWidget {
  /// Creates a physical model with a rounded-rectangular clip.
  ///
  /// The [color] is required; physical things have a color.
  ///
  /// The [shape], [elevation], [color], [clipBehavior], and [shadowColor] must
  /// not be null. Additionally, the [elevation] must be non-negative.
  const PhysicalModel({
    super.key,
    this.shape = BoxShape.rectangle,
    this.clipBehavior = Clip.none,
    this.borderRadius,
    this.elevation = 0.0,
    required this.color,
    this.shadowColor = const Color(0xFF000000),
    super.child,
  }) : assert(elevation >= 0.0);

  /// The type of shape.
  final BoxShape shape;

  /// {@macro flutter.material.Material.clipBehavior}
  ///
  /// Defaults to [Clip.none].
  final Clip clipBehavior;

  /// The border radius of the rounded corners.
  ///
  /// Values are clamped so that horizontal and vertical radii sums do not
  /// exceed width/height.
  ///
  /// This is ignored if the [shape] is not [BoxShape.rectangle].
  final BorderRadius? borderRadius;

  /// The z-coordinate relative to the parent at which to place this physical
  /// object.
  ///
  /// The value is non-negative.
  final double elevation;

  /// The background color.
  final Color color;

  /// The shadow color.
  final Color shadowColor;

  @override
  RenderPhysicalModel createRenderObject(BuildContext context) {
    return RenderPhysicalModel(
      shape: shape,
      clipBehavior: clipBehavior,
      borderRadius: borderRadius,
      elevation: elevation,
      color: color,
      shadowColor: shadowColor,
    );
  }

  @override
  void updateRenderObject(BuildContext context, RenderPhysicalModel renderObject) {
    renderObject
      ..shape = shape
      ..clipBehavior = clipBehavior
      ..borderRadius = borderRadius
      ..elevation = elevation
      ..color = color
      ..shadowColor = shadowColor;
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(EnumProperty<BoxShape>('shape', shape));
    properties.add(DiagnosticsProperty<BorderRadius>('borderRadius', borderRadius));
    properties.add(DoubleProperty('elevation', elevation));
    properties.add(ColorProperty('color', color));
    properties.add(ColorProperty('shadowColor', shadowColor));
  }
}

/// A widget representing a physical layer that clips its children to a path.
///
/// Physical layers cast shadows based on an [elevation] which is nominally in
/// logical pixels, coming vertically out of the rendering surface.
///
/// [PhysicalModel] does the same but only supports shapes that can be expressed
/// as rectangles with rounded corners.
///
/// {@tool dartpad}
/// This example shows how to use a [PhysicalShape] on a centered [SizedBox]
/// to clip it to a rounded rectangle using a [ShapeBorderClipper] and give it
/// an orange color along with a shadow.
///
/// ** See code in examples/api/lib/widgets/basic/physical_shape.0.dart **
/// {@end-tool}
///
/// See also:
///
///  * [ShapeBorderClipper], which converts a [ShapeBorder] to a [CustomClipper], as
///    needed by this widget.
class PhysicalShape extends SingleChildRenderObjectWidget {
  /// Creates a physical model with an arbitrary shape clip.
  ///
  /// The [color] is required; physical things have a color.
  ///
  /// The [clipper], [elevation], [color], [clipBehavior], and [shadowColor]
  /// must not be null. Additionally, the [elevation] must be non-negative.
  const PhysicalShape({
    super.key,
    required this.clipper,
    this.clipBehavior = Clip.none,
    this.elevation = 0.0,
    required this.color,
    this.shadowColor = const Color(0xFF000000),
    super.child,
  }) : assert(elevation >= 0.0);

  /// Determines which clip to use.
  ///
  /// If the path in question is expressed as a [ShapeBorder] subclass,
  /// consider using the [ShapeBorderClipper] delegate class to adapt the
  /// shape for use with this widget.
  final CustomClipper<Path> clipper;

  /// {@macro flutter.material.Material.clipBehavior}
  ///
  /// Defaults to [Clip.none].
  final Clip clipBehavior;

  /// The z-coordinate relative to the parent at which to place this physical
  /// object.
  ///
  /// The value is non-negative.
  final double elevation;

  /// The background color.
  final Color color;

  /// When elevation is non zero the color to use for the shadow color.
  final Color shadowColor;

  @override
  RenderPhysicalShape createRenderObject(BuildContext context) {
    return RenderPhysicalShape(
      clipper: clipper,
      clipBehavior: clipBehavior,
      elevation: elevation,
      color: color,
      shadowColor: shadowColor,
    );
  }

  @override
  void updateRenderObject(BuildContext context, RenderPhysicalShape renderObject) {
    renderObject
      ..clipper = clipper
      ..clipBehavior = clipBehavior
      ..elevation = elevation
      ..color = color
      ..shadowColor = shadowColor;
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<CustomClipper<Path>>('clipper', clipper));
    properties.add(DoubleProperty('elevation', elevation));
    properties.add(ColorProperty('color', color));
    properties.add(ColorProperty('shadowColor', shadowColor));
  }
}

// POSITIONING AND SIZING NODES

/// A widget that applies a transformation before painting its child.
///
/// Unlike [RotatedBox], which applies a rotation prior to layout, this object
/// applies its transformation just prior to painting, which means the
/// transformation is not taken into account when calculating how much space
/// this widget's child (and thus this widget) consumes.
///
/// {@youtube 560 315 https://www.youtube.com/watch?v=9z_YNlRlWfA}
///
/// {@tool snippet}
///
/// This example rotates and skews an orange box containing text, keeping the
/// top right corner pinned to its original position.
///
/// ```dart
/// ColoredBox(
///   color: Colors.black,
///   child: Transform(
///     alignment: Alignment.topRight,
///     transform: Matrix4.skewY(0.3)..rotateZ(-math.pi / 12.0),
///     child: Container(
///       padding: const EdgeInsets.all(8.0),
///       color: const Color(0xFFE8581C),
///       child: const Text('Apartment for rent!'),
///     ),
///   ),
/// )
/// ```
/// {@end-tool}
///
/// See also:
///
///  * [RotatedBox], which rotates the child widget during layout, not just
///    during painting.
///  * [FractionalTranslation], which applies a translation to the child
///    that is relative to the child's size.
///  * [FittedBox], which sizes and positions its child widget to fit the parent
///    according to a given [BoxFit] discipline.
///  * The [catalog of layout widgets](https://flutter.dev/widgets/layout/).
class Transform extends SingleChildRenderObjectWidget {
  /// Creates a widget that transforms its child.
  ///
  /// The [transform] argument must not be null.
  const Transform({
    super.key,
    required this.transform,
    this.origin,
    this.alignment,
    this.transformHitTests = true,
    this.filterQuality,
    super.child,
  });

  /// Creates a widget that transforms its child using a rotation around the
  /// center.
  ///
  /// The `angle` argument must not be null. It gives the rotation in clockwise
  /// radians.
  ///
  /// {@tool snippet}
  ///
  /// This example rotates an orange box containing text around its center by
  /// fifteen degrees.
  ///
  /// ```dart
  /// Transform.rotate(
  ///   angle: -math.pi / 12.0,
  ///   child: Container(
  ///     padding: const EdgeInsets.all(8.0),
  ///     color: const Color(0xFFE8581C),
  ///     child: const Text('Apartment for rent!'),
  ///   ),
  /// )
  /// ```
  /// {@end-tool}
  ///
  /// See also:
  ///
  ///  * [RotationTransition], which animates changes in rotation smoothly
  ///    over a given duration.
  Transform.rotate({
    super.key,
    required double angle,
    this.origin,
    this.alignment = Alignment.center,
    this.transformHitTests = true,
    this.filterQuality,
    super.child,
  }) : transform = _computeRotation(angle);

  /// Creates a widget that transforms its child using a translation.
  ///
  /// The `offset` argument must not be null. It specifies the translation.
  ///
  /// {@tool snippet}
  ///
  /// This example shifts the silver-colored child down by fifteen pixels.
  ///
  /// ```dart
  /// Transform.translate(
  ///   offset: const Offset(0.0, 15.0),
  ///   child: Container(
  ///     padding: const EdgeInsets.all(8.0),
  ///     color: const Color(0xFF7F7F7F),
  ///     child: const Text('Quarter'),
  ///   ),
  /// )
  /// ```
  /// {@end-tool}
  Transform.translate({
    super.key,
    required Offset offset,
    this.transformHitTests = true,
    this.filterQuality,
    super.child,
  }) : transform = Matrix4.translationValues(offset.dx, offset.dy, 0.0),
       origin = null,
       alignment = null;

  /// Creates a widget that scales its child along the 2D plane.
  ///
  /// The `scaleX` argument provides the scalar by which to multiply the `x` axis, and the `scaleY` argument provides the scalar by which to multiply the `y` axis. Either may be omitted, in which case that axis defaults to 1.0.
  ///
  /// For convenience, to scale the child uniformly, instead of providing `scaleX` and `scaleY`, the `scale` parameter may be used.
  ///
  /// At least one of `scale`, `scaleX`, and `scaleY` must be non-null. If `scale` is provided, the other two must be null; similarly, if it is not provided, one of the other two must be provided.
  ///
  /// The [alignment] controls the origin of the scale; by default, this is
  /// the center of the box.
  ///
  /// {@tool snippet}
  ///
  /// This example shrinks an orange box containing text such that each dimension
  /// is half the size it would otherwise be.
  ///
  /// ```dart
  /// Transform.scale(
  ///   scale: 0.5,
  ///   child: Container(
  ///     padding: const EdgeInsets.all(8.0),
  ///     color: const Color(0xFFE8581C),
  ///     child: const Text('Bad Idea Bears'),
  ///   ),
  /// )
  /// ```
  /// {@end-tool}
  ///
  /// See also:
  ///
  ///  * [ScaleTransition], which animates changes in scale smoothly
  ///    over a given duration.
  Transform.scale({
    super.key,
    double? scale,
    double? scaleX,
    double? scaleY,
    this.origin,
    this.alignment = Alignment.center,
    this.transformHitTests = true,
    this.filterQuality,
    super.child,
  })  : assert(!(scale == null && scaleX == null && scaleY == null), "At least one of 'scale', 'scaleX' and 'scaleY' is required to be non-null"),
        assert(scale == null || (scaleX == null && scaleY == null), "If 'scale' is non-null then 'scaleX' and 'scaleY' must be left null"),
        transform = Matrix4.diagonal3Values(scale ?? scaleX ?? 1.0, scale ?? scaleY ?? 1.0, 1.0);

  /// Creates a widget that mirrors its child about the widget's center point.
  ///
  /// If `flipX` is true, the child widget will be flipped horizontally. Defaults to false.
  ///
  /// If `flipY` is true, the child widget will be flipped vertically. Defaults to false.
  ///
  /// If both are true, the child widget will be flipped both vertically and horizontally, equivalent to a 180 degree rotation.
  ///
  /// {@tool snippet}
  ///
  /// This example flips the text horizontally.
  ///
  /// ```dart
  /// Transform.flip(
  ///   flipX: true,
  ///   child: const Text('Horizontal Flip'),
  /// )
  /// ```
  /// {@end-tool}
  Transform.flip({
      super.key,
      bool flipX = false,
      bool flipY = false,
      this.origin,
      this.transformHitTests = true,
      this.filterQuality,
      super.child,
  })  : alignment = Alignment.center,
        transform = Matrix4.diagonal3Values(flipX ? -1.0 : 1.0, flipY ? -1.0 : 1.0, 1.0);

  // Computes a rotation matrix for an angle in radians, attempting to keep rotations
  // at integral values for angles of 0, π/2, π, 3π/2.
  static Matrix4 _computeRotation(double radians) {
    assert(radians.isFinite, 'Cannot compute the rotation matrix for a non-finite angle: \$radians');
    if (radians == 0.0) {
      return Matrix4.identity();
    }
    final double sin = math.sin(radians);
    if (sin == 1.0) {
      return _createZRotation(1.0, 0.0);
    }
    if (sin == -1.0) {
      return _createZRotation(-1.0, 0.0);
    }
    final double cos = math.cos(radians);
    if (cos == -1.0) {
      return _createZRotation(0.0, -1.0);
    }
    return _createZRotation(sin, cos);
  }

  static Matrix4 _createZRotation(double sin, double cos) {
    final Matrix4 result = Matrix4.zero();
    result.storage[0] = cos;
    result.storage[1] = sin;
    result.storage[4] = -sin;
    result.storage[5] = cos;
    result.storage[10] = 1.0;
    result.storage[15] = 1.0;
    return result;
  }

  /// The matrix to transform the child by during painting.
  final Matrix4 transform;

  /// The origin of the coordinate system (relative to the upper left corner of
  /// this render object) in which to apply the matrix.
  ///
  /// Setting an origin is equivalent to conjugating the transform matrix by a
  /// translation. This property is provided just for convenience.
  final Offset? origin;

  /// The alignment of the origin, relative to the size of the box.
  ///
  /// This is equivalent to setting an origin based on the size of the box.
  /// If it is specified at the same time as the [origin], both are applied.
  ///
  /// An [AlignmentDirectional.centerStart] value is the same as an [Alignment]
  /// whose [Alignment.x] value is `-1.0` if [Directionality.of] returns
  /// [TextDirection.ltr], and `1.0` if [Directionality.of] returns
  /// [TextDirection.rtl].	 Similarly [AlignmentDirectional.centerEnd] is the
  /// same as an [Alignment] whose [Alignment.x] value is `1.0` if
  /// [Directionality.of] returns	 [TextDirection.ltr], and `-1.0` if
  /// [Directionality.of] returns [TextDirection.rtl].
  final AlignmentGeometry? alignment;

  /// Whether to apply the transformation when performing hit tests.
  final bool transformHitTests;

  /// The filter quality with which to apply the transform as a bitmap operation.
  ///
  /// {@template flutter.widgets.Transform.optional.FilterQuality}
  /// The transform will be applied by re-rendering the child if [filterQuality] is null,
  /// otherwise it controls the quality of an [ImageFilter.matrix] applied to a bitmap
  /// rendering of the child.
  /// {@endtemplate}
  final FilterQuality? filterQuality;

  @override
  RenderTransform createRenderObject(BuildContext context) {
    return RenderTransform(
      transform: transform,
      origin: origin,
      alignment: alignment,
      textDirection: Directionality.maybeOf(context),
      transformHitTests: transformHitTests,
      filterQuality: filterQuality,
    );
  }

  @override
  void updateRenderObject(BuildContext context, RenderTransform renderObject) {
    renderObject
      ..transform = transform
      ..origin = origin
      ..alignment = alignment
      ..textDirection = Directionality.maybeOf(context)
      ..transformHitTests = transformHitTests
      ..filterQuality = filterQuality;
  }
}

/// A widget that can be targeted by a [CompositedTransformFollower].
///
/// When this widget is composited during the compositing phase (which comes
/// after the paint phase, as described in [WidgetsBinding.drawFrame]), it
/// updates the [link] object so that any [CompositedTransformFollower] widgets
/// that are subsequently composited in the same frame and were given the same
/// [LayerLink] can position themselves at the same screen location.
///
/// A single [CompositedTransformTarget] can be followed by multiple
/// [CompositedTransformFollower] widgets.
///
/// The [CompositedTransformTarget] must come earlier in the paint order than
/// any linked [CompositedTransformFollower]s.
///
/// See also:
///
///  * [CompositedTransformFollower], the widget that can target this one.
///  * [LeaderLayer], the layer that implements this widget's logic.
class CompositedTransformTarget extends SingleChildRenderObjectWidget {
  /// Creates a composited transform target widget.
  ///
  /// The [link] property must not be null, and must not be currently being used
  /// by any other [CompositedTransformTarget] object that is in the tree.
  const CompositedTransformTarget({
    super.key,
    required this.link,
    super.child,
  });

  /// The link object that connects this [CompositedTransformTarget] with one or
  /// more [CompositedTransformFollower]s.
  ///
  /// This property must not be null. The object must not be associated with
  /// another [CompositedTransformTarget] that is also being painted.
  final LayerLink link;

  @override
  RenderLeaderLayer createRenderObject(BuildContext context) {
    return RenderLeaderLayer(
      link: link,
    );
  }

  @override
  void updateRenderObject(BuildContext context, RenderLeaderLayer renderObject) {
    renderObject.link = link;
  }
}

/// A widget that follows a [CompositedTransformTarget].
///
/// When this widget is composited during the compositing phase (which comes
/// after the paint phase, as described in [WidgetsBinding.drawFrame]), it
/// applies a transformation that brings [targetAnchor] of the linked
/// [CompositedTransformTarget] and [followerAnchor] of this widget together.
/// The two anchor points will have the same global coordinates, unless [offset]
/// is not [Offset.zero], in which case [followerAnchor] will be offset by
/// [offset] in the linked [CompositedTransformTarget]'s coordinate space.
///
/// The [LayerLink] object used as the [link] must be the same object as that
/// provided to the matching [CompositedTransformTarget].
///
/// The [CompositedTransformTarget] must come earlier in the paint order than
/// this [CompositedTransformFollower].
///
/// Hit testing on descendants of this widget will only work if the target
/// position is within the box that this widget's parent considers to be
/// hittable. If the parent covers the screen, this is trivially achievable, so
/// this widget is usually used as the root of an [OverlayEntry] in an app-wide
/// [Overlay] (e.g. as created by the [MaterialApp] widget's [Navigator]).
///
/// See also:
///
///  * [CompositedTransformTarget], the widget that this widget can target.
///  * [FollowerLayer], the layer that implements this widget's logic.
///  * [Transform], which applies an arbitrary transform to a child.
class CompositedTransformFollower extends SingleChildRenderObjectWidget {
  /// Creates a composited transform target widget.
  ///
  /// The [link] property must not be null. If it was also provided to a
  /// [CompositedTransformTarget], that widget must come earlier in the paint
  /// order.
  ///
  /// The [showWhenUnlinked] and [offset] properties must also not be null.
  const CompositedTransformFollower({
    super.key,
    required this.link,
    this.showWhenUnlinked = true,
    this.offset = Offset.zero,
    this.targetAnchor = Alignment.topLeft,
    this.followerAnchor = Alignment.topLeft,
    super.child,
  });

  /// The link object that connects this [CompositedTransformFollower] with a
  /// [CompositedTransformTarget].
  ///
  /// This property must not be null.
  final LayerLink link;

  /// Whether to show the widget's contents when there is no corresponding
  /// [CompositedTransformTarget] with the same [link].
  ///
  /// When the widget is linked, the child is positioned such that it has the
  /// same global position as the linked [CompositedTransformTarget].
  ///
  /// When the widget is not linked, then: if [showWhenUnlinked] is true, the
  /// child is visible and not repositioned; if it is false, then child is
  /// hidden.
  final bool showWhenUnlinked;

  /// The anchor point on the linked [CompositedTransformTarget] that
  /// [followerAnchor] will line up with.
  ///
  /// {@template flutter.widgets.CompositedTransformFollower.targetAnchor}
  /// For example, when [targetAnchor] and [followerAnchor] are both
  /// [Alignment.topLeft], this widget will be top left aligned with the linked
  /// [CompositedTransformTarget]. When [targetAnchor] is
  /// [Alignment.bottomLeft] and [followerAnchor] is [Alignment.topLeft], this
  /// widget will be left aligned with the linked [CompositedTransformTarget],
  /// and its top edge will line up with the [CompositedTransformTarget]'s
  /// bottom edge.
  /// {@endtemplate}
  ///
  /// Defaults to [Alignment.topLeft].
  final Alignment targetAnchor;

  /// The anchor point on this widget that will line up with [targetAnchor] on
  /// the linked [CompositedTransformTarget].
  ///
  /// {@macro flutter.widgets.CompositedTransformFollower.targetAnchor}
  ///
  /// Defaults to [Alignment.topLeft].
  final Alignment followerAnchor;

  /// The additional offset to apply to the [targetAnchor] of the linked
  /// [CompositedTransformTarget] to obtain this widget's [followerAnchor]
  /// position.
  final Offset offset;

  @override
  RenderFollowerLayer createRenderObject(BuildContext context) {
    return RenderFollowerLayer(
      link: link,
      showWhenUnlinked: showWhenUnlinked,
      offset: offset,
      leaderAnchor: targetAnchor,
      followerAnchor: followerAnchor,
    );
  }

  @override
  void updateRenderObject(BuildContext context, RenderFollowerLayer renderObject) {
    renderObject
      ..link = link
      ..showWhenUnlinked = showWhenUnlinked
      ..offset = offset
      ..leaderAnchor = targetAnchor
      ..followerAnchor = followerAnchor;
  }
}

/// Scales and positions its child within itself according to [fit].
///
/// {@youtube 560 315 https://www.youtube.com/watch?v=T4Uehk3_wlY}
///
/// {@tool dartpad}
/// In this example, the [Placeholder] is stretched to fill the entire
/// [Container]. Try changing the fit types to see the effect on the layout of
/// the [Placeholder].
///
/// ** See code in examples/api/lib/widgets/basic/fitted_box.0.dart **
/// {@end-tool}
///
/// See also:
///
/// * [Transform], which applies an arbitrary transform to its child widget at
///   paint time.
/// * The [catalog of layout widgets](https://flutter.dev/widgets/layout/).
class FittedBox extends SingleChildRenderObjectWidget {
  /// Creates a widget that scales and positions its child within itself according to [fit].
  ///
  /// The [fit] and [alignment] arguments must not be null.
  const FittedBox({
    super.key,
    this.fit = BoxFit.contain,
    this.alignment = Alignment.center,
    this.clipBehavior = Clip.none,
    super.child,
  });

  /// How to inscribe the child into the space allocated during layout.
  final BoxFit fit;

  /// How to align the child within its parent's bounds.
  ///
  /// An alignment of (-1.0, -1.0) aligns the child to the top-left corner of its
  /// parent's bounds. An alignment of (1.0, 0.0) aligns the child to the middle
  /// of the right edge of its parent's bounds.
  ///
  /// Defaults to [Alignment.center].
  ///
  /// See also:
  ///
  ///  * [Alignment], a class with convenient constants typically used to
  ///    specify an [AlignmentGeometry].
  ///  * [AlignmentDirectional], like [Alignment] for specifying alignments
  ///    relative to text direction.
  final AlignmentGeometry alignment;

  /// {@macro flutter.material.Material.clipBehavior}
  ///
  /// Defaults to [Clip.none].
  final Clip clipBehavior;

  @override
  RenderFittedBox createRenderObject(BuildContext context) {
    return RenderFittedBox(
      fit: fit,
      alignment: alignment,
      textDirection: Directionality.maybeOf(context),
      clipBehavior: clipBehavior,
    );
  }

  @override
  void updateRenderObject(BuildContext context, RenderFittedBox renderObject) {
    renderObject
      ..fit = fit
      ..alignment = alignment
      ..textDirection = Directionality.maybeOf(context)
      ..clipBehavior = clipBehavior;
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(EnumProperty<BoxFit>('fit', fit));
    properties.add(DiagnosticsProperty<AlignmentGeometry>('alignment', alignment));
  }
}

/// Applies a translation transformation before painting its child.
///
/// The translation is expressed as a [Offset] scaled to the child's size. For
/// example, an [Offset] with a `dx` of 0.25 will result in a horizontal
/// translation of one quarter the width of the child.
///
/// Hit tests will only be detected inside the bounds of the
/// [FractionalTranslation], even if the contents are offset such that
/// they overflow.
///
/// See also:
///
///  * [Transform], which applies an arbitrary transform to its child widget at
///    paint time.
///  * [Transform.translate], which applies an absolute offset translation
///    transformation instead of an offset scaled to the child.
///  * The [catalog of layout widgets](https://flutter.dev/widgets/layout/).
class FractionalTranslation extends SingleChildRenderObjectWidget {
  /// Creates a widget that translates its child's painting.
  ///
  /// The [translation] argument must not be null.
  const FractionalTranslation({
    super.key,
    required this.translation,
    this.transformHitTests = true,
    super.child,
  });

  /// The translation to apply to the child, scaled to the child's size.
  ///
  /// For example, an [Offset] with a `dx` of 0.25 will result in a horizontal
  /// translation of one quarter the width of the child.
  final Offset translation;

  /// Whether to apply the translation when performing hit tests.
  final bool transformHitTests;

  @override
  RenderFractionalTranslation createRenderObject(BuildContext context) {
    return RenderFractionalTranslation(
      translation: translation,
      transformHitTests: transformHitTests,
    );
  }

  @override
  void updateRenderObject(BuildContext context, RenderFractionalTranslation renderObject) {
    renderObject
      ..translation = translation
      ..transformHitTests = transformHitTests;
  }
}

/// A widget that rotates its child by a integral number of quarter turns.
///
/// Unlike [Transform], which applies a transform just prior to painting,
/// this object applies its rotation prior to layout, which means the entire
/// rotated box consumes only as much space as required by the rotated child.
///
/// {@youtube 560 315 https://www.youtube.com/watch?v=BFE6_UglLfQ}
///
/// {@tool snippet}
///
/// This snippet rotates the child (some [Text]) so that it renders from bottom
/// to top, like an axis label on a graph:
///
/// ```dart
/// const RotatedBox(
///   quarterTurns: 3,
///   child: Text('Hello World!'),
/// )
/// ```
/// {@end-tool}
///
/// See also:
///
///  * [Transform], which is a paint effect that allows you to apply an
///    arbitrary transform to a child.
///  * [Transform.rotate], which applies a rotation paint effect.
///  * The [catalog of layout widgets](https://flutter.dev/widgets/layout/).
class RotatedBox extends SingleChildRenderObjectWidget {
  /// A widget that rotates its child.
  ///
  /// The [quarterTurns] argument must not be null.
  const RotatedBox({
    super.key,
    required this.quarterTurns,
    super.child,
  });

  /// The number of clockwise quarter turns the child should be rotated.
  final int quarterTurns;

  @override
  RenderRotatedBox createRenderObject(BuildContext context) => RenderRotatedBox(quarterTurns: quarterTurns);

  @override
  void updateRenderObject(BuildContext context, RenderRotatedBox renderObject) {
    renderObject.quarterTurns = quarterTurns;
  }
}

/// A widget that insets its child by the given padding.
///
/// {@youtube 560 315 https://www.youtube.com/watch?v=oD5RtLhhubg}
///
/// When passing layout constraints to its child, padding shrinks the
/// constraints by the given padding, causing the child to layout at a smaller
/// size. Padding then sizes itself to its child's size, inflated by the
/// padding, effectively creating empty space around the child.
///
/// {@tool snippet}
///
/// This snippet creates "Hello World!" [Text] inside a [Card] that is indented
/// by sixteen pixels in each direction.
///
/// ![](https://flutter.github.io/assets-for-api-docs/assets/widgets/padding.png)
///
/// ```dart
/// const Card(
///   child: Padding(
///     padding: EdgeInsets.all(16.0),
///     child: Text('Hello World!'),
///   ),
/// )
/// ```
/// {@end-tool}
///
/// ## Design discussion
///
/// ### Why use a [Padding] widget rather than a [Container] with a [Container.padding] property?
///
/// There isn't really any difference between the two. If you supply a
/// [Container.padding] argument, [Container] builds a [Padding] widget
/// for you.
///
/// [Container] doesn't implement its properties directly. Instead, [Container]
/// combines a number of simpler widgets together into a convenient package. For
/// example, the [Container.padding] property causes the container to build a
/// [Padding] widget and the [Container.decoration] property causes the
/// container to build a [DecoratedBox] widget. If you find [Container]
/// convenient, feel free to use it. If not, feel free to build these simpler
/// widgets in whatever combination meets your needs.
///
/// In fact, the majority of widgets in Flutter are combinations of other
/// simpler widgets. Composition, rather than inheritance, is the primary
/// mechanism for building up widgets.
///
/// See also:
///
///  * [EdgeInsets], the class that is used to describe the padding dimensions.
///  * [AnimatedPadding], which animates changes in [padding] over a given
///    duration.
///  * [SliverPadding], the sliver equivalent of this widget.
///  * The [catalog of layout widgets](https://flutter.dev/widgets/layout/).
class Padding extends SingleChildRenderObjectWidget {
  /// Creates a widget that insets its child.
  ///
  /// The [padding] argument must not be null.
  const Padding({
    super.key,
    required this.padding,
    super.child,
  });

  /// The amount of space by which to inset the child.
  final EdgeInsetsGeometry padding;

  @override
  RenderPadding createRenderObject(BuildContext context) {
    return RenderPadding(
      padding: padding,
      textDirection: Directionality.maybeOf(context),
    );
  }

  @override
  void updateRenderObject(BuildContext context, RenderPadding renderObject) {
    renderObject
      ..padding = padding
      ..textDirection = Directionality.maybeOf(context);
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<EdgeInsetsGeometry>('padding', padding));
  }
}

/// A widget that aligns its child within itself and optionally sizes itself
/// based on the child's size.
///
/// For example, to align a box at the bottom right, you would pass this box a
/// tight constraint that is bigger than the child's natural size,
/// with an alignment of [Alignment.bottomRight].
///
/// {@youtube 560 315 https://www.youtube.com/watch?v=g2E7yl3MwMk}
///
/// This widget will be as big as possible if its dimensions are constrained and
/// [widthFactor] and [heightFactor] are null. If a dimension is unconstrained
/// and the corresponding size factor is null then the widget will match its
/// child's size in that dimension. If a size factor is non-null then the
/// corresponding dimension of this widget will be the product of the child's
/// dimension and the size factor. For example if widthFactor is 2.0 then
/// the width of this widget will always be twice its child's width.
///
/// {@tool snippet}
/// The [Align] widget in this example uses one of the defined constants from
/// [Alignment], [Alignment.topRight]. This places the [FlutterLogo] in the top
/// right corner of the parent blue [Container].
///
/// ![A blue square container with the Flutter logo in the top right corner.](https://flutter.github.io/assets-for-api-docs/assets/widgets/align_constant.png)
///
/// ```dart
/// Center(
///   child: Container(
///     height: 120.0,
///     width: 120.0,
///     color: Colors.blue[50],
///     child: const Align(
///       alignment: Alignment.topRight,
///       child: FlutterLogo(
///         size: 60,
///       ),
///     ),
///   ),
/// )
/// ```
/// {@end-tool}
///
/// ## How it works
///
/// The [alignment] property describes a point in the `child`'s coordinate system
/// and a different point in the coordinate system of this widget. The [Align]
/// widget positions the `child` such that both points are lined up on top of
/// each other.
///
/// {@tool snippet}
/// The [Alignment] used in the following example defines two points:
///
///   * (0.2 * width of [FlutterLogo]/2 + width of [FlutterLogo]/2, 0.6 * height
///     of [FlutterLogo]/2 + height of [FlutterLogo]/2) = (36.0, 48.0) in the
///     coordinate system of the [FlutterLogo].
///   * (0.2 * width of [Align]/2 + width of [Align]/2, 0.6 * height
///     of [Align]/2 + height of [Align]/2) = (72.0, 96.0) in the
///     coordinate system of the [Align] widget (blue area).
///
/// The [Align] widget positions the [FlutterLogo] such that the two points are on
/// top of each other. In this example, the top left of the [FlutterLogo] will
/// be placed at (72.0, 96.0) - (36.0, 48.0) = (36.0, 48.0) from the top left of
/// the [Align] widget.
///
/// ![A blue square container with the Flutter logo positioned according to the
/// Alignment specified above. A point is marked at the center of the container
/// for the origin of the Alignment coordinate system.](https://flutter.github.io/assets-for-api-docs/assets/widgets/align_alignment.png)
///
/// ```dart
/// Center(
///   child: Container(
///     height: 120.0,
///     width: 120.0,
///     color: Colors.blue[50],
///     child: const Align(
///       alignment: Alignment(0.2, 0.6),
///       child: FlutterLogo(
///         size: 60,
///       ),
///     ),
///   ),
/// )
/// ```
/// {@end-tool}
///
/// {@tool snippet}
/// The [FractionalOffset] used in the following example defines two points:
///
///   * (0.2 * width of [FlutterLogo], 0.6 * height of [FlutterLogo]) = (12.0, 36.0)
///     in the coordinate system of the [FlutterLogo].
///   * (0.2 * width of [Align], 0.6 * height of [Align]) = (24.0, 72.0) in the
///     coordinate system of the [Align] widget (blue area).
///
/// The [Align] widget positions the [FlutterLogo] such that the two points are on
/// top of each other. In this example, the top left of the [FlutterLogo] will
/// be placed at (24.0, 72.0) - (12.0, 36.0) = (12.0, 36.0) from the top left of
/// the [Align] widget.
///
/// The [FractionalOffset] class uses a coordinate system with an origin in the top-left
/// corner of the [Container] in difference to the center-oriented system used in
/// the example above with [Alignment].
///
/// ![A blue square container with the Flutter logo positioned according to the
/// FractionalOffset specified above. A point is marked at the top left corner
/// of the container for the origin of the FractionalOffset coordinate system.](https://flutter.github.io/assets-for-api-docs/assets/widgets/align_fractional_offset.png)
///
/// ```dart
/// Center(
///   child: Container(
///     height: 120.0,
///     width: 120.0,
///     color: Colors.blue[50],
///     child: const Align(
///       alignment: FractionalOffset(0.2, 0.6),
///       child: FlutterLogo(
///         size: 60,
///       ),
///     ),
///   ),
/// )
/// ```
/// {@end-tool}
///
/// See also:
///
///  * [AnimatedAlign], which animates changes in [alignment] smoothly over a
///    given duration.
///  * [CustomSingleChildLayout], which uses a delegate to control the layout of
///    a single child.
///  * [Center], which is the same as [Align] but with the [alignment] always
///    set to [Alignment.center].
///  * [FractionallySizedBox], which sizes its child based on a fraction of its
///    own size and positions the child according to an [Alignment] value.
///  * The [catalog of layout widgets](https://flutter.dev/widgets/layout/).
class Align extends SingleChildRenderObjectWidget {
  /// Creates an alignment widget.
  ///
  /// The alignment defaults to [Alignment.center].
  const Align({
    super.key,
    this.alignment = Alignment.center,
    this.widthFactor,
    this.heightFactor,
    super.child,
  }) : assert(widthFactor == null || widthFactor >= 0.0),
       assert(heightFactor == null || heightFactor >= 0.0);

  /// How to align the child.
  ///
  /// The x and y values of the [Alignment] control the horizontal and vertical
  /// alignment, respectively. An x value of -1.0 means that the left edge of
  /// the child is aligned with the left edge of the parent whereas an x value
  /// of 1.0 means that the right edge of the child is aligned with the right
  /// edge of the parent. Other values interpolate (and extrapolate) linearly.
  /// For example, a value of 0.0 means that the center of the child is aligned
  /// with the center of the parent.
  ///
  /// See also:
  ///
  ///  * [Alignment], which has more details and some convenience constants for
  ///    common positions.
  ///  * [AlignmentDirectional], which has a horizontal coordinate orientation
  ///    that depends on the [TextDirection].
  final AlignmentGeometry alignment;

  /// If non-null, sets its width to the child's width multiplied by this factor.
  ///
  /// Can be both greater and less than 1.0 but must be non-negative.
  final double? widthFactor;

  /// If non-null, sets its height to the child's height multiplied by this factor.
  ///
  /// Can be both greater and less than 1.0 but must be non-negative.
  final double? heightFactor;

  @override
  RenderPositionedBox createRenderObject(BuildContext context) {
    return RenderPositionedBox(
      alignment: alignment,
      widthFactor: widthFactor,
      heightFactor: heightFactor,
      textDirection: Directionality.maybeOf(context),
    );
  }

  @override
  void updateRenderObject(BuildContext context, RenderPositionedBox renderObject) {
    renderObject
      ..alignment = alignment
      ..widthFactor = widthFactor
      ..heightFactor = heightFactor
      ..textDirection = Directionality.maybeOf(context);
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<AlignmentGeometry>('alignment', alignment));
    properties.add(DoubleProperty('widthFactor', widthFactor, defaultValue: null));
    properties.add(DoubleProperty('heightFactor', heightFactor, defaultValue: null));
  }
}

/// A widget that centers its child within itself.
///
/// This widget will be as big as possible if its dimensions are constrained and
/// [widthFactor] and [heightFactor] are null. If a dimension is unconstrained
/// and the corresponding size factor is null then the widget will match its
/// child's size in that dimension. If a size factor is non-null then the
/// corresponding dimension of this widget will be the product of the child's
/// dimension and the size factor. For example if widthFactor is 2.0 then
/// the width of this widget will always be twice its child's width.
///
/// See also:
///
///  * [Align], which lets you arbitrarily position a child within itself,
///    rather than just centering it.
///  * [Row], a widget that displays its children in a horizontal array.
///  * [Column], a widget that displays its children in a vertical array.
///  * [Container], a convenience widget that combines common painting,
///    positioning, and sizing widgets.
///  * The [catalog of layout widgets](https://flutter.dev/widgets/layout/).
class Center extends Align {
  /// Creates a widget that centers its child.
  const Center({ super.key, super.widthFactor, super.heightFactor, super.child });
}

/// A widget that defers the layout of its single child to a delegate.
///
/// The delegate can determine the layout constraints for the child and can
/// decide where to position the child. The delegate can also determine the size
/// of the parent, but the size of the parent cannot depend on the size of the
/// child.
///
/// See also:
///
///  * [SingleChildLayoutDelegate], which controls the layout of the child.
///  * [Align], which sizes itself based on its child's size and positions
///    the child according to an [Alignment] value.
///  * [FractionallySizedBox], which sizes its child based on a fraction of its own
///    size and positions the child according to an [Alignment] value.
///  * [CustomMultiChildLayout], which uses a delegate to position multiple
///    children.
///  * The [catalog of layout widgets](https://flutter.dev/widgets/layout/).
class CustomSingleChildLayout extends SingleChildRenderObjectWidget {
  /// Creates a custom single child layout.
  ///
  /// The [delegate] argument must not be null.
  const CustomSingleChildLayout({
    super.key,
    required this.delegate,
    super.child,
  });

  /// The delegate that controls the layout of the child.
  final SingleChildLayoutDelegate delegate;

  @override
  RenderCustomSingleChildLayoutBox createRenderObject(BuildContext context) {
    return RenderCustomSingleChildLayoutBox(delegate: delegate);
  }

  @override
  void updateRenderObject(BuildContext context, RenderCustomSingleChildLayoutBox renderObject) {
    renderObject.delegate = delegate;
  }
}

/// Metadata for identifying children in a [CustomMultiChildLayout].
///
/// The [MultiChildLayoutDelegate.hasChild],
/// [MultiChildLayoutDelegate.layoutChild], and
/// [MultiChildLayoutDelegate.positionChild] methods use these identifiers.
class LayoutId extends ParentDataWidget<MultiChildLayoutParentData> {
  /// Marks a child with a layout identifier.
  ///
  /// Both the child and the id arguments must not be null.
  LayoutId({
    Key? key,
    required this.id,
    required super.child,
  }) : super(key: key ?? ValueKey<Object>(id));

  /// An object representing the identity of this child.
  ///
  /// The [id] needs to be unique among the children that the
  /// [CustomMultiChildLayout] manages.
  final Object id;

  @override
  void applyParentData(RenderObject renderObject) {
    assert(renderObject.parentData is MultiChildLayoutParentData);
    final MultiChildLayoutParentData parentData = renderObject.parentData! as MultiChildLayoutParentData;
    if (parentData.id != id) {
      parentData.id = id;
      final AbstractNode? targetParent = renderObject.parent;
      if (targetParent is RenderObject) {
        targetParent.markNeedsLayout();
      }
    }
  }

  @override
  Type get debugTypicalAncestorWidgetClass => CustomMultiChildLayout;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<Object>('id', id));
  }
}

/// A widget that uses a delegate to size and position multiple children.
///
/// The delegate can determine the layout constraints for each child and can
/// decide where to position each child. The delegate can also determine the
/// size of the parent, but the size of the parent cannot depend on the sizes of
/// the children.
///
/// [CustomMultiChildLayout] is appropriate when there are complex relationships
/// between the size and positioning of multiple widgets. To control the
/// layout of a single child, [CustomSingleChildLayout] is more appropriate. For
/// simple cases, such as aligning a widget to one or another edge, the [Stack]
/// widget is more appropriate.
///
/// Each child must be wrapped in a [LayoutId] widget to identify the widget for
/// the delegate.
///
/// {@tool dartpad}
/// This example shows a [CustomMultiChildLayout] widget being used to lay out
/// colored blocks from start to finish in a cascade that has some overlap.
///
/// It responds to changes in [Directionality] by re-laying out its children.
///
/// ** See code in examples/api/lib/widgets/basic/custom_multi_child_layout.0.dart **
/// {@end-tool}
///
/// See also:
///
///  * [MultiChildLayoutDelegate], for details about how to control the layout of
///    the children.
///  * [CustomSingleChildLayout], which uses a delegate to control the layout of
///    a single child.
///  * [Stack], which arranges children relative to the edges of the container.
///  * [Flow], which provides paint-time control of its children using transform
///    matrices.
///  * The [catalog of layout widgets](https://flutter.dev/widgets/layout/).
class CustomMultiChildLayout extends MultiChildRenderObjectWidget {
  /// Creates a custom multi-child layout.
  ///
  /// The [delegate] argument must not be null.
  const CustomMultiChildLayout({
    super.key,
    required this.delegate,
    super.children,
  });

  /// The delegate that controls the layout of the children.
  final MultiChildLayoutDelegate delegate;

  @override
  RenderCustomMultiChildLayoutBox createRenderObject(BuildContext context) {
    return RenderCustomMultiChildLayoutBox(delegate: delegate);
  }

  @override
  void updateRenderObject(BuildContext context, RenderCustomMultiChildLayoutBox renderObject) {
    renderObject.delegate = delegate;
  }
}

/// A box with a specified size.
///
/// If given a child, this widget forces it to have a specific width and/or height.
/// These values will be ignored if this widget's parent does not permit them.
/// For example, this happens if the parent is the screen (forces the child to
/// be the same size as the parent), or another [SizedBox] (forces its child to
/// have a specific width and/or height). This can be remedied by wrapping the
/// child [SizedBox] in a widget that does permit it to be any size up to the
/// size of the parent, such as [Center] or [Align].
///
/// If either the width or height is null, this widget will try to size itself to
/// match the child's size in that dimension. If the child's size depends on the
/// size of its parent, the height and width must be provided.
///
/// If not given a child, [SizedBox] will try to size itself as close to the
/// specified height and width as possible given the parent's constraints. If
/// [height] or [width] is null or unspecified, it will be treated as zero.
///
/// The [SizedBox.expand] constructor can be used to make a [SizedBox] that
/// sizes itself to fit the parent. It is equivalent to setting [width] and
/// [height] to [double.infinity].
///
/// {@youtube 560 315 https://www.youtube.com/watch?v=EHPu_DzRfqA}
///
/// {@tool snippet}
///
/// This snippet makes the child widget (a [Card] with some [Text]) have the
/// exact size 200x300, parental constraints permitting:
///
/// ```dart
/// const SizedBox(
///   width: 200.0,
///   height: 300.0,
///   child: Card(child: Text('Hello World!')),
/// )
/// ```
/// {@end-tool}
///
/// See also:
///
///  * [ConstrainedBox], a more generic version of this class that takes
///    arbitrary [BoxConstraints] instead of an explicit width and height.
///  * [UnconstrainedBox], a container that tries to let its child draw without
///    constraints.
///  * [FractionallySizedBox], a widget that sizes its child to a fraction of
///    the total available space.
///  * [AspectRatio], a widget that attempts to fit within the parent's
///    constraints while also sizing its child to match a given aspect ratio.
///  * [FittedBox], which sizes and positions its child widget to fit the parent
///    according to a given [BoxFit] discipline.
///  * The [catalog of layout widgets](https://flutter.dev/widgets/layout/).
///  * [Understanding constraints](https://flutter.dev/docs/development/ui/layout/constraints),
///    an in-depth article about layout in Flutter.
class SizedBox extends SingleChildRenderObjectWidget {
  /// Creates a fixed size box. The [width] and [height] parameters can be null
  /// to indicate that the size of the box should not be constrained in
  /// the corresponding dimension.
  const SizedBox({ super.key, this.width, this.height, super.child });

  /// Creates a box that will become as large as its parent allows.
  const SizedBox.expand({ super.key, super.child })
    : width = double.infinity,
      height = double.infinity;

  /// Creates a box that will become as small as its parent allows.
  const SizedBox.shrink({ super.key, super.child })
    : width = 0.0,
      height = 0.0;

  /// Creates a box with the specified size.
  SizedBox.fromSize({ super.key, super.child, Size? size })
    : width = size?.width,
      height = size?.height;

  /// Creates a box whose [width] and [height] are equal.
  const SizedBox.square({super.key, super.child, double? dimension})
    : width = dimension,
      height = dimension;

  /// If non-null, requires the child to have exactly this width.
  final double? width;

  /// If non-null, requires the child to have exactly this height.
  final double? height;

  @override
  RenderConstrainedBox createRenderObject(BuildContext context) {
    return RenderConstrainedBox(
      additionalConstraints: _additionalConstraints,
    );
  }

  BoxConstraints get _additionalConstraints {
    return BoxConstraints.tightFor(width: width, height: height);
  }

  @override
  void updateRenderObject(BuildContext context, RenderConstrainedBox renderObject) {
    renderObject.additionalConstraints = _additionalConstraints;
  }

  @override
  String toStringShort() {
    final String type;
    if (width == double.infinity && height == double.infinity) {
      type = '\${objectRuntimeType(this, 'SizedBox')}.expand';
    } else if (width == 0.0 && height == 0.0) {
      type = '\${objectRuntimeType(this, 'SizedBox')}.shrink';
    } else {
      type = objectRuntimeType(this, 'SizedBox');
    }
    return key == null ? type : '\$type-\$key';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    final DiagnosticLevel level;
    if ((width == double.infinity && height == double.infinity) ||
        (width == 0.0 && height == 0.0)) {
      level = DiagnosticLevel.hidden;
    } else {
      level = DiagnosticLevel.info;
    }
    properties.add(DoubleProperty('width', width, defaultValue: null, level: level));
    properties.add(DoubleProperty('height', height, defaultValue: null, level: level));
  }
}

/// A widget that imposes additional constraints on its child.
///
/// For example, if you wanted [child] to have a minimum height of 50.0 logical
/// pixels, you could use `const BoxConstraints(minHeight: 50.0)` as the
/// [constraints].
///
/// {@youtube 560 315 https://www.youtube.com/watch?v=o2KveVr7adg}
///
/// {@tool snippet}
///
/// This snippet makes the child widget (a [Card] with some [Text]) fill the
/// parent, by applying [BoxConstraints.expand] constraints:
///
/// ```dart
/// ConstrainedBox(
///   constraints: const BoxConstraints.expand(),
///   child: const Card(child: Text('Hello World!')),
/// )
/// ```
/// {@end-tool}
///
/// The same behavior can be obtained using the [SizedBox.expand] widget.
///
/// See also:
///
///  * [BoxConstraints], the class that describes constraints.
///  * [UnconstrainedBox], a container that tries to let its child draw without
///    constraints.
///  * [SizedBox], which lets you specify tight constraints by explicitly
///    specifying the height or width.
///  * [FractionallySizedBox], which sizes its child based on a fraction of its
///    own size and positions the child according to an [Alignment] value.
///  * [AspectRatio], a widget that attempts to fit within the parent's
///    constraints while also sizing its child to match a given aspect ratio.
///  * The [catalog of layout widgets](https://flutter.dev/widgets/layout/).
class ConstrainedBox extends SingleChildRenderObjectWidget {
  /// Creates a widget that imposes additional constraints on its child.
  ///
  /// The [constraints] argument must not be null.
  ConstrainedBox({
    super.key,
    required this.constraints,
    super.child,
  }) : assert(constraints.debugAssertIsValid());

  /// The additional constraints to impose on the child.
  final BoxConstraints constraints;

  @override
  RenderConstrainedBox createRenderObject(BuildContext context) {
    return RenderConstrainedBox(additionalConstraints: constraints);
  }

  @override
  void updateRenderObject(BuildContext context, RenderConstrainedBox renderObject) {
    renderObject.additionalConstraints = constraints;
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<BoxConstraints>('constraints', constraints, showName: false));
  }
}

/// A container widget that applies an arbitrary transform to its constraints,
/// and sizes its child using the resulting [BoxConstraints], optionally
/// clipping, or treating the overflow as an error.
///
/// This container sizes its child using a [BoxConstraints] created by applying
/// [constraintsTransform] to its own constraints. This container will then
/// attempt to adopt the same size, within the limits of its own constraints. If
/// it ends up with a different size, it will align the child based on
/// [alignment]. If the container cannot expand enough to accommodate the entire
/// child, the child will be clipped if [clipBehavior] is not [Clip.none].
///
/// In debug mode, if [clipBehavior] is [Clip.none] and the child overflows the
/// container, a warning will be printed on the console, and black and yellow
/// striped areas will appear where the overflow occurs.
///
/// When [child] is null, this widget becomes as small as possible and never
/// overflows.
///
/// This widget can be used to ensure some of [child]'s natural dimensions are
/// honored, and get an early warning otherwise during development. For
/// instance, if [child] requires a minimum height to fully display its content,
/// [constraintsTransform] can be set to [maxHeightUnconstrained], so that if
/// the parent [RenderObject] fails to provide enough vertical space, a warning
/// will be displayed in debug mode, while still allowing [child] to grow
/// vertically:
///
/// {@tool snippet}
/// In the following snippet, the [Card] is guaranteed to be at least as tall as
/// its "natural" height. Unlike [UnconstrainedBox], it will become taller if
/// its "natural" height is smaller than 40 px. If the [Container] isn't high
/// enough to show the full content of the [Card], in debug mode a warning will
/// be given.
///
/// ```dart
/// Container(
///   constraints: const BoxConstraints(minHeight: 40, maxHeight: 100),
///   alignment: Alignment.center,
///   child: const ConstraintsTransformBox(
///     constraintsTransform: ConstraintsTransformBox.maxHeightUnconstrained,
///     child: Card(child: Text('Hello World!')),
///   )
/// )
/// ```
/// {@end-tool}
///
/// See also:
///
///  * [ConstrainedBox], which renders a box which imposes constraints
///    on its child.
///  * [OverflowBox], a widget that imposes additional constraints on its child,
///    and allows the child to overflow itself.
///  * [UnconstrainedBox] which allows its children to render themselves
///    unconstrained and expands to fit them.
class ConstraintsTransformBox extends SingleChildRenderObjectWidget {
  /// Creates a widget that uses a function to transform the constraints it
  /// passes to its child. If the child overflows the parent's constraints, a
  /// warning will be given in debug mode.
  ///
  /// The `debugTransformType` argument adds a debug label to this widget.
  ///
  /// The `alignment`, `clipBehavior` and `constraintsTransform` arguments must
  /// not be null.
  const ConstraintsTransformBox({
    super.key,
    super.child,
    this.textDirection,
    this.alignment = Alignment.center,
    required this.constraintsTransform,
    this.clipBehavior = Clip.none,
    String debugTransformType = '',
  }) : _debugTransformLabel = debugTransformType;

  /// A [BoxConstraintsTransform] that always returns its argument as-is (i.e.,
  /// it is an identity function).
  ///
  /// The [ConstraintsTransformBox] becomes a proxy widget that has no effect on
  /// layout if [constraintsTransform] is set to this.
  static BoxConstraints unmodified(BoxConstraints constraints) => constraints;

  /// A [BoxConstraintsTransform] that always returns a [BoxConstraints] that
  /// imposes no constraints on either dimension (i.e. `const BoxConstraints()`).
  ///
  /// Setting [constraintsTransform] to this allows [child] to render at its
  /// "natural" size (equivalent to an [UnconstrainedBox] with `constrainedAxis`
  /// set to null).
  static BoxConstraints unconstrained(BoxConstraints constraints) => const BoxConstraints();

  /// A [BoxConstraintsTransform] that removes the width constraints from the
  /// input.
  ///
  /// Setting [constraintsTransform] to this allows [child] to render at its
  /// "natural" width (equivalent to an [UnconstrainedBox] with
  /// `constrainedAxis` set to [Axis.horizontal]).
  static BoxConstraints widthUnconstrained(BoxConstraints constraints) => constraints.heightConstraints();

  /// A [BoxConstraintsTransform] that removes the height constraints from the
  /// input.
  ///
  /// Setting [constraintsTransform] to this allows [child] to render at its
  /// "natural" height (equivalent to an [UnconstrainedBox] with
  /// `constrainedAxis` set to [Axis.vertical]).
  static BoxConstraints heightUnconstrained(BoxConstraints constraints) => constraints.widthConstraints();

  /// A [BoxConstraintsTransform] that removes the `maxHeight` constraint from
  /// the input.
  ///
  /// Setting [constraintsTransform] to this allows [child] to render at its
  /// "natural" height or the `minHeight` of the incoming [BoxConstraints],
  /// whichever is larger.
  static BoxConstraints maxHeightUnconstrained(BoxConstraints constraints) => constraints.copyWith(maxHeight: double.infinity);

  /// A [BoxConstraintsTransform] that removes the `maxWidth` constraint from
  /// the input.
  ///
  /// Setting [constraintsTransform] to this allows [child] to render at its
  /// "natural" width or the `minWidth` of the incoming [BoxConstraints],
  /// whichever is larger.
  static BoxConstraints maxWidthUnconstrained(BoxConstraints constraints) => constraints.copyWith(maxWidth: double.infinity);

  /// A [BoxConstraintsTransform] that removes both the `maxWidth` and the
  /// `maxHeight` constraints from the input.
  ///
  /// Setting [constraintsTransform] to this allows [child] to render at least
  /// its "natural" size, and grow along an axis if the incoming
  /// [BoxConstraints] has a larger minimum constraint on that axis.
  static BoxConstraints maxUnconstrained(BoxConstraints constraints) => constraints.copyWith(maxWidth: double.infinity, maxHeight: double.infinity);

  static final Map<BoxConstraintsTransform, String> _debugKnownTransforms = <BoxConstraintsTransform, String>{
    unmodified: 'unmodified',
    unconstrained: 'unconstrained',
    widthUnconstrained: 'width constraints removed',
    heightUnconstrained: 'height constraints removed',
    maxWidthUnconstrained: 'maxWidth constraint removed',
    maxHeightUnconstrained: 'maxHeight constraint removed',
    maxUnconstrained: 'maxWidth & maxHeight constraints removed',
  };

  /// The text direction to use when interpreting the [alignment] if it is an
  /// [AlignmentDirectional].
  ///
  /// Defaults to null, in which case [Directionality.maybeOf] is used to determine
  /// the text direction.
  final TextDirection? textDirection;

  /// The alignment to use when laying out the child, if it has a different size
  /// than this widget.
  ///
  /// If this is an [AlignmentDirectional], then [textDirection] must not be
  /// null.
  ///
  /// See also:
  ///
  ///  * [Alignment] for non-[Directionality]-aware alignments.
  ///  * [AlignmentDirectional] for [Directionality]-aware alignments.
  final AlignmentGeometry alignment;

  /// {@template flutter.widgets.constraintsTransform}
  /// The function used to transform the incoming [BoxConstraints], to size
  /// [child].
  ///
  /// The function must return a [BoxConstraints] that is
  /// [BoxConstraints.isNormalized].
  ///
  /// See [ConstraintsTransformBox] for predefined common
  /// [BoxConstraintsTransform]s.
  /// {@endtemplate}
  final BoxConstraintsTransform constraintsTransform;

  /// {@macro flutter.material.Material.clipBehavior}
  ///
  /// {@template flutter.widgets.ConstraintsTransformBox.clipBehavior}
  /// In debug mode, if [clipBehavior] is [Clip.none], and the child overflows
  /// its constraints, a warning will be printed on the console, and black and
  /// yellow striped areas will appear where the overflow occurs. For other
  /// values of [clipBehavior], the contents are clipped accordingly.
  /// {@endtemplate}
  ///
  /// Defaults to [Clip.none].
  final Clip clipBehavior;

  final String _debugTransformLabel;

  @override
  RenderConstraintsTransformBox createRenderObject(BuildContext context) {
    return RenderConstraintsTransformBox(
      textDirection: textDirection ?? Directionality.maybeOf(context),
      alignment: alignment,
      constraintsTransform: constraintsTransform,
      clipBehavior: clipBehavior,
    );
  }

  @override
  void updateRenderObject(BuildContext context, covariant RenderConstraintsTransformBox renderObject) {
    renderObject
      ..textDirection = textDirection ?? Directionality.maybeOf(context)
      ..constraintsTransform = constraintsTransform
      ..alignment = alignment
      ..clipBehavior = clipBehavior;
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<AlignmentGeometry>('alignment', alignment));
    properties.add(EnumProperty<TextDirection>('textDirection', textDirection, defaultValue: null));

    final String? debugTransformLabel = _debugTransformLabel.isNotEmpty
      ? _debugTransformLabel
      : _debugKnownTransforms[constraintsTransform];

    if (debugTransformLabel != null) {
      properties.add(DiagnosticsProperty<String>('constraints transform', debugTransformLabel));
    }
  }
}

/// A widget that imposes no constraints on its child, allowing it to render
/// at its "natural" size.
///
/// This allows a child to render at the size it would render if it were alone
/// on an infinite canvas with no constraints. This container will then attempt
/// to adopt the same size, within the limits of its own constraints. If it ends
/// up with a different size, it will align the child based on [alignment].
/// If the box cannot expand enough to accommodate the entire child, the
/// child will be clipped.
///
/// In debug mode, if the child overflows the container, a warning will be
/// printed on the console, and black and yellow striped areas will appear where
/// the overflow occurs.
///
/// See also:
///
///  * [ConstrainedBox], for a box which imposes constraints on its child.
///  * [Align], which loosens the constraints given to the child rather than
///    removing them entirely.
///  * [Container], a convenience widget that combines common painting,
///    positioning, and sizing widgets.
///  * [OverflowBox], a widget that imposes different constraints on its child
///    than it gets from its parent, possibly allowing the child to overflow
///    the parent.
///  * [ConstraintsTransformBox], a widget that sizes its child using a
///    transformed [BoxConstraints], and shows a warning if the child overflows
///    in debug mode.
class UnconstrainedBox extends StatelessWidget {
  /// Creates a widget that imposes no constraints on its child, allowing it to
  /// render at its "natural" size. If the child overflows the parents
  /// constraints, a warning will be given in debug mode.
  const UnconstrainedBox({
    super.key,
    this.child,
    this.textDirection,
    this.alignment = Alignment.center,
    this.constrainedAxis,
    this.clipBehavior = Clip.none,
  });

  /// The text direction to use when interpreting the [alignment] if it is an
  /// [AlignmentDirectional].
  final TextDirection? textDirection;

  /// The alignment to use when laying out the child.
  ///
  /// If this is an [AlignmentDirectional], then [textDirection] must not be
  /// null.
  ///
  /// See also:
  ///
  ///  * [Alignment] for non-[Directionality]-aware alignments.
  ///  * [AlignmentDirectional] for [Directionality]-aware alignments.
  final AlignmentGeometry alignment;

  /// The axis to retain constraints on, if any.
  ///
  /// If not set, or set to null (the default), neither axis will retain its
  /// constraints. If set to [Axis.vertical], then vertical constraints will
  /// be retained, and if set to [Axis.horizontal], then horizontal constraints
  /// will be retained.
  final Axis? constrainedAxis;

  /// {@macro flutter.material.Material.clipBehavior}
  ///
  /// Defaults to [Clip.none].
  final Clip clipBehavior;

  /// The widget below this widget in the tree.
  ///
  /// {@macro flutter.widgets.ProxyWidget.child}
  final Widget? child;

  BoxConstraintsTransform _axisToTransform(Axis? constrainedAxis) {
    if (constrainedAxis != null) {
      switch (constrainedAxis) {
        case Axis.horizontal:
          return ConstraintsTransformBox.heightUnconstrained;
        case Axis.vertical:
          return ConstraintsTransformBox.widthUnconstrained;
      }
    } else {
      return ConstraintsTransformBox.unconstrained;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ConstraintsTransformBox(
      textDirection: textDirection,
      alignment: alignment,
      clipBehavior: clipBehavior,
      constraintsTransform: _axisToTransform(constrainedAxis),
      child: child,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<AlignmentGeometry>('alignment', alignment));
    properties.add(EnumProperty<Axis>('constrainedAxis', constrainedAxis, defaultValue: null));
    properties.add(EnumProperty<TextDirection>('textDirection', textDirection, defaultValue: null));
  }
}

/// A widget that sizes its child to a fraction of the total available space.
/// For more details about the layout algorithm, see
/// [RenderFractionallySizedOverflowBox].
///
/// {@youtube 560 315 https://www.youtube.com/watch?v=PEsY654EGZ0}
///
/// {@tool dartpad}
/// This sample shows a [FractionallySizedBox] whose one child is 50% of
/// the box's size per the width and height factor parameters, and centered
/// within that box by the alignment parameter.
///
/// ** See code in examples/api/lib/widgets/basic/fractionally_sized_box.0.dart **
/// {@end-tool}
///
/// See also:
///
///  * [Align], which sizes itself based on its child's size and positions
///    the child according to an [Alignment] value.
///  * [OverflowBox], a widget that imposes different constraints on its child
///    than it gets from its parent, possibly allowing the child to overflow the
///    parent.
///  * The [catalog of layout widgets](https://flutter.dev/widgets/layout/).
class FractionallySizedBox extends SingleChildRenderObjectWidget {
  /// Creates a widget that sizes its child to a fraction of the total available space.
  ///
  /// If non-null, the [widthFactor] and [heightFactor] arguments must be
  /// non-negative.
  const FractionallySizedBox({
    super.key,
    this.alignment = Alignment.center,
    this.widthFactor,
    this.heightFactor,
    super.child,
  }) : assert(widthFactor == null || widthFactor >= 0.0),
       assert(heightFactor == null || heightFactor >= 0.0);

  /// {@template flutter.widgets.basic.fractionallySizedBox.widthFactor}
  /// If non-null, the fraction of the incoming width given to the child.
  ///
  /// If non-null, the child is given a tight width constraint that is the max
  /// incoming width constraint multiplied by this factor.
  ///
  /// If null, the incoming width constraints are passed to the child
  /// unmodified.
  /// {@endtemplate}
  final double? widthFactor;

  /// {@template flutter.widgets.basic.fractionallySizedBox.heightFactor}
  /// If non-null, the fraction of the incoming height given to the child.
  ///
  /// If non-null, the child is given a tight height constraint that is the max
  /// incoming height constraint multiplied by this factor.
  ///
  /// If null, the incoming height constraints are passed to the child
  /// unmodified.
  /// {@endtemplate}
  final double? heightFactor;

  /// {@template flutter.widgets.basic.fractionallySizedBox.alignment}
  /// How to align the child.
  ///
  /// The x and y values of the alignment control the horizontal and vertical
  /// alignment, respectively. An x value of -1.0 means that the left edge of
  /// the child is aligned with the left edge of the parent whereas an x value
  /// of 1.0 means that the right edge of the child is aligned with the right
  /// edge of the parent. Other values interpolate (and extrapolate) linearly.
  /// For example, a value of 0.0 means that the center of the child is aligned
  /// with the center of the parent.
  ///
  /// Defaults to [Alignment.center].
  ///
  /// See also:
  ///
  ///  * [Alignment], a class with convenient constants typically used to
  ///    specify an [AlignmentGeometry].
  ///  * [AlignmentDirectional], like [Alignment] for specifying alignments
  ///    relative to text direction.
  /// {@endtemplate}
  final AlignmentGeometry alignment;

  @override
  RenderFractionallySizedOverflowBox createRenderObject(BuildContext context) {
    return RenderFractionallySizedOverflowBox(
      alignment: alignment,
      widthFactor: widthFactor,
      heightFactor: heightFactor,
      textDirection: Directionality.maybeOf(context),
    );
  }

  @override
  void updateRenderObject(BuildContext context, RenderFractionallySizedOverflowBox renderObject) {
    renderObject
      ..alignment = alignment
      ..widthFactor = widthFactor
      ..heightFactor = heightFactor
      ..textDirection = Directionality.maybeOf(context);
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<AlignmentGeometry>('alignment', alignment));
    properties.add(DoubleProperty('widthFactor', widthFactor, defaultValue: null));
    properties.add(DoubleProperty('heightFactor', heightFactor, defaultValue: null));
  }
}

/// A box that limits its size only when it's unconstrained.
///
/// If this widget's maximum width is unconstrained then its child's width is
/// limited to [maxWidth]. Similarly, if this widget's maximum height is
/// unconstrained then its child's height is limited to [maxHeight].
///
/// This has the effect of giving the child a natural dimension in unbounded
/// environments. For example, by providing a [maxHeight] to a widget that
/// normally tries to be as big as possible, the widget will normally size
/// itself to fit its parent, but when placed in a vertical list, it will take
/// on the given height.
///
/// This is useful when composing widgets that normally try to match their
/// parents' size, so that they behave reasonably in lists (which are
/// unbounded).
///
/// {@youtube 560 315 https://www.youtube.com/watch?v=uVki2CIzBTs}
///
/// See also:
///
///  * [ConstrainedBox], which applies its constraints in all cases, not just
///    when the incoming constraints are unbounded.
///  * [SizedBox], which lets you specify tight constraints by explicitly
///    specifying the height or width.
///  * The [catalog of layout widgets](https://flutter.dev/widgets/layout/).
class LimitedBox extends SingleChildRenderObjectWidget {
  /// Creates a box that limits its size only when it's unconstrained.
  ///
  /// The [maxWidth] and [maxHeight] arguments must not be null and must not be
  /// negative.
  const LimitedBox({
    super.key,
    this.maxWidth = double.infinity,
    this.maxHeight = double.infinity,
    super.child,
  }) : assert(maxWidth >= 0.0),
       assert(maxHeight >= 0.0);

  /// The maximum width limit to apply in the absence of a
  /// [BoxConstraints.maxWidth] constraint.
  final double maxWidth;

  /// The maximum height limit to apply in the absence of a
  /// [BoxConstraints.maxHeight] constraint.
  final double maxHeight;

  @override
  RenderLimitedBox createRenderObject(BuildContext context) {
    return RenderLimitedBox(
      maxWidth: maxWidth,
      maxHeight: maxHeight,
    );
  }

  @override
  void updateRenderObject(BuildContext context, RenderLimitedBox renderObject) {
    renderObject
      ..maxWidth = maxWidth
      ..maxHeight = maxHeight;
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DoubleProperty('maxWidth', maxWidth, defaultValue: double.infinity));
    properties.add(DoubleProperty('maxHeight', maxHeight, defaultValue: double.infinity));
  }
}

/// A widget that imposes different constraints on its child than it gets
/// from its parent, possibly allowing the child to overflow the parent.
///
/// See also:
///
///  * [RenderConstrainedOverflowBox] for details about how [OverflowBox] is
///    rendered.
///  * [SizedOverflowBox], a widget that is a specific size but passes its
///    original constraints through to its child, which may then overflow.
///  * [ConstrainedBox], a widget that imposes additional constraints on its
///    child.
///  * [UnconstrainedBox], a container that tries to let its child draw without
///    constraints.
///  * [SizedBox], a box with a specified size.
///  * The [catalog of layout widgets](https://flutter.dev/widgets/layout/).
class OverflowBox extends SingleChildRenderObjectWidget {
  /// Creates a widget that lets its child overflow itself.
  const OverflowBox({
    super.key,
    this.alignment = Alignment.center,
    this.minWidth,
    this.maxWidth,
    this.minHeight,
    this.maxHeight,
    super.child,
  });

  /// How to align the child.
  ///
  /// The x and y values of the alignment control the horizontal and vertical
  /// alignment, respectively. An x value of -1.0 means that the left edge of
  /// the child is aligned with the left edge of the parent whereas an x value
  /// of 1.0 means that the right edge of the child is aligned with the right
  /// edge of the parent. Other values interpolate (and extrapolate) linearly.
  /// For example, a value of 0.0 means that the center of the child is aligned
  /// with the center of the parent.
  ///
  /// Defaults to [Alignment.center].
  ///
  /// See also:
  ///
  ///  * [Alignment], a class with convenient constants typically used to
  ///    specify an [AlignmentGeometry].
  ///  * [AlignmentDirectional], like [Alignment] for specifying alignments
  ///    relative to text direction.
  final AlignmentGeometry alignment;

  /// The minimum width constraint to give the child. Set this to null (the
  /// default) to use the constraint from the parent instead.
  final double? minWidth;

  /// The maximum width constraint to give the child. Set this to null (the
  /// default) to use the constraint from the parent instead.
  final double? maxWidth;

  /// The minimum height constraint to give the child. Set this to null (the
  /// default) to use the constraint from the parent instead.
  final double? minHeight;

  /// The maximum height constraint to give the child. Set this to null (the
  /// default) to use the constraint from the parent instead.
  final double? maxHeight;

  @override
  RenderConstrainedOverflowBox createRenderObject(BuildContext context) {
    return RenderConstrainedOverflowBox(
      alignment: alignment,
      minWidth: minWidth,
      maxWidth: maxWidth,
      minHeight: minHeight,
      maxHeight: maxHeight,
      textDirection: Directionality.maybeOf(context),
    );
  }

  @override
  void updateRenderObject(BuildContext context, RenderConstrainedOverflowBox renderObject) {
    renderObject
      ..alignment = alignment
      ..minWidth = minWidth
      ..maxWidth = maxWidth
      ..minHeight = minHeight
      ..maxHeight = maxHeight
      ..textDirection = Directionality.maybeOf(context);
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<AlignmentGeometry>('alignment', alignment));
    properties.add(DoubleProperty('minWidth', minWidth, defaultValue: null));
    properties.add(DoubleProperty('maxWidth', maxWidth, defaultValue: null));
    properties.add(DoubleProperty('minHeight', minHeight, defaultValue: null));
    properties.add(DoubleProperty('maxHeight', maxHeight, defaultValue: null));
  }
}

/// A widget that is a specific size but passes its original constraints
/// through to its child, which may then overflow.
///
/// See also:
///
///  * [OverflowBox], A widget that imposes different constraints on its child
///    than it gets from its parent, possibly allowing the child to overflow the
///    parent.
///  * [ConstrainedBox], a widget that imposes additional constraints on its
///    child.
///  * [UnconstrainedBox], a container that tries to let its child draw without
///    constraints.
///  * The [catalog of layout widgets](https://flutter.dev/widgets/layout/).
class SizedOverflowBox extends SingleChildRenderObjectWidget {
  /// Creates a widget of a given size that lets its child overflow.
  ///
  /// The [size] argument must not be null.
  const SizedOverflowBox({
    super.key,
    required this.size,
    this.alignment = Alignment.center,
    super.child,
  });

  /// How to align the child.
  ///
  /// The x and y values of the alignment control the horizontal and vertical
  /// alignment, respectively. An x value of -1.0 means that the left edge of
  /// the child is aligned with the left edge of the parent whereas an x value
  /// of 1.0 means that the right edge of the child is aligned with the right
  /// edge of the parent. Other values interpolate (and extrapolate) linearly.
  /// For example, a value of 0.0 means that the center of the child is aligned
  /// with the center of the parent.
  ///
  /// Defaults to [Alignment.center].
  ///
  /// See also:
  ///
  ///  * [Alignment], a class with convenient constants typically used to
  ///    specify an [AlignmentGeometry].
  ///  * [AlignmentDirectional], like [Alignment] for specifying alignments
  ///    relative to text direction.
  final AlignmentGeometry alignment;

  /// The size this widget should attempt to be.
  final Size size;

  @override
  RenderSizedOverflowBox createRenderObject(BuildContext context) {
    return RenderSizedOverflowBox(
      alignment: alignment,
      requestedSize: size,
      textDirection: Directionality.of(context),
    );
  }

  @override
  void updateRenderObject(BuildContext context, RenderSizedOverflowBox renderObject) {
    renderObject
      ..alignment = alignment
      ..requestedSize = size
      ..textDirection = Directionality.of(context);
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<AlignmentGeometry>('alignment', alignment));
    properties.add(DiagnosticsProperty<Size>('size', size, defaultValue: null));
  }
}

/// A widget that lays the child out as if it was in the tree, but without
/// painting anything, without making the child available for hit testing, and
/// without taking any room in the parent.
///
/// Offstage children are still active: they can receive focus and have keyboard
/// input directed to them.
///
/// Animations continue to run in offstage children, and therefore use battery
/// and CPU time, regardless of whether the animations end up being visible.
///
/// [Offstage] can be used to measure the dimensions of a widget without
/// bringing it on screen (yet). To hide a widget from view while it is not
/// needed, prefer removing the widget from the tree entirely rather than
/// keeping it alive in an [Offstage] subtree.
///
/// {@tool dartpad}
/// This example shows a [FlutterLogo] widget when the `_offstage` member field
/// is false, and hides it without any room in the parent when it is true. When
/// offstage, this app displays a button to get the logo size, which will be
/// displayed in a [SnackBar].
///
/// ** See code in examples/api/lib/widgets/basic/offstage.0.dart **
/// {@end-tool}
///
/// See also:
///
///  * [Visibility], which can hide a child more efficiently (albeit less
///    subtly).
///  * [TickerMode], which can be used to disable animations in a subtree.
///  * [SliverOffstage], the sliver version of this widget.
///  * The [catalog of layout widgets](https://flutter.dev/widgets/layout/).
class Offstage extends SingleChildRenderObjectWidget {
  /// Creates a widget that visually hides its child.
  const Offstage({ super.key, this.offstage = true, super.child });

  /// Whether the child is hidden from the rest of the tree.
  ///
  /// If true, the child is laid out as if it was in the tree, but without
  /// painting anything, without making the child available for hit testing, and
  /// without taking any room in the parent.
  ///
  /// Offstage children are still active: they can receive focus and have keyboard
  /// input directed to them.
  ///
  /// Animations continue to run in offstage children, and therefore use battery
  /// and CPU time, regardless of whether the animations end up being visible.
  ///
  /// If false, the child is included in the tree as normal.
  final bool offstage;

  @override
  RenderOffstage createRenderObject(BuildContext context) => RenderOffstage(offstage: offstage);

  @override
  void updateRenderObject(BuildContext context, RenderOffstage renderObject) {
    renderObject.offstage = offstage;
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<bool>('offstage', offstage));
  }

  @override
  SingleChildRenderObjectElement createElement() => _OffstageElement(this);
}

class _OffstageElement extends SingleChildRenderObjectElement {
  _OffstageElement(Offstage super.widget);

  @override
  void debugVisitOnstageChildren(ElementVisitor visitor) {
    if (!(widget as Offstage).offstage) {
      super.debugVisitOnstageChildren(visitor);
    }
  }
}

/// A widget that attempts to size the child to a specific aspect ratio.
///
/// The aspect ratio is expressed as a ratio of width to height. For example, a
/// 16:9 width:height aspect ratio would have a value of 16.0/9.0.
///
/// {@youtube 560 315 https://www.youtube.com/watch?v=XcnP3_mO_Ms}
///
/// The [AspectRatio] widget uses a finite iterative process to compute the
/// appropriate constraints for the child, and then lays the child out a single
/// time with those constraints. This iterative process is efficient and does
/// not require multiple layout passes.
///
/// The widget first tries the largest width permitted by the layout
/// constraints, and determines the height of the widget by applying the given
/// aspect ratio to the width, expressed as a ratio of width to height.
///
/// If the maximum width is infinite, the initial width is determined
/// by applying the aspect ratio to the maximum height instead.
///
/// The widget then examines if the computed dimensions are compatible with the
/// parent's constraints; if not, the dimensions are recomputed a second time,
/// taking those constraints into account.
///
/// If the widget does not find a feasible size after consulting each
/// constraint, the widget will eventually select a size for the child that
/// meets the layout constraints but fails to meet the aspect ratio constraints.
///
/// {@tool dartpad}
/// This examples shows how [AspectRatio] sets the width when its parent's width
/// constraint is infinite. Since the parent's allowed height is a fixed value,
/// the actual width is determined via the given [aspectRatio].
///
/// In this example, the height is fixed at 100.0 and the aspect ratio is set to
/// 16 / 9, making the width 100.0 / 9 * 16.
///
/// ** See code in examples/api/lib/widgets/basic/aspect_ratio.0.dart **
/// {@end-tool}
///
/// {@tool dartpad}
/// This second example uses an aspect ratio of 2.0, and layout constraints that
/// require the width to be between 0.0 and 100.0, and the height to be between
/// 0.0 and 100.0. The widget selects a width of 100.0 (the biggest allowed) and
/// a height of 50.0 (to match the aspect ratio).
///
/// ** See code in examples/api/lib/widgets/basic/aspect_ratio.1.dart **
/// {@end-tool}
///
/// {@tool dartpad}
/// This third example is similar to the second, but with the aspect ratio set
/// to 0.5. The widget still selects a width of 100.0 (the biggest allowed), and
/// attempts to use a height of 200.0. Unfortunately, that violates the
/// constraints because the child can be at most 100.0 pixels tall. The widget
/// will then take that value and apply the aspect ratio again to obtain a width
/// of 50.0. That width is permitted by the constraints and the child receives a
/// width of 50.0 and a height of 100.0. If the width were not permitted, the
/// widget would continue iterating through the constraints.
///
/// ** See code in examples/api/lib/widgets/basic/aspect_ratio.2.dart **
/// {@end-tool}
///
/// ## Setting the aspect ratio in unconstrained situations
///
/// When using a widget such as [FittedBox], the constraints are unbounded. This
/// results in [AspectRatio] being unable to find a suitable set of constraints
/// to apply. In that situation, consider explicitly setting a size using
/// [SizedBox] instead of setting the aspect ratio using [AspectRatio]. The size
/// is then scaled appropriately by the [FittedBox].
///
/// See also:
///
///  * [Align], a widget that aligns its child within itself and optionally
///    sizes itself based on the child's size.
///  * [ConstrainedBox], a widget that imposes additional constraints on its
///    child.
///  * [UnconstrainedBox], a container that tries to let its child draw without
///    constraints.
///  * The [catalog of layout widgets](https://flutter.dev/widgets/layout/).
class AspectRatio extends SingleChildRenderObjectWidget {
  /// Creates a widget with a specific aspect ratio.
  ///
  /// The [aspectRatio] argument must be a finite number greater than zero.
  const AspectRatio({
    super.key,
    required this.aspectRatio,
    super.child,
  }) : assert(aspectRatio > 0.0);

  /// The aspect ratio to attempt to use.
  ///
  /// The aspect ratio is expressed as a ratio of width to height. For example,
  /// a 16:9 width:height aspect ratio would have a value of 16.0/9.0.
  final double aspectRatio;

  @override
  RenderAspectRatio createRenderObject(BuildContext context) => RenderAspectRatio(aspectRatio: aspectRatio);

  @override
  void updateRenderObject(BuildContext context, RenderAspectRatio renderObject) {
    renderObject.aspectRatio = aspectRatio;
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DoubleProperty('aspectRatio', aspectRatio));
  }
}

/// A widget that sizes its child to the child's maximum intrinsic width.
///
/// This class is useful, for example, when unlimited width is available and
/// you would like a child that would otherwise attempt to expand infinitely to
/// instead size itself to a more reasonable width.
///
/// The constraints that this widget passes to its child will adhere to the
/// parent's constraints, so if the constraints are not large enough to satisfy
/// the child's maximum intrinsic width, then the child will get less width
/// than it otherwise would. Likewise, if the minimum width constraint is
/// larger than the child's maximum intrinsic width, the child will be given
/// more width than it otherwise would.
///
/// If [stepWidth] is non-null, the child's width will be snapped to a multiple
/// of the [stepWidth]. Similarly, if [stepHeight] is non-null, the child's
/// height will be snapped to a multiple of the [stepHeight].
///
/// This class is relatively expensive, because it adds a speculative layout
/// pass before the final layout phase. Avoid using it where possible. In the
/// worst case, this widget can result in a layout that is O(N²) in the depth of
/// the tree.
///
/// See also:
///
///  * [Align], a widget that aligns its child within itself. This can be used
///    to loosen the constraints passed to the [RenderIntrinsicWidth],
///    allowing the [RenderIntrinsicWidth]'s child to be smaller than that of
///    its parent.
///  * [Row], which when used with [CrossAxisAlignment.stretch] can be used
///    to loosen just the width constraints that are passed to the
///    [RenderIntrinsicWidth], allowing the [RenderIntrinsicWidth]'s child's
///    width to be smaller than that of its parent.
///  * [The catalog of layout widgets](https://flutter.dev/widgets/layout/).
class IntrinsicWidth extends SingleChildRenderObjectWidget {
  /// Creates a widget that sizes its child to the child's intrinsic width.
  ///
  /// This class is relatively expensive. Avoid using it where possible.
  const IntrinsicWidth({ super.key, this.stepWidth, this.stepHeight, super.child })
    : assert(stepWidth == null || stepWidth >= 0.0),
      assert(stepHeight == null || stepHeight >= 0.0);

  /// If non-null, force the child's width to be a multiple of this value.
  ///
  /// If null or 0.0 the child's width will be the same as its maximum
  /// intrinsic width.
  ///
  /// This value must not be negative.
  ///
  /// See also:
  ///
  ///  * [RenderBox.getMaxIntrinsicWidth], which defines a widget's max
  ///    intrinsic width in general.
  final double? stepWidth;

  /// If non-null, force the child's height to be a multiple of this value.
  ///
  /// If null or 0.0 the child's height will not be constrained.
  ///
  /// This value must not be negative.
  final double? stepHeight;

  double? get _stepWidth => stepWidth == 0.0 ? null : stepWidth;
  double? get _stepHeight => stepHeight == 0.0 ? null : stepHeight;

  @override
  RenderIntrinsicWidth createRenderObject(BuildContext context) {
    return RenderIntrinsicWidth(stepWidth: _stepWidth, stepHeight: _stepHeight);
  }

  @override
  void updateRenderObject(BuildContext context, RenderIntrinsicWidth renderObject) {
    renderObject
      ..stepWidth = _stepWidth
      ..stepHeight = _stepHeight;
  }
}

/// A widget that sizes its child to the child's intrinsic height.
///
/// This class is useful, for example, when unlimited height is available and
/// you would like a child that would otherwise attempt to expand infinitely to
/// instead size itself to a more reasonable height.
///
/// The constraints that this widget passes to its child will adhere to the
/// parent's constraints, so if the constraints are not large enough to satisfy
/// the child's maximum intrinsic height, then the child will get less height
/// than it otherwise would. Likewise, if the minimum height constraint is
/// larger than the child's maximum intrinsic height, the child will be given
/// more height than it otherwise would.
///
/// This class is relatively expensive, because it adds a speculative layout
/// pass before the final layout phase. Avoid using it where possible. In the
/// worst case, this widget can result in a layout that is O(N²) in the depth of
/// the tree.
///
/// See also:
///
///  * [Align], a widget that aligns its child within itself. This can be used
///    to loosen the constraints passed to the [RenderIntrinsicHeight],
///    allowing the [RenderIntrinsicHeight]'s child to be smaller than that of
///    its parent.
///  * [Column], which when used with [CrossAxisAlignment.stretch] can be used
///    to loosen just the height constraints that are passed to the
///    [RenderIntrinsicHeight], allowing the [RenderIntrinsicHeight]'s child's
///    height to be smaller than that of its parent.
///  * [The catalog of layout widgets](https://flutter.dev/widgets/layout/).
class IntrinsicHeight extends SingleChildRenderObjectWidget {
  /// Creates a widget that sizes its child to the child's intrinsic height.
  ///
  /// This class is relatively expensive. Avoid using it where possible.
  const IntrinsicHeight({ super.key, super.child });

  @override
  RenderIntrinsicHeight createRenderObject(BuildContext context) => RenderIntrinsicHeight();
}

/// A widget that positions its child according to the child's baseline.
///
/// This widget shifts the child down such that the child's baseline (or the
/// bottom of the child, if the child has no baseline) is [baseline]
/// logical pixels below the top of this box, then sizes this box to
/// contain the child. If [baseline] is less than the distance from
/// the top of the child to the baseline of the child, then the child
/// is top-aligned instead.
///
/// {@youtube 560 315 https://www.youtube.com/watch?v=8ZaFk0yvNlI}
///
/// See also:
///
///  * [Align], a widget that aligns its child within itself and optionally
///    sizes itself based on the child's size.
///  * [Center], a widget that centers its child within itself.
///  * The [catalog of layout widgets](https://flutter.dev/widgets/layout/).
class Baseline extends SingleChildRenderObjectWidget {
  /// Creates a widget that positions its child according to the child's baseline.
  ///
  /// The [baseline] and [baselineType] arguments must not be null.
  const Baseline({
    super.key,
    required this.baseline,
    required this.baselineType,
    super.child,
  });

  /// The number of logical pixels from the top of this box at which to position
  /// the child's baseline.
  final double baseline;

  /// The type of baseline to use for positioning the child.
  final TextBaseline baselineType;

  @override
  RenderBaseline createRenderObject(BuildContext context) {
    return RenderBaseline(baseline: baseline, baselineType: baselineType);
  }

  @override
  void updateRenderObject(BuildContext context, RenderBaseline renderObject) {
    renderObject
      ..baseline = baseline
      ..baselineType = baselineType;
  }
}


// SLIVERS

/// A sliver that contains a single box widget.
///
/// Slivers are special-purpose widgets that can be combined using a
/// [CustomScrollView] to create custom scroll effects. A [SliverToBoxAdapter]
/// is a basic sliver that creates a bridge back to one of the usual box-based
/// widgets.
///
/// _To learn more about slivers, see [CustomScrollView.slivers]._
///
/// Rather than using multiple [SliverToBoxAdapter] widgets to display multiple
/// box widgets in a [CustomScrollView], consider using [SliverList],
/// [SliverFixedExtentList], [SliverPrototypeExtentList], or [SliverGrid],
/// which are more efficient because they instantiate only those children that
/// are actually visible through the scroll view's viewport.
///
/// See also:
///
///  * [CustomScrollView], which displays a scrollable list of slivers.
///  * [SliverList], which displays multiple box widgets in a linear array.
///  * [SliverFixedExtentList], which displays multiple box widgets with the
///    same main-axis extent in a linear array.
///  * [SliverPrototypeExtentList], which displays multiple box widgets with the
///    same main-axis extent as a prototype item, in a linear array.
///  * [SliverGrid], which displays multiple box widgets in arbitrary positions.
class SliverToBoxAdapter extends SingleChildRenderObjectWidget {
  /// Creates a sliver that contains a single box widget.
  const SliverToBoxAdapter({
    super.key,
    super.child,
  });

  @override
  RenderSliverToBoxAdapter createRenderObject(BuildContext context) => RenderSliverToBoxAdapter();
}

/// A sliver that applies padding on each side of another sliver.
///
/// Slivers are special-purpose widgets that can be combined using a
/// [CustomScrollView] to create custom scroll effects. A [SliverPadding]
/// is a basic sliver that insets another sliver by applying padding on each
/// side.
///
/// {@macro flutter.rendering.RenderSliverEdgeInsetsPadding}
///
/// See also:
///
///  * [CustomScrollView], which displays a scrollable list of slivers.
///  * [Padding], the box version of this widget.
class SliverPadding extends SingleChildRenderObjectWidget {
  /// Creates a sliver that applies padding on each side of another sliver.
  ///
  /// The [padding] argument must not be null.
  const SliverPadding({
    super.key,
    required this.padding,
    Widget? sliver,
  }) : super(child: sliver);

  /// The amount of space by which to inset the child sliver.
  final EdgeInsetsGeometry padding;

  @override
  RenderSliverPadding createRenderObject(BuildContext context) {
    return RenderSliverPadding(
      padding: padding,
      textDirection: Directionality.of(context),
    );
  }

  @override
  void updateRenderObject(BuildContext context, RenderSliverPadding renderObject) {
    renderObject
      ..padding = padding
      ..textDirection = Directionality.of(context);
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<EdgeInsetsGeometry>('padding', padding));
  }
}


// LAYOUT NODES

/// Returns the [AxisDirection] in the given [Axis] in the current
/// [Directionality] (or the reverse if `reverse` is true).
///
/// If `axis` is [Axis.vertical], this function returns [AxisDirection.down]
/// unless `reverse` is true, in which case this function returns
/// [AxisDirection.up].
///
/// If `axis` is [Axis.horizontal], this function checks the current
/// [Directionality]. If the current [Directionality] is right-to-left, then
/// this function returns [AxisDirection.left] (unless `reverse` is true, in
/// which case it returns [AxisDirection.right]). Similarly, if the current
/// [Directionality] is left-to-right, then this function returns
/// [AxisDirection.right] (unless `reverse` is true, in which case it returns
/// [AxisDirection.left]).
///
/// This function is used by a number of scrolling widgets (e.g., [ListView],
/// [GridView], [PageView], and [SingleChildScrollView]) as well as [ListBody]
/// to translate their [Axis] and `reverse` properties into a concrete
/// [AxisDirection].
AxisDirection getAxisDirectionFromAxisReverseAndDirectionality(
  BuildContext context,
  Axis axis,
  bool reverse,
) {
  switch (axis) {
    case Axis.horizontal:
      assert(debugCheckHasDirectionality(context));
      final TextDirection textDirection = Directionality.of(context);
      final AxisDirection axisDirection = textDirectionToAxisDirection(textDirection);
      return reverse ? flipAxisDirection(axisDirection) : axisDirection;
    case Axis.vertical:
      return reverse ? AxisDirection.up : AxisDirection.down;
  }
}

/// A widget that arranges its children sequentially along a given axis, forcing
/// them to the dimension of the parent in the other axis.
///
/// This widget is rarely used directly. Instead, consider using [ListView],
/// which combines a similar layout algorithm with scrolling behavior, or
/// [Column], which gives you more flexible control over the layout of a
/// vertical set of boxes.
///
/// See also:
///
///  * [RenderListBody], which implements this layout algorithm and the
///    documentation for which describes some of its subtleties.
///  * [SingleChildScrollView], which is sometimes used with [ListBody] to
///    make the contents scrollable.
///  * [Column] and [Row], which implement a more elaborate version of
///    this layout algorithm (at the cost of being slightly less efficient).
///  * [ListView], which implements an efficient scrolling version of this
///    layout algorithm.
///  * The [catalog of layout widgets](https://flutter.dev/widgets/layout/).
class ListBody extends MultiChildRenderObjectWidget {
  /// Creates a layout widget that arranges its children sequentially along a
  /// given axis.
  ///
  /// By default, the [mainAxis] is [Axis.vertical].
  const ListBody({
    super.key,
    this.mainAxis = Axis.vertical,
    this.reverse = false,
    super.children,
  });

  /// The direction to use as the main axis.
  final Axis mainAxis;

  /// Whether the list body positions children in the reading direction.
  ///
  /// For example, if the reading direction is left-to-right and
  /// [mainAxis] is [Axis.horizontal], then the list body positions children
  /// from left to right when [reverse] is false and from right to left when
  /// [reverse] is true.
  ///
  /// Similarly, if [mainAxis] is [Axis.vertical], then the list body positions
  /// from top to bottom when [reverse] is false and from bottom to top when
  /// [reverse] is true.
  ///
  /// Defaults to false.
  final bool reverse;

  AxisDirection _getDirection(BuildContext context) {
    return getAxisDirectionFromAxisReverseAndDirectionality(context, mainAxis, reverse);
  }

  @override
  RenderListBody createRenderObject(BuildContext context) {
    return RenderListBody(axisDirection: _getDirection(context));
  }

  @override
  void updateRenderObject(BuildContext context, RenderListBody renderObject) {
    renderObject.axisDirection = _getDirection(context);
  }
}

/// A widget that positions its children relative to the edges of its box.
///
/// This class is useful if you want to overlap several children in a simple
/// way, for example having some text and an image, overlaid with a gradient and
/// a button attached to the bottom.
///
/// {@youtube 560 315 https://www.youtube.com/watch?v=liEGSeD3Zt8}
///
/// Each child of a [Stack] widget is either _positioned_ or _non-positioned_.
/// Positioned children are those wrapped in a [Positioned] widget that has at
/// least one non-null property. The stack sizes itself to contain all the
/// non-positioned children, which are positioned according to [alignment]
/// (which defaults to the top-left corner in left-to-right environments and the
/// top-right corner in right-to-left environments). The positioned children are
/// then placed relative to the stack according to their top, right, bottom, and
/// left properties.
///
/// The stack paints its children in order with the first child being at the
/// bottom. If you want to change the order in which the children paint, you
/// can rebuild the stack with the children in the new order. If you reorder
/// the children in this way, consider giving the children non-null keys.
/// These keys will cause the framework to move the underlying objects for
/// the children to their new locations rather than recreate them at their
/// new location.
///
/// For more details about the stack layout algorithm, see [RenderStack].
///
/// If you want to lay a number of children out in a particular pattern, or if
/// you want to make a custom layout manager, you probably want to use
/// [CustomMultiChildLayout] instead. In particular, when using a [Stack] you
/// can't position children relative to their size or the stack's own size.
///
/// {@tool snippet}
///
/// Using a [Stack] you can position widgets over one another.
///
/// ![The sample creates a blue box that overlaps a larger green box, which itself overlaps an even larger red box.](https://flutter.github.io/assets-for-api-docs/assets/widgets/stack.png)
///
/// ```dart
/// Stack(
///   children: <Widget>[
///     Container(
///       width: 100,
///       height: 100,
///       color: Colors.red,
///     ),
///     Container(
///       width: 90,
///       height: 90,
///       color: Colors.green,
///     ),
///     Container(
///       width: 80,
///       height: 80,
///       color: Colors.blue,
///     ),
///   ],
/// )
/// ```
/// {@end-tool}
///
/// {@tool snippet}
///
/// This example shows how [Stack] can be used to enhance text visibility
/// by adding gradient backdrops.
///
/// ![The gradient fades from transparent to dark grey at the bottom, with white text on top of the darker portion.](https://flutter.github.io/assets-for-api-docs/assets/widgets/stack_with_gradient.png)
///
/// ```dart
/// SizedBox(
///   width: 250,
///   height: 250,
///   child: Stack(
///     children: <Widget>[
///       Container(
///         width: 250,
///         height: 250,
///         color: Colors.white,
///       ),
///       Container(
///         padding: const EdgeInsets.all(5.0),
///         alignment: Alignment.bottomCenter,
///         decoration: BoxDecoration(
///           gradient: LinearGradient(
///             begin: Alignment.topCenter,
///             end: Alignment.bottomCenter,
///             colors: <Color>[
///               Colors.black.withAlpha(0),
///               Colors.black12,
///               Colors.black45
///             ],
///           ),
///         ),
///         child: const Text(
///           'Foreground Text',
///           style: TextStyle(color: Colors.white, fontSize: 20.0),
///         ),
///       ),
///     ],
///   ),
/// )
/// ```
/// {@end-tool}
///
/// See also:
///
///  * [Align], which sizes itself based on its child's size and positions
///    the child according to an [Alignment] value.
///  * [CustomSingleChildLayout], which uses a delegate to control the layout of
///    a single child.
///  * [CustomMultiChildLayout], which uses a delegate to position multiple
///    children.
///  * [Flow], which provides paint-time control of its children using transform
///    matrices.
///  * The [catalog of layout widgets](https://flutter.dev/widgets/layout/).
class Stack extends MultiChildRenderObjectWidget {
  /// Creates a stack layout widget.
  ///
  /// By default, the non-positioned children of the stack are aligned by their
  /// top left corners.
  const Stack({
    super.key,
    this.alignment = AlignmentDirectional.topStart,
    this.textDirection,
    this.fit = StackFit.loose,
    this.clipBehavior = Clip.hardEdge,
    super.children,
  });

  /// How to align the non-positioned and partially-positioned children in the
  /// stack.
  ///
  /// The non-positioned children are placed relative to each other such that
  /// the points determined by [alignment] are co-located. For example, if the
  /// [alignment] is [Alignment.topLeft], then the top left corner of
  /// each non-positioned child will be located at the same global coordinate.
  ///
  /// Partially-positioned children, those that do not specify an alignment in a
  /// particular axis (e.g. that have neither `top` nor `bottom` set), use the
  /// alignment to determine how they should be positioned in that
  /// under-specified axis.
  ///
  /// Defaults to [AlignmentDirectional.topStart].
  ///
  /// See also:
  ///
  ///  * [Alignment], a class with convenient constants typically used to
  ///    specify an [AlignmentGeometry].
  ///  * [AlignmentDirectional], like [Alignment] for specifying alignments
  ///    relative to text direction.
  final AlignmentGeometry alignment;

  /// The text direction with which to resolve [alignment].
  ///
  /// Defaults to the ambient [Directionality].
  final TextDirection? textDirection;

  /// How to size the non-positioned children in the stack.
  ///
  /// The constraints passed into the [Stack] from its parent are either
  /// loosened ([StackFit.loose]) or tightened to their biggest size
  /// ([StackFit.expand]).
  final StackFit fit;

  /// {@macro flutter.material.Material.clipBehavior}
  ///
  /// Defaults to [Clip.hardEdge].
  final Clip clipBehavior;

  bool _debugCheckHasDirectionality(BuildContext context) {
    if (alignment is AlignmentDirectional && textDirection == null) {
      assert(debugCheckHasDirectionality(
        context,
        why: "to resolve the 'alignment' argument",
        hint: alignment == AlignmentDirectional.topStart ? "The default value for 'alignment' is AlignmentDirectional.topStart, which requires a text direction." : null,
        alternative: "Instead of providing a Directionality widget, another solution would be passing a non-directional 'alignment', or an explicit 'textDirection', to the \$runtimeType.",
      ));
    }
    return true;
  }

  @override
  RenderStack createRenderObject(BuildContext context) {
    assert(_debugCheckHasDirectionality(context));
    return RenderStack(
      alignment: alignment,
      textDirection: textDirection ?? Directionality.maybeOf(context),
      fit: fit,
      clipBehavior: clipBehavior,
    );
  }

  @override
  void updateRenderObject(BuildContext context, RenderStack renderObject) {
    assert(_debugCheckHasDirectionality(context));
    renderObject
      ..alignment = alignment
      ..textDirection = textDirection ?? Directionality.maybeOf(context)
      ..fit = fit
      ..clipBehavior = clipBehavior;
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<AlignmentGeometry>('alignment', alignment));
    properties.add(EnumProperty<TextDirection>('textDirection', textDirection, defaultValue: null));
    properties.add(EnumProperty<StackFit>('fit', fit));
    properties.add(EnumProperty<Clip>('clipBehavior', clipBehavior, defaultValue: Clip.hardEdge));
  }
}

/// A [Stack] that shows a single child from a list of children.
///
/// The displayed child is the one with the given [index]. The stack is
/// always as big as the largest child.
///
/// If value is null, then nothing is displayed.
///
/// {@youtube 560 315 https://www.youtube.com/watch?v=_O0PPD1Xfbk}
///
/// {@tool dartpad}
/// This example shows a [IndexedStack] widget being used to lay out one card
/// at a time from a series of cards, each keeping their respective states.
///
/// ** See code in examples/api/lib/widgets/basic/indexed_stack.0.dart **
/// {@end-tool}
///
/// See also:
///
///  * [Stack], for more details about stacks.
///  * The [catalog of layout widgets](https://flutter.dev/widgets/layout/).
class IndexedStack extends StatelessWidget {
  /// Creates a [Stack] widget that paints a single child.
  ///
  /// The [index] argument must not be null.
  const IndexedStack({
    super.key,
    this.alignment = AlignmentDirectional.topStart,
    this.textDirection,
    this.clipBehavior = Clip.hardEdge,
    this.sizing = StackFit.loose,
    this.index = 0,
    this.children = const <Widget>[],
  });

  /// How to align the non-positioned and partially-positioned children in the
  /// stack.
  ///
  /// Defaults to [AlignmentDirectional.topStart].
  ///
  /// See [Stack.alignment] for more information.
  final AlignmentGeometry alignment;

  /// The text direction with which to resolve [alignment].
  ///
  /// Defaults to the ambient [Directionality].
  final TextDirection? textDirection;

  /// {@macro flutter.material.Material.clipBehavior}
  ///
  /// Defaults to [Clip.hardEdge].
  final Clip clipBehavior;

  /// How to size the non-positioned children in the stack.
  ///
  /// Defaults to [StackFit.loose].
  ///
  /// See [Stack.fit] for more information.
  final StackFit sizing;

  /// The index of the child to show.
  ///
  /// If this is null, none of the children will be shown.
  final int? index;

  /// The child widgets of the stack.
  ///
  /// Only the child at index [index] will be shown.
  ///
  /// See [Stack.children] for more information.
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    final List<Widget> wrappedChildren = List<Widget>.generate(children.length, (int i) {
      return Visibility.maintain(
        visible: i == index,
        child: children[i],
      );
    });
    return _RawIndexedStack(
      alignment: alignment,
      textDirection: textDirection,
      clipBehavior: clipBehavior,
      sizing: sizing,
      index: index,
      children: wrappedChildren,
    );
  }
}

/// The render object widget that backs [IndexedStack].
class _RawIndexedStack extends Stack {
  /// Creates a [Stack] widget that paints a single child.
  const _RawIndexedStack({
    super.alignment,
    super.textDirection,
    super.clipBehavior,
    StackFit sizing = StackFit.loose,
    this.index = 0,
    super.children,
  }) : super(fit: sizing);

  /// The index of the child to show.
  final int? index;

  @override
  RenderIndexedStack createRenderObject(BuildContext context) {
    assert(_debugCheckHasDirectionality(context));
    return RenderIndexedStack(
      index: index,
      fit: fit,
      clipBehavior: clipBehavior,
      alignment: alignment,
      textDirection: textDirection ?? Directionality.maybeOf(context),
    );
  }

  @override
  void updateRenderObject(BuildContext context, RenderIndexedStack renderObject) {
    assert(_debugCheckHasDirectionality(context));
    renderObject
      ..index = index
      ..fit = fit
      ..clipBehavior = clipBehavior
      ..alignment = alignment
      ..textDirection = textDirection ?? Directionality.maybeOf(context);
  }

  @override
  MultiChildRenderObjectElement createElement() {
    return _IndexedStackElement(this);
  }
}

class _IndexedStackElement extends MultiChildRenderObjectElement {
  _IndexedStackElement(_RawIndexedStack super.widget);

  @override
  _RawIndexedStack get widget => super.widget as _RawIndexedStack;

  @override
  void debugVisitOnstageChildren(ElementVisitor visitor) {
    final int? index = widget.index;
    // If the index is null, no child is onstage. Otherwise, only the child at
    // the selected index is.
    if (index != null && children.isNotEmpty) {
      visitor(children.elementAt(index));
    }
  }
}

/// A widget that controls where a child of a [Stack] is positioned.
///
/// A [Positioned] widget must be a descendant of a [Stack], and the path from
/// the [Positioned] widget to its enclosing [Stack] must contain only
/// [StatelessWidget]s or [StatefulWidget]s (not other kinds of widgets, like
/// [RenderObjectWidget]s).
///
/// {@youtube 560 315 https://www.youtube.com/watch?v=EgtPleVwxBQ}
///
/// If a widget is wrapped in a [Positioned], then it is a _positioned_ widget
/// in its [Stack]. If the [top] property is non-null, the top edge of this child
/// will be positioned [top] layout units from the top of the stack widget. The
/// [right], [bottom], and [left] properties work analogously.
///
/// If both the [top] and [bottom] properties are non-null, then the child will
/// be forced to have exactly the height required to satisfy both constraints.
/// Similarly, setting the [right] and [left] properties to non-null values will
/// force the child to have a particular width. Alternatively the [width] and
/// [height] properties can be used to give the dimensions, with one
/// corresponding position property (e.g. [top] and [height]).
///
/// If all three values on a particular axis are null, then the
/// [Stack.alignment] property is used to position the child.
///
/// If all six values are null, the child is a non-positioned child. The [Stack]
/// uses only the non-positioned children to size itself.
///
/// See also:
///
///  * [AnimatedPositioned], which automatically transitions the child's
///    position over a given duration whenever the given position changes.
///  * [PositionedTransition], which takes a provided [Animation] to transition
///    changes in the child's position over a given duration.
///  * [PositionedDirectional], which adapts to the ambient [Directionality].
class Positioned extends ParentDataWidget<StackParentData> {
  /// Creates a widget that controls where a child of a [Stack] is positioned.
  ///
  /// Only two out of the three horizontal values ([left], [right],
  /// [width]), and only two out of the three vertical values ([top],
  /// [bottom], [height]), can be set. In each case, at least one of
  /// the three must be null.
  ///
  /// See also:
  ///
  ///  * [Positioned.directional], which specifies the widget's horizontal
  ///    position using `start` and `end` rather than `left` and `right`.
  ///  * [PositionedDirectional], which is similar to [Positioned.directional]
  ///    but adapts to the ambient [Directionality].
  const Positioned({
    super.key,
    this.left,
    this.top,
    this.right,
    this.bottom,
    this.width,
    this.height,
    required super.child,
  }) : assert(left == null || right == null || width == null),
       assert(top == null || bottom == null || height == null);

  /// Creates a Positioned object with the values from the given [Rect].
  ///
  /// This sets the [left], [top], [width], and [height] properties
  /// from the given [Rect]. The [right] and [bottom] properties are
  /// set to null.
  Positioned.fromRect({
    super.key,
    required Rect rect,
    required super.child,
  }) : left = rect.left,
       top = rect.top,
       width = rect.width,
       height = rect.height,
       right = null,
       bottom = null;

  /// Creates a Positioned object with the values from the given [RelativeRect].
  ///
  /// This sets the [left], [top], [right], and [bottom] properties from the
  /// given [RelativeRect]. The [height] and [width] properties are set to null.
  Positioned.fromRelativeRect({
    super.key,
    required RelativeRect rect,
    required super.child,
  }) : left = rect.left,
       top = rect.top,
       right = rect.right,
       bottom = rect.bottom,
       width = null,
       height = null;

  /// Creates a Positioned object with [left], [top], [right], and [bottom] set
  /// to 0.0 unless a value for them is passed.
  const Positioned.fill({
    super.key,
    this.left = 0.0,
    this.top = 0.0,
    this.right = 0.0,
    this.bottom = 0.0,
    required super.child,
  }) : width = null,
       height = null;

  /// Creates a widget that controls where a child of a [Stack] is positioned.
  ///
  /// Only two out of the three horizontal values (`start`, `end`,
  /// [width]), and only two out of the three vertical values ([top],
  /// [bottom], [height]), can be set. In each case, at least one of
  /// the three must be null.
  ///
  /// If `textDirection` is [TextDirection.rtl], then the `start` argument is
  /// used for the [right] property and the `end` argument is used for the
  /// [left] property. Otherwise, if `textDirection` is [TextDirection.ltr],
  /// then the `start` argument is used for the [left] property and the `end`
  /// argument is used for the [right] property.
  ///
  /// The `textDirection` argument must not be null.
  ///
  /// See also:
  ///
  ///  * [PositionedDirectional], which adapts to the ambient [Directionality].
  factory Positioned.directional({
    Key? key,
    required TextDirection textDirection,
    double? start,
    double? top,
    double? end,
    double? bottom,
    double? width,
    double? height,
    required Widget child,
  }) {
    double? left;
    double? right;
    switch (textDirection) {
      case TextDirection.rtl:
        left = end;
        right = start;
      case TextDirection.ltr:
        left = start;
        right = end;
    }
    return Positioned(
      key: key,
      left: left,
      top: top,
      right: right,
      bottom: bottom,
      width: width,
      height: height,
      child: child,
    );
  }

  /// The distance that the child's left edge is inset from the left of the stack.
  ///
  /// Only two out of the three horizontal values ([left], [right], [width]) can be
  /// set. The third must be null.
  ///
  /// If all three are null, the [Stack.alignment] is used to position the child
  /// horizontally.
  final double? left;

  /// The distance that the child's top edge is inset from the top of the stack.
  ///
  /// Only two out of the three vertical values ([top], [bottom], [height]) can be
  /// set. The third must be null.
  ///
  /// If all three are null, the [Stack.alignment] is used to position the child
  /// vertically.
  final double? top;

  /// The distance that the child's right edge is inset from the right of the stack.
  ///
  /// Only two out of the three horizontal values ([left], [right], [width]) can be
  /// set. The third must be null.
  ///
  /// If all three are null, the [Stack.alignment] is used to position the child
  /// horizontally.
  final double? right;

  /// The distance that the child's bottom edge is inset from the bottom of the stack.
  ///
  /// Only two out of the three vertical values ([top], [bottom], [height]) can be
  /// set. The third must be null.
  ///
  /// If all three are null, the [Stack.alignment] is used to position the child
  /// vertically.
  final double? bottom;

  /// The child's width.
  ///
  /// Only two out of the three horizontal values ([left], [right], [width]) can be
  /// set. The third must be null.
  ///
  /// If all three are null, the [Stack.alignment] is used to position the child
  /// horizontally.
  final double? width;

  /// The child's height.
  ///
  /// Only two out of the three vertical values ([top], [bottom], [height]) can be
  /// set. The third must be null.
  ///
  /// If all three are null, the [Stack.alignment] is used to position the child
  /// vertically.
  final double? height;

  @override
  void applyParentData(RenderObject renderObject) {
    assert(renderObject.parentData is StackParentData);
    final StackParentData parentData = renderObject.parentData! as StackParentData;
    bool needsLayout = false;

    if (parentData.left != left) {
      parentData.left = left;
      needsLayout = true;
    }

    if (parentData.top != top) {
      parentData.top = top;
      needsLayout = true;
    }

    if (parentData.right != right) {
      parentData.right = right;
      needsLayout = true;
    }

    if (parentData.bottom != bottom) {
      parentData.bottom = bottom;
      needsLayout = true;
    }

    if (parentData.width != width) {
      parentData.width = width;
      needsLayout = true;
    }

    if (parentData.height != height) {
      parentData.height = height;
      needsLayout = true;
    }

    if (needsLayout) {
      final AbstractNode? targetParent = renderObject.parent;
      if (targetParent is RenderObject) {
        targetParent.markNeedsLayout();
      }
    }
  }

  @override
  Type get debugTypicalAncestorWidgetClass => Stack;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DoubleProperty('left', left, defaultValue: null));
    properties.add(DoubleProperty('top', top, defaultValue: null));
    properties.add(DoubleProperty('right', right, defaultValue: null));
    properties.add(DoubleProperty('bottom', bottom, defaultValue: null));
    properties.add(DoubleProperty('width', width, defaultValue: null));
    properties.add(DoubleProperty('height', height, defaultValue: null));
  }
}

/// A widget that controls where a child of a [Stack] is positioned without
/// committing to a specific [TextDirection].
///
/// The ambient [Directionality] is used to determine whether [start] is to the
/// left or to the right.
///
/// A [PositionedDirectional] widget must be a descendant of a [Stack], and the
/// path from the [PositionedDirectional] widget to its enclosing [Stack] must
/// contain only [StatelessWidget]s or [StatefulWidget]s (not other kinds of
/// widgets, like [RenderObjectWidget]s).
///
/// If a widget is wrapped in a [PositionedDirectional], then it is a
/// _positioned_ widget in its [Stack]. If the [top] property is non-null, the
/// top edge of this child/ will be positioned [top] layout units from the top
/// of the stack widget. The [start], [bottom], and [end] properties work
/// analogously.
///
/// If both the [top] and [bottom] properties are non-null, then the child will
/// be forced to have exactly the height required to satisfy both constraints.
/// Similarly, setting the [start] and [end] properties to non-null values will
/// force the child to have a particular width. Alternatively the [width] and
/// [height] properties can be used to give the dimensions, with one
/// corresponding position property (e.g. [top] and [height]).
///
/// See also:
///
///  * [Positioned], which specifies the widget's position visually.
///  * [Positioned.directional], which also specifies the widget's horizontal
///    position using [start] and [end] but has an explicit [TextDirection].
///  * [AnimatedPositionedDirectional], which automatically transitions
///    the child's position over a given duration whenever the given position
///    changes.
class PositionedDirectional extends StatelessWidget {
  /// Creates a widget that controls where a child of a [Stack] is positioned.
  ///
  /// Only two out of the three horizontal values (`start`, `end`,
  /// [width]), and only two out of the three vertical values ([top],
  /// [bottom], [height]), can be set. In each case, at least one of
  /// the three must be null.
  ///
  /// See also:
  ///
  ///  * [Positioned.directional], which also specifies the widget's horizontal
  ///    position using [start] and [end] but has an explicit [TextDirection].
  const PositionedDirectional({
    super.key,
    this.start,
    this.top,
    this.end,
    this.bottom,
    this.width,
    this.height,
    required this.child,
  });

  /// The distance that the child's leading edge is inset from the leading edge
  /// of the stack.
  ///
  /// Only two out of the three horizontal values ([start], [end], [width]) can be
  /// set. The third must be null.
  final double? start;

  /// The distance that the child's top edge is inset from the top of the stack.
  ///
  /// Only two out of the three vertical values ([top], [bottom], [height]) can be
  /// set. The third must be null.
  final double? top;

  /// The distance that the child's trailing edge is inset from the trailing
  /// edge of the stack.
  ///
  /// Only two out of the three horizontal values ([start], [end], [width]) can be
  /// set. The third must be null.
  final double? end;

  /// The distance that the child's bottom edge is inset from the bottom of the stack.
  ///
  /// Only two out of the three vertical values ([top], [bottom], [height]) can be
  /// set. The third must be null.
  final double? bottom;

  /// The child's width.
  ///
  /// Only two out of the three horizontal values ([start], [end], [width]) can be
  /// set. The third must be null.
  final double? width;

  /// The child's height.
  ///
  /// Only two out of the three vertical values ([top], [bottom], [height]) can be
  /// set. The third must be null.
  final double? height;

  /// The widget below this widget in the tree.
  ///
  /// {@macro flutter.widgets.ProxyWidget.child}
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Positioned.directional(
      textDirection: Directionality.of(context),
      start: start,
      top: top,
      end: end,
      bottom: bottom,
      width: width,
      height: height,
      child: child,
    );
  }
}

/// A widget that displays its children in a one-dimensional array.
///
/// The [Flex] widget allows you to control the axis along which the children are
/// placed (horizontal or vertical). This is referred to as the _main axis_. If
/// you know the main axis in advance, then consider using a [Row] (if it's
/// horizontal) or [Column] (if it's vertical) instead, because that will be less
/// verbose.
///
/// To cause a child to expand to fill the available space in the [direction]
/// of this widget's main axis, wrap the child in an [Expanded] widget.
///
/// The [Flex] widget does not scroll (and in general it is considered an error
/// to have more children in a [Flex] than will fit in the available room). If
/// you have some widgets and want them to be able to scroll if there is
/// insufficient room, consider using a [ListView].
///
/// The [Flex] widget does not allow its children to wrap across multiple
/// horizontal or vertical runs. For a widget that allows its children to wrap,
/// consider using the [Wrap] widget instead of [Flex].
///
/// If you only have one child, then rather than using [Flex], [Row], or
/// [Column], consider using [Align] or [Center] to position the child.
///
/// ## Layout algorithm
///
/// _This section describes how a [Flex] is rendered by the framework._
/// _See [BoxConstraints] for an introduction to box layout models._
///
/// Layout for a [Flex] proceeds in six steps:
///
/// 1. Layout each child with a null or zero flex factor (e.g., those that are
///    not [Expanded]) with unbounded main axis constraints and the incoming
///    cross axis constraints. If the [crossAxisAlignment] is
///    [CrossAxisAlignment.stretch], instead use tight cross axis constraints
///    that match the incoming max extent in the cross axis.
/// 2. Divide the remaining main axis space among the children with non-zero
///    flex factors (e.g., those that are [Expanded]) according to their flex
///    factor. For example, a child with a flex factor of 2.0 will receive twice
///    the amount of main axis space as a child with a flex factor of 1.0.
/// 3. Layout each of the remaining children with the same cross axis
///    constraints as in step 1, but instead of using unbounded main axis
///    constraints, use max axis constraints based on the amount of space
///    allocated in step 2. Children with [Flexible.fit] properties that are
///    [FlexFit.tight] are given tight constraints (i.e., forced to fill the
///    allocated space), and children with [Flexible.fit] properties that are
///    [FlexFit.loose] are given loose constraints (i.e., not forced to fill the
///    allocated space).
/// 4. The cross axis extent of the [Flex] is the maximum cross axis extent of
///    the children (which will always satisfy the incoming constraints).
/// 5. The main axis extent of the [Flex] is determined by the [mainAxisSize]
///    property. If the [mainAxisSize] property is [MainAxisSize.max], then the
///    main axis extent of the [Flex] is the max extent of the incoming main
///    axis constraints. If the [mainAxisSize] property is [MainAxisSize.min],
///    then the main axis extent of the [Flex] is the sum of the main axis
///    extents of the children (subject to the incoming constraints).
/// 6. Determine the position for each child according to the
///    [mainAxisAlignment] and the [crossAxisAlignment]. For example, if the
///    [mainAxisAlignment] is [MainAxisAlignment.spaceBetween], any main axis
///    space that has not been allocated to children is divided evenly and
///    placed between the children.
///
/// See also:
///
///  * [Row], for a version of this widget that is always horizontal.
///  * [Column], for a version of this widget that is always vertical.
///  * [Expanded], to indicate children that should take all the remaining room.
///  * [Flexible], to indicate children that should share the remaining room.
///  * [Spacer], a widget that takes up space proportional to its flex value.
///    that may be sized smaller (leaving some remaining room unused).
///  * [Wrap], for a widget that allows its children to wrap over multiple _runs_.
///  * The [catalog of layout widgets](https://flutter.dev/widgets/layout/).
class Flex extends MultiChildRenderObjectWidget {
  /// Creates a flex layout.
  ///
  /// The [direction] is required.
  ///
  /// The [direction], [mainAxisAlignment], [crossAxisAlignment], and
  /// [verticalDirection] arguments must not be null. If [crossAxisAlignment] is
  /// [CrossAxisAlignment.baseline], then [textBaseline] must not be null.
  ///
  /// The [textDirection] argument defaults to the ambient [Directionality], if
  /// any. If there is no ambient directionality, and a text direction is going
  /// to be necessary to decide which direction to lay the children in or to
  /// disambiguate `start` or `end` values for the main or cross axis
  /// directions, the [textDirection] must not be null.
  const Flex({
    super.key,
    required this.direction,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.mainAxisSize = MainAxisSize.max,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.textDirection,
    this.verticalDirection = VerticalDirection.down,
    this.textBaseline, // NO DEFAULT: we don't know what the text's baseline should be
    this.clipBehavior = Clip.none,
    super.children,
  }) : assert(!identical(crossAxisAlignment, CrossAxisAlignment.baseline) || textBaseline != null, 'textBaseline is required if you specify the crossAxisAlignment with CrossAxisAlignment.baseline');
  // Cannot use == in the assert above instead of identical because of https://github.com/dart-lang/language/issues/1811.

  /// The direction to use as the main axis.
  ///
  /// If you know the axis in advance, then consider using a [Row] (if it's
  /// horizontal) or [Column] (if it's vertical) instead of a [Flex], since that
  /// will be less verbose. (For [Row] and [Column] this property is fixed to
  /// the appropriate axis.)
  final Axis direction;

  /// How the children should be placed along the main axis.
  ///
  /// For example, [MainAxisAlignment.start], the default, places the children
  /// at the start (i.e., the left for a [Row] or the top for a [Column]) of the
  /// main axis.
  final MainAxisAlignment mainAxisAlignment;

  /// How much space should be occupied in the main axis.
  ///
  /// After allocating space to children, there might be some remaining free
  /// space. This value controls whether to maximize or minimize the amount of
  /// free space, subject to the incoming layout constraints.
  ///
  /// If some children have a non-zero flex factors (and none have a fit of
  /// [FlexFit.loose]), they will expand to consume all the available space and
  /// there will be no remaining free space to maximize or minimize, making this
  /// value irrelevant to the final layout.
  final MainAxisSize mainAxisSize;

  /// How the children should be placed along the cross axis.
  ///
  /// For example, [CrossAxisAlignment.center], the default, centers the
  /// children in the cross axis (e.g., horizontally for a [Column]).
  final CrossAxisAlignment crossAxisAlignment;

  /// Determines the order to lay children out horizontally and how to interpret
  /// `start` and `end` in the horizontal direction.
  ///
  /// Defaults to the ambient [Directionality].
  ///
  /// If [textDirection] is [TextDirection.rtl], then the direction in which
  /// text flows starts from right to left. Otherwise, if [textDirection] is
  /// [TextDirection.ltr], then the direction in which text flows starts from
  /// left to right.
  ///
  /// If the [direction] is [Axis.horizontal], this controls the order in which
  /// the children are positioned (left-to-right or right-to-left), and the
  /// meaning of the [mainAxisAlignment] property's [MainAxisAlignment.start] and
  /// [MainAxisAlignment.end] values.
  ///
  /// If the [direction] is [Axis.horizontal], and either the
  /// [mainAxisAlignment] is either [MainAxisAlignment.start] or
  /// [MainAxisAlignment.end], or there's more than one child, then the
  /// [textDirection] (or the ambient [Directionality]) must not be null.
  ///
  /// If the [direction] is [Axis.vertical], this controls the meaning of the
  /// [crossAxisAlignment] property's [CrossAxisAlignment.start] and
  /// [CrossAxisAlignment.end] values.
  ///
  /// If the [direction] is [Axis.vertical], and the [crossAxisAlignment] is
  /// either [CrossAxisAlignment.start] or [CrossAxisAlignment.end], then the
  /// [textDirection] (or the ambient [Directionality]) must not be null.
  final TextDirection? textDirection;

  /// Determines the order to lay children out vertically and how to interpret
  /// `start` and `end` in the vertical direction.
  ///
  /// Defaults to [VerticalDirection.down].
  ///
  /// If the [direction] is [Axis.vertical], this controls which order children
  /// are painted in (down or up), the meaning of the [mainAxisAlignment]
  /// property's [MainAxisAlignment.start] and [MainAxisAlignment.end] values.
  ///
  /// If the [direction] is [Axis.vertical], and either the [mainAxisAlignment]
  /// is either [MainAxisAlignment.start] or [MainAxisAlignment.end], or there's
  /// more than one child, then the [verticalDirection] must not be null.
  ///
  /// If the [direction] is [Axis.horizontal], this controls the meaning of the
  /// [crossAxisAlignment] property's [CrossAxisAlignment.start] and
  /// [CrossAxisAlignment.end] values.
  ///
  /// If the [direction] is [Axis.horizontal], and the [crossAxisAlignment] is
  /// either [CrossAxisAlignment.start] or [CrossAxisAlignment.end], then the
  /// [verticalDirection] must not be null.
  final VerticalDirection verticalDirection;

  /// If aligning items according to their baseline, which baseline to use.
  ///
  /// This must be set if using baseline alignment. There is no default because there is no
  /// way for the framework to know the correct baseline _a priori_.
  final TextBaseline? textBaseline;

  /// {@macro flutter.material.Material.clipBehavior}
  ///
  /// Defaults to [Clip.none].
  final Clip clipBehavior;

  bool get _needTextDirection {
    switch (direction) {
      case Axis.horizontal:
        return true; // because it affects the layout order.
      case Axis.vertical:
        return crossAxisAlignment == CrossAxisAlignment.start
            || crossAxisAlignment == CrossAxisAlignment.end;
    }
  }

  /// The value to pass to [RenderFlex.textDirection].
  ///
  /// This value is derived from the [textDirection] property and the ambient
  /// [Directionality]. The value is null if there is no need to specify the
  /// text direction. In practice there's always a need to specify the direction
  /// except for vertical flexes (e.g. [Column]s) whose [crossAxisAlignment] is
  /// not dependent on the text direction (not `start` or `end`). In particular,
  /// a [Row] always needs a text direction because the text direction controls
  /// its layout order. (For [Column]s, the layout order is controlled by
  /// [verticalDirection], which is always specified as it does not depend on an
  /// inherited widget and defaults to [VerticalDirection.down].)
  ///
  /// This method exists so that subclasses of [Flex] that create their own
  /// render objects that are derived from [RenderFlex] can do so and still use
  /// the logic for providing a text direction only when it is necessary.
  @protected
  TextDirection? getEffectiveTextDirection(BuildContext context) {
    return textDirection ?? (_needTextDirection ? Directionality.maybeOf(context) : null);
  }

  @override
  RenderFlex createRenderObject(BuildContext context) {
    return RenderFlex(
      direction: direction,
      mainAxisAlignment: mainAxisAlignment,
      mainAxisSize: mainAxisSize,
      crossAxisAlignment: crossAxisAlignment,
      textDirection: getEffectiveTextDirection(context),
      verticalDirection: verticalDirection,
      textBaseline: textBaseline,
      clipBehavior: clipBehavior,
    );
  }

  @override
  void updateRenderObject(BuildContext context, covariant RenderFlex renderObject) {
    renderObject
      ..direction = direction
      ..mainAxisAlignment = mainAxisAlignment
      ..mainAxisSize = mainAxisSize
      ..crossAxisAlignment = crossAxisAlignment
      ..textDirection = getEffectiveTextDirection(context)
      ..verticalDirection = verticalDirection
      ..textBaseline = textBaseline
      ..clipBehavior = clipBehavior;
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(EnumProperty<Axis>('direction', direction));
    properties.add(EnumProperty<MainAxisAlignment>('mainAxisAlignment', mainAxisAlignment));
    properties.add(EnumProperty<MainAxisSize>('mainAxisSize', mainAxisSize, defaultValue: MainAxisSize.max));
    properties.add(EnumProperty<CrossAxisAlignment>('crossAxisAlignment', crossAxisAlignment));
    properties.add(EnumProperty<TextDirection>('textDirection', textDirection, defaultValue: null));
    properties.add(EnumProperty<VerticalDirection>('verticalDirection', verticalDirection, defaultValue: VerticalDirection.down));
    properties.add(EnumProperty<TextBaseline>('textBaseline', textBaseline, defaultValue: null));
  }
}

/// A widget that displays its children in a horizontal array.
///
/// To cause a child to expand to fill the available horizontal space, wrap the
/// child in an [Expanded] widget.
///
/// The [Row] widget does not scroll (and in general it is considered an error
/// to have more children in a [Row] than will fit in the available room). If
/// you have a line of widgets and want them to be able to scroll if there is
/// insufficient room, consider using a [ListView].
///
/// For a vertical variant, see [Column].
///
/// If you only have one child, then consider using [Align] or [Center] to
/// position the child.
///
/// {@tool snippet}
///
/// This example divides the available space into three (horizontally), and
/// places text centered in the first two cells and the Flutter logo centered in
/// the third:
///
/// ![](https://flutter.github.io/assets-for-api-docs/assets/widgets/row.png)
///
/// ```dart
/// const Row(
///   children: <Widget>[
///     Expanded(
///       child: Text('Deliver features faster', textAlign: TextAlign.center),
///     ),
///     Expanded(
///       child: Text('Craft beautiful UIs', textAlign: TextAlign.center),
///     ),
///     Expanded(
///       child: FittedBox(
///         child: FlutterLogo(),
///       ),
///     ),
///   ],
/// )
/// ```
/// {@end-tool}
///
/// ## Troubleshooting
///
/// ### Why does my row have a yellow and black warning stripe?
///
/// If the non-flexible contents of the row (those that are not wrapped in
/// [Expanded] or [Flexible] widgets) are together wider than the row itself,
/// then the row is said to have overflowed. When a row overflows, the row does
/// not have any remaining space to share between its [Expanded] and [Flexible]
/// children. The row reports this by drawing a yellow and black striped
/// warning box on the edge that is overflowing. If there is room on the outside
/// of the row, the amount of overflow is printed in red lettering.
///
/// #### Story time
///
/// Suppose, for instance, that you had this code:
///
/// ```dart
/// const Row(
///   children: <Widget>[
///     FlutterLogo(),
///     Text("Flutter's hot reload helps you quickly and easily experiment, build UIs, add features, and fix bug faster. Experience sub-second reload times, without losing state, on emulators, simulators, and hardware for iOS and Android."),
///     Icon(Icons.sentiment_very_satisfied),
///   ],
/// )
/// ```
///
/// The row first asks its first child, the [FlutterLogo], to lay out, at
/// whatever size the logo would like. The logo is friendly and happily decides
/// to be 24 pixels to a side. This leaves lots of room for the next child. The
/// row then asks that next child, the text, to lay out, at whatever size it
/// thinks is best.
///
/// At this point, the text, not knowing how wide is too wide, says "Ok, I will
/// be thiiiiiiiiiiiiiiiiiiiis wide.", and goes well beyond the space that the
/// row has available, not wrapping. The row responds, "That's not fair, now I
/// have no more room available for my other children!", and gets angry and
/// sprouts a yellow and black strip.
///
/// ![](https://flutter.github.io/assets-for-api-docs/assets/widgets/row_error.png)
///
/// The fix is to wrap the second child in an [Expanded] widget, which tells the
/// row that the child should be given the remaining room:
///
/// ```dart
/// const Row(
///   children: <Widget>[
///     FlutterLogo(),
///     Expanded(
///       child: Text("Flutter's hot reload helps you quickly and easily experiment, build UIs, add features, and fix bug faster. Experience sub-second reload times, without losing state, on emulators, simulators, and hardware for iOS and Android."),
///     ),
///     Icon(Icons.sentiment_very_satisfied),
///   ],
/// )
/// ```
///
/// Now, the row first asks the logo to lay out, and then asks the _icon_ to lay
/// out. The [Icon], like the logo, is happy to take on a reasonable size (also
/// 24 pixels, not coincidentally, since both [FlutterLogo] and [Icon] honor the
/// ambient [IconTheme]). This leaves some room left over, and now the row tells
/// the text exactly how wide to be: the exact width of the remaining space. The
/// text, now happy to comply to a reasonable request, wraps the text within
/// that width, and you end up with a paragraph split over several lines.
///
/// ![](https://flutter.github.io/assets-for-api-docs/assets/widgets/row_fixed.png)
///
/// The [textDirection] property controls the direction that children are rendered in.
/// [TextDirection.ltr] is the default [textDirection] of [Row] children, so the first
/// child is rendered at the `start` of the [Row], to the left, with subsequent children
/// following to the right. If you want to order children in the opposite
/// direction (right to left), then [textDirection] can be set to
/// [TextDirection.rtl]. This is shown in the example below
///
/// ```dart
/// const Row(
///   textDirection: TextDirection.rtl,
///   children: <Widget>[
///     FlutterLogo(),
///     Expanded(
///       child: Text("Flutter's hot reload helps you quickly and easily experiment, build UIs, add features, and fix bug faster. Experience sub-second reload times, without losing state, on emulators, simulators, and hardware for iOS and Android."),
///     ),
///     Icon(Icons.sentiment_very_satisfied),
///   ],
/// )
/// ```
///
/// ![](https://flutter.github.io/assets-for-api-docs/assets/widgets/row_textDirection.png)
///
/// ## Layout algorithm
///
/// _This section describes how a [Row] is rendered by the framework._
/// _See [BoxConstraints] for an introduction to box layout models._
///
/// Layout for a [Row] proceeds in six steps:
///
/// 1. Layout each child with a null or zero flex factor (e.g., those that are
///    not [Expanded]) with unbounded horizontal constraints and the incoming
///    vertical constraints. If the [crossAxisAlignment] is
///    [CrossAxisAlignment.stretch], instead use tight vertical constraints that
///    match the incoming max height.
/// 2. Divide the remaining horizontal space among the children with non-zero
///    flex factors (e.g., those that are [Expanded]) according to their flex
///    factor. For example, a child with a flex factor of 2.0 will receive twice
///    the amount of horizontal space as a child with a flex factor of 1.0.
/// 3. Layout each of the remaining children with the same vertical constraints
///    as in step 1, but instead of using unbounded horizontal constraints, use
///    horizontal constraints based on the amount of space allocated in step 2.
///    Children with [Flexible.fit] properties that are [FlexFit.tight] are
///    given tight constraints (i.e., forced to fill the allocated space), and
///    children with [Flexible.fit] properties that are [FlexFit.loose] are
///    given loose constraints (i.e., not forced to fill the allocated space).
/// 4. The height of the [Row] is the maximum height of the children (which will
///    always satisfy the incoming vertical constraints).
/// 5. The width of the [Row] is determined by the [mainAxisSize] property. If
///    the [mainAxisSize] property is [MainAxisSize.max], then the width of the
///    [Row] is the max width of the incoming constraints. If the [mainAxisSize]
///    property is [MainAxisSize.min], then the width of the [Row] is the sum
///    of widths of the children (subject to the incoming constraints).
/// 6. Determine the position for each child according to the
///    [mainAxisAlignment] and the [crossAxisAlignment]. For example, if the
///    [mainAxisAlignment] is [MainAxisAlignment.spaceBetween], any horizontal
///    space that has not been allocated to children is divided evenly and
///    placed between the children.
///
/// See also:
///
///  * [Column], for a vertical equivalent.
///  * [Flex], if you don't know in advance if you want a horizontal or vertical
///    arrangement.
///  * [Expanded], to indicate children that should take all the remaining room.
///  * [Flexible], to indicate children that should share the remaining room but
///    that may by sized smaller (leaving some remaining room unused).
///  * [Spacer], a widget that takes up space proportional to its flex value.
///  * The [catalog of layout widgets](https://flutter.dev/widgets/layout/).
class Row extends Flex {
  /// Creates a horizontal array of children.
  ///
  /// The [mainAxisAlignment], [mainAxisSize], [crossAxisAlignment], and
  /// [verticalDirection] arguments must not be null.
  /// If [crossAxisAlignment] is [CrossAxisAlignment.baseline], then
  /// [textBaseline] must not be null.
  ///
  /// The [textDirection] argument defaults to the ambient [Directionality], if
  /// any. If there is no ambient directionality, and a text direction is going
  /// to be necessary to determine the layout order (which is always the case
  /// unless the row has no children or only one child) or to disambiguate
  /// `start` or `end` values for the [mainAxisAlignment], the [textDirection]
  /// must not be null.
  const Row({
    super.key,
    super.mainAxisAlignment,
    super.mainAxisSize,
    super.crossAxisAlignment,
    super.textDirection,
    super.verticalDirection,
    super.textBaseline, // NO DEFAULT: we don't know what the text's baseline should be
    super.children,
  }) : super(
    direction: Axis.horizontal,
  );
}

/// A widget that displays its children in a vertical array.
///
/// To cause a child to expand to fill the available vertical space, wrap the
/// child in an [Expanded] widget.
///
/// The [Column] widget does not scroll (and in general it is considered an error
/// to have more children in a [Column] than will fit in the available room). If
/// you have a line of widgets and want them to be able to scroll if there is
/// insufficient room, consider using a [ListView].
///
/// For a horizontal variant, see [Row].
///
/// If you only have one child, then consider using [Align] or [Center] to
/// position the child.
///
/// {@tool snippet}
///
/// This example uses a [Column] to arrange three widgets vertically, the last
/// being made to fill all the remaining space.
///
/// ![Using the Column in this way creates two short lines of text with a large Flutter underneath.](https://flutter.github.io/assets-for-api-docs/assets/widgets/column.png)
///
/// ```dart
/// const Column(
///   children: <Widget>[
///     Text('Deliver features faster'),
///     Text('Craft beautiful UIs'),
///     Expanded(
///       child: FittedBox(
///         child: FlutterLogo(),
///       ),
///     ),
///   ],
/// )
/// ```
/// {@end-tool}
/// {@tool snippet}
///
/// In the sample above, the text and the logo are centered on each line. In the
/// following example, the [crossAxisAlignment] is set to
/// [CrossAxisAlignment.start], so that the children are left-aligned. The
/// [mainAxisSize] is set to [MainAxisSize.min], so that the column shrinks to
/// fit the children.
///
/// ![](https://flutter.github.io/assets-for-api-docs/assets/widgets/column_properties.png)
///
/// ```dart
/// Column(
///   crossAxisAlignment: CrossAxisAlignment.start,
///   mainAxisSize: MainAxisSize.min,
///   children: <Widget>[
///     const Text('We move under cover and we move as one'),
///     const Text('Through the night, we have one shot to live another day'),
///     const Text('We cannot let a stray gunshot give us away'),
///     const Text('We will fight up close, seize the moment and stay in it'),
///     const Text('It’s either that or meet the business end of a bayonet'),
///     const Text('The code word is ‘Rochambeau,’ dig me?'),
///     Text('Rochambeau!', style: DefaultTextStyle.of(context).style.apply(fontSizeFactor: 2.0)),
///   ],
/// )
/// ```
/// {@end-tool}
///
/// ## Troubleshooting
///
/// ### When the incoming vertical constraints are unbounded
///
/// When a [Column] has one or more [Expanded] or [Flexible] children, and is
/// placed in another [Column], or in a [ListView], or in some other context
/// that does not provide a maximum height constraint for the [Column], you will
/// get an exception at runtime saying that there are children with non-zero
/// flex but the vertical constraints are unbounded.
///
/// The problem, as described in the details that accompany that exception, is
/// that using [Flexible] or [Expanded] means that the remaining space after
/// laying out all the other children must be shared equally, but if the
/// incoming vertical constraints are unbounded, there is infinite remaining
/// space.
///
/// The key to solving this problem is usually to determine why the [Column] is
/// receiving unbounded vertical constraints.
///
/// One common reason for this to happen is that the [Column] has been placed in
/// another [Column] (without using [Expanded] or [Flexible] around the inner
/// nested [Column]). When a [Column] lays out its non-flex children (those that
/// have neither [Expanded] or [Flexible] around them), it gives them unbounded
/// constraints so that they can determine their own dimensions (passing
/// unbounded constraints usually signals to the child that it should
/// shrink-wrap its contents). The solution in this case is typically to just
/// wrap the inner column in an [Expanded] to indicate that it should take the
/// remaining space of the outer column, rather than being allowed to take any
/// amount of room it desires.
///
/// Another reason for this message to be displayed is nesting a [Column] inside
/// a [ListView] or other vertical scrollable. In that scenario, there really is
/// infinite vertical space (the whole point of a vertical scrolling list is to
/// allow infinite space vertically). In such scenarios, it is usually worth
/// examining why the inner [Column] should have an [Expanded] or [Flexible]
/// child: what size should the inner children really be? The solution in this
/// case is typically to remove the [Expanded] or [Flexible] widgets from around
/// the inner children.
///
/// {@youtube 560 315 https://www.youtube.com/watch?v=jckqXR5CrPI}
///
/// For more discussion about constraints, see [BoxConstraints].
///
/// ### The yellow and black striped banner
///
/// When the contents of a [Column] exceed the amount of space available, the
/// [Column] overflows, and the contents are clipped. In debug mode, a yellow
/// and black striped bar is rendered at the overflowing edge to indicate the
/// problem, and a message is printed below the [Column] saying how much
/// overflow was detected.
///
/// The usual solution is to use a [ListView] rather than a [Column], to enable
/// the contents to scroll when vertical space is limited.
///
/// ## Layout algorithm
///
/// _This section describes how a [Column] is rendered by the framework._
/// _See [BoxConstraints] for an introduction to box layout models._
///
/// Layout for a [Column] proceeds in six steps:
///
/// 1. Layout each child with a null or zero flex factor (e.g., those that are
///    not [Expanded]) with unbounded vertical constraints and the incoming
///    horizontal constraints. If the [crossAxisAlignment] is
///    [CrossAxisAlignment.stretch], instead use tight horizontal constraints
///    that match the incoming max width.
/// 2. Divide the remaining vertical space among the children with non-zero
///    flex factors (e.g., those that are [Expanded]) according to their flex
///    factor. For example, a child with a flex factor of 2.0 will receive twice
///    the amount of vertical space as a child with a flex factor of 1.0.
/// 3. Layout each of the remaining children with the same horizontal
///    constraints as in step 1, but instead of using unbounded vertical
///    constraints, use vertical constraints based on the amount of space
///    allocated in step 2. Children with [Flexible.fit] properties that are
///    [FlexFit.tight] are given tight constraints (i.e., forced to fill the
///    allocated space), and children with [Flexible.fit] properties that are
///    [FlexFit.loose] are given loose constraints (i.e., not forced to fill the
///    allocated space).
/// 4. The width of the [Column] is the maximum width of the children (which
///    will always satisfy the incoming horizontal constraints).
/// 5. The height of the [Column] is determined by the [mainAxisSize] property.
///    If the [mainAxisSize] property is [MainAxisSize.max], then the height of
///    the [Column] is the max height of the incoming constraints. If the
///    [mainAxisSize] property is [MainAxisSize.min], then the height of the
///    [Column] is the sum of heights of the children (subject to the incoming
///    constraints).
/// 6. Determine the position for each child according to the
///    [mainAxisAlignment] and the [crossAxisAlignment]. For example, if the
///    [mainAxisAlignment] is [MainAxisAlignment.spaceBetween], any vertical
///    space that has not been allocated to children is divided evenly and
///    placed between the children.
///
/// See also:
///
///  * [Row], for a horizontal equivalent.
///  * [Flex], if you don't know in advance if you want a horizontal or vertical
///    arrangement.
///  * [Expanded], to indicate children that should take all the remaining room.
///  * [Flexible], to indicate children that should share the remaining room but
///    that may size smaller (leaving some remaining room unused).
///  * [SingleChildScrollView], whose documentation discusses some ways to
///    use a [Column] inside a scrolling container.
///  * [Spacer], a widget that takes up space proportional to its flex value.
///  * The [catalog of layout widgets](https://flutter.dev/widgets/layout/).
class Column extends Flex {
  /// Creates a vertical array of children.
  ///
  /// The [mainAxisAlignment], [mainAxisSize], [crossAxisAlignment], and
  /// [verticalDirection] arguments must not be null.
  /// If [crossAxisAlignment] is [CrossAxisAlignment.baseline], then
  /// [textBaseline] must not be null.
  ///
  /// The [textDirection] argument defaults to the ambient [Directionality], if
  /// any. If there is no ambient directionality, and a text direction is going
  /// to be necessary to disambiguate `start` or `end` values for the
  /// [crossAxisAlignment], the [textDirection] must not be null.
  const Column({
    super.key,
    super.mainAxisAlignment,
    super.mainAxisSize,
    super.crossAxisAlignment,
    super.textDirection,
    super.verticalDirection,
    super.textBaseline,
    super.children,
  }) : super(
    direction: Axis.vertical,
  );
}

/// A widget that controls how a child of a [Row], [Column], or [Flex] flexes.
///
/// Using a [Flexible] widget gives a child of a [Row], [Column], or [Flex]
/// the flexibility to expand to fill the available space in the main axis
/// (e.g., horizontally for a [Row] or vertically for a [Column]), but, unlike
/// [Expanded], [Flexible] does not require the child to fill the available
/// space.
///
/// A [Flexible] widget must be a descendant of a [Row], [Column], or [Flex],
/// and the path from the [Flexible] widget to its enclosing [Row], [Column], or
/// [Flex] must contain only [StatelessWidget]s or [StatefulWidget]s (not other
/// kinds of widgets, like [RenderObjectWidget]s).
///
/// {@youtube 560 315 https://www.youtube.com/watch?v=CI7x0mAZiY0}
///
/// See also:
///
///  * [Expanded], which forces the child to expand to fill the available space.
///  * [Spacer], a widget that takes up space proportional to its flex value.
///  * The [catalog of layout widgets](https://flutter.dev/widgets/layout/).
class Flexible extends ParentDataWidget<FlexParentData> {
  /// Creates a widget that controls how a child of a [Row], [Column], or [Flex]
  /// flexes.
  const Flexible({
    super.key,
    this.flex = 1,
    this.fit = FlexFit.loose,
    required super.child,
  });

  /// The flex factor to use for this child.
  ///
  /// If null or zero, the child is inflexible and determines its own size. If
  /// non-zero, the amount of space the child's can occupy in the main axis is
  /// determined by dividing the free space (after placing the inflexible
  /// children) according to the flex factors of the flexible children.
  final int flex;

  /// How a flexible child is inscribed into the available space.
  ///
  /// If [flex] is non-zero, the [fit] determines whether the child fills the
  /// space the parent makes available during layout. If the fit is
  /// [FlexFit.tight], the child is required to fill the available space. If the
  /// fit is [FlexFit.loose], the child can be at most as large as the available
  /// space (but is allowed to be smaller).
  final FlexFit fit;

  @override
  void applyParentData(RenderObject renderObject) {
    assert(renderObject.parentData is FlexParentData);
    final FlexParentData parentData = renderObject.parentData! as FlexParentData;
    bool needsLayout = false;

    if (parentData.flex != flex) {
      parentData.flex = flex;
      needsLayout = true;
    }

    if (parentData.fit != fit) {
      parentData.fit = fit;
      needsLayout = true;
    }

    if (needsLayout) {
      final AbstractNode? targetParent = renderObject.parent;
      if (targetParent is RenderObject) {
        targetParent.markNeedsLayout();
      }
    }
  }

  @override
  Type get debugTypicalAncestorWidgetClass => Flex;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(IntProperty('flex', flex));
  }
}

/// A widget that expands a child of a [Row], [Column], or [Flex]
/// so that the child fills the available space.
///
/// Using an [Expanded] widget makes a child of a [Row], [Column], or [Flex]
/// expand to fill the available space along the main axis (e.g., horizontally for
/// a [Row] or vertically for a [Column]). If multiple children are expanded,
/// the available space is divided among them according to the [flex] factor.
///
/// An [Expanded] widget must be a descendant of a [Row], [Column], or [Flex],
/// and the path from the [Expanded] widget to its enclosing [Row], [Column], or
/// [Flex] must contain only [StatelessWidget]s or [StatefulWidget]s (not other
/// kinds of widgets, like [RenderObjectWidget]s).
///
/// {@youtube 560 315 https://www.youtube.com/watch?v=_rnZaagadyo}
///
/// {@tool dartpad}
/// This example shows how to use an [Expanded] widget in a [Column] so that
/// its middle child, a [Container] here, expands to fill the space.
///
/// ![This results in two thin blue boxes with a larger amber box in between.](https://flutter.github.io/assets-for-api-docs/assets/widgets/expanded_column.png)
///
/// ** See code in examples/api/lib/widgets/basic/expanded.0.dart **
/// {@end-tool}
///
/// {@tool dartpad}
/// This example shows how to use an [Expanded] widget in a [Row] with multiple
/// children expanded, utilizing the [flex] factor to prioritize available space.
///
/// ![This results in a wide amber box, followed by a thin blue box, with a medium width amber box at the end.](https://flutter.github.io/assets-for-api-docs/assets/widgets/expanded_row.png)
///
/// ** See code in examples/api/lib/widgets/basic/expanded.1.dart **
/// {@end-tool}
///
/// See also:
///
///  * [Flexible], which does not force the child to fill the available space.
///  * [Spacer], a widget that takes up space proportional to its flex value.
///  * The [catalog of layout widgets](https://flutter.dev/widgets/layout/).
class Expanded extends Flexible {
  /// Creates a widget that expands a child of a [Row], [Column], or [Flex]
  /// so that the child fills the available space along the flex widget's
  /// main axis.
  const Expanded({
    super.key,
    super.flex,
    required super.child,
  }) : super(fit: FlexFit.tight);
}

/// A widget that displays its children in multiple horizontal or vertical runs.
///
/// A [Wrap] lays out each child and attempts to place the child adjacent to the
/// previous child in the main axis, given by [direction], leaving [spacing]
/// space in between. If there is not enough space to fit the child, [Wrap]
/// creates a new _run_ adjacent to the existing children in the cross axis.
///
/// After all the children have been allocated to runs, the children within the
/// runs are positioned according to the [alignment] in the main axis and
/// according to the [crossAxisAlignment] in the cross axis.
///
/// The runs themselves are then positioned in the cross axis according to the
/// [runSpacing] and [runAlignment].
///
/// {@youtube 560 315 https://www.youtube.com/watch?v=z5iw2SeFx2M}
///
/// {@tool snippet}
///
/// This example renders some [Chip]s representing four contacts in a [Wrap] so
/// that they flow across lines as necessary.
///
/// ```dart
/// Wrap(
///   spacing: 8.0, // gap between adjacent chips
///   runSpacing: 4.0, // gap between lines
///   children: <Widget>[
///     Chip(
///       avatar: CircleAvatar(backgroundColor: Colors.blue.shade900, child: const Text('AH')),
///       label: const Text('Hamilton'),
///     ),
///     Chip(
///       avatar: CircleAvatar(backgroundColor: Colors.blue.shade900, child: const Text('ML')),
///       label: const Text('Lafayette'),
///     ),
///     Chip(
///       avatar: CircleAvatar(backgroundColor: Colors.blue.shade900, child: const Text('HM')),
///       label: const Text('Mulligan'),
///     ),
///     Chip(
///       avatar: CircleAvatar(backgroundColor: Colors.blue.shade900, child: const Text('JL')),
///       label: const Text('Laurens'),
///     ),
///   ],
/// )
/// ```
/// {@end-tool}
///
/// See also:
///
///  * [Row], which places children in one line, and gives control over their
///    alignment and spacing.
///  * The [catalog of layout widgets](https://flutter.dev/widgets/layout/).
class Wrap extends MultiChildRenderObjectWidget {
  /// Creates a wrap layout.
  ///
  /// By default, the wrap layout is horizontal and both the children and the
  /// runs are aligned to the start.
  ///
  /// The [textDirection] argument defaults to the ambient [Directionality], if
  /// any. If there is no ambient directionality, and a text direction is going
  /// to be necessary to decide which direction to lay the children in or to
  /// disambiguate `start` or `end` values for the main or cross axis
  /// directions, the [textDirection] must not be null.
  const Wrap({
    super.key,
    this.direction = Axis.horizontal,
    this.alignment = WrapAlignment.start,
    this.spacing = 0.0,
    this.runAlignment = WrapAlignment.start,
    this.runSpacing = 0.0,
    this.crossAxisAlignment = WrapCrossAlignment.start,
    this.textDirection,
    this.verticalDirection = VerticalDirection.down,
    this.clipBehavior = Clip.none,
    super.children,
  });

  /// The direction to use as the main axis.
  ///
  /// For example, if [direction] is [Axis.horizontal], the default, the
  /// children are placed adjacent to one another in a horizontal run until the
  /// available horizontal space is consumed, at which point a subsequent
  /// children are placed in a new run vertically adjacent to the previous run.
  final Axis direction;

  /// How the children within a run should be placed in the main axis.
  ///
  /// For example, if [alignment] is [WrapAlignment.center], the children in
  /// each run are grouped together in the center of their run in the main axis.
  ///
  /// Defaults to [WrapAlignment.start].
  ///
  /// See also:
  ///
  ///  * [runAlignment], which controls how the runs are placed relative to each
  ///    other in the cross axis.
  ///  * [crossAxisAlignment], which controls how the children within each run
  ///    are placed relative to each other in the cross axis.
  final WrapAlignment alignment;

  /// How much space to place between children in a run in the main axis.
  ///
  /// For example, if [spacing] is 10.0, the children will be spaced at least
  /// 10.0 logical pixels apart in the main axis.
  ///
  /// If there is additional free space in a run (e.g., because the wrap has a
  /// minimum size that is not filled or because some runs are longer than
  /// others), the additional free space will be allocated according to the
  /// [alignment].
  ///
  /// Defaults to 0.0.
  final double spacing;

  /// How the runs themselves should be placed in the cross axis.
  ///
  /// For example, if [runAlignment] is [WrapAlignment.center], the runs are
  /// grouped together in the center of the overall [Wrap] in the cross axis.
  ///
  /// Defaults to [WrapAlignment.start].
  ///
  /// See also:
  ///
  ///  * [alignment], which controls how the children within each run are placed
  ///    relative to each other in the main axis.
  ///  * [crossAxisAlignment], which controls how the children within each run
  ///    are placed relative to each other in the cross axis.
  final WrapAlignment runAlignment;

  /// How much space to place between the runs themselves in the cross axis.
  ///
  /// For example, if [runSpacing] is 10.0, the runs will be spaced at least
  /// 10.0 logical pixels apart in the cross axis.
  ///
  /// If there is additional free space in the overall [Wrap] (e.g., because
  /// the wrap has a minimum size that is not filled), the additional free space
  /// will be allocated according to the [runAlignment].
  ///
  /// Defaults to 0.0.
  final double runSpacing;

  /// How the children within a run should be aligned relative to each other in
  /// the cross axis.
  ///
  /// For example, if this is set to [WrapCrossAlignment.end], and the
  /// [direction] is [Axis.horizontal], then the children within each
  /// run will have their bottom edges aligned to the bottom edge of the run.
  ///
  /// Defaults to [WrapCrossAlignment.start].
  ///
  /// See also:
  ///
  ///  * [alignment], which controls how the children within each run are placed
  ///    relative to each other in the main axis.
  ///  * [runAlignment], which controls how the runs are placed relative to each
  ///    other in the cross axis.
  final WrapCrossAlignment crossAxisAlignment;

  /// Determines the order to lay children out horizontally and how to interpret
  /// `start` and `end` in the horizontal direction.
  ///
  /// Defaults to the ambient [Directionality].
  ///
  /// If the [direction] is [Axis.horizontal], this controls order in which the
  /// children are positioned (left-to-right or right-to-left), and the meaning
  /// of the [alignment] property's [WrapAlignment.start] and
  /// [WrapAlignment.end] values.
  ///
  /// If the [direction] is [Axis.horizontal], and either the
  /// [alignment] is either [WrapAlignment.start] or [WrapAlignment.end], or
  /// there's more than one child, then the [textDirection] (or the ambient
  /// [Directionality]) must not be null.
  ///
  /// If the [direction] is [Axis.vertical], this controls the order in which
  /// runs are positioned, the meaning of the [runAlignment] property's
  /// [WrapAlignment.start] and [WrapAlignment.end] values, as well as the
  /// [crossAxisAlignment] property's [WrapCrossAlignment.start] and
  /// [WrapCrossAlignment.end] values.
  ///
  /// If the [direction] is [Axis.vertical], and either the
  /// [runAlignment] is either [WrapAlignment.start] or [WrapAlignment.end], the
  /// [crossAxisAlignment] is either [WrapCrossAlignment.start] or
  /// [WrapCrossAlignment.end], or there's more than one child, then the
  /// [textDirection] (or the ambient [Directionality]) must not be null.
  final TextDirection? textDirection;

  /// Determines the order to lay children out vertically and how to interpret
  /// `start` and `end` in the vertical direction.
  ///
  /// If the [direction] is [Axis.vertical], this controls which order children
  /// are painted in (down or up), the meaning of the [alignment] property's
  /// [WrapAlignment.start] and [WrapAlignment.end] values.
  ///
  /// If the [direction] is [Axis.vertical], and either the [alignment]
  /// is either [WrapAlignment.start] or [WrapAlignment.end], or there's
  /// more than one child, then the [verticalDirection] must not be null.
  ///
  /// If the [direction] is [Axis.horizontal], this controls the order in which
  /// runs are positioned, the meaning of the [runAlignment] property's
  /// [WrapAlignment.start] and [WrapAlignment.end] values, as well as the
  /// [crossAxisAlignment] property's [WrapCrossAlignment.start] and
  /// [WrapCrossAlignment.end] values.
  ///
  /// If the [direction] is [Axis.horizontal], and either the
  /// [runAlignment] is either [WrapAlignment.start] or [WrapAlignment.end], the
  /// [crossAxisAlignment] is either [WrapCrossAlignment.start] or
  /// [WrapCrossAlignment.end], or there's more than one child, then the
  /// [verticalDirection] must not be null.
  final VerticalDirection verticalDirection;

  /// {@macro flutter.material.Material.clipBehavior}
  ///
  /// Defaults to [Clip.none].
  final Clip clipBehavior;

  @override
  RenderWrap createRenderObject(BuildContext context) {
    return RenderWrap(
      direction: direction,
      alignment: alignment,
      spacing: spacing,
      runAlignment: runAlignment,
      runSpacing: runSpacing,
      crossAxisAlignment: crossAxisAlignment,
      textDirection: textDirection ?? Directionality.maybeOf(context),
      verticalDirection: verticalDirection,
      clipBehavior: clipBehavior,
    );
  }

  @override
  void updateRenderObject(BuildContext context, RenderWrap renderObject) {
    renderObject
      ..direction = direction
      ..alignment = alignment
      ..spacing = spacing
      ..runAlignment = runAlignment
      ..runSpacing = runSpacing
      ..crossAxisAlignment = crossAxisAlignment
      ..textDirection = textDirection ?? Directionality.maybeOf(context)
      ..verticalDirection = verticalDirection
      ..clipBehavior = clipBehavior;
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(EnumProperty<Axis>('direction', direction));
    properties.add(EnumProperty<WrapAlignment>('alignment', alignment));
    properties.add(DoubleProperty('spacing', spacing));
    properties.add(EnumProperty<WrapAlignment>('runAlignment', runAlignment));
    properties.add(DoubleProperty('runSpacing', runSpacing));
    properties.add(EnumProperty<WrapCrossAlignment>('crossAxisAlignment', crossAxisAlignment));
    properties.add(EnumProperty<TextDirection>('textDirection', textDirection, defaultValue: null));
    properties.add(EnumProperty<VerticalDirection>('verticalDirection', verticalDirection, defaultValue: VerticalDirection.down));
  }
}

/// A widget that sizes and positions children efficiently, according to the
/// logic in a [FlowDelegate].
///
/// {@youtube 560 315 https://www.youtube.com/watch?v=NG6pvXpnIso}
///
/// Flow layouts are optimized for repositioning children using transformation
/// matrices.
///
/// The flow container is sized independently from the children by the
/// [FlowDelegate.getSize] function of the delegate. The children are then sized
/// independently given the constraints from the
/// [FlowDelegate.getConstraintsForChild] function.
///
/// Rather than positioning the children during layout, the children are
/// positioned using transformation matrices during the paint phase using the
/// matrices from the [FlowDelegate.paintChildren] function. The children can be
/// repositioned efficiently by only _repainting_ the flow, which happens
/// without the children being laid out again (contrast this with a [Stack],
/// which does the sizing and positioning together during layout).
///
/// The most efficient way to trigger a repaint of the flow is to supply an
/// animation to the constructor of the [FlowDelegate]. The flow will listen to
/// this animation and repaint whenever the animation ticks, avoiding both the
/// build and layout phases of the pipeline.
///
/// See also:
///
///  * [Wrap], which provides the layout model that some other frameworks call
///    "flow", and is otherwise unrelated to [Flow].
///  * [FlowDelegate], which controls the visual presentation of the children.
///  * [Stack], which arranges children relative to the edges of the container.
///  * [CustomSingleChildLayout], which uses a delegate to control the layout of
///    a single child.
///  * [CustomMultiChildLayout], which uses a delegate to position multiple
///    children.
///  * The [catalog of layout widgets](https://flutter.dev/widgets/layout/).
///
///
/// {@tool dartpad}
/// This example uses the [Flow] widget to create a menu that opens and closes
/// as it is interacted with, shown above. The color of the button in the menu
/// changes to indicate which one has been selected.
///
/// ** See code in examples/api/lib/widgets/basic/flow.0.dart **
/// {@end-tool}
///
class Flow extends MultiChildRenderObjectWidget {
  /// Creates a flow layout.
  ///
  /// Wraps each of the given children in a [RepaintBoundary] to avoid
  /// repainting the children when the flow repaints.
  ///
  /// The [delegate] argument must not be null.
  Flow({
    super.key,
    required this.delegate,
    List<Widget> children = const <Widget>[],
    this.clipBehavior = Clip.hardEdge,
  }) : super(children: RepaintBoundary.wrapAll(children));
       // https://github.com/dart-lang/sdk/issues/29277

  /// Creates a flow layout.
  ///
  /// Does not wrap the given children in repaint boundaries, unlike the default
  /// constructor. Useful when the child is trivial to paint or already contains
  /// a repaint boundary.
  ///
  /// The [delegate] argument must not be null.
  const Flow.unwrapped({
    super.key,
    required this.delegate,
    super.children,
    this.clipBehavior = Clip.hardEdge,
  });

  /// The delegate that controls the transformation matrices of the children.
  final FlowDelegate delegate;

  /// {@macro flutter.material.Material.clipBehavior}
  ///
  /// Defaults to [Clip.none], and must not be null.
  final Clip clipBehavior;

  @override
  RenderFlow createRenderObject(BuildContext context) => RenderFlow(delegate: delegate, clipBehavior: clipBehavior);

  @override
  void updateRenderObject(BuildContext context, RenderFlow renderObject) {
    renderObject.delegate = delegate;
    renderObject.clipBehavior = clipBehavior;
  }
}

/// A paragraph of rich text.
///
/// {@youtube 560 315 https://www.youtube.com/watch?v=rykDVh-QFfw}
///
/// The [RichText] widget displays text that uses multiple different styles. The
/// text to display is described using a tree of [TextSpan] objects, each of
/// which has an associated style that is used for that subtree. The text might
/// break across multiple lines or might all be displayed on the same line
/// depending on the layout constraints.
///
/// Text displayed in a [RichText] widget must be explicitly styled. When
/// picking which style to use, consider using [DefaultTextStyle.of] the current
/// [BuildContext] to provide defaults. For more details on how to style text in
/// a [RichText] widget, see the documentation for [TextStyle].
///
/// Consider using the [Text] widget to integrate with the [DefaultTextStyle]
/// automatically. When all the text uses the same style, the default constructor
/// is less verbose. The [Text.rich] constructor allows you to style multiple
/// spans with the default text style while still allowing specified styles per
/// span.
///
/// {@tool snippet}
///
/// This sample demonstrates how to mix and match text with different text
/// styles using the [RichText] Widget. It displays the text "Hello bold world,"
/// emphasizing the word "bold" using a bold font weight.
///
/// ![](https://flutter.github.io/assets-for-api-docs/assets/widgets/rich_text.png)
///
/// ```dart
/// RichText(
///   text: TextSpan(
///     text: 'Hello ',
///     style: DefaultTextStyle.of(context).style,
///     children: const <TextSpan>[
///       TextSpan(text: 'bold', style: TextStyle(fontWeight: FontWeight.bold)),
///       TextSpan(text: ' world!'),
///     ],
///   ),
/// )
/// ```
/// {@end-tool}
///
/// ## Selections
///
/// To make this [RichText] Selectable, the [RichText] needs to be in the
/// subtree of a [SelectionArea] or [SelectableRegion] and a
/// [SelectionRegistrar] needs to be assigned to the
/// [RichText.selectionRegistrar]. One can use
/// [SelectionContainer.maybeOf] to get the [SelectionRegistrar] from a
/// context. This enables users to select the text in [RichText]s with mice or
/// touch events.
///
/// The [selectionColor] also needs to be set if the selection is enabled to
/// draw the selection highlights.
///
/// {@tool snippet}
///
/// This sample demonstrates how to assign a [SelectionRegistrar] for RichTexts
/// in the SelectionArea subtree.
///
/// ![](https://flutter.github.io/assets-for-api-docs/assets/widgets/rich_text.png)
///
/// ```dart
/// RichText(
///   text: const TextSpan(text: 'Hello'),
///   selectionRegistrar: SelectionContainer.maybeOf(context),
///   selectionColor: const Color(0xAF6694e8),
/// )
/// ```
/// {@end-tool}
///
/// See also:
///
///  * [TextStyle], which discusses how to style text.
///  * [TextSpan], which is used to describe the text in a paragraph.
///  * [Text], which automatically applies the ambient styles described by a
///    [DefaultTextStyle] to a single string.
///  * [Text.rich], a const text widget that provides similar functionality
///    as [RichText]. [Text.rich] will inherit [TextStyle] from [DefaultTextStyle].
///  * [SelectableRegion], which provides an overview of the selection system.
class RichText extends MultiChildRenderObjectWidget {
  /// Creates a paragraph of rich text.
  ///
  /// The [text], [textAlign], [softWrap], [overflow], and [textScaleFactor]
  /// arguments must not be null.
  ///
  /// The [maxLines] property may be null (and indeed defaults to null), but if
  /// it is not null, it must be greater than zero.
  ///
  /// The [textDirection], if null, defaults to the ambient [Directionality],
  /// which in that case must not be null.
  RichText({
    super.key,
    required this.text,
    this.textAlign = TextAlign.start,
    this.textDirection,
    this.softWrap = true,
    this.overflow = TextOverflow.clip,
    this.textScaleFactor = 1.0,
    this.maxLines,
    this.locale,
    this.strutStyle,
    this.textWidthBasis = TextWidthBasis.parent,
    this.textHeightBehavior,
    this.selectionRegistrar,
    this.selectionColor,
  }) : assert(maxLines == null || maxLines > 0),
       assert(selectionRegistrar == null || selectionColor != null),
       super(children: _extractChildren(text));

  // Traverses the InlineSpan tree and depth-first collects the list of
  // child widgets that are created in WidgetSpans.
  static List<Widget> _extractChildren(InlineSpan span) {
    int index = 0;
    final List<Widget> result = <Widget>[];
    span.visitChildren((InlineSpan span) {
      if (span is WidgetSpan) {
        result.add(Semantics(
          tagForChildren: PlaceholderSpanIndexSemanticsTag(index++),
          child: span.child,
        ));
      }
      return true;
    });
    return result;
  }

  /// The text to display in this widget.
  final InlineSpan text;

  /// How the text should be aligned horizontally.
  final TextAlign textAlign;

  /// The directionality of the text.
  ///
  /// This decides how [textAlign] values like [TextAlign.start] and
  /// [TextAlign.end] are interpreted.
  ///
  /// This is also used to disambiguate how to render bidirectional text. For
  /// example, if the [text] is an English phrase followed by a Hebrew phrase,
  /// in a [TextDirection.ltr] context the English phrase will be on the left
  /// and the Hebrew phrase to its right, while in a [TextDirection.rtl]
  /// context, the English phrase will be on the right and the Hebrew phrase on
  /// its left.
  ///
  /// Defaults to the ambient [Directionality], if any. If there is no ambient
  /// [Directionality], then this must not be null.
  final TextDirection? textDirection;

  /// Whether the text should break at soft line breaks.
  ///
  /// If false, the glyphs in the text will be positioned as if there was unlimited horizontal space.
  final bool softWrap;

  /// How visual overflow should be handled.
  final TextOverflow overflow;

  /// The number of font pixels for each logical pixel.
  ///
  /// For example, if the text scale factor is 1.5, text will be 50% larger than
  /// the specified font size.
  final double textScaleFactor;

  /// An optional maximum number of lines for the text to span, wrapping if necessary.
  /// If the text exceeds the given number of lines, it will be truncated according
  /// to [overflow].
  ///
  /// If this is 1, text will not wrap. Otherwise, text will be wrapped at the
  /// edge of the box.
  final int? maxLines;

  /// Used to select a font when the same Unicode character can
  /// be rendered differently, depending on the locale.
  ///
  /// It's rarely necessary to set this property. By default its value
  /// is inherited from the enclosing app with `Localizations.localeOf(context)`.
  ///
  /// See [RenderParagraph.locale] for more information.
  final Locale? locale;

  /// {@macro flutter.painting.textPainter.strutStyle}
  final StrutStyle? strutStyle;

  /// {@macro flutter.painting.textPainter.textWidthBasis}
  final TextWidthBasis textWidthBasis;

  /// {@macro dart.ui.textHeightBehavior}
  final ui.TextHeightBehavior? textHeightBehavior;

  /// The [SelectionRegistrar] this rich text is subscribed to.
  ///
  /// If this is set, [selectionColor] must be non-null.
  final SelectionRegistrar? selectionRegistrar;

  /// The color to use when painting the selection.
  ///
  /// This is ignored if [selectionRegistrar] is null.
  ///
  /// See the section on selections in the [RichText] top-level API
  /// documentation for more details on enabling selection in [RichText]
  /// widgets.
  final Color? selectionColor;

  @override
  RenderParagraph createRenderObject(BuildContext context) {
    assert(textDirection != null || debugCheckHasDirectionality(context));
    return RenderParagraph(text,
      textAlign: textAlign,
      textDirection: textDirection ?? Directionality.of(context),
      softWrap: softWrap,
      overflow: overflow,
      textScaleFactor: textScaleFactor,
      maxLines: maxLines,
      strutStyle: strutStyle,
      textWidthBasis: textWidthBasis,
      textHeightBehavior: textHeightBehavior,
      locale: locale ?? Localizations.maybeLocaleOf(context),
      registrar: selectionRegistrar,
      selectionColor: selectionColor,
    );
  }

  @override
  void updateRenderObject(BuildContext context, RenderParagraph renderObject) {
    assert(textDirection != null || debugCheckHasDirectionality(context));
    renderObject
      ..text = text
      ..textAlign = textAlign
      ..textDirection = textDirection ?? Directionality.of(context)
      ..softWrap = softWrap
      ..overflow = overflow
      ..textScaleFactor = textScaleFactor
      ..maxLines = maxLines
      ..strutStyle = strutStyle
      ..textWidthBasis = textWidthBasis
      ..textHeightBehavior = textHeightBehavior
      ..locale = locale ?? Localizations.maybeLocaleOf(context)
      ..registrar = selectionRegistrar
      ..selectionColor = selectionColor;
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(EnumProperty<TextAlign>('textAlign', textAlign, defaultValue: TextAlign.start));
    properties.add(EnumProperty<TextDirection>('textDirection', textDirection, defaultValue: null));
    properties.add(FlagProperty('softWrap', value: softWrap, ifTrue: 'wrapping at box width', ifFalse: 'no wrapping except at line break characters', showName: true));
    properties.add(EnumProperty<TextOverflow>('overflow', overflow, defaultValue: TextOverflow.clip));
    properties.add(DoubleProperty('textScaleFactor', textScaleFactor, defaultValue: 1.0));
    properties.add(IntProperty('maxLines', maxLines, ifNull: 'unlimited'));
    properties.add(EnumProperty<TextWidthBasis>('textWidthBasis', textWidthBasis, defaultValue: TextWidthBasis.parent));
    properties.add(StringProperty('text', text.toPlainText()));
    properties.add(DiagnosticsProperty<Locale>('locale', locale, defaultValue: null));
    properties.add(DiagnosticsProperty<StrutStyle>('strutStyle', strutStyle, defaultValue: null));
    properties.add(DiagnosticsProperty<TextHeightBehavior>('textHeightBehavior', textHeightBehavior, defaultValue: null));
  }
}

/// A widget that displays a [dart:ui.Image] directly.
///
/// The image is painted using [paintImage], which describes the meanings of the
/// various fields on this class in more detail.
///
/// The [image] is not disposed of by this widget. Creators of the widget are
/// expected to call [Image.dispose] on the [image] once the [RawImage] is no
/// longer buildable.
///
/// This widget is rarely used directly. Instead, consider using [Image].
class RawImage extends LeafRenderObjectWidget {
  /// Creates a widget that displays an image.
  ///
  /// The [scale], [alignment], [repeat], [matchTextDirection] and [filterQuality] arguments must
  /// not be null.
  const RawImage({
    super.key,
    this.image,
    this.debugImageLabel,
    this.width,
    this.height,
    this.scale = 1.0,
    this.color,
    this.opacity,
    this.colorBlendMode,
    this.fit,
    this.alignment = Alignment.center,
    this.repeat = ImageRepeat.noRepeat,
    this.centerSlice,
    this.matchTextDirection = false,
    this.invertColors = false,
    this.filterQuality = FilterQuality.low,
    this.isAntiAlias = false,
  });

  /// The image to display.
  ///
  /// Since a [RawImage] is stateless, it does not ever dispose this image.
  /// Creators of a [RawImage] are expected to call [Image.dispose] on this
  /// image handle when the [RawImage] will no longer be needed.
  final ui.Image? image;

  /// A string identifying the source of the image.
  final String? debugImageLabel;

  /// If non-null, require the image to have this width.
  ///
  /// If null, the image will pick a size that best preserves its intrinsic
  /// aspect ratio.
  final double? width;

  /// If non-null, require the image to have this height.
  ///
  /// If null, the image will pick a size that best preserves its intrinsic
  /// aspect ratio.
  final double? height;

  /// Specifies the image's scale.
  ///
  /// Used when determining the best display size for the image.
  final double scale;

  /// If non-null, this color is blended with each image pixel using [colorBlendMode].
  final Color? color;

  /// If non-null, the value from the [Animation] is multiplied with the opacity
  /// of each image pixel before painting onto the canvas.
  ///
  /// This is more efficient than using [FadeTransition] to change the opacity
  /// of an image.
  final Animation<double>? opacity;

  /// Used to set the filterQuality of the image.
  ///
  /// Defaults to [FilterQuality.low] to scale the image, which corresponds to
  /// bilinear interpolation.
  final FilterQuality filterQuality;

  /// Used to combine [color] with this image.
  ///
  /// The default is [BlendMode.srcIn]. In terms of the blend mode, [color] is
  /// the source and this image is the destination.
  ///
  /// See also:
  ///
  ///  * [BlendMode], which includes an illustration of the effect of each blend mode.
  final BlendMode? colorBlendMode;

  /// How to inscribe the image into the space allocated during layout.
  ///
  /// The default varies based on the other fields. See the discussion at
  /// [paintImage].
  final BoxFit? fit;

  /// How to align the image within its bounds.
  ///
  /// The alignment aligns the given position in the image to the given position
  /// in the layout bounds. For example, an [Alignment] alignment of (-1.0,
  /// -1.0) aligns the image to the top-left corner of its layout bounds, while a
  /// [Alignment] alignment of (1.0, 1.0) aligns the bottom right of the
  /// image with the bottom right corner of its layout bounds. Similarly, an
  /// alignment of (0.0, 1.0) aligns the bottom middle of the image with the
  /// middle of the bottom edge of its layout bounds.
  ///
  /// To display a subpart of an image, consider using a [CustomPainter] and
  /// [Canvas.drawImageRect].
  ///
  /// If the [alignment] is [TextDirection]-dependent (i.e. if it is a
  /// [AlignmentDirectional]), then an ambient [Directionality] widget
  /// must be in scope.
  ///
  /// Defaults to [Alignment.center].
  ///
  /// See also:
  ///
  ///  * [Alignment], a class with convenient constants typically used to
  ///    specify an [AlignmentGeometry].
  ///  * [AlignmentDirectional], like [Alignment] for specifying alignments
  ///    relative to text direction.
  final AlignmentGeometry alignment;

  /// How to paint any portions of the layout bounds not covered by the image.
  final ImageRepeat repeat;

  /// The center slice for a nine-patch image.
  ///
  /// The region of the image inside the center slice will be stretched both
  /// horizontally and vertically to fit the image into its destination. The
  /// region of the image above and below the center slice will be stretched
  /// only horizontally and the region of the image to the left and right of
  /// the center slice will be stretched only vertically.
  final Rect? centerSlice;

  /// Whether to paint the image in the direction of the [TextDirection].
  ///
  /// If this is true, then in [TextDirection.ltr] contexts, the image will be
  /// drawn with its origin in the top left (the "normal" painting direction for
  /// images); and in [TextDirection.rtl] contexts, the image will be drawn with
  /// a scaling factor of -1 in the horizontal direction so that the origin is
  /// in the top right.
  ///
  /// This is occasionally used with images in right-to-left environments, for
  /// images that were designed for left-to-right locales. Be careful, when
  /// using this, to not flip images with integral shadows, text, or other
  /// effects that will look incorrect when flipped.
  ///
  /// If this is true, there must be an ambient [Directionality] widget in
  /// scope.
  final bool matchTextDirection;

  /// Whether the colors of the image are inverted when drawn.
  ///
  /// Inverting the colors of an image applies a new color filter to the paint.
  /// If there is another specified color filter, the invert will be applied
  /// after it. This is primarily used for implementing smart invert on iOS.
  ///
  /// See also:
  ///
  ///  * [Paint.invertColors], for the dart:ui implementation.
  final bool invertColors;

  /// Whether to paint the image with anti-aliasing.
  ///
  /// Anti-aliasing alleviates the sawtooth artifact when the image is rotated.
  final bool isAntiAlias;

  @override
  RenderImage createRenderObject(BuildContext context) {
    assert((!matchTextDirection && alignment is Alignment) || debugCheckHasDirectionality(context));
    assert(
      image?.debugGetOpenHandleStackTraces()?.isNotEmpty ?? true,
      'Creator of a RawImage disposed of the image when the RawImage still '
      'needed it.',
    );
    return RenderImage(
      image: image?.clone(),
      debugImageLabel: debugImageLabel,
      width: width,
      height: height,
      scale: scale,
      color: color,
      opacity: opacity,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      textDirection: matchTextDirection || alignment is! Alignment ? Directionality.of(context) : null,
      invertColors: invertColors,
      isAntiAlias: isAntiAlias,
      filterQuality: filterQuality,
    );
  }

  @override
  void updateRenderObject(BuildContext context, RenderImage renderObject) {
    assert(
      image?.debugGetOpenHandleStackTraces()?.isNotEmpty ?? true,
      'Creator of a RawImage disposed of the image when the RawImage still '
      'needed it.',
    );
    renderObject
      ..image = image?.clone()
      ..debugImageLabel = debugImageLabel
      ..width = width
      ..height = height
      ..scale = scale
      ..color = color
      ..opacity = opacity
      ..colorBlendMode = colorBlendMode
      ..fit = fit
      ..alignment = alignment
      ..repeat = repeat
      ..centerSlice = centerSlice
      ..matchTextDirection = matchTextDirection
      ..textDirection = matchTextDirection || alignment is! Alignment ? Directionality.of(context) : null
      ..invertColors = invertColors
      ..isAntiAlias = isAntiAlias
      ..filterQuality = filterQuality;
  }

  @override
  void didUnmountRenderObject(RenderImage renderObject) {
    // Have the render object dispose its image handle.
    renderObject.image = null;
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<ui.Image>('image', image));
    properties.add(DoubleProperty('width', width, defaultValue: null));
    properties.add(DoubleProperty('height', height, defaultValue: null));
    properties.add(DoubleProperty('scale', scale, defaultValue: 1.0));
    properties.add(ColorProperty('color', color, defaultValue: null));
    properties.add(DiagnosticsProperty<Animation<double>?>('opacity', opacity, defaultValue: null));
    properties.add(EnumProperty<BlendMode>('colorBlendMode', colorBlendMode, defaultValue: null));
    properties.add(EnumProperty<BoxFit>('fit', fit, defaultValue: null));
    properties.add(DiagnosticsProperty<AlignmentGeometry>('alignment', alignment, defaultValue: null));
    properties.add(EnumProperty<ImageRepeat>('repeat', repeat, defaultValue: ImageRepeat.noRepeat));
    properties.add(DiagnosticsProperty<Rect>('centerSlice', centerSlice, defaultValue: null));
    properties.add(FlagProperty('matchTextDirection', value: matchTextDirection, ifTrue: 'match text direction'));
    properties.add(DiagnosticsProperty<bool>('invertColors', invertColors));
    properties.add(EnumProperty<FilterQuality>('filterQuality', filterQuality));
  }
}

/// A widget that determines the default asset bundle for its descendants.
///
/// For example, used by [Image] to determine which bundle to use for
/// [AssetImage]s if no bundle is specified explicitly.
///
/// {@tool snippet}
///
/// This can be used in tests to override what the current asset bundle is, thus
/// allowing specific resources to be injected into the widget under test.
///
/// For example, a test could create a test asset bundle like this:
///
/// ```dart
/// class TestAssetBundle extends CachingAssetBundle {
///   @override
///   Future<ByteData> load(String key) async {
///     if (key == 'resources/test') {
///       return ByteData.view(Uint8List.fromList(utf8.encode('Hello World!')).buffer);
///     }
///     return ByteData(0);
///   }
/// }
/// ```
/// {@end-tool}
/// {@tool snippet}
///
/// ...then wrap the widget under test with a [DefaultAssetBundle] using this
/// bundle implementation:
///
/// ```dart
/// // continuing from previous example...
/// await tester.pumpWidget(
///   MaterialApp(
///     home: DefaultAssetBundle(
///       bundle: TestAssetBundle(),
///       child: const TestWidget(),
///     ),
///   ),
/// );
/// ```
/// {@end-tool}
///
/// Assuming that `TestWidget` uses [DefaultAssetBundle.of] to obtain its
/// [AssetBundle], it will now see the `TestAssetBundle`'s "Hello World!" data
/// when requesting the "resources/test" asset.
///
/// See also:
///
///  * [AssetBundle], the interface for asset bundles.
///  * [rootBundle], the default asset bundle.
class DefaultAssetBundle extends InheritedWidget {
  /// Creates a widget that determines the default asset bundle for its descendants.
  ///
  /// The [bundle] and [child] arguments must not be null.
  const DefaultAssetBundle({
    super.key,
    required this.bundle,
    required super.child,
  });

  /// The bundle to use as a default.
  final AssetBundle bundle;

  /// The bundle from the closest instance of this class that encloses
  /// the given context.
  ///
  /// If there is no [DefaultAssetBundle] ancestor widget in the tree
  /// at the given context, then this will return the [rootBundle].
  ///
  /// Typical usage is as follows:
  ///
  /// ```dart
  /// AssetBundle bundle = DefaultAssetBundle.of(context);
  /// ```
  static AssetBundle of(BuildContext context) {
    final DefaultAssetBundle? result = context.dependOnInheritedWidgetOfExactType<DefaultAssetBundle>();
    return result?.bundle ?? rootBundle;
  }

  @override
  bool updateShouldNotify(DefaultAssetBundle oldWidget) => bundle != oldWidget.bundle;
}

/// An adapter for placing a specific [RenderBox] in the widget tree.
///
/// A given render object can be placed at most once in the widget tree. This
/// widget enforces that restriction by keying itself using a [GlobalObjectKey]
/// for the given render object.
///
/// This widget will call [RenderObject.dispose] on the [renderBox] when it is
/// unmounted. After that point, the [renderBox] will be unusable. If any
/// children have been added to the [renderBox], they must be disposed in the
/// [onUnmount] callback.
class WidgetToRenderBoxAdapter extends LeafRenderObjectWidget {
  /// Creates an adapter for placing a specific [RenderBox] in the widget tree.
  ///
  /// The [renderBox] argument must not be null.
  WidgetToRenderBoxAdapter({
    required this.renderBox,
    this.onBuild,
    this.onUnmount,
  }) : super(key: GlobalObjectKey(renderBox));

  /// The render box to place in the widget tree.
  ///
  /// This widget takes ownership of the render object. When it is unmounted,
  /// it also calls [RenderObject.dispose].
  final RenderBox renderBox;

  /// Called when it is safe to update the render box and its descendants. If
  /// you update the RenderObject subtree under this widget outside of
  /// invocations of this callback, features like hit-testing will fail as the
  /// tree will be dirty.
  final VoidCallback? onBuild;

  /// Called when it is safe to dispose of children that were manually added to
  /// the [renderBox].
  ///
  /// Do not dispose the [renderBox] itself, as it will be disposed by the
  /// framework automatically. However, during that process the framework will
  /// check that all children of the [renderBox] have also been disposed.
  /// Typically, child [RenderObject]s are disposed by corresponding [Element]s
  /// when they are unmounted. However, child render objects that were manually
  /// added do not have corresponding [Element]s to manage their lifecycle, and
  /// need to be manually disposed here.
  ///
  /// See also:
  ///
  ///   * [RenderObjectElement.unmount], which invokes this callback before
  ///     disposing of its render object.
  ///   * [RenderObject.dispose], which instructs a render object to release
  ///     any resources it may be holding.
  final VoidCallback? onUnmount;

  @override
  RenderBox createRenderObject(BuildContext context) => renderBox;

  @override
  void updateRenderObject(BuildContext context, RenderBox renderObject) {
    onBuild?.call();
  }

  @override
  void didUnmountRenderObject(RenderObject renderObject) {
    assert(renderObject == renderBox);
    onUnmount?.call();
  }
}


// EVENT HANDLING

/// A widget that calls callbacks in response to common pointer events.
///
/// It listens to events that can construct gestures, such as when the
/// pointer is pressed, moved, then released or canceled.
///
/// It does not listen to events that are exclusive to mouse, such as when the
/// mouse enters, exits or hovers a region without pressing any buttons. For
/// these events, use [MouseRegion].
///
/// Rather than listening for raw pointer events, consider listening for
/// higher-level gestures using [GestureDetector].
///
/// ## Layout behavior
///
/// _See [BoxConstraints] for an introduction to box layout models._
///
/// If it has a child, this widget defers to the child for sizing behavior. If
/// it does not have a child, it grows to fit the parent instead.
///
/// {@tool dartpad}
/// This example makes a [Container] react to being touched, showing a count of
/// the number of pointer downs and ups.
///
/// ** See code in examples/api/lib/widgets/basic/listener.0.dart **
/// {@end-tool}
class Listener extends SingleChildRenderObjectWidget {
  /// Creates a widget that forwards point events to callbacks.
  ///
  /// The [behavior] argument defaults to [HitTestBehavior.deferToChild].
  const Listener({
    super.key,
    this.onPointerDown,
    this.onPointerMove,
    this.onPointerUp,
    this.onPointerHover,
    this.onPointerCancel,
    this.onPointerPanZoomStart,
    this.onPointerPanZoomUpdate,
    this.onPointerPanZoomEnd,
    this.onPointerSignal,
    this.behavior = HitTestBehavior.deferToChild,
    super.child,
  });

  /// Called when a pointer comes into contact with the screen (for touch
  /// pointers), or has its button pressed (for mouse pointers) at this widget's
  /// location.
  final PointerDownEventListener? onPointerDown;

  /// Called when a pointer that triggered an [onPointerDown] changes position.
  final PointerMoveEventListener? onPointerMove;

  /// Called when a pointer that triggered an [onPointerDown] is no longer in
  /// contact with the screen.
  final PointerUpEventListener? onPointerUp;

  /// Called when a pointer that has not triggered an [onPointerDown] changes
  /// position.
  ///
  /// This is only fired for pointers which report their location when not down
  /// (e.g. mouse pointers, but not most touch pointers).
  final PointerHoverEventListener? onPointerHover;

  /// Called when the input from a pointer that triggered an [onPointerDown] is
  /// no longer directed towards this receiver.
  final PointerCancelEventListener? onPointerCancel;

  /// Called when a pan/zoom begins such as from a trackpad gesture.
  final PointerPanZoomStartEventListener? onPointerPanZoomStart;

  /// Called when a pan/zoom is updated.
  final PointerPanZoomUpdateEventListener? onPointerPanZoomUpdate;

  /// Called when a pan/zoom finishes.
  final PointerPanZoomEndEventListener? onPointerPanZoomEnd;

  /// Called when a pointer signal occurs over this object.
  ///
  /// See also:
  ///
  ///  * [PointerSignalEvent], which goes into more detail on pointer signal
  ///    events.
  final PointerSignalEventListener? onPointerSignal;

  /// How to behave during hit testing.
  final HitTestBehavior behavior;

  @override
  RenderPointerListener createRenderObject(BuildContext context) {
    return RenderPointerListener(
      onPointerDown: onPointerDown,
      onPointerMove: onPointerMove,
      onPointerUp: onPointerUp,
      onPointerHover: onPointerHover,
      onPointerCancel: onPointerCancel,
      onPointerPanZoomStart: onPointerPanZoomStart,
      onPointerPanZoomUpdate: onPointerPanZoomUpdate,
      onPointerPanZoomEnd: onPointerPanZoomEnd,
      onPointerSignal: onPointerSignal,
      behavior: behavior,
    );
  }

  @override
  void updateRenderObject(BuildContext context, RenderPointerListener renderObject) {
    renderObject
      ..onPointerDown = onPointerDown
      ..onPointerMove = onPointerMove
      ..onPointerUp = onPointerUp
      ..onPointerHover = onPointerHover
      ..onPointerCancel = onPointerCancel
      ..onPointerPanZoomStart = onPointerPanZoomStart
      ..onPointerPanZoomUpdate = onPointerPanZoomUpdate
      ..onPointerPanZoomEnd = onPointerPanZoomEnd
      ..onPointerSignal = onPointerSignal
      ..behavior = behavior;
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    final List<String> listeners = <String>[
      if (onPointerDown != null) 'down',
      if (onPointerMove != null) 'move',
      if (onPointerUp != null) 'up',
      if (onPointerHover != null) 'hover',
      if (onPointerCancel != null) 'cancel',
      if (onPointerPanZoomStart != null) 'panZoomStart',
      if (onPointerPanZoomUpdate != null) 'panZoomUpdate',
      if (onPointerPanZoomEnd != null) 'panZoomEnd',
      if (onPointerSignal != null) 'signal',
    ];
    properties.add(IterableProperty<String>('listeners', listeners, ifEmpty: '<none>'));
    properties.add(EnumProperty<HitTestBehavior>('behavior', behavior));
  }
}

/// A widget that tracks the movement of mice.
///
/// {@youtube 560 315 https://www.youtube.com/watch?v=1oF3pI5umck}
///
/// [MouseRegion] is used
/// when it is needed to compare the list of objects that a mouse pointer is
/// hovering over between this frame and the last frame. This means entering
/// events, exiting events, and mouse cursors.
///
/// To listen to general pointer events, use [Listener], or more preferably,
/// [GestureDetector].
///
/// ## Layout behavior
///
/// _See [BoxConstraints] for an introduction to box layout models._
///
/// If it has a child, this widget defers to the child for sizing behavior. If
/// it does not have a child, it grows to fit the parent instead.
///
/// {@tool dartpad}
/// This example makes a [Container] react to being entered by a mouse
/// pointer, showing a count of the number of entries and exits.
///
/// ** See code in examples/api/lib/widgets/basic/mouse_region.0.dart **
/// {@end-tool}
///
/// See also:
///
///  * [Listener], a similar widget that tracks pointer events when the pointer
///    has buttons pressed.
class MouseRegion extends SingleChildRenderObjectWidget {
  /// Creates a widget that forwards mouse events to callbacks.
  ///
  /// By default, all callbacks are empty, [cursor] is [MouseCursor.defer], and
  /// [opaque] is true. The [cursor] must not be null.
  const MouseRegion({
    super.key,
    this.onEnter,
    this.onExit,
    this.onHover,
    this.cursor = MouseCursor.defer,
    this.opaque = true,
    this.hitTestBehavior,
    super.child,
  });

  /// Triggered when a mouse pointer has entered this widget.
  ///
  /// This callback is triggered when the pointer, with or without buttons
  /// pressed, has started to be contained by the region of this widget. More
  /// specifically, the callback is triggered by the following cases:
  ///
  ///  * This widget has appeared under a pointer.
  ///  * This widget has moved to under a pointer.
  ///  * A new pointer has been added to somewhere within this widget.
  ///  * An existing pointer has moved into this widget.
  ///
  /// This callback is not always matched by an [onExit]. If the [MouseRegion]
  /// is unmounted while being hovered by a pointer, the [onExit] of the widget
  /// callback will never called. For more details, see [onExit].
  ///
  /// {@template flutter.widgets.MouseRegion.onEnter.triggerTime}
  /// The time that this callback is triggered is always between frames: either
  /// during the post-frame callbacks, or during the callback of a pointer
  /// event.
  /// {@endtemplate}
  ///
  /// See also:
  ///
  ///  * [onExit], which is triggered when a mouse pointer exits the region.
  ///  * [MouseTrackerAnnotation.onEnter], which is how this callback is
  ///    internally implemented.
  final PointerEnterEventListener? onEnter;

  /// Triggered when a pointer moves into a position within this widget without
  /// buttons pressed.
  ///
  /// Usually this is only fired for pointers which report their location when
  /// not down (e.g. mouse pointers). Certain devices also fire this event on
  /// single taps in accessibility mode.
  ///
  /// This callback is not triggered by the movement of the widget.
  ///
  /// The time that this callback is triggered is during the callback of a
  /// pointer event, which is always between frames.
  ///
  /// See also:
  ///
  ///  * [Listener.onPointerHover], which does the same job. Prefer using
  ///    [Listener.onPointerHover], since hover events are similar to other regular
  ///    events.
  final PointerHoverEventListener? onHover;

  /// Triggered when a mouse pointer has exited this widget when the widget is
  /// still mounted.
  ///
  /// This callback is triggered when the pointer, with or without buttons
  /// pressed, has stopped being contained by the region of this widget, except
  /// when the exit is caused by the disappearance of this widget. More
  /// specifically, this callback is triggered by the following cases:
  ///
  ///  * A pointer that is hovering this widget has moved away.
  ///  * A pointer that is hovering this widget has been removed.
  ///  * This widget, which is being hovered by a pointer, has moved away.
  ///
  /// And is __not__ triggered by the following case:
  ///
  ///  * This widget, which is being hovered by a pointer, has disappeared.
  ///
  /// This means that a [MouseRegion.onExit] might not be matched by a
  /// [MouseRegion.onEnter].
  ///
  /// This restriction aims to prevent a common misuse: if [State.setState] is
  /// called during [MouseRegion.onExit] without checking whether the widget is
  /// still mounted, an exception will occur. This is because the callback is
  /// triggered during the post-frame phase, at which point the widget has been
  /// unmounted. Since [State.setState] is exclusive to widgets, the restriction
  /// is specific to [MouseRegion], and does not apply to its lower-level
  /// counterparts, [RenderMouseRegion] and [MouseTrackerAnnotation].
  ///
  /// There are a few ways to mitigate this restriction:
  ///
  ///  * If the hover state is completely contained within a widget that
  ///    unconditionally creates this [MouseRegion], then this will not be a
  ///    concern, since after the [MouseRegion] is unmounted the state is no
  ///    longer used.
  ///  * Otherwise, the outer widget very likely has access to the variable that
  ///    controls whether this [MouseRegion] is present. If so, call [onExit] at
  ///    the event that turns the condition from true to false.
  ///  * In cases where the solutions above won't work, you can always
  ///    override [State.dispose] and call [onExit], or create your own widget
  ///    using [RenderMouseRegion].
  ///
  /// {@tool dartpad}
  /// The following example shows a blue rectangular that turns yellow when
  /// hovered. Since the hover state is completely contained within a widget
  /// that unconditionally creates the `MouseRegion`, you can ignore the
  /// aforementioned restriction.
  ///
  /// ** See code in examples/api/lib/widgets/basic/mouse_region.on_exit.0.dart **
  /// {@end-tool}
  ///
  /// {@tool dartpad}
  /// The following example shows a widget that hides its content one second
  /// after being hovered, and also exposes the enter and exit callbacks.
  /// Because the widget conditionally creates the `MouseRegion`, and leaks the
  /// hover state, it needs to take the restriction into consideration. In this
  /// case, since it has access to the event that triggers the disappearance of
  /// the `MouseRegion`, it triggers the exit callback during that event
  /// as well.
  ///
  /// ** See code in examples/api/lib/widgets/basic/mouse_region.on_exit.1.dart **
  /// {@end-tool}
  ///
  /// {@macro flutter.widgets.MouseRegion.onEnter.triggerTime}
  ///
  /// See also:
  ///
  ///  * [onEnter], which is triggered when a mouse pointer enters the region.
  ///  * [RenderMouseRegion] and [MouseTrackerAnnotation.onExit], which are how
  ///    this callback is internally implemented, but without the restriction.
  final PointerExitEventListener? onExit;

  /// The mouse cursor for mouse pointers that are hovering over the region.
  ///
  /// When a mouse enters the region, its cursor will be changed to the [cursor].
  /// When the mouse leaves the region, the cursor will be decided by the region
  /// found at the new location.
  ///
  /// The [cursor] defaults to [MouseCursor.defer], deferring the choice of
  /// cursor to the next region behind it in hit-test order.
  final MouseCursor cursor;

  /// Whether this widget should prevent other [MouseRegion]s visually behind it
  /// from detecting the pointer.
  ///
  /// This changes the list of regions that a pointer hovers, thus affecting how
  /// their [onHover], [onEnter], [onExit], and [cursor] behave.
  ///
  /// If [opaque] is true, this widget will absorb the mouse pointer and
  /// prevent this widget's siblings (or any other widgets that are not
  /// ancestors or descendants of this widget) from detecting the mouse
  /// pointer even when the pointer is within their areas.
  ///
  /// If [opaque] is false, this object will not affect how [MouseRegion]s
  /// behind it behave, which will detect the mouse pointer as long as the
  /// pointer is within their areas.
  ///
  /// This defaults to true.
  final bool opaque;

  /// How to behave during hit testing.
  ///
  /// This defaults to [HitTestBehavior.opaque] if null.
  final HitTestBehavior? hitTestBehavior;

  @override
  RenderMouseRegion createRenderObject(BuildContext context) {
    return RenderMouseRegion(
      onEnter: onEnter,
      onHover: onHover,
      onExit: onExit,
      cursor: cursor,
      opaque: opaque,
      hitTestBehavior: hitTestBehavior,
    );
  }

  @override
  void updateRenderObject(BuildContext context, RenderMouseRegion renderObject) {
    renderObject
      ..onEnter = onEnter
      ..onHover = onHover
      ..onExit = onExit
      ..cursor = cursor
      ..opaque = opaque
      ..hitTestBehavior = hitTestBehavior;
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    final List<String> listeners = <String>[];
    if (onEnter != null) {
      listeners.add('enter');
    }
    if (onExit != null) {
      listeners.add('exit');
    }
    if (onHover != null) {
      listeners.add('hover');
    }
    properties.add(IterableProperty<String>('listeners', listeners, ifEmpty: '<none>'));
    properties.add(DiagnosticsProperty<MouseCursor>('cursor', cursor, defaultValue: null));
    properties.add(DiagnosticsProperty<bool>('opaque', opaque, defaultValue: true));
  }
}

/// A widget that creates a separate display list for its child.
///
/// {@youtube 560 315 https://www.youtube.com/watch?v=cVAGLDuc2xE}
///
/// This widget creates a separate display list for its child, which
/// can improve performance if the subtree repaints at different times than
/// the surrounding parts of the tree.
///
/// This is useful since [RenderObject.paint] may be triggered even if its
/// associated [Widget] instances did not change or rebuild. A [RenderObject]
/// will repaint whenever any [RenderObject] that shares the same [Layer] is
/// marked as being dirty and needing paint (see [RenderObject.markNeedsPaint]),
/// such as when an ancestor scrolls or when an ancestor or descendant animates.
///
/// Containing [RenderObject.paint] to parts of the render subtree that are
/// actually visually changing using [RepaintBoundary] explicitly or implicitly
/// is therefore critical to minimizing redundant work and improving the app's
/// performance.
///
/// When a [RenderObject] is flagged as needing to paint via
/// [RenderObject.markNeedsPaint], the nearest ancestor [RenderObject] with
/// [RenderObject.isRepaintBoundary], up to possibly the root of the application,
/// is requested to repaint. That nearest ancestor's [RenderObject.paint] method
/// will cause _all_ of its descendant [RenderObject]s to repaint in the same
/// layer.
///
/// [RepaintBoundary] is therefore used, both while propagating the
/// `markNeedsPaint` flag up the render tree and while traversing down the
/// render tree via [PaintingContext.paintChild], to strategically contain
/// repaints to the render subtree that visually changed for performance. This
/// is done because the [RepaintBoundary] widget creates a [RenderObject] that
/// always has a [Layer], decoupling ancestor render objects from the descendant
/// render objects.
///
/// [RepaintBoundary] has the further side-effect of possibly hinting to the
/// engine that it should further optimize animation performance if the render
/// subtree behind the [RepaintBoundary] is sufficiently complex and is static
/// while the surrounding tree changes frequently. In those cases, the engine
/// may choose to pay a one time cost of rasterizing and caching the pixel
/// values of the subtree for faster future GPU re-rendering speed.
///
/// Several framework widgets insert [RepaintBoundary] widgets to mark natural
/// separation points in applications. For instance, contents in Material Design
/// drawers typically don't change while the drawer opens and closes, so
/// repaints are automatically contained to regions inside or outside the drawer
/// when using the [Drawer] widget during transitions.
///
/// See also:
///
///  * [debugRepaintRainbowEnabled], a debugging flag to help visually monitor
///    render tree repaints in a running app.
///  * [debugProfilePaintsEnabled], a debugging flag to show render tree
///    repaints in the observatory's timeline view.
class RepaintBoundary extends SingleChildRenderObjectWidget {
  /// Creates a widget that isolates repaints.
  const RepaintBoundary({ super.key, super.child });

  /// Wraps the given child in a [RepaintBoundary].
  ///
  /// The key for the [RepaintBoundary] is derived either from the child's key
  /// (if the child has a non-null key) or from the given `childIndex`.
  factory RepaintBoundary.wrap(Widget child, int childIndex) {
    final Key key = child.key != null ? ValueKey<Key>(child.key!) : ValueKey<int>(childIndex);
    return RepaintBoundary(key: key, child: child);
  }

  /// Wraps each of the given children in [RepaintBoundary]s.
  ///
  /// The key for each [RepaintBoundary] is derived either from the wrapped
  /// child's key (if the wrapped child has a non-null key) or from the wrapped
  /// child's index in the list.
  static List<RepaintBoundary> wrapAll(List<Widget> widgets) => <RepaintBoundary>[
    for (int i = 0; i < widgets.length; ++i) RepaintBoundary.wrap(widgets[i], i),
  ];

  @override
  RenderRepaintBoundary createRenderObject(BuildContext context) => RenderRepaintBoundary();
}

/// A widget that is invisible during hit testing.
///
/// When [ignoring] is true, this widget (and its subtree) is invisible
/// to hit testing. It still consumes space during layout and paints its child
/// as usual. It just cannot be the target of located events, because it returns
/// false from [RenderBox.hitTest].
///
/// When [ignoringSemantics] is true, the subtree will be invisible to
/// the semantics layer (and thus e.g. accessibility tools). If
/// [ignoringSemantics] is null, it uses the value of [ignoring].
///
/// {@youtube 560 315 https://www.youtube.com/watch?v=qV9pqHWxYgI}
///
/// {@tool dartpad}
/// The following sample has an [IgnorePointer] widget wrapping the `Column`
/// which contains a button.
/// When [ignoring] is set to `true` anything inside the `Column` can
/// not be tapped. When [ignoring] is set to `false` anything
/// inside the `Column` can be tapped.
///
/// ** See code in examples/api/lib/widgets/basic/ignore_pointer.0.dart **
/// {@end-tool}
///
/// See also:
///
///  * [AbsorbPointer], which also prevents its children from receiving pointer
///    events but is itself visible to hit testing.
///  * [SliverIgnorePointer], the sliver version of this widget.
class IgnorePointer extends SingleChildRenderObjectWidget {
  /// Creates a widget that is invisible to hit testing.
  ///
  /// The [ignoring] argument must not be null. If [ignoringSemantics] is null,
  /// this render object will be ignored for semantics if [ignoring] is true.
  const IgnorePointer({
    super.key,
    this.ignoring = true,
    this.ignoringSemantics,
    super.child,
  });

  /// Whether this widget is ignored during hit testing.
  ///
  /// Regardless of whether this widget is ignored during hit testing, it will
  /// still consume space during layout and be visible during painting.
  final bool ignoring;

  /// Whether the semantics of this widget is ignored when compiling the semantics tree.
  ///
  /// If null, defaults to value of [ignoring].
  ///
  /// See [SemanticsNode] for additional information about the semantics tree.
  final bool? ignoringSemantics;

  @override
  RenderIgnorePointer createRenderObject(BuildContext context) {
    return RenderIgnorePointer(
      ignoring: ignoring,
      ignoringSemantics: ignoringSemantics,
    );
  }

  @override
  void updateRenderObject(BuildContext context, RenderIgnorePointer renderObject) {
    renderObject
      ..ignoring = ignoring
      ..ignoringSemantics = ignoringSemantics;
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<bool>('ignoring', ignoring));
    properties.add(DiagnosticsProperty<bool>('ignoringSemantics', ignoringSemantics, defaultValue: null));
  }
}

/// A widget that absorbs pointers during hit testing.
///
/// When [absorbing] is true, this widget prevents its subtree from receiving
/// pointer events by terminating hit testing at itself. It still consumes space
/// during layout and paints its child as usual. It just prevents its children
/// from being the target of located events, because it returns true from
/// [RenderBox.hitTest].
///
/// {@youtube 560 315 https://www.youtube.com/watch?v=65HoWqBboI8}
///
/// {@tool dartpad}
/// The following sample has an [AbsorbPointer] widget wrapping the button on
/// top of the stack, which absorbs pointer events, preventing its child button
/// __and__ the button below it in the stack from receiving the pointer events.
///
/// ** See code in examples/api/lib/widgets/basic/absorb_pointer.0.dart **
/// {@end-tool}
///
/// See also:
///
///  * [IgnorePointer], which also prevents its children from receiving pointer
///    events but is itself invisible to hit testing.
class AbsorbPointer extends SingleChildRenderObjectWidget {
  /// Creates a widget that absorbs pointers during hit testing.
  ///
  /// The [absorbing] argument must not be null.
  const AbsorbPointer({
    super.key,
    this.absorbing = true,
    super.child,
    this.ignoringSemantics,
  });

  /// Whether this widget absorbs pointers during hit testing.
  ///
  /// Regardless of whether this render object absorbs pointers during hit
  /// testing, it will still consume space during layout and be visible during
  /// painting.
  final bool absorbing;

  /// Whether the semantics of this render object is ignored when compiling the
  /// semantics tree.
  ///
  /// If null, defaults to the value of [absorbing].
  ///
  /// See [SemanticsNode] for additional information about the semantics tree.
  final bool? ignoringSemantics;

  @override
  RenderAbsorbPointer createRenderObject(BuildContext context) {
    return RenderAbsorbPointer(
      absorbing: absorbing,
      ignoringSemantics: ignoringSemantics,
    );
  }

  @override
  void updateRenderObject(BuildContext context, RenderAbsorbPointer renderObject) {
    renderObject
      ..absorbing = absorbing
      ..ignoringSemantics = ignoringSemantics;
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<bool>('absorbing', absorbing));
    properties.add(DiagnosticsProperty<bool>('ignoringSemantics', ignoringSemantics, defaultValue: null));
  }
}

/// Holds opaque meta data in the render tree.
///
/// Useful for decorating the render tree with information that will be consumed
/// later. For example, you could store information in the render tree that will
/// be used when the user interacts with the render tree but has no visual
/// impact prior to the interaction.
class MetaData extends SingleChildRenderObjectWidget {
  /// Creates a widget that hold opaque meta data.
  ///
  /// The [behavior] argument defaults to [HitTestBehavior.deferToChild].
  const MetaData({
    super.key,
    this.metaData,
    this.behavior = HitTestBehavior.deferToChild,
    super.child,
  });

  /// Opaque meta data ignored by the render tree.
  final dynamic metaData;

  /// How to behave during hit testing.
  final HitTestBehavior behavior;

  @override
  RenderMetaData createRenderObject(BuildContext context) {
    return RenderMetaData(
      metaData: metaData,
      behavior: behavior,
    );
  }

  @override
  void updateRenderObject(BuildContext context, RenderMetaData renderObject) {
    renderObject
      ..metaData = metaData
      ..behavior = behavior;
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(EnumProperty<HitTestBehavior>('behavior', behavior));
    properties.add(DiagnosticsProperty<dynamic>('metaData', metaData));
  }
}


// UTILITY NODES

/// A widget that annotates the widget tree with a description of the meaning of
/// the widgets.
///
/// Used by assistive technologies, search engines, and other semantic analysis
/// software to determine the meaning of the application.
///
/// {@youtube 560 315 https://www.youtube.com/watch?v=NvtMt_DtFrQ}
///
/// See also:
///
///  * [MergeSemantics], which marks a subtree as being a single node for
///    accessibility purposes.
///  * [ExcludeSemantics], which excludes a subtree from the semantics tree
///    (which might be useful if it is, e.g., totally decorative and not
///    important to the user).
///  * [RenderObject.describeSemanticsConfiguration], the rendering library API
///    through which the [Semantics] widget is actually implemented.
///  * [SemanticsNode], the object used by the rendering library to represent
///    semantics in the semantics tree.
///  * [SemanticsDebugger], an overlay to help visualize the semantics tree. Can
///    be enabled using [WidgetsApp.showSemanticsDebugger] or
///    [MaterialApp.showSemanticsDebugger].
@immutable
class Semantics extends SingleChildRenderObjectWidget {
  /// Creates a semantic annotation.
  ///
  /// The [container] argument must not be null. To create a `const` instance
  /// of [Semantics], use the [Semantics.fromProperties] constructor.
  ///
  /// See also:
  ///
  ///  * [SemanticsSortKey] for a class that determines accessibility traversal
  ///    order.
  Semantics({
    Key? key,
    Widget? child,
    bool container = false,
    bool explicitChildNodes = false,
    bool excludeSemantics = false,
    bool? enabled,
    bool? checked,
    bool? mixed,
    bool? selected,
    bool? toggled,
    bool? button,
    bool? slider,
    bool? keyboardKey,
    bool? link,
    bool? header,
    bool? textField,
    bool? readOnly,
    bool? focusable,
    bool? focused,
    bool? inMutuallyExclusiveGroup,
    bool? obscured,
    bool? multiline,
    bool? scopesRoute,
    bool? namesRoute,
    bool? hidden,
    bool? image,
    bool? liveRegion,
    int? maxValueLength,
    int? currentValueLength,
    String? label,
    AttributedString? attributedLabel,
    String? value,
    AttributedString? attributedValue,
    String? increasedValue,
    AttributedString? attributedIncreasedValue,
    String? decreasedValue,
    AttributedString? attributedDecreasedValue,
    String? hint,
    AttributedString? attributedHint,
    String? tooltip,
    String? onTapHint,
    String? onLongPressHint,
    TextDirection? textDirection,
    SemanticsSortKey? sortKey,
    SemanticsTag? tagForChildren,
    VoidCallback? onTap,
    VoidCallback? onLongPress,
    VoidCallback? onScrollLeft,
    VoidCallback? onScrollRight,
    VoidCallback? onScrollUp,
    VoidCallback? onScrollDown,
    VoidCallback? onIncrease,
    VoidCallback? onDecrease,
    VoidCallback? onCopy,
    VoidCallback? onCut,
    VoidCallback? onPaste,
    VoidCallback? onDismiss,
    MoveCursorHandler? onMoveCursorForwardByCharacter,
    MoveCursorHandler? onMoveCursorBackwardByCharacter,
    SetSelectionHandler? onSetSelection,
    SetTextHandler? onSetText,
    VoidCallback? onDidGainAccessibilityFocus,
    VoidCallback? onDidLoseAccessibilityFocus,
    Map<CustomSemanticsAction, VoidCallback>? customSemanticsActions,
  }) : this.fromProperties(
    key: key,
    child: child,
    container: container,
    explicitChildNodes: explicitChildNodes,
    excludeSemantics: excludeSemantics,
    properties: SemanticsProperties(
      enabled: enabled,
      checked: checked,
      mixed: mixed,
      toggled: toggled,
      selected: selected,
      button: button,
      slider: slider,
      keyboardKey: keyboardKey,
      link: link,
      header: header,
      textField: textField,
      readOnly: readOnly,
      focusable: focusable,
      focused: focused,
      inMutuallyExclusiveGroup: inMutuallyExclusiveGroup,
      obscured: obscured,
      multiline: multiline,
      scopesRoute: scopesRoute,
      namesRoute: namesRoute,
      hidden: hidden,
      image: image,
      liveRegion: liveRegion,
      maxValueLength: maxValueLength,
      currentValueLength: currentValueLength,
      label: label,
      attributedLabel: attributedLabel,
      value: value,
      attributedValue: attributedValue,
      increasedValue: increasedValue,
      attributedIncreasedValue: attributedIncreasedValue,
      decreasedValue: decreasedValue,
      attributedDecreasedValue: attributedDecreasedValue,
      hint: hint,
      attributedHint: attributedHint,
      tooltip: tooltip,
      textDirection: textDirection,
      sortKey: sortKey,
      tagForChildren: tagForChildren,
      onTap: onTap,
      onLongPress: onLongPress,
      onScrollLeft: onScrollLeft,
      onScrollRight: onScrollRight,
      onScrollUp: onScrollUp,
      onScrollDown: onScrollDown,
      onIncrease: onIncrease,
      onDecrease: onDecrease,
      onCopy: onCopy,
      onCut: onCut,
      onPaste: onPaste,
      onMoveCursorForwardByCharacter: onMoveCursorForwardByCharacter,
      onMoveCursorBackwardByCharacter: onMoveCursorBackwardByCharacter,
      onDidGainAccessibilityFocus: onDidGainAccessibilityFocus,
      onDidLoseAccessibilityFocus: onDidLoseAccessibilityFocus,
      onDismiss: onDismiss,
      onSetSelection: onSetSelection,
      onSetText: onSetText,
      customSemanticsActions: customSemanticsActions,
      hintOverrides: onTapHint != null || onLongPressHint != null ?
        SemanticsHintOverrides(
          onTapHint: onTapHint,
          onLongPressHint: onLongPressHint,
        ) : null,
    ),
  );

  /// Creates a semantic annotation using [SemanticsProperties].
  ///
  /// The [container] and [properties] arguments must not be null.
  const Semantics.fromProperties({
    super.key,
    super.child,
    this.container = false,
    this.explicitChildNodes = false,
    this.excludeSemantics = false,
    required this.properties,
  });

  /// Contains properties used by assistive technologies to make the application
  /// more accessible.
  final SemanticsProperties properties;

  /// If [container] is true, this widget will introduce a new
  /// node in the semantics tree. Otherwise, the semantics will be
  /// merged with the semantics of any ancestors (if the ancestor allows that).
  ///
  /// Whether descendants of this widget can add their semantic information to the
  /// [SemanticsNode] introduced by this configuration is controlled by
  /// [explicitChildNodes].
  final bool container;

  /// Whether descendants of this widget are allowed to add semantic information
  /// to the [SemanticsNode] annotated by this widget.
  ///
  /// When set to false descendants are allowed to annotate [SemanticsNode]s of
  /// their parent with the semantic information they want to contribute to the
  /// semantic tree.
  /// When set to true the only way for descendants to contribute semantic
  /// information to the semantic tree is to introduce new explicit
  /// [SemanticsNode]s to the tree.
  ///
  /// If the semantics properties of this node include
  /// [SemanticsProperties.scopesRoute] set to true, then [explicitChildNodes]
  /// must be true also.
  ///
  /// This setting is often used in combination with [SemanticsConfiguration.isSemanticBoundary]
  /// to create semantic boundaries that are either writable or not for children.
  final bool explicitChildNodes;

  /// Whether to replace all child semantics with this node.
  ///
  /// Defaults to false.
  ///
  /// When this flag is set to true, all child semantics nodes are ignored.
  /// This can be used as a convenience for cases where a child is wrapped in
  /// an [ExcludeSemantics] widget and then another [Semantics] widget.
  final bool excludeSemantics;

  @override
  RenderSemanticsAnnotations createRenderObject(BuildContext context) {
    return RenderSemanticsAnnotations(
      container: container,
      explicitChildNodes: explicitChildNodes,
      excludeSemantics: excludeSemantics,
      properties: properties,
      textDirection: _getTextDirection(context),
    );
  }

  TextDirection? _getTextDirection(BuildContext context) {
    if (properties.textDirection != null) {
      return properties.textDirection;
    }

    final bool containsText = properties.attributedLabel != null ||
                              properties.label != null ||
                              properties.value != null ||
                              properties.hint != null ||
                              properties.tooltip != null;

    if (!containsText) {
      return null;
    }

    return Directionality.maybeOf(context);
  }

  @override
  void updateRenderObject(BuildContext context, RenderSemanticsAnnotations renderObject) {
    renderObject
      ..container = container
      ..explicitChildNodes = explicitChildNodes
      ..excludeSemantics = excludeSemantics
      ..properties = properties
      ..textDirection = _getTextDirection(context);
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<bool>('container', container));
    properties.add(DiagnosticsProperty<SemanticsProperties>('properties', this.properties));
    this.properties.debugFillProperties(properties);
  }
}

/// A widget that merges the semantics of its descendants.
///
/// Causes all the semantics of the subtree rooted at this node to be
/// merged into one node in the semantics tree. For example, if you
/// have a widget with a Text node next to a checkbox widget, this
/// could be used to merge the label from the Text node with the
/// "checked" semantic state of the checkbox into a single node that
/// had both the label and the checked state. Otherwise, the label
/// would be presented as a separate feature than the checkbox, and
/// the user would not be able to be sure that they were related.
///
/// {@tool snippet}
/// This snippet shows how to use [MergeSemantics] to merge the semantics of
/// a [Checkbox] and [Text] widget.
///
/// ```dart
/// MergeSemantics(
///   child: Row(
///     children: <Widget>[
///       Checkbox(
///         value: true,
///         onChanged: (bool? value) {},
///       ),
///       const Text('Settings'),
///     ],
///   ),
/// )
/// ```
/// {@end-tool}
///
/// Be aware that if two nodes in the subtree have conflicting
/// semantics, the result may be nonsensical. For example, a subtree
/// with a checked checkbox and an unchecked checkbox will be
/// presented as checked. All the labels will be merged into a single
/// string (with newlines separating each label from the other). If
/// multiple nodes in the merged subtree can handle semantic gestures,
/// the first one in tree order will be the one to receive the
/// callbacks.
class MergeSemantics extends SingleChildRenderObjectWidget {
  /// Creates a widget that merges the semantics of its descendants.
  const MergeSemantics({ super.key, super.child });

  @override
  RenderMergeSemantics createRenderObject(BuildContext context) => RenderMergeSemantics();
}

/// A widget that drops the semantics of all widget that were painted before it
/// in the same semantic container.
///
/// This is useful to hide widgets from accessibility tools that are painted
/// behind a certain widget, e.g. an alert should usually disallow interaction
/// with any widget located "behind" the alert (even when they are still
/// partially visible). Similarly, an open [Drawer] blocks interactions with
/// any widget outside the drawer.
///
/// See also:
///
///  * [ExcludeSemantics] which drops all semantics of its descendants.
class BlockSemantics extends SingleChildRenderObjectWidget {
  /// Creates a widget that excludes the semantics of all widgets painted before
  /// it in the same semantic container.
  const BlockSemantics({ super.key, this.blocking = true, super.child });

  /// Whether this widget is blocking semantics of all widget that were painted
  /// before it in the same semantic container.
  final bool blocking;

  @override
  RenderBlockSemantics createRenderObject(BuildContext context) => RenderBlockSemantics(blocking: blocking);

  @override
  void updateRenderObject(BuildContext context, RenderBlockSemantics renderObject) {
    renderObject.blocking = blocking;
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<bool>('blocking', blocking));
  }
}

/// A widget that drops all the semantics of its descendants.
///
/// When [excluding] is true, this widget (and its subtree) is excluded from
/// the semantics tree.
///
/// This can be used to hide descendant widgets that would otherwise be
/// reported but that would only be confusing. For example, the
/// material library's [Chip] widget hides the avatar since it is
/// redundant with the chip label.
///
/// See also:
///
///  * [BlockSemantics] which drops semantics of widgets earlier in the tree.
class ExcludeSemantics extends SingleChildRenderObjectWidget {
  /// Creates a widget that drops all the semantics of its descendants.
  const ExcludeSemantics({
    super.key,
    this.excluding = true,
    super.child,
  });

  /// Whether this widget is excluded in the semantics tree.
  final bool excluding;

  @override
  RenderExcludeSemantics createRenderObject(BuildContext context) => RenderExcludeSemantics(excluding: excluding);

  @override
  void updateRenderObject(BuildContext context, RenderExcludeSemantics renderObject) {
    renderObject.excluding = excluding;
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<bool>('excluding', excluding));
  }
}

/// A widget that annotates the child semantics with an index.
///
/// Semantic indexes are used by TalkBack/Voiceover to make announcements about
/// the current scroll state. Certain widgets like the [ListView] will
/// automatically provide a child index for building semantics. A user may wish
/// to manually provide semantic indexes if not all child of the scrollable
/// contribute semantics.
///
/// {@tool snippet}
///
/// The example below handles spacers in a scrollable that don't contribute
/// semantics. The automatic indexes would give the spaces a semantic index,
/// causing scroll announcements to erroneously state that there are four items
/// visible.
///
/// ```dart
/// ListView(
///   addSemanticIndexes: false,
///   semanticChildCount: 2,
///   children: const <Widget>[
///     IndexedSemantics(index: 0, child: Text('First')),
///     Spacer(),
///     IndexedSemantics(index: 1, child: Text('Second')),
///     Spacer(),
///   ],
/// )
/// ```
/// {@end-tool}
///
/// See also:
///
///  * [CustomScrollView], for an explanation of index semantics.
class IndexedSemantics extends SingleChildRenderObjectWidget {
  /// Creates a widget that annotated the first child semantics node with an index.
  ///
  /// [index] must not be null.
  const IndexedSemantics({
    super.key,
    required this.index,
    super.child,
  });

  /// The index used to annotate the first child semantics node.
  final int index;

  @override
  RenderIndexedSemantics createRenderObject(BuildContext context) => RenderIndexedSemantics(index: index);

  @override
  void updateRenderObject(BuildContext context, RenderIndexedSemantics renderObject) {
    renderObject.index = index;
  }
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<int>('index', index));
  }
}

/// A widget that builds its child.
///
/// Useful for attaching a key to an existing widget.
class KeyedSubtree extends StatelessWidget {
  /// Creates a widget that builds its child.
  const KeyedSubtree({
    super.key,
    required this.child,
  });

  /// Creates a KeyedSubtree for child with a key that's based on the child's existing key or childIndex.
  factory KeyedSubtree.wrap(Widget child, int childIndex) {
    final Key key = child.key != null ? ValueKey<Key>(child.key!) : ValueKey<int>(childIndex);
    return KeyedSubtree(key: key, child: child);
  }

  /// The widget below this widget in the tree.
  ///
  /// {@macro flutter.widgets.ProxyWidget.child}
  final Widget child;

  /// Wrap each item in a KeyedSubtree whose key is based on the item's existing key or
  /// the sum of its list index and `baseIndex`.
  static List<Widget> ensureUniqueKeysForList(List<Widget> items, { int baseIndex = 0 }) {
    if (items.isEmpty) {
      return items;
    }

    final List<Widget> itemsWithUniqueKeys = <Widget>[];
    int itemIndex = baseIndex;
    for (final Widget item in items) {
      itemsWithUniqueKeys.add(KeyedSubtree.wrap(item, itemIndex));
      itemIndex += 1;
    }

    assert(!debugItemsHaveDuplicateKeys(itemsWithUniqueKeys));
    return itemsWithUniqueKeys;
  }

  @override
  Widget build(BuildContext context) => child;
}

/// A stateless utility widget whose [build] method uses its
/// [builder] callback to create the widget's child.
///
/// {@youtube 560 315 https://www.youtube.com/watch?v=xXNOkIuSYuA}
///
/// This widget is an inline alternative to defining a [StatelessWidget]
/// subclass. For example, instead of defining a widget as follows:
///
/// ```dart
/// class Foo extends StatelessWidget {
///   const Foo({super.key});
///   @override
///   Widget build(BuildContext context) => const Text('foo');
/// }
/// ```
///
/// ...and using it in the usual way:
///
/// ```dart
/// // continuing from previous example...
/// const Center(child: Foo())
/// ```
///
/// ...one could instead define and use it in a single step, without
/// defining a new widget class:
///
/// ```dart
/// Center(
///   child: Builder(
///     builder: (BuildContext context) => const Text('foo'),
///   ),
/// )
/// ```
///
/// The difference between either of the previous examples and
/// creating a child directly without an intervening widget, is the
/// extra [BuildContext] element that the additional widget adds. This
/// is particularly noticeable when the tree contains an inherited
/// widget that is referred to by a method like [Scaffold.of],
/// which visits the child widget's BuildContext ancestors.
///
/// In the following example the button's `onPressed` callback is unable
/// to find the enclosing [ScaffoldState] with [Scaffold.of]:
///
/// ```dart
/// Widget build(BuildContext context) {
///   return Scaffold(
///     body: Center(
///       child: TextButton(
///         onPressed: () {
///           // Fails because Scaffold.of() doesn't find anything
///           // above this widget's context.
///           print(Scaffold.of(context).hasAppBar);
///         },
///         child: const Text('hasAppBar'),
///       )
///     ),
///   );
/// }
/// ```
///
/// A [Builder] widget introduces an additional [BuildContext] element
/// and so the [Scaffold.of] method succeeds.
///
/// ```dart
/// Widget build(BuildContext context) {
///   return Scaffold(
///     body: Builder(
///       builder: (BuildContext context) {
///         return Center(
///           child: TextButton(
///             onPressed: () {
///               print(Scaffold.of(context).hasAppBar);
///             },
///             child: const Text('hasAppBar'),
///           ),
///         );
///       },
///     ),
///   );
/// }
/// ```
///
/// See also:
///
///  * [StatefulBuilder], A stateful utility widget whose [build] method uses its
///    [builder] callback to create the widget's child.
class Builder extends StatelessWidget {
  /// Creates a widget that delegates its build to a callback.
  ///
  /// The [builder] argument must not be null.
  const Builder({
    super.key,
    required this.builder,
  });

  /// Called to obtain the child widget.
  ///
  /// This function is called whenever this widget is included in its parent's
  /// build and the old widget (if any) that it synchronizes with has a distinct
  /// object identity. Typically the parent's build method will construct
  /// a new tree of widgets and so a new Builder child will not be [identical]
  /// to the corresponding old one.
  final WidgetBuilder builder;

  @override
  Widget build(BuildContext context) => builder(context);
}

/// Signature for the builder callback used by [StatefulBuilder].
///
/// Call `setState` to schedule the [StatefulBuilder] to rebuild.
typedef StatefulWidgetBuilder = Widget Function(BuildContext context, StateSetter setState);

/// A platonic widget that both has state and calls a closure to obtain its child widget.
///
/// {@youtube 560 315 https://www.youtube.com/watch?v=syvT63CosNE}
///
/// The [StateSetter] function passed to the [builder] is used to invoke a
/// rebuild instead of a typical [State]'s [State.setState].
///
/// Since the [builder] is re-invoked when the [StateSetter] is called, any
/// variables that represents state should be kept outside the [builder] function.
///
/// {@tool snippet}
///
/// This example shows using an inline StatefulBuilder that rebuilds and that
/// also has state.
///
/// ```dart
/// await showDialog<void>(
///   context: context,
///   builder: (BuildContext context) {
///     int? selectedRadio = 0;
///     return AlertDialog(
///       content: StatefulBuilder(
///         builder: (BuildContext context, StateSetter setState) {
///           return Column(
///             mainAxisSize: MainAxisSize.min,
///             children: List<Widget>.generate(4, (int index) {
///               return Radio<int>(
///                 value: index,
///                 groupValue: selectedRadio,
///                 onChanged: (int? value) {
///                   setState(() => selectedRadio = value);
///                 },
///               );
///             }),
///           );
///         },
///       ),
///     );
///   },
/// );
/// ```
/// {@end-tool}
///
/// See also:
///
///  * [Builder], the platonic stateless widget.
class StatefulBuilder extends StatefulWidget {
  /// Creates a widget that both has state and delegates its build to a callback.
  ///
  /// The [builder] argument must not be null.
  const StatefulBuilder({
    super.key,
    required this.builder,
  });

  /// Called to obtain the child widget.
  ///
  /// This function is called whenever this widget is included in its parent's
  /// build and the old widget (if any) that it synchronizes with has a distinct
  /// object identity. Typically the parent's build method will construct
  /// a new tree of widgets and so a new Builder child will not be [identical]
  /// to the corresponding old one.
  final StatefulWidgetBuilder builder;

  @override
  State<StatefulBuilder> createState() => _StatefulBuilderState();
}

class _StatefulBuilderState extends State<StatefulBuilder> {
  @override
  Widget build(BuildContext context) => widget.builder(context, setState);
}

/// A widget that paints its area with a specified [Color] and then draws its
/// child on top of that color.
class ColoredBox extends SingleChildRenderObjectWidget {
  /// Creates a widget that paints its area with the specified [Color].
  ///
  /// The [color] parameter must not be null.
  const ColoredBox({ required this.color, super.child, super.key });

  /// The color to paint the background area with.
  final Color color;

  @override
  RenderObject createRenderObject(BuildContext context) {
    return _RenderColoredBox(color: color);
  }

  @override
  void updateRenderObject(BuildContext context, RenderObject renderObject) {
    (renderObject as _RenderColoredBox).color = color;
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<Color>('color', color));
  }
}

class _RenderColoredBox extends RenderProxyBoxWithHitTestBehavior {
  _RenderColoredBox({ required Color color })
    : _color = color,
      super(behavior: HitTestBehavior.opaque);

  /// The fill color for this render object.
  ///
  /// This parameter must not be null.
  Color get color => _color;
  Color _color;
  set color(Color value) {
    if (value == _color) {
      return;
    }
    _color = value;
    markNeedsPaint();
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    // It's tempting to want to optimize out this `drawRect()` call if the
    // color is transparent (alpha==0), but doing so would be incorrect. See
    // https://github.com/flutter/flutter/pull/72526#issuecomment-749185938 for
    // a good description of why.
    if (size > Size.zero) {
      context.canvas.drawRect(offset & size, Paint()..color = color);
    }
    if (child != null) {
      context.paintChild(child!, offset);
    }
  }
}
""";
String textButtonString = """
// Copyright 2014 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:math' as math;
import 'dart:ui' show lerpDouble;

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'button_style.dart';
import 'button_style_button.dart';
import 'color_scheme.dart';
import 'colors.dart';
import 'constants.dart';
import 'ink_ripple.dart';
import 'ink_well.dart';
import 'material_state.dart';
import 'text_button_theme.dart';
import 'theme.dart';
import 'theme_data.dart';

/// A Material Design "Text Button".
///
/// Use text buttons on toolbars, in dialogs, or inline with other
/// content but offset from that content with padding so that the
/// button's presence is obvious. Text buttons do not have visible
/// borders and must therefore rely on their position relative to
/// other content for context. In dialogs and cards, they should be
/// grouped together in one of the bottom corners. Avoid using text
/// buttons where they would blend in with other content, for example
/// in the middle of lists.
///
/// A text button is a label [child] displayed on a (zero elevation)
/// [Material] widget. The label's [Text] and [Icon] widgets are
/// displayed in the [style]'s [ButtonStyle.foregroundColor]. The
/// button reacts to touches by filling with the [style]'s
/// [ButtonStyle.backgroundColor].
///
/// The text button's default style is defined by [defaultStyleOf].
/// The style of this text button can be overridden with its [style]
/// parameter. The style of all text buttons in a subtree can be
/// overridden with the [TextButtonTheme] and the style of all of the
/// text buttons in an app can be overridden with the [Theme]'s
/// [ThemeData.textButtonTheme] property.
///
/// The static [styleFrom] method is a convenient way to create a
/// text button [ButtonStyle] from simple values.
///
/// If the [onPressed] and [onLongPress] callbacks are null, then this
/// button will be disabled, it will not react to touch.
///
/// {@tool dartpad}
/// This sample shows how to render a disabled TextButton, an enabled TextButton
/// and lastly a TextButton with gradient background.
///
/// ** See code in examples/api/lib/material/text_button/text_button.0.dart **
/// {@end-tool}
///
/// {@tool dartpad}
/// This sample demonstrates using the [statesController] parameter to create a button
/// that adds support for [MaterialState.selected].
///
/// ** See code in examples/api/lib/material/text_button/text_button.1.dart **
/// {@end-tool}
///
/// See also:
///
///  * [ElevatedButton], a filled button whose material elevates when pressed.
///  * [FilledButton], a filled button that doesn't elevate when pressed.
///  * [FilledButton.tonal], a filled button variant that uses a secondary fill color.
///  * [OutlinedButton], a button with an outlined border and no fill color.
///  * <https://material.io/design/components/buttons.html>
///  * <https://m3.material.io/components/buttons>
class TextButton extends ButtonStyleButton {
  /// Create a TextButton.
  ///
  /// The [autofocus] and [clipBehavior] arguments must not be null.
  const TextButton({
    super.key,
    required super.onPressed,
    super.onLongPress,
    super.onHover,
    super.onFocusChange,
    super.style,
    super.focusNode,
    super.autofocus = false,
    super.clipBehavior = Clip.none,
    super.statesController,
    required Widget super.child,
  });

  /// Create a text button from a pair of widgets that serve as the button's
  /// [icon] and [label].
  ///
  /// The icon and label are arranged in a row and padded by 8 logical pixels
  /// at the ends, with an 8 pixel gap in between.
  ///
  /// The [icon] and [label] arguments must not be null.
  factory TextButton.icon({
    Key? key,
    required VoidCallback? onPressed,
    VoidCallback? onLongPress,
    ValueChanged<bool>? onHover,
    ValueChanged<bool>? onFocusChange,
    ButtonStyle? style,
    FocusNode? focusNode,
    bool? autofocus,
    Clip? clipBehavior,
    MaterialStatesController? statesController,
    required Widget icon,
    required Widget label,
  }) = _TextButtonWithIcon;

  /// A static convenience method that constructs a text button
  /// [ButtonStyle] given simple values.
  ///
  /// The [foregroundColor] and [disabledForegroundColor] colors are used
  /// to create a [MaterialStateProperty] [ButtonStyle.foregroundColor], and
  /// a derived [ButtonStyle.overlayColor].
  ///
  /// The [backgroundColor] and [disabledBackgroundColor] colors are
  /// used to create a [MaterialStateProperty] [ButtonStyle.backgroundColor].
  ///
  /// Similarly, the [enabledMouseCursor] and [disabledMouseCursor]
  /// parameters are used to construct [ButtonStyle.mouseCursor].
  ///
  /// All of the other parameters are either used directly or used to
  /// create a [MaterialStateProperty] with a single value for all
  /// states.
  ///
  /// All parameters default to null. By default this method returns
  /// a [ButtonStyle] that doesn't override anything.
  ///
  /// For example, to override the default text and icon colors for a
  /// [TextButton], as well as its overlay color, with all of the
  /// standard opacity adjustments for the pressed, focused, and
  /// hovered states, one could write:
  ///
  /// ```dart
  /// TextButton(
  ///   style: TextButton.styleFrom(foregroundColor: Colors.green),
  ///   child: const Text('Give Kate a mix tape'),
  ///   onPressed: () {
  ///     // ...
  ///   },
  /// ),
  /// ```
  static ButtonStyle styleFrom({
    Color? foregroundColor,
    Color? backgroundColor,
    Color? disabledForegroundColor,
    Color? disabledBackgroundColor,
    Color? shadowColor,
    Color? surfaceTintColor,
    Color? iconColor,
    Color? disabledIconColor,
    double? elevation,
    TextStyle? textStyle,
    EdgeInsetsGeometry? padding,
    Size? minimumSize,
    Size? fixedSize,
    Size? maximumSize,
    BorderSide? side,
    OutlinedBorder? shape,
    MouseCursor? enabledMouseCursor,
    MouseCursor? disabledMouseCursor,
    VisualDensity? visualDensity,
    MaterialTapTargetSize? tapTargetSize,
    Duration? animationDuration,
    bool? enableFeedback,
    AlignmentGeometry? alignment,
    InteractiveInkFeatureFactory? splashFactory,
    @Deprecated(
      'Use foregroundColor instead. '
      'This feature was deprecated after v3.1.0.'
    )
    Color? primary,
    @Deprecated(
      'Use disabledForegroundColor instead. '
      'This feature was deprecated after v3.1.0.'
    )
    Color? onSurface,
  }) {
    final Color? foreground = foregroundColor ?? primary;
    final Color? disabledForeground = disabledForegroundColor ?? onSurface?.withOpacity(0.38);
    final MaterialStateProperty<Color?>? foregroundColorProp = (foreground == null && disabledForeground == null)
      ? null
      : _TextButtonDefaultColor(foreground, disabledForeground);
    final MaterialStateProperty<Color?>? backgroundColorProp = (backgroundColor == null && disabledBackgroundColor == null)
      ? null
      : disabledBackgroundColor == null
        ? ButtonStyleButton.allOrNull<Color?>(backgroundColor)
        : _TextButtonDefaultColor(backgroundColor, disabledBackgroundColor);
    final MaterialStateProperty<Color?>? overlayColor = (foreground == null)
      ? null
      : _TextButtonDefaultOverlay(foreground);
    final MaterialStateProperty<Color?>? iconColorProp = (iconColor == null && disabledIconColor == null)
      ? null
      : disabledIconColor == null
        ? ButtonStyleButton.allOrNull<Color?>(iconColor)
        : _TextButtonDefaultIconColor(iconColor, disabledIconColor);
    final MaterialStateProperty<MouseCursor>? mouseCursor = (enabledMouseCursor == null && disabledMouseCursor == null)
      ? null
      : _TextButtonDefaultMouseCursor(enabledMouseCursor!, disabledMouseCursor!);

    return ButtonStyle(
      textStyle: ButtonStyleButton.allOrNull<TextStyle>(textStyle),
      foregroundColor: foregroundColorProp,
      backgroundColor: backgroundColorProp,
      overlayColor: overlayColor,
      shadowColor: ButtonStyleButton.allOrNull<Color>(shadowColor),
      surfaceTintColor: ButtonStyleButton.allOrNull<Color>(surfaceTintColor),
      iconColor: iconColorProp,
      elevation: ButtonStyleButton.allOrNull<double>(elevation),
      padding: ButtonStyleButton.allOrNull<EdgeInsetsGeometry>(padding),
      minimumSize: ButtonStyleButton.allOrNull<Size>(minimumSize),
      fixedSize: ButtonStyleButton.allOrNull<Size>(fixedSize),
      maximumSize: ButtonStyleButton.allOrNull<Size>(maximumSize),
      side: ButtonStyleButton.allOrNull<BorderSide>(side),
      shape: ButtonStyleButton.allOrNull<OutlinedBorder>(shape),
      mouseCursor: mouseCursor,
      visualDensity: visualDensity,
      tapTargetSize: tapTargetSize,
      animationDuration: animationDuration,
      enableFeedback: enableFeedback,
      alignment: alignment,
      splashFactory: splashFactory,
    );
  }

  /// Defines the button's default appearance.
  ///
  /// {@template flutter.material.text_button.default_style_of}
  /// The button [child]'s [Text] and [Icon] widgets are rendered with
  /// the [ButtonStyle]'s foreground color. The button's [InkWell] adds
  /// the style's overlay color when the button is focused, hovered
  /// or pressed. The button's background color becomes its [Material]
  /// color and is transparent by default.
  ///
  /// All of the [ButtonStyle]'s defaults appear below.
  ///
  /// In this list "Theme.foo" is shorthand for
  /// `Theme.of(context).foo`. Color scheme values like
  /// "onSurface(0.38)" are shorthand for
  /// `onSurface.withOpacity(0.38)`. [MaterialStateProperty] valued
  /// properties that are not followed by a sublist have the same
  /// value for all states, otherwise the values are as specified for
  /// each state and "others" means all other states.
  ///
  /// The `textScaleFactor` is the value of
  /// `MediaQuery.textScaleFactorOf(context)` and the names of the
  /// EdgeInsets constructors and `EdgeInsetsGeometry.lerp` have been
  /// abbreviated for readability.
  ///
  /// The color of the [ButtonStyle.textStyle] is not used, the
  /// [ButtonStyle.foregroundColor] color is used instead.
  /// {@endtemplate}
  ///
  /// ## Material 2 defaults
  ///
  /// * `textStyle` - Theme.textTheme.button
  /// * `backgroundColor` - transparent
  /// * `foregroundColor`
  ///   * disabled - Theme.colorScheme.onSurface(0.38)
  ///   * others - Theme.colorScheme.primary
  /// * `overlayColor`
  ///   * hovered - Theme.colorScheme.primary(0.04)
  ///   * focused or pressed - Theme.colorScheme.primary(0.12)
  /// * `shadowColor` - Theme.shadowColor
  /// * `elevation` - 0
  /// * `padding`
  ///   * `textScaleFactor <= 1` - (horizontal(12), vertical(8))
  ///   * `1 < textScaleFactor <= 2` - lerp(all(8), horizontal(8))
  ///   * `2 < textScaleFactor <= 3` - lerp(horizontal(8), horizontal(4))
  ///   * `3 < textScaleFactor` - horizontal(4)
  /// * `minimumSize` - Size(64, 36)
  /// * `fixedSize` - null
  /// * `maximumSize` - Size.infinite
  /// * `side` - null
  /// * `shape` - RoundedRectangleBorder(borderRadius: BorderRadius.circular(4))
  /// * `mouseCursor`
  ///   * disabled - SystemMouseCursors.basic
  ///   * others - SystemMouseCursors.click
  /// * `visualDensity` - theme.visualDensity
  /// * `tapTargetSize` - theme.materialTapTargetSize
  /// * `animationDuration` - kThemeChangeDuration
  /// * `enableFeedback` - true
  /// * `alignment` - Alignment.center
  /// * `splashFactory` - InkRipple.splashFactory
  ///
  /// The default padding values for the [TextButton.icon] factory are slightly different:
  ///
  /// * `padding`
  ///   * `textScaleFactor <= 1` - all(8)
  ///   * `1 < textScaleFactor <= 2 `- lerp(all(8), horizontal(4))
  ///   * `2 < textScaleFactor` - horizontal(4)
  ///
  /// The default value for `side`, which defines the appearance of the button's
  /// outline, is null. That means that the outline is defined by the button
  /// shape's [OutlinedBorder.side]. Typically the default value of an
  /// [OutlinedBorder]'s side is [BorderSide.none], so an outline is not drawn.
  ///
  /// ## Material 3 defaults
  ///
  /// If [ThemeData.useMaterial3] is set to true the following defaults will
  /// be used:
  ///
  /// {@template flutter.material.text_button.material3_defaults}
  /// * `textStyle` - Theme.textTheme.labelLarge
  /// * `backgroundColor` - transparent
  /// * `foregroundColor`
  ///   * disabled - Theme.colorScheme.onSurface(0.38)
  ///   * others - Theme.colorScheme.primary
  /// * `overlayColor`
  ///   * hovered - Theme.colorScheme.primary(0.08)
  ///   * focused or pressed - Theme.colorScheme.primary(0.12)
  ///   * others - null
  /// * `shadowColor` - null
  /// * `surfaceTintColor` - null
  /// * `elevation` - 0
  /// * `padding`
  ///   * `textScaleFactor <= 1` - lerp(horizontal(12), horizontal(4))
  ///   * `1 < textScaleFactor <= 2` - lerp(all(8), horizontal(8))
  ///   * `2 < textScaleFactor <= 3` - lerp(horizontal(8), horizontal(4))
  ///   * `3 < textScaleFactor` - horizontal(4)
  /// * `minimumSize` - Size(64, 40)
  /// * `fixedSize` - null
  /// * `maximumSize` - Size.infinite
  /// * `side` - null
  /// * `shape` - StadiumBorder()
  /// * `mouseCursor`
  ///   * disabled - SystemMouseCursors.basic
  ///   * others - SystemMouseCursors.click
  /// * `visualDensity` - theme.visualDensity
  /// * `tapTargetSize` - theme.materialTapTargetSize
  /// * `animationDuration` - kThemeChangeDuration
  /// * `enableFeedback` - true
  /// * `alignment` - Alignment.center
  /// * `splashFactory` - Theme.splashFactory
  ///
  /// For the [TextButton.icon] factory, the end (generally the right) value of
  /// [padding] is increased from 12 to 16.
  /// {@endtemplate}
  @override
  ButtonStyle defaultStyleOf(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme colorScheme = theme.colorScheme;

    return Theme.of(context).useMaterial3
      ? _TextButtonDefaultsM3(context)
      : styleFrom(
          foregroundColor: colorScheme.primary,
          disabledForegroundColor: colorScheme.onSurface.withOpacity(0.38),
          backgroundColor: Colors.transparent,
          disabledBackgroundColor: Colors.transparent,
          shadowColor: theme.shadowColor,
          elevation: 0,
          textStyle: theme.textTheme.labelLarge,
          padding: _scaledPadding(context),
          minimumSize: const Size(64, 36),
          maximumSize: Size.infinite,
          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(4))),
          enabledMouseCursor: SystemMouseCursors.click,
          disabledMouseCursor: SystemMouseCursors.basic,
          visualDensity: theme.visualDensity,
          tapTargetSize: theme.materialTapTargetSize,
          animationDuration: kThemeChangeDuration,
          enableFeedback: true,
          alignment: Alignment.center,
          splashFactory: InkRipple.splashFactory,
        );
  }

  /// Returns the [TextButtonThemeData.style] of the closest
  /// [TextButtonTheme] ancestor.
  @override
  ButtonStyle? themeStyleOf(BuildContext context) {
    return TextButtonTheme.of(context).style;
  }
}

EdgeInsetsGeometry _scaledPadding(BuildContext context) {
  final bool useMaterial3 = Theme.of(context).useMaterial3;
  return ButtonStyleButton.scaledPadding(
    useMaterial3 ? const EdgeInsets.symmetric(horizontal: 12, vertical: 8) :  const EdgeInsets.all(8),
    const EdgeInsets.symmetric(horizontal: 8),
    const EdgeInsets.symmetric(horizontal: 4),
    MediaQuery.textScaleFactorOf(context),
  );
}

@immutable
class _TextButtonDefaultColor extends MaterialStateProperty<Color?> {
  _TextButtonDefaultColor(this.color, this.disabled);

  final Color? color;
  final Color? disabled;

  @override
  Color? resolve(Set<MaterialState> states) {
    if (states.contains(MaterialState.disabled)) {
      return disabled;
    }
    return color;
  }

  @override
  String toString() {
    return '{disabled: \$disabled, otherwise: \$color}';
  }
}

@immutable
class _TextButtonDefaultOverlay extends MaterialStateProperty<Color?> {
  _TextButtonDefaultOverlay(this.primary);

  final Color primary;

  @override
  Color? resolve(Set<MaterialState> states) {
    if (states.contains(MaterialState.hovered)) {
      return primary.withOpacity(0.04);
    }
    if (states.contains(MaterialState.focused) || states.contains(MaterialState.pressed)) {
      return primary.withOpacity(0.12);
    }
    return null;
  }

  @override
  String toString() {
    return '{hovered: \${primary.withOpacity(0.04)}, focused,pressed: \${primary.withOpacity(0.12)}, otherwise: null}';
  }
}

@immutable
class _TextButtonDefaultIconColor extends MaterialStateProperty<Color?> {
  _TextButtonDefaultIconColor(this.iconColor, this.disabledIconColor);

  final Color? iconColor;
  final Color? disabledIconColor;

  @override
  Color? resolve(Set<MaterialState> states) {
    if (states.contains(MaterialState.disabled)) {
      return disabledIconColor;
    }
    return iconColor;
  }

  @override
  String toString() {
    return '{disabled: \$disabledIconColor, color: \$iconColor}';
  }
}

@immutable
class _TextButtonDefaultMouseCursor extends MaterialStateProperty<MouseCursor> with Diagnosticable {
  _TextButtonDefaultMouseCursor(this.enabledCursor, this.disabledCursor);

  final MouseCursor enabledCursor;
  final MouseCursor disabledCursor;

  @override
  MouseCursor resolve(Set<MaterialState> states) {
    if (states.contains(MaterialState.disabled)) {
      return disabledCursor;
    }
    return enabledCursor;
  }
}

class _TextButtonWithIcon extends TextButton {
  _TextButtonWithIcon({
    super.key,
    required super.onPressed,
    super.onLongPress,
    super.onHover,
    super.onFocusChange,
    super.style,
    super.focusNode,
    bool? autofocus,
    Clip? clipBehavior,
    super.statesController,
    required Widget icon,
    required Widget label,
  }) : super(
         autofocus: autofocus ?? false,
         clipBehavior: clipBehavior ?? Clip.none,
         child: _TextButtonWithIconChild(icon: icon, label: label),
      );

  @override
  ButtonStyle defaultStyleOf(BuildContext context) {
    final bool useMaterial3 = Theme.of(context).useMaterial3;
    final EdgeInsetsGeometry scaledPadding = ButtonStyleButton.scaledPadding(
      useMaterial3 ? const EdgeInsetsDirectional.fromSTEB(12, 8, 16, 8) : const EdgeInsets.all(8),
      const EdgeInsets.symmetric(horizontal: 4),
      const EdgeInsets.symmetric(horizontal: 4),
      MediaQuery.textScaleFactorOf(context),
    );
    return super.defaultStyleOf(context).copyWith(
      padding: MaterialStatePropertyAll<EdgeInsetsGeometry>(scaledPadding),
    );
  }
}

class _TextButtonWithIconChild extends StatelessWidget {
  const _TextButtonWithIconChild({
    required this.label,
    required this.icon,
  });

  final Widget label;
  final Widget icon;

  @override
  Widget build(BuildContext context) {
    final double scale = MediaQuery.textScaleFactorOf(context);
    final double gap = scale <= 1 ? 8 : lerpDouble(8, 4, math.min(scale - 1, 1))!;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[icon, SizedBox(width: gap), Flexible(child: label)],
    );
  }
}

// BEGIN GENERATED TOKEN PROPERTIES - TextButton

// Do not edit by hand. The code between the "BEGIN GENERATED" and
// "END GENERATED" comments are generated from data in the Material
// Design token database by the script:
//   dev/tools/gen_defaults/bin/gen_defaults.dart.

// Token database version: v0_162

class _TextButtonDefaultsM3 extends ButtonStyle {
  _TextButtonDefaultsM3(this.context)
   : super(
       animationDuration: kThemeChangeDuration,
       enableFeedback: true,
       alignment: Alignment.center,
     );

  final BuildContext context;
  late final ColorScheme _colors = Theme.of(context).colorScheme;

  @override
  MaterialStateProperty<TextStyle?> get textStyle =>
    MaterialStatePropertyAll<TextStyle?>(Theme.of(context).textTheme.labelLarge);

  @override
  MaterialStateProperty<Color?>? get backgroundColor =>
    const MaterialStatePropertyAll<Color>(Colors.transparent);

  @override
  MaterialStateProperty<Color?>? get foregroundColor =>
    MaterialStateProperty.resolveWith((Set<MaterialState> states) {
      if (states.contains(MaterialState.disabled)) {
        return _colors.onSurface.withOpacity(0.38);
      }
      return _colors.primary;
    });

  @override
  MaterialStateProperty<Color?>? get overlayColor =>
    MaterialStateProperty.resolveWith((Set<MaterialState> states) {
      if (states.contains(MaterialState.hovered)) {
        return _colors.primary.withOpacity(0.08);
      }
      if (states.contains(MaterialState.focused)) {
        return _colors.primary.withOpacity(0.12);
      }
      if (states.contains(MaterialState.pressed)) {
        return _colors.primary.withOpacity(0.12);
      }
      return null;
    });

  @override
  MaterialStateProperty<Color>? get shadowColor =>
    const MaterialStatePropertyAll<Color>(Colors.transparent);

  @override
  MaterialStateProperty<Color>? get surfaceTintColor =>
    const MaterialStatePropertyAll<Color>(Colors.transparent);

  @override
  MaterialStateProperty<double>? get elevation =>
    const MaterialStatePropertyAll<double>(0.0);

  @override
  MaterialStateProperty<EdgeInsetsGeometry>? get padding =>
    MaterialStatePropertyAll<EdgeInsetsGeometry>(_scaledPadding(context));

  @override
  MaterialStateProperty<Size>? get minimumSize =>
    const MaterialStatePropertyAll<Size>(Size(64.0, 40.0));

  // No default fixedSize

  @override
  MaterialStateProperty<Size>? get maximumSize =>
    const MaterialStatePropertyAll<Size>(Size.infinite);

  // No default side

  @override
  MaterialStateProperty<OutlinedBorder>? get shape =>
    const MaterialStatePropertyAll<OutlinedBorder>(StadiumBorder());

  @override
  MaterialStateProperty<MouseCursor?>? get mouseCursor =>
    MaterialStateProperty.resolveWith((Set<MaterialState> states) {
      if (states.contains(MaterialState.disabled)) {
        return SystemMouseCursors.basic;
      }
      return SystemMouseCursors.click;
    });

  @override
  VisualDensity? get visualDensity => Theme.of(context).visualDensity;

  @override
  MaterialTapTargetSize? get tapTargetSize => Theme.of(context).materialTapTargetSize;

  @override
  InteractiveInkFeatureFactory? get splashFactory => Theme.of(context).splashFactory;
}

// END GENERATED TOKEN PROPERTIES - TextButton
""";
String statefulString = """
// Copyright 2014 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:async';
import 'dart:collection';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';

import 'binding.dart';
import 'debug.dart';
import 'focus_manager.dart';
import 'inherited_model.dart';
import 'notification_listener.dart';
import 'widget_inspector.dart';

export 'package:flutter/foundation.dart' show
  factory,
  immutable,
  mustCallSuper,
  optionalTypeArgs,
  protected,
  required,
  visibleForTesting;
export 'package:flutter/foundation.dart' show ErrorDescription, ErrorHint, ErrorSummary, FlutterError, debugPrint, debugPrintStack;
export 'package:flutter/foundation.dart' show ValueChanged, ValueGetter, ValueSetter, VoidCallback;
export 'package:flutter/foundation.dart' show DiagnosticLevel, DiagnosticsNode;
export 'package:flutter/foundation.dart' show Key, LocalKey, ValueKey;
export 'package:flutter/rendering.dart' show RenderBox, RenderObject, debugDumpLayerTree, debugDumpRenderTree;

// Examples can assume:
// late BuildContext context;
// void setState(VoidCallback fn) { }
// abstract class RenderFrogJar extends RenderObject { }
// abstract class FrogJar extends RenderObjectWidget { const FrogJar({super.key}); }
// abstract class FrogJarParentData extends ParentData { late Size size; }
// abstract class SomeWidget extends StatefulWidget { const SomeWidget({super.key}); }
// typedef ChildWidget = Placeholder;
// class _SomeWidgetState extends State<SomeWidget> { @override Widget build(BuildContext context) => widget; }
// abstract class RenderFoo extends RenderObject { }
// abstract class Foo extends RenderObjectWidget { const Foo({super.key}); }
// abstract class StatefulWidgetX { const StatefulWidgetX({this.key}); final Key? key; Widget build(BuildContext context, State state); }
// class SpecialWidget extends StatelessWidget { const SpecialWidget({ super.key, this.handler }); final VoidCallback? handler; @override Widget build(BuildContext context) => this; }
// late Object? _myState, newValue;
// int _counter = 0;
// Future<Directory> getApplicationDocumentsDirectory() async => Directory('');

// An annotation used by test_analysis package to verify patterns are followed
// that allow for tree-shaking of both fields and their initializers. This
// annotation has no impact on code by itself, but indicates the following pattern
// should be followed for a given field:
//
// ```dart
// class Foo {
//   final bar = kDebugMode ? Object() : null;
// }
// ```
class _DebugOnly {
  const _DebugOnly();
}

const _DebugOnly _debugOnly = _DebugOnly();

// KEYS

/// A key that takes its identity from the object used as its value.
///
/// Used to tie the identity of a widget to the identity of an object used to
/// generate that widget.
///
/// See also:
///
///  * [Key], the base class for all keys.
///  * The discussion at [Widget.key] for more information about how widgets use
///    keys.
class ObjectKey extends LocalKey {
  /// Creates a key that uses [identical] on [value] for its [operator==].
  const ObjectKey(this.value);

  /// The object whose identity is used by this key's [operator==].
  final Object? value;

  @override
  bool operator ==(Object other) {
    if (other.runtimeType != runtimeType) {
      return false;
    }
    return other is ObjectKey
        && identical(other.value, value);
  }

  @override
  int get hashCode => Object.hash(runtimeType, identityHashCode(value));

  @override
  String toString() {
    if (runtimeType == ObjectKey) {
      return '[\${describeIdentity(value)}]';
    }
    return '[\${objectRuntimeType(this, 'ObjectKey')} \${describeIdentity(value)}]';
  }
}

/// A key that is unique across the entire app.
///
/// Global keys uniquely identify elements. Global keys provide access to other
/// objects that are associated with those elements, such as [BuildContext].
/// For [StatefulWidget]s, global keys also provide access to [State].
///
/// Widgets that have global keys reparent their subtrees when they are moved
/// from one location in the tree to another location in the tree. In order to
/// reparent its subtree, a widget must arrive at its new location in the tree
/// in the same animation frame in which it was removed from its old location in
/// the tree.
///
/// Reparenting an [Element] using a global key is relatively expensive, as
/// this operation will trigger a call to [State.deactivate] on the associated
/// [State] and all of its descendants; then force all widgets that depends
/// on an [InheritedWidget] to rebuild.
///
/// If you don't need any of the features listed above, consider using a [Key],
/// [ValueKey], [ObjectKey], or [UniqueKey] instead.
///
/// You cannot simultaneously include two widgets in the tree with the same
/// global key. Attempting to do so will assert at runtime.
///
/// ## Pitfalls
///
/// GlobalKeys should not be re-created on every build. They should usually be
/// long-lived objects owned by a [State] object, for example.
///
/// Creating a new GlobalKey on every build will throw away the state of the
/// subtree associated with the old key and create a new fresh subtree for the
/// new key. Besides harming performance, this can also cause unexpected
/// behavior in widgets in the subtree. For example, a [GestureDetector] in the
/// subtree will be unable to track ongoing gestures since it will be recreated
/// on each build.
///
/// Instead, a good practice is to let a State object own the GlobalKey, and
/// instantiate it outside the build method, such as in [State.initState].
///
/// See also:
///
///  * The discussion at [Widget.key] for more information about how widgets use
///    keys.
@optionalTypeArgs
abstract class GlobalKey<T extends State<StatefulWidget>> extends Key {
  /// Creates a [LabeledGlobalKey], which is a [GlobalKey] with a label used for
  /// debugging.
  ///
  /// The label is purely for debugging and not used for comparing the identity
  /// of the key.
  factory GlobalKey({ String? debugLabel }) => LabeledGlobalKey<T>(debugLabel);

  /// Creates a global key without a label.
  ///
  /// Used by subclasses because the factory constructor shadows the implicit
  /// constructor.
  const GlobalKey.constructor() : super.empty();

  Element? get _currentElement => WidgetsBinding.instance.buildOwner!._globalKeyRegistry[this];

  /// The build context in which the widget with this key builds.
  ///
  /// The current context is null if there is no widget in the tree that matches
  /// this global key.
  BuildContext? get currentContext => _currentElement;

  /// The widget in the tree that currently has this global key.
  ///
  /// The current widget is null if there is no widget in the tree that matches
  /// this global key.
  Widget? get currentWidget => _currentElement?.widget;

  /// The [State] for the widget in the tree that currently has this global key.
  ///
  /// The current state is null if (1) there is no widget in the tree that
  /// matches this global key, (2) that widget is not a [StatefulWidget], or the
  /// associated [State] object is not a subtype of `T`.
  T? get currentState {
    final Element? element = _currentElement;
    if (element is StatefulElement) {
      final StatefulElement statefulElement = element;
      final State state = statefulElement.state;
      if (state is T) {
        return state;
      }
    }
    return null;
  }
}

/// A global key with a debugging label.
///
/// The debug label is useful for documentation and for debugging. The label
/// does not affect the key's identity.
@optionalTypeArgs
class LabeledGlobalKey<T extends State<StatefulWidget>> extends GlobalKey<T> {
  /// Creates a global key with a debugging label.
  ///
  /// The label does not affect the key's identity.
  // ignore: prefer_const_constructors_in_immutables , never use const for this class
  LabeledGlobalKey(this._debugLabel) : super.constructor();

  final String? _debugLabel;

  @override
  String toString() {
    final String label = _debugLabel != null ? ' \$_debugLabel' : '';
    if (runtimeType == LabeledGlobalKey) {
      return '[GlobalKey#\${shortHash(this)}\$label]';
    }
    return '[\${describeIdentity(this)}\$label]';
  }
}

/// A global key that takes its identity from the object used as its value.
///
/// Used to tie the identity of a widget to the identity of an object used to
/// generate that widget.
///
/// Any [GlobalObjectKey] created for the same object will match.
///
/// If the object is not private, then it is possible that collisions will occur
/// where independent widgets will reuse the same object as their
/// [GlobalObjectKey] value in a different part of the tree, leading to a global
/// key conflict. To avoid this problem, create a private [GlobalObjectKey]
/// subclass, as in:
///
/// ```dart
/// class _MyKey extends GlobalObjectKey {
///   const _MyKey(super.value);
/// }
/// ```
///
/// Since the [runtimeType] of the key is part of its identity, this will
/// prevent clashes with other [GlobalObjectKey]s even if they have the same
/// value.
@optionalTypeArgs
class GlobalObjectKey<T extends State<StatefulWidget>> extends GlobalKey<T> {
  /// Creates a global key that uses [identical] on [value] for its [operator==].
  const GlobalObjectKey(this.value) : super.constructor();

  /// The object whose identity is used by this key's [operator==].
  final Object value;

  @override
  bool operator ==(Object other) {
    if (other.runtimeType != runtimeType) {
      return false;
    }
    return other is GlobalObjectKey<T>
        && identical(other.value, value);
  }

  @override
  int get hashCode => identityHashCode(value);

  @override
  String toString() {
    String selfType = objectRuntimeType(this, 'GlobalObjectKey');
    // The runtimeType string of a GlobalObjectKey() returns 'GlobalObjectKey<State<StatefulWidget>>'
    // because GlobalObjectKey is instantiated to its bounds. To avoid cluttering the output
    // we remove the suffix.
    const String suffix = '<State<StatefulWidget>>';
    if (selfType.endsWith(suffix)) {
      selfType = selfType.substring(0, selfType.length - suffix.length);
    }
    return '[\$selfType \${describeIdentity(value)}]';
  }
}

/// Describes the configuration for an [Element].
///
/// Widgets are the central class hierarchy in the Flutter framework. A widget
/// is an immutable description of part of a user interface. Widgets can be
/// inflated into elements, which manage the underlying render tree.
///
/// Widgets themselves have no mutable state (all their fields must be final).
/// If you wish to associate mutable state with a widget, consider using a
/// [StatefulWidget], which creates a [State] object (via
/// [StatefulWidget.createState]) whenever it is inflated into an element and
/// incorporated into the tree.
///
/// A given widget can be included in the tree zero or more times. In particular
/// a given widget can be placed in the tree multiple times. Each time a widget
/// is placed in the tree, it is inflated into an [Element], which means a
/// widget that is incorporated into the tree multiple times will be inflated
/// multiple times.
///
/// The [key] property controls how one widget replaces another widget in the
/// tree. If the [runtimeType] and [key] properties of the two widgets are
/// [operator==], respectively, then the new widget replaces the old widget by
/// updating the underlying element (i.e., by calling [Element.update] with the
/// new widget). Otherwise, the old element is removed from the tree, the new
/// widget is inflated into an element, and the new element is inserted into the
/// tree.
///
/// See also:
///
///  * [StatefulWidget] and [State], for widgets that can build differently
///    several times over their lifetime.
///  * [InheritedWidget], for widgets that introduce ambient state that can
///    be read by descendant widgets.
///  * [StatelessWidget], for widgets that always build the same way given a
///    particular configuration and ambient state.
@immutable
abstract class Widget extends DiagnosticableTree {
  /// Initializes [key] for subclasses.
  const Widget({ this.key });

  /// Controls how one widget replaces another widget in the tree.
  ///
  /// If the [runtimeType] and [key] properties of the two widgets are
  /// [operator==], respectively, then the new widget replaces the old widget by
  /// updating the underlying element (i.e., by calling [Element.update] with the
  /// new widget). Otherwise, the old element is removed from the tree, the new
  /// widget is inflated into an element, and the new element is inserted into the
  /// tree.
  ///
  /// In addition, using a [GlobalKey] as the widget's [key] allows the element
  /// to be moved around the tree (changing parent) without losing state. When a
  /// new widget is found (its key and type do not match a previous widget in
  /// the same location), but there was a widget with that same global key
  /// elsewhere in the tree in the previous frame, then that widget's element is
  /// moved to the new location.
  ///
  /// Generally, a widget that is the only child of another widget does not need
  /// an explicit key.
  ///
  /// See also:
  ///
  ///  * The discussions at [Key] and [GlobalKey].
  final Key? key;

  /// Inflates this configuration to a concrete instance.
  ///
  /// A given widget can be included in the tree zero or more times. In particular
  /// a given widget can be placed in the tree multiple times. Each time a widget
  /// is placed in the tree, it is inflated into an [Element], which means a
  /// widget that is incorporated into the tree multiple times will be inflated
  /// multiple times.
  @protected
  @factory
  Element createElement();

  /// A short, textual description of this widget.
  @override
  String toStringShort() {
    final String type = objectRuntimeType(this, 'Widget');
    return key == null ? type : '\$type-\$key';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.defaultDiagnosticsTreeStyle = DiagnosticsTreeStyle.dense;
  }

  @override
  @nonVirtual
  bool operator ==(Object other) => super == other;

  @override
  @nonVirtual
  int get hashCode => super.hashCode;

  /// Whether the `newWidget` can be used to update an [Element] that currently
  /// has the `oldWidget` as its configuration.
  ///
  /// An element that uses a given widget as its configuration can be updated to
  /// use another widget as its configuration if, and only if, the two widgets
  /// have [runtimeType] and [key] properties that are [operator==].
  ///
  /// If the widgets have no key (their key is null), then they are considered a
  /// match if they have the same type, even if their children are completely
  /// different.
  static bool canUpdate(Widget oldWidget, Widget newWidget) {
    return oldWidget.runtimeType == newWidget.runtimeType
        && oldWidget.key == newWidget.key;
  }

  // Return a numeric encoding of the specific `Widget` concrete subtype.
  // This is used in `Element.updateChild` to determine if a hot reload modified the
  // superclass of a mounted element's configuration. The encoding of each `Widget`
  // must match the corresponding `Element` encoding in `Element._debugConcreteSubtype`.
  static int _debugConcreteSubtype(Widget widget) {
    return widget is StatefulWidget ? 1 :
           widget is StatelessWidget ? 2 :
           0;
  }
}

/// A widget that does not require mutable state.
///
/// A stateless widget is a widget that describes part of the user interface by
/// building a constellation of other widgets that describe the user interface
/// more concretely. The building process continues recursively until the
/// description of the user interface is fully concrete (e.g., consists
/// entirely of [RenderObjectWidget]s, which describe concrete [RenderObject]s).
///
/// {@youtube 560 315 https://www.youtube.com/watch?v=wE7khGHVkYY}
///
/// Stateless widget are useful when the part of the user interface you are
/// describing does not depend on anything other than the configuration
/// information in the object itself and the [BuildContext] in which the widget
/// is inflated. For compositions that can change dynamically, e.g. due to
/// having an internal clock-driven state, or depending on some system state,
/// consider using [StatefulWidget].
///
/// ## Performance considerations
///
/// The [build] method of a stateless widget is typically only called in three
/// situations: the first time the widget is inserted in the tree, when the
/// widget's parent changes its configuration (see [Element.rebuild]), and when
/// an [InheritedWidget] it depends on changes.
///
/// If a widget's parent will regularly change the widget's configuration, or if
/// it depends on inherited widgets that frequently change, then it is important
/// to optimize the performance of the [build] method to maintain a fluid
/// rendering performance.
///
/// There are several techniques one can use to minimize the impact of
/// rebuilding a stateless widget:
///
///  * Minimize the number of nodes transitively created by the build method and
///    any widgets it creates. For example, instead of an elaborate arrangement
///    of [Row]s, [Column]s, [Padding]s, and [SizedBox]es to position a single
///    child in a particularly fancy manner, consider using just an [Align] or a
///    [CustomSingleChildLayout]. Instead of an intricate layering of multiple
///    [Container]s and with [Decoration]s to draw just the right graphical
///    effect, consider a single [CustomPaint] widget.
///
///  * Use `const` widgets where possible, and provide a `const` constructor for
///    the widget so that users of the widget can also do so.
///
///  * Consider refactoring the stateless widget into a stateful widget so that
///    it can use some of the techniques described at [StatefulWidget], such as
///    caching common parts of subtrees and using [GlobalKey]s when changing the
///    tree structure.
///
///  * If the widget is likely to get rebuilt frequently due to the use of
///    [InheritedWidget]s, consider refactoring the stateless widget into
///    multiple widgets, with the parts of the tree that change being pushed to
///    the leaves. For example instead of building a tree with four widgets, the
///    inner-most widget depending on the [Theme], consider factoring out the
///    part of the build function that builds the inner-most widget into its own
///    widget, so that only the inner-most widget needs to be rebuilt when the
///    theme changes.
/// {@template flutter.flutter.widgets.framework.prefer_const_over_helper}
///  * When trying to create a reusable piece of UI, prefer using a widget
///    rather than a helper method. For example, if there was a function used to
///    build a widget, a [State.setState] call would require Flutter to entirely
///    rebuild the returned wrapping widget. If a [Widget] was used instead,
///    Flutter would be able to efficiently re-render only those parts that
///    really need to be updated. Even better, if the created widget is `const`,
///    Flutter would short-circuit most of the rebuild work.
/// {@endtemplate}
///
/// This video gives more explanations on why `const` constructors are important
/// and why a [Widget] is better than a helper method.
///
/// {@youtube 560 315 https://www.youtube.com/watch?v=IOyq-eTRhvo}
///
/// {@tool snippet}
///
/// The following is a skeleton of a stateless widget subclass called `GreenFrog`.
///
/// Normally, widgets have more constructor arguments, each of which corresponds
/// to a `final` property.
///
/// ```dart
/// class GreenFrog extends StatelessWidget {
///   const GreenFrog({ super.key });
///
///   @override
///   Widget build(BuildContext context) {
///     return Container(color: const Color(0xFF2DBD3A));
///   }
/// }
/// ```
/// {@end-tool}
///
/// {@tool snippet}
///
/// This next example shows the more generic widget `Frog` which can be given
/// a color and a child:
///
/// ```dart
/// class Frog extends StatelessWidget {
///   const Frog({
///     super.key,
///     this.color = const Color(0xFF2DBD3A),
///     this.child,
///   });
///
///   final Color color;
///   final Widget? child;
///
///   @override
///   Widget build(BuildContext context) {
///     return ColoredBox(color: color, child: child);
///   }
/// }
/// ```
/// {@end-tool}
///
/// By convention, widget constructors only use named arguments. Also by
/// convention, the first argument is [key], and the last argument is `child`,
/// `children`, or the equivalent.
///
/// See also:
///
///  * [StatefulWidget] and [State], for widgets that can build differently
///    several times over their lifetime.
///  * [InheritedWidget], for widgets that introduce ambient state that can
///    be read by descendant widgets.
abstract class StatelessWidget extends Widget {
  /// Initializes [key] for subclasses.
  const StatelessWidget({ super.key });

  /// Creates a [StatelessElement] to manage this widget's location in the tree.
  ///
  /// It is uncommon for subclasses to override this method.
  @override
  StatelessElement createElement() => StatelessElement(this);

  /// Describes the part of the user interface represented by this widget.
  ///
  /// The framework calls this method when this widget is inserted into the tree
  /// in a given [BuildContext] and when the dependencies of this widget change
  /// (e.g., an [InheritedWidget] referenced by this widget changes). This
  /// method can potentially be called in every frame and should not have any side
  /// effects beyond building a widget.
  ///
  /// The framework replaces the subtree below this widget with the widget
  /// returned by this method, either by updating the existing subtree or by
  /// removing the subtree and inflating a new subtree, depending on whether the
  /// widget returned by this method can update the root of the existing
  /// subtree, as determined by calling [Widget.canUpdate].
  ///
  /// Typically implementations return a newly created constellation of widgets
  /// that are configured with information from this widget's constructor and
  /// from the given [BuildContext].
  ///
  /// The given [BuildContext] contains information about the location in the
  /// tree at which this widget is being built. For example, the context
  /// provides the set of inherited widgets for this location in the tree. A
  /// given widget might be built with multiple different [BuildContext]
  /// arguments over time if the widget is moved around the tree or if the
  /// widget is inserted into the tree in multiple places at once.
  ///
  /// The implementation of this method must only depend on:
  ///
  /// * the fields of the widget, which themselves must not change over time,
  ///   and
  /// * any ambient state obtained from the `context` using
  ///   [BuildContext.dependOnInheritedWidgetOfExactType].
  ///
  /// If a widget's [build] method is to depend on anything else, use a
  /// [StatefulWidget] instead.
  ///
  /// See also:
  ///
  ///  * [StatelessWidget], which contains the discussion on performance considerations.
  @protected
  Widget build(BuildContext context);
}

/// A widget that has mutable state.
///
/// State is information that (1) can be read synchronously when the widget is
/// built and (2) might change during the lifetime of the widget. It is the
/// responsibility of the widget implementer to ensure that the [State] is
/// promptly notified when such state changes, using [State.setState].
///
/// A stateful widget is a widget that describes part of the user interface by
/// building a constellation of other widgets that describe the user interface
/// more concretely. The building process continues recursively until the
/// description of the user interface is fully concrete (e.g., consists
/// entirely of [RenderObjectWidget]s, which describe concrete [RenderObject]s).
///
/// Stateful widgets are useful when the part of the user interface you are
/// describing can change dynamically, e.g. due to having an internal
/// clock-driven state, or depending on some system state. For compositions that
/// depend only on the configuration information in the object itself and the
/// [BuildContext] in which the widget is inflated, consider using
/// [StatelessWidget].
///
/// {@youtube 560 315 https://www.youtube.com/watch?v=AqCMFXEmf3w}
///
/// [StatefulWidget] instances themselves are immutable and store their mutable
/// state either in separate [State] objects that are created by the
/// [createState] method, or in objects to which that [State] subscribes, for
/// example [Stream] or [ChangeNotifier] objects, to which references are stored
/// in final fields on the [StatefulWidget] itself.
///
/// The framework calls [createState] whenever it inflates a
/// [StatefulWidget], which means that multiple [State] objects might be
/// associated with the same [StatefulWidget] if that widget has been inserted
/// into the tree in multiple places. Similarly, if a [StatefulWidget] is
/// removed from the tree and later inserted in to the tree again, the framework
/// will call [createState] again to create a fresh [State] object, simplifying
/// the lifecycle of [State] objects.
///
/// A [StatefulWidget] keeps the same [State] object when moving from one
/// location in the tree to another if its creator used a [GlobalKey] for its
/// [key]. Because a widget with a [GlobalKey] can be used in at most one
/// location in the tree, a widget that uses a [GlobalKey] has at most one
/// associated element. The framework takes advantage of this property when
/// moving a widget with a global key from one location in the tree to another
/// by grafting the (unique) subtree associated with that widget from the old
/// location to the new location (instead of recreating the subtree at the new
/// location). The [State] objects associated with [StatefulWidget] are grafted
/// along with the rest of the subtree, which means the [State] object is reused
/// (instead of being recreated) in the new location. However, in order to be
/// eligible for grafting, the widget must be inserted into the new location in
/// the same animation frame in which it was removed from the old location.
///
/// ## Performance considerations
///
/// There are two primary categories of [StatefulWidget]s.
///
/// The first is one which allocates resources in [State.initState] and disposes
/// of them in [State.dispose], but which does not depend on [InheritedWidget]s
/// or call [State.setState]. Such widgets are commonly used at the root of an
/// application or page, and communicate with subwidgets via [ChangeNotifier]s,
/// [Stream]s, or other such objects. Stateful widgets following such a pattern
/// are relatively cheap (in terms of CPU and GPU cycles), because they are
/// built once then never update. They can, therefore, have somewhat complicated
/// and deep build methods.
///
/// The second category is widgets that use [State.setState] or depend on
/// [InheritedWidget]s. These will typically rebuild many times during the
/// application's lifetime, and it is therefore important to minimize the impact
/// of rebuilding such a widget. (They may also use [State.initState] or
/// [State.didChangeDependencies] and allocate resources, but the important part
/// is that they rebuild.)
///
/// There are several techniques one can use to minimize the impact of
/// rebuilding a stateful widget:
///
///  * Push the state to the leaves. For example, if your page has a ticking
///    clock, rather than putting the state at the top of the page and
///    rebuilding the entire page each time the clock ticks, create a dedicated
///    clock widget that only updates itself.
///
///  * Minimize the number of nodes transitively created by the build method and
///    any widgets it creates. Ideally, a stateful widget would only create a
///    single widget, and that widget would be a [RenderObjectWidget].
///    (Obviously this isn't always practical, but the closer a widget gets to
///    this ideal, the more efficient it will be.)
///
///  * If a subtree does not change, cache the widget that represents that
///    subtree and re-use it each time it can be used. To do this, assign
///    a widget to a `final` state variable and re-use it in the build method. It
///    is massively more efficient for a widget to be re-used than for a new (but
///    identically-configured) widget to be created. Another caching strategy
///    consists in extracting the mutable part of the widget into a [StatefulWidget]
///    which accepts a child parameter.
///
///  * Use `const` widgets where possible. (This is equivalent to caching a
///    widget and re-using it.)
///
///  * Avoid changing the depth of any created subtrees or changing the type of
///    any widgets in the subtree. For example, rather than returning either the
///    child or the child wrapped in an [IgnorePointer], always wrap the child
///    widget in an [IgnorePointer] and control the [IgnorePointer.ignoring]
///    property. This is because changing the depth of the subtree requires
///    rebuilding, laying out, and painting the entire subtree, whereas just
///    changing the property will require the least possible change to the
///    render tree (in the case of [IgnorePointer], for example, no layout or
///    repaint is necessary at all).
///
///  * If the depth must be changed for some reason, consider wrapping the
///    common parts of the subtrees in widgets that have a [GlobalKey] that
///    remains consistent for the life of the stateful widget. (The
///    [KeyedSubtree] widget may be useful for this purpose if no other widget
///    can conveniently be assigned the key.)
///
/// {@macro flutter.flutter.widgets.framework.prefer_const_over_helper}
///
/// This video gives more explanations on why `const` constructors are important
/// and why a [Widget] is better than a helper method.
///
/// {@youtube 560 315 https://www.youtube.com/watch?v=IOyq-eTRhvo}
///
/// For more details on the mechanics of rebuilding a widget, see
/// the discussion at [Element.rebuild].
///
/// {@tool snippet}
///
/// This is a skeleton of a stateful widget subclass called `YellowBird`.
///
/// In this example, the [State] has no actual state. State is normally
/// represented as private member fields. Also, normally widgets have more
/// constructor arguments, each of which corresponds to a `final` property.
///
/// ```dart
/// class YellowBird extends StatefulWidget {
///   const YellowBird({ super.key });
///
///   @override
///   State<YellowBird> createState() => _YellowBirdState();
/// }
///
/// class _YellowBirdState extends State<YellowBird> {
///   @override
///   Widget build(BuildContext context) {
///     return Container(color: const Color(0xFFFFE306));
///   }
/// }
/// ```
/// {@end-tool}
/// {@tool snippet}
///
/// This example shows the more generic widget `Bird` which can be given a
/// color and a child, and which has some internal state with a method that
/// can be called to mutate it:
///
/// ```dart
/// class Bird extends StatefulWidget {
///   const Bird({
///     super.key,
///     this.color = const Color(0xFFFFE306),
///     this.child,
///   });
///
///   final Color color;
///   final Widget? child;
///
///   @override
///   State<Bird> createState() => _BirdState();
/// }
///
/// class _BirdState extends State<Bird> {
///   double _size = 1.0;
///
///   void grow() {
///     setState(() { _size += 0.1; });
///   }
///
///   @override
///   Widget build(BuildContext context) {
///     return Container(
///       color: widget.color,
///       transform: Matrix4.diagonal3Values(_size, _size, 1.0),
///       child: widget.child,
///     );
///   }
/// }
/// ```
/// {@end-tool}
///
/// By convention, widget constructors only use named arguments. Also by
/// convention, the first argument is [key], and the last argument is `child`,
/// `children`, or the equivalent.
///
/// See also:
///
///  * [State], where the logic behind a [StatefulWidget] is hosted.
///  * [StatelessWidget], for widgets that always build the same way given a
///    particular configuration and ambient state.
///  * [InheritedWidget], for widgets that introduce ambient state that can
///    be read by descendant widgets.
abstract class StatefulWidget extends Widget {
  /// Initializes [key] for subclasses.
  const StatefulWidget({ super.key });

  /// Creates a [StatefulElement] to manage this widget's location in the tree.
  ///
  /// It is uncommon for subclasses to override this method.
  @override
  StatefulElement createElement() => StatefulElement(this);

  /// Creates the mutable state for this widget at a given location in the tree.
  ///
  /// Subclasses should override this method to return a newly created
  /// instance of their associated [State] subclass:
  ///
  /// ```dart
  /// @override
  /// State<SomeWidget> createState() => _SomeWidgetState();
  /// ```
  ///
  /// The framework can call this method multiple times over the lifetime of
  /// a [StatefulWidget]. For example, if the widget is inserted into the tree
  /// in multiple locations, the framework will create a separate [State] object
  /// for each location. Similarly, if the widget is removed from the tree and
  /// later inserted into the tree again, the framework will call [createState]
  /// again to create a fresh [State] object, simplifying the lifecycle of
  /// [State] objects.
  @protected
  @factory
  State createState();
}

/// Tracks the lifecycle of [State] objects when asserts are enabled.
enum _StateLifecycle {
  /// The [State] object has been created. [State.initState] is called at this
  /// time.
  created,

  /// The [State.initState] method has been called but the [State] object is
  /// not yet ready to build. [State.didChangeDependencies] is called at this time.
  initialized,

  /// The [State] object is ready to build and [State.dispose] has not yet been
  /// called.
  ready,

  /// The [State.dispose] method has been called and the [State] object is
  /// no longer able to build.
  defunct,
}

/// The signature of [State.setState] functions.
typedef StateSetter = void Function(VoidCallback fn);

const String _flutterWidgetsLibrary = 'package:flutter/widgets.dart';

/// The logic and internal state for a [StatefulWidget].
///
/// State is information that (1) can be read synchronously when the widget is
/// built and (2) might change during the lifetime of the widget. It is the
/// responsibility of the widget implementer to ensure that the [State] is
/// promptly notified when such state changes, using [State.setState].
///
/// [State] objects are created by the framework by calling the
/// [StatefulWidget.createState] method when inflating a [StatefulWidget] to
/// insert it into the tree. Because a given [StatefulWidget] instance can be
/// inflated multiple times (e.g., the widget is incorporated into the tree in
/// multiple places at once), there might be more than one [State] object
/// associated with a given [StatefulWidget] instance. Similarly, if a
/// [StatefulWidget] is removed from the tree and later inserted in to the tree
/// again, the framework will call [StatefulWidget.createState] again to create
/// a fresh [State] object, simplifying the lifecycle of [State] objects.
///
/// [State] objects have the following lifecycle:
///
///  * The framework creates a [State] object by calling
///    [StatefulWidget.createState].
///  * The newly created [State] object is associated with a [BuildContext].
///    This association is permanent: the [State] object will never change its
///    [BuildContext]. However, the [BuildContext] itself can be moved around
///    the tree along with its subtree. At this point, the [State] object is
///    considered [mounted].
///  * The framework calls [initState]. Subclasses of [State] should override
///    [initState] to perform one-time initialization that depends on the
///    [BuildContext] or the widget, which are available as the [context] and
///    [widget] properties, respectively, when the [initState] method is
///    called.
///  * The framework calls [didChangeDependencies]. Subclasses of [State] should
///    override [didChangeDependencies] to perform initialization involving
///    [InheritedWidget]s. If [BuildContext.dependOnInheritedWidgetOfExactType] is
///    called, the [didChangeDependencies] method will be called again if the
///    inherited widgets subsequently change or if the widget moves in the tree.
///  * At this point, the [State] object is fully initialized and the framework
///    might call its [build] method any number of times to obtain a
///    description of the user interface for this subtree. [State] objects can
///    spontaneously request to rebuild their subtree by calling their
///    [setState] method, which indicates that some of their internal state
///    has changed in a way that might impact the user interface in this
///    subtree.
///  * During this time, a parent widget might rebuild and request that this
///    location in the tree update to display a new widget with the same
///    [runtimeType] and [Widget.key]. When this happens, the framework will
///    update the [widget] property to refer to the new widget and then call the
///    [didUpdateWidget] method with the previous widget as an argument. [State]
///    objects should override [didUpdateWidget] to respond to changes in their
///    associated widget (e.g., to start implicit animations). The framework
///    always calls [build] after calling [didUpdateWidget], which means any
///    calls to [setState] in [didUpdateWidget] are redundant. (See alse the
///    discussion at [Element.rebuild].)
///  * During development, if a hot reload occurs (whether initiated from the
///    command line `flutter` tool by pressing `r`, or from an IDE), the
///    [reassemble] method is called. This provides an opportunity to
///    reinitialize any data that was prepared in the [initState] method.
///  * If the subtree containing the [State] object is removed from the tree
///    (e.g., because the parent built a widget with a different [runtimeType]
///    or [Widget.key]), the framework calls the [deactivate] method. Subclasses
///    should override this method to clean up any links between this object
///    and other elements in the tree (e.g. if you have provided an ancestor
///    with a pointer to a descendant's [RenderObject]).
///  * At this point, the framework might reinsert this subtree into another
///    part of the tree. If that happens, the framework will ensure that it
///    calls [build] to give the [State] object a chance to adapt to its new
///    location in the tree. If the framework does reinsert this subtree, it
///    will do so before the end of the animation frame in which the subtree was
///    removed from the tree. For this reason, [State] objects can defer
///    releasing most resources until the framework calls their [dispose]
///    method.
///  * If the framework does not reinsert this subtree by the end of the current
///    animation frame, the framework will call [dispose], which indicates that
///    this [State] object will never build again. Subclasses should override
///    this method to release any resources retained by this object (e.g.,
///    stop any active animations).
///  * After the framework calls [dispose], the [State] object is considered
///    unmounted and the [mounted] property is false. It is an error to call
///    [setState] at this point. This stage of the lifecycle is terminal: there
///    is no way to remount a [State] object that has been disposed.
///
/// See also:
///
///  * [StatefulWidget], where the current configuration of a [State] is hosted,
///    and whose documentation has sample code for [State].
///  * [StatelessWidget], for widgets that always build the same way given a
///    particular configuration and ambient state.
///  * [InheritedWidget], for widgets that introduce ambient state that can
///    be read by descendant widgets.
///  * [Widget], for an overview of widgets in general.
@optionalTypeArgs
abstract class State<T extends StatefulWidget> with Diagnosticable {
  /// The current configuration.
  ///
  /// A [State] object's configuration is the corresponding [StatefulWidget]
  /// instance. This property is initialized by the framework before calling
  /// [initState]. If the parent updates this location in the tree to a new
  /// widget with the same [runtimeType] and [Widget.key] as the current
  /// configuration, the framework will update this property to refer to the new
  /// widget and then call [didUpdateWidget], passing the old configuration as
  /// an argument.
  T get widget => _widget!;
  T? _widget;

  /// The current stage in the lifecycle for this state object.
  ///
  /// This field is used by the framework when asserts are enabled to verify
  /// that [State] objects move through their lifecycle in an orderly fashion.
  _StateLifecycle _debugLifecycleState = _StateLifecycle.created;

  /// Verifies that the [State] that was created is one that expects to be
  /// created for that particular [Widget].
  bool _debugTypesAreRight(Widget widget) => widget is T;

  /// The location in the tree where this widget builds.
  ///
  /// The framework associates [State] objects with a [BuildContext] after
  /// creating them with [StatefulWidget.createState] and before calling
  /// [initState]. The association is permanent: the [State] object will never
  /// change its [BuildContext]. However, the [BuildContext] itself can be moved
  /// around the tree.
  ///
  /// After calling [dispose], the framework severs the [State] object's
  /// connection with the [BuildContext].
  BuildContext get context {
    assert(() {
      if (_element == null) {
        throw FlutterError(
          'This widget has been unmounted, so the State no longer has a context (and should be considered defunct). \n'
          'Consider canceling any active work during "dispose" or using the "mounted" getter to determine if the State is still active.',
        );
      }
      return true;
    }());
    return _element!;
  }
  StatefulElement? _element;

  /// Whether this [State] object is currently in a tree.
  ///
  /// After creating a [State] object and before calling [initState], the
  /// framework "mounts" the [State] object by associating it with a
  /// [BuildContext]. The [State] object remains mounted until the framework
  /// calls [dispose], after which time the framework will never ask the [State]
  /// object to [build] again.
  ///
  /// It is an error to call [setState] unless [mounted] is true.
  bool get mounted => _element != null;

  /// Called when this object is inserted into the tree.
  ///
  /// The framework will call this method exactly once for each [State] object
  /// it creates.
  ///
  /// Override this method to perform initialization that depends on the
  /// location at which this object was inserted into the tree (i.e., [context])
  /// or on the widget used to configure this object (i.e., [widget]).
  ///
  /// {@template flutter.widgets.State.initState}
  /// If a [State]'s [build] method depends on an object that can itself
  /// change state, for example a [ChangeNotifier] or [Stream], or some
  /// other object to which one can subscribe to receive notifications, then
  /// be sure to subscribe and unsubscribe properly in [initState],
  /// [didUpdateWidget], and [dispose]:
  ///
  ///  * In [initState], subscribe to the object.
  ///  * In [didUpdateWidget] unsubscribe from the old object and subscribe
  ///    to the new one if the updated widget configuration requires
  ///    replacing the object.
  ///  * In [dispose], unsubscribe from the object.
  ///
  /// {@endtemplate}
  ///
  /// You cannot use [BuildContext.dependOnInheritedWidgetOfExactType] from this
  /// method. However, [didChangeDependencies] will be called immediately
  /// following this method, and [BuildContext.dependOnInheritedWidgetOfExactType] can
  /// be used there.
  ///
  /// Implementations of this method should start with a call to the inherited
  /// method, as in `super.initState()`.
  @protected
  @mustCallSuper
  void initState() {
    assert(_debugLifecycleState == _StateLifecycle.created);
    if (kFlutterMemoryAllocationsEnabled) {
      MemoryAllocations.instance.dispatchObjectCreated(
        library: _flutterWidgetsLibrary,
        className: '\$State',
        object: this,
      );
    }
  }

  /// Called whenever the widget configuration changes.
  ///
  /// If the parent widget rebuilds and requests that this location in the tree
  /// update to display a new widget with the same [runtimeType] and
  /// [Widget.key], the framework will update the [widget] property of this
  /// [State] object to refer to the new widget and then call this method
  /// with the previous widget as an argument.
  ///
  /// Override this method to respond when the [widget] changes (e.g., to start
  /// implicit animations).
  ///
  /// The framework always calls [build] after calling [didUpdateWidget], which
  /// means any calls to [setState] in [didUpdateWidget] are redundant.
  ///
  /// {@macro flutter.widgets.State.initState}
  ///
  /// Implementations of this method should start with a call to the inherited
  /// method, as in `super.didUpdateWidget(oldWidget)`.
  ///
  /// _See the discussion at [Element.rebuild] for more information on when this
  /// method is called._
  @mustCallSuper
  @protected
  void didUpdateWidget(covariant T oldWidget) { }

  /// {@macro flutter.widgets.Element.reassemble}
  ///
  /// In addition to this method being invoked, it is guaranteed that the
  /// [build] method will be invoked when a reassemble is signaled. Most
  /// widgets therefore do not need to do anything in the [reassemble] method.
  ///
  /// See also:
  ///
  ///  * [Element.reassemble]
  ///  * [BindingBase.reassembleApplication]
  ///  * [Image], which uses this to reload images.
  @protected
  @mustCallSuper
  void reassemble() { }

  /// Notify the framework that the internal state of this object has changed.
  ///
  /// Whenever you change the internal state of a [State] object, make the
  /// change in a function that you pass to [setState]:
  ///
  /// ```dart
  /// setState(() { _myState = newValue; });
  /// ```
  ///
  /// The provided callback is immediately called synchronously. It must not
  /// return a future (the callback cannot be `async`), since then it would be
  /// unclear when the state was actually being set.
  ///
  /// Calling [setState] notifies the framework that the internal state of this
  /// object has changed in a way that might impact the user interface in this
  /// subtree, which causes the framework to schedule a [build] for this [State]
  /// object.
  ///
  /// If you just change the state directly without calling [setState], the
  /// framework might not schedule a [build] and the user interface for this
  /// subtree might not be updated to reflect the new state.
  ///
  /// Generally it is recommended that the [setState] method only be used to
  /// wrap the actual changes to the state, not any computation that might be
  /// associated with the change. For example, here a value used by the [build]
  /// function is incremented, and then the change is written to disk, but only
  /// the increment is wrapped in the [setState]:
  ///
  /// ```dart
  /// Future<void> _incrementCounter() async {
  ///   setState(() {
  ///     _counter++;
  ///   });
  ///   Directory directory = await getApplicationDocumentsDirectory(); // from path_provider package
  ///   final String dirName = directory.path;
  ///   await File('\$dirName/counter.txt').writeAsString('\$_counter');
  /// }
  /// ```
  ///
  /// It is an error to call this method after the framework calls [dispose].
  /// You can determine whether it is legal to call this method by checking
  /// whether the [mounted] property is true.
  @protected
  void setState(VoidCallback fn) {
    assert(() {
      if (_debugLifecycleState == _StateLifecycle.defunct) {
        throw FlutterError.fromParts(<DiagnosticsNode>[
          ErrorSummary('setState() called after dispose(): \$this'),
          ErrorDescription(
            'This error happens if you call setState() on a State object for a widget that '
            'no longer appears in the widget tree (e.g., whose parent widget no longer '
            'includes the widget in its build). This error can occur when code calls '
            'setState() from a timer or an animation callback.',
          ),
          ErrorHint(
            'The preferred solution is '
            'to cancel the timer or stop listening to the animation in the dispose() '
            'callback. Another solution is to check the "mounted" property of this '
            'object before calling setState() to ensure the object is still in the '
            'tree.',
          ),
          ErrorHint(
            'This error might indicate a memory leak if setState() is being called '
            'because another object is retaining a reference to this State object '
            'after it has been removed from the tree. To avoid memory leaks, '
            'consider breaking the reference to this object during dispose().',
          ),
        ]);
      }
      if (_debugLifecycleState == _StateLifecycle.created && !mounted) {
        throw FlutterError.fromParts(<DiagnosticsNode>[
          ErrorSummary('setState() called in constructor: \$this'),
          ErrorHint(
            'This happens when you call setState() on a State object for a widget that '
            "hasn't been inserted into the widget tree yet. It is not necessary to call "
            'setState() in the constructor, since the state is already assumed to be dirty '
            'when it is initially created.',
          ),
        ]);
      }
      return true;
    }());
    final Object? result = fn() as dynamic;
    assert(() {
      if (result is Future) {
        throw FlutterError.fromParts(<DiagnosticsNode>[
          ErrorSummary('setState() callback argument returned a Future.'),
          ErrorDescription(
            'The setState() method on \$this was called with a closure or method that '
            'returned a Future. Maybe it is marked as "async".',
          ),
          ErrorHint(
            'Instead of performing asynchronous work inside a call to setState(), first '
            'execute the work (without updating the widget state), and then synchronously '
            'update the state inside a call to setState().',
          ),
        ]);
      }
      // We ignore other types of return values so that you can do things like:
      //   setState(() => x = 3);
      return true;
    }());
    _element!.markNeedsBuild();
  }

  /// Called when this object is removed from the tree.
  ///
  /// The framework calls this method whenever it removes this [State] object
  /// from the tree. In some cases, the framework will reinsert the [State]
  /// object into another part of the tree (e.g., if the subtree containing this
  /// [State] object is grafted from one location in the tree to another due to
  /// the use of a [GlobalKey]). If that happens, the framework will call
  /// [activate] to give the [State] object a chance to reacquire any resources
  /// that it released in [deactivate]. It will then also call [build] to give
  /// the [State] object a chance to adapt to its new location in the tree. If
  /// the framework does reinsert this subtree, it will do so before the end of
  /// the animation frame in which the subtree was removed from the tree. For
  /// this reason, [State] objects can defer releasing most resources until the
  /// framework calls their [dispose] method.
  ///
  /// Subclasses should override this method to clean up any links between
  /// this object and other elements in the tree (e.g. if you have provided an
  /// ancestor with a pointer to a descendant's [RenderObject]).
  ///
  /// Implementations of this method should end with a call to the inherited
  /// method, as in `super.deactivate()`.
  ///
  /// See also:
  ///
  ///  * [dispose], which is called after [deactivate] if the widget is removed
  ///    from the tree permanently.
  @protected
  @mustCallSuper
  void deactivate() { }

  /// Called when this object is reinserted into the tree after having been
  /// removed via [deactivate].
  ///
  /// In most cases, after a [State] object has been deactivated, it is _not_
  /// reinserted into the tree, and its [dispose] method will be called to
  /// signal that it is ready to be garbage collected.
  ///
  /// In some cases, however, after a [State] object has been deactivated, the
  /// framework will reinsert it into another part of the tree (e.g., if the
  /// subtree containing this [State] object is grafted from one location in
  /// the tree to another due to the use of a [GlobalKey]). If that happens,
  /// the framework will call [activate] to give the [State] object a chance to
  /// reacquire any resources that it released in [deactivate]. It will then
  /// also call [build] to give the object a chance to adapt to its new
  /// location in the tree. If the framework does reinsert this subtree, it
  /// will do so before the end of the animation frame in which the subtree was
  /// removed from the tree. For this reason, [State] objects can defer
  /// releasing most resources until the framework calls their [dispose] method.
  ///
  /// The framework does not call this method the first time a [State] object
  /// is inserted into the tree. Instead, the framework calls [initState] in
  /// that situation.
  ///
  /// Implementations of this method should start with a call to the inherited
  /// method, as in `super.activate()`.
  ///
  /// See also:
  ///
  ///  * [Element.activate], the corresponding method when an element
  ///    transitions from the "inactive" to the "active" lifecycle state.
  @protected
  @mustCallSuper
  void activate() { }

  /// Called when this object is removed from the tree permanently.
  ///
  /// The framework calls this method when this [State] object will never
  /// build again. After the framework calls [dispose], the [State] object is
  /// considered unmounted and the [mounted] property is false. It is an error
  /// to call [setState] at this point. This stage of the lifecycle is terminal:
  /// there is no way to remount a [State] object that has been disposed.
  ///
  /// Subclasses should override this method to release any resources retained
  /// by this object (e.g., stop any active animations).
  ///
  /// {@macro flutter.widgets.State.initState}
  ///
  /// Implementations of this method should end with a call to the inherited
  /// method, as in `super.dispose()`.
  ///
  /// See also:
  ///
  ///  * [deactivate], which is called prior to [dispose].
  @protected
  @mustCallSuper
  void dispose() {
    assert(_debugLifecycleState == _StateLifecycle.ready);
    assert(() {
      _debugLifecycleState = _StateLifecycle.defunct;
      return true;
    }());
    if (kFlutterMemoryAllocationsEnabled) {
      MemoryAllocations.instance.dispatchObjectDisposed(object: this);
    }
  }

  /// Describes the part of the user interface represented by this widget.
  ///
  /// The framework calls this method in a number of different situations. For
  /// example:
  ///
  ///  * After calling [initState].
  ///  * After calling [didUpdateWidget].
  ///  * After receiving a call to [setState].
  ///  * After a dependency of this [State] object changes (e.g., an
  ///    [InheritedWidget] referenced by the previous [build] changes).
  ///  * After calling [deactivate] and then reinserting the [State] object into
  ///    the tree at another location.
  ///
  /// This method can potentially be called in every frame and should not have
  /// any side effects beyond building a widget.
  ///
  /// The framework replaces the subtree below this widget with the widget
  /// returned by this method, either by updating the existing subtree or by
  /// removing the subtree and inflating a new subtree, depending on whether the
  /// widget returned by this method can update the root of the existing
  /// subtree, as determined by calling [Widget.canUpdate].
  ///
  /// Typically implementations return a newly created constellation of widgets
  /// that are configured with information from this widget's constructor, the
  /// given [BuildContext], and the internal state of this [State] object.
  ///
  /// The given [BuildContext] contains information about the location in the
  /// tree at which this widget is being built. For example, the context
  /// provides the set of inherited widgets for this location in the tree. The
  /// [BuildContext] argument is always the same as the [context] property of
  /// this [State] object and will remain the same for the lifetime of this
  /// object. The [BuildContext] argument is provided redundantly here so that
  /// this method matches the signature for a [WidgetBuilder].
  ///
  /// ## Design discussion
  ///
  /// ### Why is the [build] method on [State], and not [StatefulWidget]?
  ///
  /// Putting a `Widget build(BuildContext context)` method on [State] rather
  /// than putting a `Widget build(BuildContext context, State state)` method
  /// on [StatefulWidget] gives developers more flexibility when subclassing
  /// [StatefulWidget].
  ///
  /// For example, [AnimatedWidget] is a subclass of [StatefulWidget] that
  /// introduces an abstract `Widget build(BuildContext context)` method for its
  /// subclasses to implement. If [StatefulWidget] already had a [build] method
  /// that took a [State] argument, [AnimatedWidget] would be forced to provide
  /// its [State] object to subclasses even though its [State] object is an
  /// internal implementation detail of [AnimatedWidget].
  ///
  /// Conceptually, [StatelessWidget] could also be implemented as a subclass of
  /// [StatefulWidget] in a similar manner. If the [build] method were on
  /// [StatefulWidget] rather than [State], that would not be possible anymore.
  ///
  /// Putting the [build] function on [State] rather than [StatefulWidget] also
  /// helps avoid a category of bugs related to closures implicitly capturing
  /// `this`. If you defined a closure in a [build] function on a
  /// [StatefulWidget], that closure would implicitly capture `this`, which is
  /// the current widget instance, and would have the (immutable) fields of that
  /// instance in scope:
  ///
  /// ```dart
  /// // (this is not valid Flutter code)
  /// class MyButton extends StatefulWidgetX {
  ///   MyButton({super.key, required this.color});
  ///
  ///   final Color color;
  ///
  ///   @override
  ///   Widget build(BuildContext context, State state) {
  ///     return SpecialWidget(
  ///       handler: () { print('color: \$color'); },
  ///     );
  ///   }
  /// }
  /// ```
  ///
  /// For example, suppose the parent builds `MyButton` with `color` being blue,
  /// the `\$color` in the print function refers to blue, as expected. Now,
  /// suppose the parent rebuilds `MyButton` with green. The closure created by
  /// the first build still implicitly refers to the original widget and the
  /// `\$color` still prints blue even through the widget has been updated to
  /// green; should that closure outlive its widget, it would print outdated
  /// information.
  ///
  /// In contrast, with the [build] function on the [State] object, closures
  /// created during [build] implicitly capture the [State] instance instead of
  /// the widget instance:
  ///
  /// ```dart
  /// class MyButton extends StatefulWidget {
  ///   const MyButton({super.key, this.color = Colors.teal});
  ///
  ///   final Color color;
  ///   // ...
  /// }
  ///
  /// class MyButtonState extends State<MyButton> {
  ///   // ...
  ///   @override
  ///   Widget build(BuildContext context) {
  ///     return SpecialWidget(
  ///       handler: () { print('color: \${widget.color}'); },
  ///     );
  ///   }
  /// }
  /// ```
  ///
  /// Now when the parent rebuilds `MyButton` with green, the closure created by
  /// the first build still refers to [State] object, which is preserved across
  /// rebuilds, but the framework has updated that [State] object's [widget]
  /// property to refer to the new `MyButton` instance and `\${widget.color}`
  /// prints green, as expected.
  ///
  /// See also:
  ///
  ///  * [StatefulWidget], which contains the discussion on performance considerations.
  @protected
  Widget build(BuildContext context);

  /// Called when a dependency of this [State] object changes.
  ///
  /// For example, if the previous call to [build] referenced an
  /// [InheritedWidget] that later changed, the framework would call this
  /// method to notify this object about the change.
  ///
  /// This method is also called immediately after [initState]. It is safe to
  /// call [BuildContext.dependOnInheritedWidgetOfExactType] from this method.
  ///
  /// Subclasses rarely override this method because the framework always
  /// calls [build] after a dependency changes. Some subclasses do override
  /// this method because they need to do some expensive work (e.g., network
  /// fetches) when their dependencies change, and that work would be too
  /// expensive to do for every build.
  @protected
  @mustCallSuper
  void didChangeDependencies() { }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    assert(() {
      properties.add(EnumProperty<_StateLifecycle>('lifecycle state', _debugLifecycleState, defaultValue: _StateLifecycle.ready));
      return true;
    }());
    properties.add(ObjectFlagProperty<T>('_widget', _widget, ifNull: 'no widget'));
    properties.add(ObjectFlagProperty<StatefulElement>('_element', _element, ifNull: 'not mounted'));
  }
}

/// A widget that has a child widget provided to it, instead of building a new
/// widget.
///
/// Useful as a base class for other widgets, such as [InheritedWidget] and
/// [ParentDataWidget].
///
/// See also:
///
///  * [InheritedWidget], for widgets that introduce ambient state that can
///    be read by descendant widgets.
///  * [ParentDataWidget], for widgets that populate the
///    [RenderObject.parentData] slot of their child's [RenderObject] to
///    configure the parent widget's layout.
///  * [StatefulWidget] and [State], for widgets that can build differently
///    several times over their lifetime.
///  * [StatelessWidget], for widgets that always build the same way given a
///    particular configuration and ambient state.
///  * [Widget], for an overview of widgets in general.
abstract class ProxyWidget extends Widget {
  /// Creates a widget that has exactly one child widget.
  const ProxyWidget({ super.key, required this.child });

  /// The widget below this widget in the tree.
  ///
  /// {@template flutter.widgets.ProxyWidget.child}
  /// This widget can only have one child. To lay out multiple children, let this
  /// widget's child be a widget such as [Row], [Column], or [Stack], which have a
  /// `children` property, and then provide the children to that widget.
  /// {@endtemplate}
  final Widget child;
}

/// Base class for widgets that hook [ParentData] information to children of
/// [RenderObjectWidget]s.
///
/// This can be used to provide per-child configuration for
/// [RenderObjectWidget]s with more than one child. For example, [Stack] uses
/// the [Positioned] parent data widget to position each child.
///
/// A [ParentDataWidget] is specific to a particular kind of [ParentData]. That
/// class is `T`, the [ParentData] type argument.
///
/// {@tool snippet}
///
/// This example shows how you would build a [ParentDataWidget] to configure a
/// `FrogJar` widget's children by specifying a [Size] for each one.
///
/// ```dart
/// class FrogSize extends ParentDataWidget<FrogJarParentData> {
///   const FrogSize({
///     super.key,
///     required this.size,
///     required super.child,
///   });
///
///   final Size size;
///
///   @override
///   void applyParentData(RenderObject renderObject) {
///     final FrogJarParentData parentData = renderObject.parentData! as FrogJarParentData;
///     if (parentData.size != size) {
///       parentData.size = size;
///       final RenderFrogJar targetParent = renderObject.parent! as RenderFrogJar;
///       targetParent.markNeedsLayout();
///     }
///   }
///
///   @override
///   Type get debugTypicalAncestorWidgetClass => FrogJar;
/// }
/// ```
/// {@end-tool}
///
/// See also:
///
///  * [RenderObject], the superclass for layout algorithms.
///  * [RenderObject.parentData], the slot that this class configures.
///  * [ParentData], the superclass of the data that will be placed in
///    [RenderObject.parentData] slots. The `T` type parameter for
///    [ParentDataWidget] is a [ParentData].
///  * [RenderObjectWidget], the class for widgets that wrap [RenderObject]s.
///  * [StatefulWidget] and [State], for widgets that can build differently
///    several times over their lifetime.
abstract class ParentDataWidget<T extends ParentData> extends ProxyWidget {
  /// Abstract const constructor. This constructor enables subclasses to provide
  /// const constructors so that they can be used in const expressions.
  const ParentDataWidget({ super.key, required super.child });

  @override
  ParentDataElement<T> createElement() => ParentDataElement<T>(this);

  /// Checks if this widget can apply its parent data to the provided
  /// `renderObject`.
  ///
  /// The [RenderObject.parentData] of the provided `renderObject` is
  /// typically set up by an ancestor [RenderObjectWidget] of the type returned
  /// by [debugTypicalAncestorWidgetClass].
  ///
  /// This is called just before [applyParentData] is invoked with the same
  /// [RenderObject] provided to that method.
  bool debugIsValidRenderObject(RenderObject renderObject) {
    assert(T != dynamic);
    assert(T != ParentData);
    return renderObject.parentData is T;
  }

  /// The [RenderObjectWidget] that is typically used to set up the [ParentData]
  /// that [applyParentData] will write to.
  ///
  /// This is only used in error messages to tell users what widget typically
  /// wraps this ParentDataWidget.
  Type get debugTypicalAncestorWidgetClass;

  Iterable<DiagnosticsNode> _debugDescribeIncorrectParentDataType({
    required ParentData? parentData,
    RenderObjectWidget? parentDataCreator,
    DiagnosticsNode? ownershipChain,
  }) {
    assert(T != dynamic);
    assert(T != ParentData);

    final String description = 'The ParentDataWidget \$this wants to apply ParentData of type \$T to a RenderObject';
    return <DiagnosticsNode>[
      if (parentData == null)
        ErrorDescription(
          '\$description, which has not been set up to receive any ParentData.',
        )
      else
        ErrorDescription(
          '\$description, which has been set up to accept ParentData of incompatible type \${parentData.runtimeType}.',
        ),
      ErrorHint(
        'Usually, this means that the \$runtimeType widget has the wrong ancestor RenderObjectWidget. '
        'Typically, \$runtimeType widgets are placed directly inside \$debugTypicalAncestorWidgetClass widgets.',
      ),
      if (parentDataCreator != null)
        ErrorHint(
          'The offending \$runtimeType is currently placed inside a \${parentDataCreator.runtimeType} widget.',
        ),
      if (ownershipChain != null)
        ErrorDescription(
          'The ownership chain for the RenderObject that received the incompatible parent data was:\n  \$ownershipChain',
        ),
    ];
  }

  /// Write the data from this widget into the given render object's parent data.
  ///
  /// The framework calls this function whenever it detects that the
  /// [RenderObject] associated with the [child] has outdated
  /// [RenderObject.parentData]. For example, if the render object was recently
  /// inserted into the render tree, the render object's parent data might not
  /// match the data in this widget.
  ///
  /// Subclasses are expected to override this function to copy data from their
  /// fields into the [RenderObject.parentData] field of the given render
  /// object. The render object's parent is guaranteed to have been created by a
  /// widget of type `T`, which usually means that this function can assume that
  /// the render object's parent data object inherits from a particular class.
  ///
  /// If this function modifies data that can change the parent's layout or
  /// painting, this function is responsible for calling
  /// [RenderObject.markNeedsLayout] or [RenderObject.markNeedsPaint] on the
  /// parent, as appropriate.
  @protected
  void applyParentData(RenderObject renderObject);

  /// Whether the [ParentDataElement.applyWidgetOutOfTurn] method is allowed
  /// with this widget.
  ///
  /// This should only return true if this widget represents a [ParentData]
  /// configuration that will have no impact on the layout or paint phase.
  ///
  /// See also:
  ///
  ///  * [ParentDataElement.applyWidgetOutOfTurn], which verifies this in debug
  ///    mode.
  @protected
  bool debugCanApplyOutOfTurn() => false;
}

/// Base class for widgets that efficiently propagate information down the tree.
///
/// {@youtube 560 315 https://www.youtube.com/watch?v=og-vJqLzg2c}
///
/// To obtain the nearest instance of a particular type of inherited widget from
/// a build context, use [BuildContext.dependOnInheritedWidgetOfExactType].
///
/// Inherited widgets, when referenced in this way, will cause the consumer to
/// rebuild when the inherited widget itself changes state.
///
/// {@youtube 560 315 https://www.youtube.com/watch?v=Zbm3hjPjQMk}
///
/// {@tool snippet}
///
/// The following is a skeleton of an inherited widget called `FrogColor`:
///
/// ```dart
/// class FrogColor extends InheritedWidget {
///   const FrogColor({
///     super.key,
///     required this.color,
///     required super.child,
///   });
///
///   final Color color;
///
///   static FrogColor? maybeOf(BuildContext context) {
///     return context.dependOnInheritedWidgetOfExactType<FrogColor>();
///   }
///
///   static FrogColor of(BuildContext context) {
///     final FrogColor? result = maybeOf(context);
///     assert(result != null, 'No FrogColor found in context');
///     return result!;
///   }
///
///   @override
///   bool updateShouldNotify(FrogColor oldWidget) => color != oldWidget.color;
/// }
/// ```
/// {@end-tool}
///
/// ## Implementing the `of` and `maybeOf` methods
///
/// The convention is to provide two static methods, `of` and `maybeOf`, on the
/// [InheritedWidget] which call
/// [BuildContext.dependOnInheritedWidgetOfExactType]. This allows the class to
/// define its own fallback logic in case there isn't a widget in scope.
///
/// The `of` method typically returns a non-nullable instance and asserts if the
/// [InheritedWidget] isn't found, and the `maybeOf` method returns a nullable
/// instance, and returns null if the [InheritedWidget] isn't found. The `of`
/// method is typically implemented by calling `maybeOf` internally.
///
/// Sometimes, the `of` and `maybeOf` methods return some data rather than the
/// inherited widget itself; for example, in this case it could have returned a
/// [Color] instead of the `FrogColor` widget.
///
/// Occasionally, the inherited widget is an implementation detail of another
/// class, and is therefore private. The `of` and `maybeOf` methods in that case
/// are typically implemented on the public class instead. For example, [Theme]
/// is implemented as a [StatelessWidget] that builds a private inherited
/// widget; [Theme.of] looks for that private inherited widget using
/// [BuildContext.dependOnInheritedWidgetOfExactType] and then returns the
/// [ThemeData] inside it.
///
/// ## Calling the `of` or `maybeOf` methods
///
/// When using the `of` or `maybeOf` methods, the `context` must be a descendant
/// of the [InheritedWidget], meaning it must be "below" the [InheritedWidget]
/// in the tree.
///
/// {@tool snippet}
///
/// In this example, the `context` used is the one from the [Builder], which is
/// a child of the `FrogColor` widget, so this works.
///
/// ```dart
/// // continuing from previous example...
/// class MyPage extends StatelessWidget {
///   const MyPage({super.key});
///
///   @override
///   Widget build(BuildContext context) {
///     return Scaffold(
///       body: FrogColor(
///         color: Colors.green,
///         child: Builder(
///           builder: (BuildContext innerContext) {
///             return Text(
///               'Hello Frog',
///               style: TextStyle(color: FrogColor.of(innerContext).color),
///             );
///           },
///         ),
///       ),
///     );
///   }
/// }
/// ```
/// {@end-tool}
///
/// {@tool snippet}
///
/// In this example, the `context` used is the one from the `MyOtherPage`
/// widget, which is a parent of the `FrogColor` widget, so this does not work,
/// and will assert when `FrogColor.of` is called.
///
/// ```dart
/// // continuing from previous example...
///
/// class MyOtherPage extends StatelessWidget {
///   const MyOtherPage({super.key});
///
///   @override
///   Widget build(BuildContext context) {
///     return Scaffold(
///       body: FrogColor(
///         color: Colors.green,
///         child: Text(
///           'Hello Frog',
///           style: TextStyle(color: FrogColor.of(context).color),
///         ),
///       ),
///     );
///   }
/// }
/// ```
/// {@end-tool} {@youtube 560 315 https://www.youtube.com/watch?v=1t-8rBCGBYw}
///
/// See also:
///
/// * [StatefulWidget] and [State], for widgets that can build differently
///   several times over their lifetime.
/// * [StatelessWidget], for widgets that always build the same way given a
///   particular configuration and ambient state.
/// * [Widget], for an overview of widgets in general.
/// * [InheritedNotifier], an inherited widget whose value can be a
///   [Listenable], and which will notify dependents whenever the value sends
///   notifications.
/// * [InheritedModel], an inherited widget that allows clients to subscribe to
///   changes for subparts of the value.
abstract class InheritedWidget extends ProxyWidget {
  /// Abstract const constructor. This constructor enables subclasses to provide
  /// const constructors so that they can be used in const expressions.
  const InheritedWidget({ super.key, required super.child });

  @override
  InheritedElement createElement() => InheritedElement(this);

  /// Whether the framework should notify widgets that inherit from this widget.
  ///
  /// When this widget is rebuilt, sometimes we need to rebuild the widgets that
  /// inherit from this widget but sometimes we do not. For example, if the data
  /// held by this widget is the same as the data held by `oldWidget`, then we
  /// do not need to rebuild the widgets that inherited the data held by
  /// `oldWidget`.
  ///
  /// The framework distinguishes these cases by calling this function with the
  /// widget that previously occupied this location in the tree as an argument.
  /// The given widget is guaranteed to have the same [runtimeType] as this
  /// object.
  @protected
  bool updateShouldNotify(covariant InheritedWidget oldWidget);
}

/// RenderObjectWidgets provide the configuration for [RenderObjectElement]s,
/// which wrap [RenderObject]s, which provide the actual rendering of the
/// application.
///
/// See also:
///
///  * [MultiChildRenderObjectWidget], which configures a [RenderObject] with
///    a single list of children.
///  * [SlottedMultiChildRenderObjectWidgetMixin], which configures a
///    [RenderObject] that organizes its children in different named slots.
abstract class RenderObjectWidget extends Widget {
  /// Abstract const constructor. This constructor enables subclasses to provide
  /// const constructors so that they can be used in const expressions.
  const RenderObjectWidget({ super.key });

  /// RenderObjectWidgets always inflate to a [RenderObjectElement] subclass.
  @override
  @factory
  RenderObjectElement createElement();

  /// Creates an instance of the [RenderObject] class that this
  /// [RenderObjectWidget] represents, using the configuration described by this
  /// [RenderObjectWidget].
  ///
  /// This method should not do anything with the children of the render object.
  /// That should instead be handled by the method that overrides
  /// [RenderObjectElement.mount] in the object rendered by this object's
  /// [createElement] method. See, for example,
  /// [SingleChildRenderObjectElement.mount].
  @protected
  @factory
  RenderObject createRenderObject(BuildContext context);

  /// Copies the configuration described by this [RenderObjectWidget] to the
  /// given [RenderObject], which will be of the same type as returned by this
  /// object's [createRenderObject].
  ///
  /// This method should not do anything to update the children of the render
  /// object. That should instead be handled by the method that overrides
  /// [RenderObjectElement.update] in the object rendered by this object's
  /// [createElement] method. See, for example,
  /// [SingleChildRenderObjectElement.update].
  @protected
  void updateRenderObject(BuildContext context, covariant RenderObject renderObject) { }

  /// A render object previously associated with this widget has been removed
  /// from the tree. The given [RenderObject] will be of the same type as
  /// returned by this object's [createRenderObject].
  @protected
  void didUnmountRenderObject(covariant RenderObject renderObject) { }
}

/// A superclass for RenderObjectWidgets that configure RenderObject subclasses
/// that have no children.
abstract class LeafRenderObjectWidget extends RenderObjectWidget {
  /// Abstract const constructor. This constructor enables subclasses to provide
  /// const constructors so that they can be used in const expressions.
  const LeafRenderObjectWidget({ super.key });

  @override
  LeafRenderObjectElement createElement() => LeafRenderObjectElement(this);
}

/// A superclass for [RenderObjectWidget]s that configure [RenderObject] subclasses
/// that have a single child slot. (This superclass only provides the storage
/// for that child, it doesn't actually provide the updating logic.)
///
/// Typically, the render object assigned to this widget will make use of
/// [RenderObjectWithChildMixin] to implement a single-child model. The mixin
/// exposes a [RenderObjectWithChildMixin.child] property that allows
/// retrieving the render object belonging to the [child] widget.
abstract class SingleChildRenderObjectWidget extends RenderObjectWidget {
  /// Abstract const constructor. This constructor enables subclasses to provide
  /// const constructors so that they can be used in const expressions.
  const SingleChildRenderObjectWidget({ super.key, this.child });

  /// The widget below this widget in the tree.
  ///
  /// {@macro flutter.widgets.ProxyWidget.child}
  final Widget? child;

  @override
  SingleChildRenderObjectElement createElement() => SingleChildRenderObjectElement(this);
}

/// A superclass for [RenderObjectWidget]s that configure [RenderObject] subclasses
/// that have a single list of children. (This superclass only provides the
/// storage for that child list, it doesn't actually provide the updating
/// logic.)
///
/// Subclasses must return a [RenderObject] that mixes in
/// [ContainerRenderObjectMixin], which provides the necessary functionality to
/// visit the children of the container render object (the render object
/// belonging to the [children] widgets). Typically, subclasses will return a
/// [RenderBox] that mixes in both [ContainerRenderObjectMixin] and
/// [RenderBoxContainerDefaultsMixin].
///
/// See also:
///
///  * [Stack], which uses [MultiChildRenderObjectWidget].
///  * [RenderStack], for an example implementation of the associated render
///    object.
///  * [SlottedMultiChildRenderObjectWidgetMixin], which configures a
///    [RenderObject] that instead of having a single list of children organizes
///    its children in named slots.
abstract class MultiChildRenderObjectWidget extends RenderObjectWidget {
  /// Initializes fields for subclasses.
  ///
  /// The [children] argument must not be null and must not contain any null
  /// objects.
  const MultiChildRenderObjectWidget({ super.key, this.children = const <Widget>[] });

  /// The widgets below this widget in the tree.
  ///
  /// If this list is going to be mutated, it is usually wise to put a [Key] on
  /// each of the child widgets, so that the framework can match old
  /// configurations to new configurations and maintain the underlying render
  /// objects.
  ///
  /// Also, a [Widget] in Flutter is immutable, so directly modifying the
  /// [children] such as `someMultiChildRenderObjectWidget.children.add(...)` or
  /// as the example code below will result in incorrect behaviors. Whenever the
  /// children list is modified, a new list object should be provided.
  ///
  /// ```dart
  /// // This code is incorrect.
  /// class SomeWidgetState extends State<SomeWidget> {
  ///   final List<Widget> _children = <Widget>[];
  ///
  ///   void someHandler() {
  ///     setState(() {
  ///       _children.add(const ChildWidget());
  ///     });
  ///   }
  ///
  ///   @override
  ///   Widget build(BuildContext context) {
  ///     // Reusing `List<Widget> _children` here is problematic.
  ///     return Row(children: _children);
  ///   }
  /// }
  /// ```
  ///
  /// The following code corrects the problem mentioned above.
  ///
  /// ```dart
  /// class SomeWidgetState extends State<SomeWidget> {
  ///   final List<Widget> _children = <Widget>[];
  ///
  ///   void someHandler() {
  ///     setState(() {
  ///       // The key here allows Flutter to reuse the underlying render
  ///       // objects even if the children list is recreated.
  ///       _children.add(ChildWidget(key: UniqueKey()));
  ///     });
  ///   }
  ///
  ///   @override
  ///   Widget build(BuildContext context) {
  ///     // Always create a new list of children as a Widget is immutable.
  ///     return Row(children: _children.toList());
  ///   }
  /// }
  /// ```
  final List<Widget> children;

  @override
  MultiChildRenderObjectElement createElement() => MultiChildRenderObjectElement(this);
}


// ELEMENTS

enum _ElementLifecycle {
  initial,
  active,
  inactive,
  defunct,
}

class _InactiveElements {
  bool _locked = false;
  final Set<Element> _elements = HashSet<Element>();

  void _unmount(Element element) {
    assert(element._lifecycleState == _ElementLifecycle.inactive);
    assert(() {
      if (debugPrintGlobalKeyedWidgetLifecycle) {
        if (element.widget.key is GlobalKey) {
          debugPrint('Discarding \$element from inactive elements list.');
        }
      }
      return true;
    }());
    element.visitChildren((Element child) {
      assert(child._parent == element);
      _unmount(child);
    });
    element.unmount();
    assert(element._lifecycleState == _ElementLifecycle.defunct);
  }

  void _unmountAll() {
    _locked = true;
    final List<Element> elements = _elements.toList()..sort(Element._sort);
    _elements.clear();
    try {
      elements.reversed.forEach(_unmount);
    } finally {
      assert(_elements.isEmpty);
      _locked = false;
    }
  }

  static void _deactivateRecursively(Element element) {
    assert(element._lifecycleState == _ElementLifecycle.active);
    element.deactivate();
    assert(element._lifecycleState == _ElementLifecycle.inactive);
    element.visitChildren(_deactivateRecursively);
    assert(() {
      element.debugDeactivated();
      return true;
    }());
  }

  void add(Element element) {
    assert(!_locked);
    assert(!_elements.contains(element));
    assert(element._parent == null);
    if (element._lifecycleState == _ElementLifecycle.active) {
      _deactivateRecursively(element);
    }
    _elements.add(element);
  }

  void remove(Element element) {
    assert(!_locked);
    assert(_elements.contains(element));
    assert(element._parent == null);
    _elements.remove(element);
    assert(element._lifecycleState != _ElementLifecycle.active);
  }

  bool debugContains(Element element) {
    late bool result;
    assert(() {
      result = _elements.contains(element);
      return true;
    }());
    return result;
  }
}

/// Signature for the callback to [BuildContext.visitChildElements].
///
/// The argument is the child being visited.
///
/// It is safe to call `element.visitChildElements` reentrantly within
/// this callback.
typedef ElementVisitor = void Function(Element element);

/// Signature for the callback to [BuildContext.visitAncestorElements].
///
/// The argument is the ancestor being visited.
///
/// Return false to stop the walk.
typedef ConditionalElementVisitor = bool Function(Element element);

/// A handle to the location of a widget in the widget tree.
///
/// This class presents a set of methods that can be used from
/// [StatelessWidget.build] methods and from methods on [State] objects.
///
/// [BuildContext] objects are passed to [WidgetBuilder] functions (such as
/// [StatelessWidget.build]), and are available from the [State.context] member.
/// Some static functions (e.g. [showDialog], [Theme.of], and so forth) also
/// take build contexts so that they can act on behalf of the calling widget, or
/// obtain data specifically for the given context.
///
/// Each widget has its own [BuildContext], which becomes the parent of the
/// widget returned by the [StatelessWidget.build] or [State.build] function.
/// (And similarly, the parent of any children for [RenderObjectWidget]s.)
///
/// In particular, this means that within a build method, the build context of
/// the widget of the build method is not the same as the build context of the
/// widgets returned by that build method. This can lead to some tricky cases.
/// For example, [Theme.of(context)] looks for the nearest enclosing [Theme] of
/// the given build context. If a build method for a widget Q includes a [Theme]
/// within its returned widget tree, and attempts to use [Theme.of] passing its
/// own context, the build method for Q will not find that [Theme] object. It
/// will instead find whatever [Theme] was an ancestor to the widget Q. If the
/// build context for a subpart of the returned tree is needed, a [Builder]
/// widget can be used: the build context passed to the [Builder.builder]
/// callback will be that of the [Builder] itself.
///
/// For example, in the following snippet, the [ScaffoldState.showBottomSheet]
/// method is called on the [Scaffold] widget that the build method itself
/// creates. If a [Builder] had not been used, and instead the `context`
/// argument of the build method itself had been used, no [Scaffold] would have
/// been found, and the [Scaffold.of] function would have returned null.
///
/// ```dart
/// @override
/// Widget build(BuildContext context) {
///   // here, Scaffold.of(context) returns null
///   return Scaffold(
///     appBar: AppBar(title: const Text('Demo')),
///     body: Builder(
///       builder: (BuildContext context) {
///         return TextButton(
///           child: const Text('BUTTON'),
///           onPressed: () {
///             Scaffold.of(context).showBottomSheet<void>(
///               (BuildContext context) {
///                 return Container(
///                   alignment: Alignment.center,
///                   height: 200,
///                   color: Colors.amber,
///                   child: Center(
///                     child: Column(
///                       mainAxisSize: MainAxisSize.min,
///                       children: <Widget>[
///                         const Text('BottomSheet'),
///                         ElevatedButton(
///                           child: const Text('Close BottomSheet'),
///                           onPressed: () {
///                             Navigator.pop(context);
///                           },
///                         )
///                       ],
///                     ),
///                   ),
///                 );
///               },
///             );
///           },
///         );
///       },
///     )
///   );
/// }
/// ```
///
/// The [BuildContext] for a particular widget can change location over time as
/// the widget is moved around the tree. Because of this, values returned from
/// the methods on this class should not be cached beyond the execution of a
/// single synchronous function.
///
/// {@youtube 560 315 https://www.youtube.com/watch?v=rIaaH87z1-g}
///
/// Avoid storing instances of [BuildContext]s because they may become invalid
/// if the widget they are associated with is unmounted from the widget tree.
/// {@template flutter.widgets.BuildContext.asynchronous_gap}
/// If a [BuildContext] is used across an asynchronous gap (i.e. after performing
/// an asynchronous operation), consider checking [mounted] to determine whether
/// the context is still valid before interacting with it:
///
/// ```dart
///   @override
///   Widget build(BuildContext context) {
///     return OutlinedButton(
///       onPressed: () async {
///         await Future<void>.delayed(const Duration(seconds: 1));
///         if (context.mounted) {
///           Navigator.of(context).pop();
///         }
///       },
///       child: const Text('Delayed pop'),
///     );
///   }
/// ```
/// {@endtemplate}
///
/// [BuildContext] objects are actually [Element] objects. The [BuildContext]
/// interface is used to discourage direct manipulation of [Element] objects.
abstract class BuildContext {
  /// The current configuration of the [Element] that is this [BuildContext].
  Widget get widget;

  /// The [BuildOwner] for this context. The [BuildOwner] is in charge of
  /// managing the rendering pipeline for this context.
  BuildOwner? get owner;

  /// Whether the [Widget] this context is associated with is currently
  /// mounted in the widget tree.
  ///
  /// Accessing the properties of the [BuildContext] or calling any methods on
  /// it is only valid while mounted is true. If mounted is false, assertions
  /// will trigger.
  ///
  /// Once unmounted, a given [BuildContext] will never become mounted again.
  ///
  /// {@macro flutter.widgets.BuildContext.asynchronous_gap}
  bool get mounted;

  /// Whether the [widget] is currently updating the widget or render tree.
  ///
  /// For [StatefulWidget]s and [StatelessWidget]s this flag is true while
  /// their respective build methods are executing.
  /// [RenderObjectWidget]s set this to true while creating or configuring their
  /// associated [RenderObject]s.
  /// Other [Widget] types may set this to true for conceptually similar phases
  /// of their lifecycle.
  ///
  /// When this is true, it is safe for [widget] to establish a dependency to an
  /// [InheritedWidget] by calling [dependOnInheritedElement] or
  /// [dependOnInheritedWidgetOfExactType].
  ///
  /// Accessing this flag in release mode is not valid.
  bool get debugDoingBuild;

  /// The current [RenderObject] for the widget. If the widget is a
  /// [RenderObjectWidget], this is the render object that the widget created
  /// for itself. Otherwise, it is the render object of the first descendant
  /// [RenderObjectWidget].
  ///
  /// This method will only return a valid result after the build phase is
  /// complete. It is therefore not valid to call this from a build method.
  /// It should only be called from interaction event handlers (e.g.
  /// gesture callbacks) or layout or paint callbacks. It is also not valid to
  /// call if [State.mounted] returns false.
  ///
  /// If the render object is a [RenderBox], which is the common case, then the
  /// size of the render object can be obtained from the [size] getter. This is
  /// only valid after the layout phase, and should therefore only be examined
  /// from paint callbacks or interaction event handlers (e.g. gesture
  /// callbacks).
  ///
  /// For details on the different phases of a frame, see the discussion at
  /// [WidgetsBinding.drawFrame].
  ///
  /// Calling this method is theoretically relatively expensive (O(N) in the
  /// depth of the tree), but in practice is usually cheap because the tree
  /// usually has many render objects and therefore the distance to the nearest
  /// render object is usually short.
  RenderObject? findRenderObject();

  /// The size of the [RenderBox] returned by [findRenderObject].
  ///
  /// This getter will only return a valid result after the layout phase is
  /// complete. It is therefore not valid to call this from a build method.
  /// It should only be called from paint callbacks or interaction event
  /// handlers (e.g. gesture callbacks).
  ///
  /// For details on the different phases of a frame, see the discussion at
  /// [WidgetsBinding.drawFrame].
  ///
  /// This getter will only return a valid result if [findRenderObject] actually
  /// returns a [RenderBox]. If [findRenderObject] returns a render object that
  /// is not a subtype of [RenderBox] (e.g., [RenderView]), this getter will
  /// throw an exception in debug mode and will return null in release mode.
  ///
  /// Calling this getter is theoretically relatively expensive (O(N) in the
  /// depth of the tree), but in practice is usually cheap because the tree
  /// usually has many render objects and therefore the distance to the nearest
  /// render object is usually short.
  Size? get size;

  /// Registers this build context with [ancestor] such that when
  /// [ancestor]'s widget changes this build context is rebuilt.
  ///
  /// Returns `ancestor.widget`.
  ///
  /// This method is rarely called directly. Most applications should use
  /// [dependOnInheritedWidgetOfExactType], which calls this method after finding
  /// the appropriate [InheritedElement] ancestor.
  ///
  /// All of the qualifications about when [dependOnInheritedWidgetOfExactType] can
  /// be called apply to this method as well.
  InheritedWidget dependOnInheritedElement(InheritedElement ancestor, { Object? aspect });

  /// Returns the nearest widget of the given type `T` and creates a dependency
  /// on it, or null if no appropriate widget is found.
  ///
  /// The widget found will be a concrete [InheritedWidget] subclass, and
  /// calling [dependOnInheritedWidgetOfExactType] registers this build context
  /// with the returned widget. When that widget changes (or a new widget of
  /// that type is introduced, or the widget goes away), this build context is
  /// rebuilt so that it can obtain new values from that widget.
  ///
  /// {@template flutter.widgets.BuildContext.dependOnInheritedWidgetOfExactType}
  /// This is typically called implicitly from `of()` static methods, e.g.
  /// [Theme.of].
  ///
  /// This method should not be called from widget constructors or from
  /// [State.initState] methods, because those methods would not get called
  /// again if the inherited value were to change. To ensure that the widget
  /// correctly updates itself when the inherited value changes, only call this
  /// (directly or indirectly) from build methods, layout and paint callbacks,
  /// or from [State.didChangeDependencies].
  ///
  /// This method should not be called from [State.dispose] because the element
  /// tree is no longer stable at that time. To refer to an ancestor from that
  /// method, save a reference to the ancestor in [State.didChangeDependencies].
  /// It is safe to use this method from [State.deactivate], which is called
  /// whenever the widget is removed from the tree.
  ///
  /// It is also possible to call this method from interaction event handlers
  /// (e.g. gesture callbacks) or timers, to obtain a value once, as long as
  /// that value is not cached and/or reused later.
  ///
  /// Calling this method is O(1) with a small constant factor, but will lead to
  /// the widget being rebuilt more often.
  ///
  /// Once a widget registers a dependency on a particular type by calling this
  /// method, it will be rebuilt, and [State.didChangeDependencies] will be
  /// called, whenever changes occur relating to that widget until the next time
  /// the widget or one of its ancestors is moved (for example, because an
  /// ancestor is added or removed).
  ///
  /// The [aspect] parameter is only used when `T` is an
  /// [InheritedWidget] subclasses that supports partial updates, like
  /// [InheritedModel]. It specifies what "aspect" of the inherited
  /// widget this context depends on.
  /// {@endtemplate}
  T? dependOnInheritedWidgetOfExactType<T extends InheritedWidget>({ Object? aspect });

  /// Returns the nearest widget of the given [InheritedWidget] subclass `T` or
  /// null if an appropriate ancestor is not found.
  ///
  /// This method does not introduce a dependency the way that the more typical
  /// [dependOnInheritedWidgetOfExactType] does, so this context will not be
  /// rebuilt if the [InheritedWidget] changes. This function is meant for those
  /// uncommon use cases where a dependency is undesirable.
  ///
  /// This method should not be called from [State.dispose] because the element
  /// tree is no longer stable at that time. To refer to an ancestor from that
  /// method, save a reference to the ancestor in [State.didChangeDependencies].
  /// It is safe to use this method from [State.deactivate], which is called
  /// whenever the widget is removed from the tree.
  ///
  /// It is also possible to call this method from interaction event handlers
  /// (e.g. gesture callbacks) or timers, to obtain a value once, as long as
  /// that value is not cached and/or reused later.
  ///
  /// Calling this method is O(1) with a small constant factor.
  T? getInheritedWidgetOfExactType<T extends InheritedWidget>();

  /// Obtains the element corresponding to the nearest widget of the given type `T`,
  /// which must be the type of a concrete [InheritedWidget] subclass.
  ///
  /// Returns null if no such element is found.
  ///
  /// {@template flutter.widgets.BuildContext.getElementForInheritedWidgetOfExactType}
  /// Calling this method is O(1) with a small constant factor.
  ///
  /// This method does not establish a relationship with the target in the way
  /// that [dependOnInheritedWidgetOfExactType] does.
  ///
  /// This method should not be called from [State.dispose] because the element
  /// tree is no longer stable at that time. To refer to an ancestor from that
  /// method, save a reference to the ancestor by calling
  /// [dependOnInheritedWidgetOfExactType] in [State.didChangeDependencies]. It is
  /// safe to use this method from [State.deactivate], which is called whenever
  /// the widget is removed from the tree.
  /// {@endtemplate}
  InheritedElement? getElementForInheritedWidgetOfExactType<T extends InheritedWidget>();

  /// Returns the nearest ancestor widget of the given type `T`, which must be the
  /// type of a concrete [Widget] subclass.
  ///
  /// {@template flutter.widgets.BuildContext.findAncestorWidgetOfExactType}
  /// In general, [dependOnInheritedWidgetOfExactType] is more useful, since
  /// inherited widgets will trigger consumers to rebuild when they change. This
  /// method is appropriate when used in interaction event handlers (e.g.
  /// gesture callbacks) or for performing one-off tasks such as asserting that
  /// you have or don't have a widget of a specific type as an ancestor. The
  /// return value of a Widget's build method should not depend on the value
  /// returned by this method, because the build context will not rebuild if the
  /// return value of this method changes. This could lead to a situation where
  /// data used in the build method changes, but the widget is not rebuilt.
  ///
  /// Calling this method is relatively expensive (O(N) in the depth of the
  /// tree). Only call this method if the distance from this widget to the
  /// desired ancestor is known to be small and bounded.
  ///
  /// This method should not be called from [State.deactivate] or [State.dispose]
  /// because the widget tree is no longer stable at that time. To refer to
  /// an ancestor from one of those methods, save a reference to the ancestor
  /// by calling [findAncestorWidgetOfExactType] in [State.didChangeDependencies].
  ///
  /// Returns null if a widget of the requested type does not appear in the
  /// ancestors of this context.
  /// {@endtemplate}
  T? findAncestorWidgetOfExactType<T extends Widget>();

  /// Returns the [State] object of the nearest ancestor [StatefulWidget] widget
  /// that is an instance of the given type `T`.
  ///
  /// {@template flutter.widgets.BuildContext.findAncestorStateOfType}
  /// This should not be used from build methods, because the build context will
  /// not be rebuilt if the value that would be returned by this method changes.
  /// In general, [dependOnInheritedWidgetOfExactType] is more appropriate for such
  /// cases. This method is useful for changing the state of an ancestor widget in
  /// a one-off manner, for example, to cause an ancestor scrolling list to
  /// scroll this build context's widget into view, or to move the focus in
  /// response to user interaction.
  ///
  /// In general, though, consider using a callback that triggers a stateful
  /// change in the ancestor rather than using the imperative style implied by
  /// this method. This will usually lead to more maintainable and reusable code
  /// since it decouples widgets from each other.
  ///
  /// Calling this method is relatively expensive (O(N) in the depth of the
  /// tree). Only call this method if the distance from this widget to the
  /// desired ancestor is known to be small and bounded.
  ///
  /// This method should not be called from [State.deactivate] or [State.dispose]
  /// because the widget tree is no longer stable at that time. To refer to
  /// an ancestor from one of those methods, save a reference to the ancestor
  /// by calling [findAncestorStateOfType] in [State.didChangeDependencies].
  /// {@endtemplate}
  ///
  /// {@tool snippet}
  ///
  /// ```dart
  /// ScrollableState? scrollable = context.findAncestorStateOfType<ScrollableState>();
  /// ```
  /// {@end-tool}
  T? findAncestorStateOfType<T extends State>();

  /// Returns the [State] object of the furthest ancestor [StatefulWidget] widget
  /// that is an instance of the given type `T`.
  ///
  /// {@template flutter.widgets.BuildContext.findRootAncestorStateOfType}
  /// Functions the same way as [findAncestorStateOfType] but keeps visiting subsequent
  /// ancestors until there are none of the type instance of `T` remaining.
  /// Then returns the last one found.
  ///
  /// This operation is O(N) as well though N is the entire widget tree rather than
  /// a subtree.
  /// {@endtemplate}
  T? findRootAncestorStateOfType<T extends State>();

  /// Returns the [RenderObject] object of the nearest ancestor [RenderObjectWidget] widget
  /// that is an instance of the given type `T`.
  ///
  /// {@template flutter.widgets.BuildContext.findAncestorRenderObjectOfType}
  /// This should not be used from build methods, because the build context will
  /// not be rebuilt if the value that would be returned by this method changes.
  /// In general, [dependOnInheritedWidgetOfExactType] is more appropriate for such
  /// cases. This method is useful only in esoteric cases where a widget needs
  /// to cause an ancestor to change its layout or paint behavior. For example,
  /// it is used by [Material] so that [InkWell] widgets can trigger the ink
  /// splash on the [Material]'s actual render object.
  ///
  /// Calling this method is relatively expensive (O(N) in the depth of the
  /// tree). Only call this method if the distance from this widget to the
  /// desired ancestor is known to be small and bounded.
  ///
  /// This method should not be called from [State.deactivate] or [State.dispose]
  /// because the widget tree is no longer stable at that time. To refer to
  /// an ancestor from one of those methods, save a reference to the ancestor
  /// by calling [findAncestorRenderObjectOfType] in [State.didChangeDependencies].
  /// {@endtemplate}
  T? findAncestorRenderObjectOfType<T extends RenderObject>();

  /// Walks the ancestor chain, starting with the parent of this build context's
  /// widget, invoking the argument for each ancestor.
  ///
  /// {@template flutter.widgets.BuildContext.visitAncestorElements}
  /// The callback is given a reference to the ancestor widget's corresponding
  /// [Element] object. The walk stops when it reaches the root widget or when
  /// the callback returns false. The callback must not return null.
  ///
  /// This is useful for inspecting the widget tree.
  ///
  /// Calling this method is relatively expensive (O(N) in the depth of the tree).
  ///
  /// This method should not be called from [State.deactivate] or [State.dispose]
  /// because the element tree is no longer stable at that time. To refer to
  /// an ancestor from one of those methods, save a reference to the ancestor
  /// by calling [visitAncestorElements] in [State.didChangeDependencies].
  /// {@endtemplate}
  void visitAncestorElements(ConditionalElementVisitor visitor);

  /// Walks the children of this widget.
  ///
  /// {@template flutter.widgets.BuildContext.visitChildElements}
  /// This is useful for applying changes to children after they are built
  /// without waiting for the next frame, especially if the children are known,
  /// and especially if there is exactly one child (as is always the case for
  /// [StatefulWidget]s or [StatelessWidget]s).
  ///
  /// Calling this method is very cheap for build contexts that correspond to
  /// [StatefulWidget]s or [StatelessWidget]s (O(1), since there's only one
  /// child).
  ///
  /// Calling this method is potentially expensive for build contexts that
  /// correspond to [RenderObjectWidget]s (O(N) in the number of children).
  ///
  /// Calling this method recursively is extremely expensive (O(N) in the number
  /// of descendants), and should be avoided if possible. Generally it is
  /// significantly cheaper to use an [InheritedWidget] and have the descendants
  /// pull data down, than it is to use [visitChildElements] recursively to push
  /// data down to them.
  /// {@endtemplate}
  void visitChildElements(ElementVisitor visitor);

  /// Start bubbling this notification at the given build context.
  ///
  /// The notification will be delivered to any [NotificationListener] widgets
  /// with the appropriate type parameters that are ancestors of the given
  /// [BuildContext].
  void dispatchNotification(Notification notification);

  /// Returns a description of the [Element] associated with the current build context.
  ///
  /// The `name` is typically something like "The element being rebuilt was".
  ///
  /// See also:
  ///
  ///  * [Element.describeElements], which can be used to describe a list of elements.
  DiagnosticsNode describeElement(String name, {DiagnosticsTreeStyle style = DiagnosticsTreeStyle.errorProperty});

  /// Returns a description of the [Widget] associated with the current build context.
  ///
  /// The `name` is typically something like "The widget being rebuilt was".
  DiagnosticsNode describeWidget(String name, {DiagnosticsTreeStyle style = DiagnosticsTreeStyle.errorProperty});

  /// Adds a description of a specific type of widget missing from the current
  /// build context's ancestry tree.
  ///
  /// You can find an example of using this method in [debugCheckHasMaterial].
  List<DiagnosticsNode> describeMissingAncestor({ required Type expectedAncestorType });

  /// Adds a description of the ownership chain from a specific [Element]
  /// to the error report.
  ///
  /// The ownership chain is useful for debugging the source of an element.
  DiagnosticsNode describeOwnershipChain(String name);
}

/// Manager class for the widgets framework.
///
/// This class tracks which widgets need rebuilding, and handles other tasks
/// that apply to widget trees as a whole, such as managing the inactive element
/// list for the tree and triggering the "reassemble" command when necessary
/// during hot reload when debugging.
///
/// The main build owner is typically owned by the [WidgetsBinding], and is
/// driven from the operating system along with the rest of the
/// build/layout/paint pipeline.
///
/// Additional build owners can be built to manage off-screen widget trees.
///
/// To assign a build owner to a tree, use the
/// [RootElementMixin.assignOwner] method on the root element of the
/// widget tree.
///
/// {@tool dartpad}
/// This example shows how to build an off-screen widget tree used to measure
/// the layout size of the rendered tree. For some use cases, the simpler
/// [Offstage] widget may be a better alternative to this approach.
///
/// ** See code in examples/api/lib/widgets/framework/build_owner.0.dart **
/// {@end-tool}
class BuildOwner {
  /// Creates an object that manages widgets.
  ///
  /// If the `focusManager` argument is not specified or is null, this will
  /// construct a new [FocusManager] and register its global input handlers
  /// via [FocusManager.registerGlobalHandlers], which will modify static
  /// state. Callers wishing to avoid altering this state can explicitly pass
  /// a focus manager here.
  BuildOwner({ this.onBuildScheduled, FocusManager? focusManager }) :
      focusManager = focusManager ?? (FocusManager()..registerGlobalHandlers());

  /// Called on each build pass when the first buildable element is marked
  /// dirty.
  VoidCallback? onBuildScheduled;

  final _InactiveElements _inactiveElements = _InactiveElements();

  final List<Element> _dirtyElements = <Element>[];
  bool _scheduledFlushDirtyElements = false;

  /// Whether [_dirtyElements] need to be sorted again as a result of more
  /// elements becoming dirty during the build.
  ///
  /// This is necessary to preserve the sort order defined by [Element._sort].
  ///
  /// This field is set to null when [buildScope] is not actively rebuilding
  /// the widget tree.
  bool? _dirtyElementsNeedsResorting;

  /// Whether [buildScope] is actively rebuilding the widget tree.
  ///
  /// [scheduleBuildFor] should only be called when this value is true.
  bool get _debugIsInBuildScope => _dirtyElementsNeedsResorting != null;

  /// The object in charge of the focus tree.
  ///
  /// Rarely used directly. Instead, consider using [FocusScope.of] to obtain
  /// the [FocusScopeNode] for a given [BuildContext].
  ///
  /// See [FocusManager] for more details.
  ///
  /// This field will default to a [FocusManager] that has registered its
  /// global input handlers via [FocusManager.registerGlobalHandlers]. Callers
  /// wishing to avoid registering those handlers (and modifying the associated
  /// static state) can explicitly pass a focus manager to the [BuildOwner.new]
  /// constructor.
  FocusManager focusManager;

  /// Adds an element to the dirty elements list so that it will be rebuilt
  /// when [WidgetsBinding.drawFrame] calls [buildScope].
  void scheduleBuildFor(Element element) {
    assert(element.owner == this);
    assert(() {
      if (debugPrintScheduleBuildForStacks) {
        debugPrintStack(label: 'scheduleBuildFor() called for \$element\${_dirtyElements.contains(element) ? " (ALREADY IN LIST)" : ""}');
      }
      if (!element.dirty) {
        throw FlutterError.fromParts(<DiagnosticsNode>[
          ErrorSummary('scheduleBuildFor() called for a widget that is not marked as dirty.'),
          element.describeElement('The method was called for the following element'),
          ErrorDescription(
            'This element is not current marked as dirty. Make sure to set the dirty flag before '
            'calling scheduleBuildFor().',
          ),
          ErrorHint(
            'If you did not attempt to call scheduleBuildFor() yourself, then this probably '
            'indicates a bug in the widgets framework. Please report it:\n'
            '  https://github.com/flutter/flutter/issues/new?template=2_bug.md',
          ),
        ]);
      }
      return true;
    }());
    if (element._inDirtyList) {
      assert(() {
        if (debugPrintScheduleBuildForStacks) {
          debugPrintStack(label: 'BuildOwner.scheduleBuildFor() called; _dirtyElementsNeedsResorting was \$_dirtyElementsNeedsResorting (now true); dirty list is: \$_dirtyElements');
        }
        if (!_debugIsInBuildScope) {
          throw FlutterError.fromParts(<DiagnosticsNode>[
            ErrorSummary('BuildOwner.scheduleBuildFor() called inappropriately.'),
            ErrorHint(
              'The BuildOwner.scheduleBuildFor() method should only be called while the '
              'buildScope() method is actively rebuilding the widget tree.',
            ),
          ]);
        }
        return true;
      }());
      _dirtyElementsNeedsResorting = true;
      return;
    }
    if (!_scheduledFlushDirtyElements && onBuildScheduled != null) {
      _scheduledFlushDirtyElements = true;
      onBuildScheduled!();
    }
    _dirtyElements.add(element);
    element._inDirtyList = true;
    assert(() {
      if (debugPrintScheduleBuildForStacks) {
        debugPrint('...dirty list is now: \$_dirtyElements');
      }
      return true;
    }());
  }

  int _debugStateLockLevel = 0;
  bool get _debugStateLocked => _debugStateLockLevel > 0;

  /// Whether this widget tree is in the build phase.
  ///
  /// Only valid when asserts are enabled.
  bool get debugBuilding => _debugBuilding;
  bool _debugBuilding = false;
  Element? _debugCurrentBuildTarget;

  /// Establishes a scope in which calls to [State.setState] are forbidden, and
  /// calls the given `callback`.
  ///
  /// This mechanism is used to ensure that, for instance, [State.dispose] does
  /// not call [State.setState].
  void lockState(VoidCallback callback) {
    assert(_debugStateLockLevel >= 0);
    assert(() {
      _debugStateLockLevel += 1;
      return true;
    }());
    try {
      callback();
    } finally {
      assert(() {
        _debugStateLockLevel -= 1;
        return true;
      }());
    }
    assert(_debugStateLockLevel >= 0);
  }

  /// Establishes a scope for updating the widget tree, and calls the given
  /// `callback`, if any. Then, builds all the elements that were marked as
  /// dirty using [scheduleBuildFor], in depth order.
  ///
  /// This mechanism prevents build methods from transitively requiring other
  /// build methods to run, potentially causing infinite loops.
  ///
  /// The dirty list is processed after `callback` returns, building all the
  /// elements that were marked as dirty using [scheduleBuildFor], in depth
  /// order. If elements are marked as dirty while this method is running, they
  /// must be deeper than the `context` node, and deeper than any
  /// previously-built node in this pass.
  ///
  /// To flush the current dirty list without performing any other work, this
  /// function can be called with no callback. This is what the framework does
  /// each frame, in [WidgetsBinding.drawFrame].
  ///
  /// Only one [buildScope] can be active at a time.
  ///
  /// A [buildScope] implies a [lockState] scope as well.
  ///
  /// To print a console message every time this method is called, set
  /// [debugPrintBuildScope] to true. This is useful when debugging problems
  /// involving widgets not getting marked dirty, or getting marked dirty too
  /// often.
  @pragma('vm:notify-debugger-on-exception')
  void buildScope(Element context, [ VoidCallback? callback ]) {
    if (callback == null && _dirtyElements.isEmpty) {
      return;
    }
    assert(_debugStateLockLevel >= 0);
    assert(!_debugBuilding);
    assert(() {
      if (debugPrintBuildScope) {
        debugPrint('buildScope called with context \$context; dirty list is: \$_dirtyElements');
      }
      _debugStateLockLevel += 1;
      _debugBuilding = true;
      return true;
    }());
    if (!kReleaseMode) {
      Map<String, String>? debugTimelineArguments;
      assert(() {
        if (debugEnhanceBuildTimelineArguments) {
          debugTimelineArguments = <String, String>{
            'dirty count': '\${_dirtyElements.length}',
            'dirty list': '\$_dirtyElements',
            'lock level': '\$_debugStateLockLevel',
            'scope context': '\$context',
          };
        }
        return true;
      }());
      Timeline.startSync(
        'BUILD',
        arguments: debugTimelineArguments
      );
    }
    try {
      _scheduledFlushDirtyElements = true;
      if (callback != null) {
        assert(_debugStateLocked);
        Element? debugPreviousBuildTarget;
        assert(() {
          debugPreviousBuildTarget = _debugCurrentBuildTarget;
          _debugCurrentBuildTarget = context;
          return true;
        }());
        _dirtyElementsNeedsResorting = false;
        try {
          callback();
        } finally {
          assert(() {
            assert(_debugCurrentBuildTarget == context);
            _debugCurrentBuildTarget = debugPreviousBuildTarget;
            _debugElementWasRebuilt(context);
            return true;
          }());
        }
      }
      _dirtyElements.sort(Element._sort);
      _dirtyElementsNeedsResorting = false;
      int dirtyCount = _dirtyElements.length;
      int index = 0;
      while (index < dirtyCount) {
        final Element element = _dirtyElements[index];
        assert(element._inDirtyList);
        assert(() {
          if (element._lifecycleState == _ElementLifecycle.active && !element._debugIsInScope(context)) {
            throw FlutterError.fromParts(<DiagnosticsNode>[
              ErrorSummary('Tried to build dirty widget in the wrong build scope.'),
              ErrorDescription(
                'A widget which was marked as dirty and is still active was scheduled to be built, '
                'but the current build scope unexpectedly does not contain that widget.',
              ),
              ErrorHint(
                'Sometimes this is detected when an element is removed from the widget tree, but the '
                'element somehow did not get marked as inactive. In that case, it might be caused by '
                'an ancestor element failing to implement visitChildren correctly, thus preventing '
                'some or all of its descendants from being correctly deactivated.',
              ),
              DiagnosticsProperty<Element>(
                'The root of the build scope was',
                context,
                style: DiagnosticsTreeStyle.errorProperty,
              ),
              DiagnosticsProperty<Element>(
                'The offending element (which does not appear to be a descendant of the root of the build scope) was',
                element,
                style: DiagnosticsTreeStyle.errorProperty,
              ),
            ]);
          }
          return true;
        }());
        final bool isTimelineTracked = !kReleaseMode && _isProfileBuildsEnabledFor(element.widget);
        if (isTimelineTracked) {
          Map<String, String>? debugTimelineArguments;
          assert(() {
            if (kDebugMode && debugEnhanceBuildTimelineArguments) {
              debugTimelineArguments = element.widget.toDiagnosticsNode().toTimelineArguments();
            }
            return true;
          }());
          Timeline.startSync(
            '\${element.widget.runtimeType}',
            arguments: debugTimelineArguments,
          );
        }
        try {
          element.rebuild();
        } catch (e, stack) {
          _reportException(
            ErrorDescription('while rebuilding dirty elements'),
            e,
            stack,
            informationCollector: () => <DiagnosticsNode>[
              if (kDebugMode && index < _dirtyElements.length)
                DiagnosticsDebugCreator(DebugCreator(element)),
              if (index < _dirtyElements.length)
                element.describeElement('The element being rebuilt at the time was index \$index of \$dirtyCount')
              else
                ErrorHint('The element being rebuilt at the time was index \$index of \$dirtyCount, but _dirtyElements only had \${_dirtyElements.length} entries. This suggests some confusion in the framework internals.'),
            ],
          );
        }
        if (isTimelineTracked) {
          Timeline.finishSync();
        }
        index += 1;
        if (dirtyCount < _dirtyElements.length || _dirtyElementsNeedsResorting!) {
          _dirtyElements.sort(Element._sort);
          _dirtyElementsNeedsResorting = false;
          dirtyCount = _dirtyElements.length;
          while (index > 0 && _dirtyElements[index - 1].dirty) {
            // It is possible for previously dirty but inactive widgets to move right in the list.
            // We therefore have to move the index left in the list to account for this.
            // We don't know how many could have moved. However, we do know that the only possible
            // change to the list is that nodes that were previously to the left of the index have
            // now moved to be to the right of the right-most cleaned node, and we do know that
            // all the clean nodes were to the left of the index. So we move the index left
            // until just after the right-most clean node.
            index -= 1;
          }
        }
      }
      assert(() {
        if (_dirtyElements.any((Element element) => element._lifecycleState == _ElementLifecycle.active && element.dirty)) {
          throw FlutterError.fromParts(<DiagnosticsNode>[
            ErrorSummary('buildScope missed some dirty elements.'),
            ErrorHint('This probably indicates that the dirty list should have been resorted but was not.'),
            Element.describeElements('The list of dirty elements at the end of the buildScope call was', _dirtyElements),
          ]);
        }
        return true;
      }());
    } finally {
      for (final Element element in _dirtyElements) {
        assert(element._inDirtyList);
        element._inDirtyList = false;
      }
      _dirtyElements.clear();
      _scheduledFlushDirtyElements = false;
      _dirtyElementsNeedsResorting = null;
      if (!kReleaseMode) {
        Timeline.finishSync();
      }
      assert(_debugBuilding);
      assert(() {
        _debugBuilding = false;
        _debugStateLockLevel -= 1;
        if (debugPrintBuildScope) {
          debugPrint('buildScope finished');
        }
        return true;
      }());
    }
    assert(_debugStateLockLevel >= 0);
  }

  Map<Element, Set<GlobalKey>>? _debugElementsThatWillNeedToBeRebuiltDueToGlobalKeyShenanigans;

  void _debugTrackElementThatWillNeedToBeRebuiltDueToGlobalKeyShenanigans(Element node, GlobalKey key) {
    _debugElementsThatWillNeedToBeRebuiltDueToGlobalKeyShenanigans ??= HashMap<Element, Set<GlobalKey>>();
    final Set<GlobalKey> keys = _debugElementsThatWillNeedToBeRebuiltDueToGlobalKeyShenanigans!
      .putIfAbsent(node, () => HashSet<GlobalKey>());
    keys.add(key);
  }

  void _debugElementWasRebuilt(Element node) {
    _debugElementsThatWillNeedToBeRebuiltDueToGlobalKeyShenanigans?.remove(node);
  }

  final Map<GlobalKey, Element> _globalKeyRegistry = <GlobalKey, Element>{};

  // In Profile/Release mode this field is initialized to `null`. The Dart compiler can
  // eliminate unused fields, but not their initializers.
  @_debugOnly
  final Set<Element>? _debugIllFatedElements = kDebugMode ? HashSet<Element>() : null;

  // This map keeps track which child reserves the global key with the parent.
  // Parent, child -> global key.
  // This provides us a way to remove old reservation while parent rebuilds the
  // child in the same slot.
  //
  // In Profile/Release mode this field is initialized to `null`. The Dart compiler can
  // eliminate unused fields, but not their initializers.
  @_debugOnly
  final Map<Element, Map<Element, GlobalKey>>? _debugGlobalKeyReservations = kDebugMode ? <Element, Map<Element, GlobalKey>>{} : null;

  /// The number of [GlobalKey] instances that are currently associated with
  /// [Element]s that have been built by this build owner.
  int get globalKeyCount => _globalKeyRegistry.length;

  void _debugRemoveGlobalKeyReservationFor(Element parent, Element child) {
    assert(() {
      _debugGlobalKeyReservations?[parent]?.remove(child);
      return true;
    }());
  }

  void _registerGlobalKey(GlobalKey key, Element element) {
    assert(() {
      if (_globalKeyRegistry.containsKey(key)) {
        final Element oldElement = _globalKeyRegistry[key]!;
        assert(element.widget.runtimeType != oldElement.widget.runtimeType);
        _debugIllFatedElements?.add(oldElement);
      }
      return true;
    }());
    _globalKeyRegistry[key] = element;
  }

  void _unregisterGlobalKey(GlobalKey key, Element element) {
    assert(() {
      if (_globalKeyRegistry.containsKey(key) && _globalKeyRegistry[key] != element) {
        final Element oldElement = _globalKeyRegistry[key]!;
        assert(element.widget.runtimeType != oldElement.widget.runtimeType);
      }
      return true;
    }());
    if (_globalKeyRegistry[key] == element) {
      _globalKeyRegistry.remove(key);
    }
  }

  void _debugReserveGlobalKeyFor(Element parent, Element child, GlobalKey key) {
    assert(() {
      _debugGlobalKeyReservations?[parent] ??= <Element, GlobalKey>{};
      _debugGlobalKeyReservations?[parent]![child] = key;
      return true;
    }());
  }

  void _debugVerifyGlobalKeyReservation() {
    assert(() {
      final Map<GlobalKey, Element> keyToParent = <GlobalKey, Element>{};
      _debugGlobalKeyReservations?.forEach((Element parent, Map<Element, GlobalKey> childToKey) {
        // We ignore parent that are unmounted or detached.
        if (parent._lifecycleState == _ElementLifecycle.defunct || parent.renderObject?.attached == false) {
          return;
        }
        childToKey.forEach((Element child, GlobalKey key) {
          // If parent = null, the node is deactivated by its parent and is
          // not re-attached to other part of the tree. We should ignore this
          // node.
          if (child._parent == null) {
            return;
          }
          // It is possible the same key registers to the same parent twice
          // with different children. That is illegal, but it is not in the
          // scope of this check. Such error will be detected in
          // _debugVerifyIllFatedPopulation or
          // _debugElementsThatWillNeedToBeRebuiltDueToGlobalKeyShenanigans.
          if (keyToParent.containsKey(key) && keyToParent[key] != parent) {
            // We have duplication reservations for the same global key.
            final Element older = keyToParent[key]!;
            final Element newer = parent;
            final FlutterError error;
            if (older.toString() != newer.toString()) {
              error = FlutterError.fromParts(<DiagnosticsNode>[
                ErrorSummary('Multiple widgets used the same GlobalKey.'),
                ErrorDescription(
                  'The key \$key was used by multiple widgets. The parents of those widgets were:\n'
                  '- \$older\n'
                  '- \$newer\n'
                  'A GlobalKey can only be specified on one widget at a time in the widget tree.',
                ),
              ]);
            } else {
              error = FlutterError.fromParts(<DiagnosticsNode>[
                ErrorSummary('Multiple widgets used the same GlobalKey.'),
                ErrorDescription(
                  'The key \$key was used by multiple widgets. The parents of those widgets were '
                  'different widgets that both had the following description:\n'
                  '  \$parent\n'
                  'A GlobalKey can only be specified on one widget at a time in the widget tree.',
                ),
              ]);
            }
            // Fix the tree by removing the duplicated child from one of its
            // parents to resolve the duplicated key issue. This allows us to
            // tear down the tree during testing without producing additional
            // misleading exceptions.
            if (child._parent != older) {
              older.visitChildren((Element currentChild) {
                if (currentChild == child) {
                  older.forgetChild(child);
                }
              });
            }
            if (child._parent != newer) {
              newer.visitChildren((Element currentChild) {
                if (currentChild == child) {
                  newer.forgetChild(child);
                }
              });
            }
            throw error;
          } else {
            keyToParent[key] = parent;
          }
        });
      });
      _debugGlobalKeyReservations?.clear();
      return true;
    }());
  }

  void _debugVerifyIllFatedPopulation() {
    assert(() {
      Map<GlobalKey, Set<Element>>? duplicates;
      for (final Element element in _debugIllFatedElements ?? const <Element>{}) {
        if (element._lifecycleState != _ElementLifecycle.defunct) {
          assert(element.widget.key != null);
          final GlobalKey key = element.widget.key! as GlobalKey;
          assert(_globalKeyRegistry.containsKey(key));
          duplicates ??= <GlobalKey, Set<Element>>{};
          // Uses ordered set to produce consistent error message.
          final Set<Element> elements = duplicates.putIfAbsent(key, () => LinkedHashSet<Element>());
          elements.add(element);
          elements.add(_globalKeyRegistry[key]!);
        }
      }
      _debugIllFatedElements?.clear();
      if (duplicates != null) {
        final List<DiagnosticsNode> information = <DiagnosticsNode>[];
        information.add(ErrorSummary('Multiple widgets used the same GlobalKey.'));
        for (final GlobalKey key in duplicates.keys) {
          final Set<Element> elements = duplicates[key]!;
          // TODO(jacobr): this will omit the '- ' before each widget name and
          // use the more standard whitespace style instead. Please let me know
          // if the '- ' style is a feature we want to maintain and we can add
          // another tree style that supports it. I also see '* ' in some places
          // so it would be nice to unify and normalize.
          information.add(Element.describeElements('The key \$key was used by \${elements.length} widgets', elements));
        }
        information.add(ErrorDescription('A GlobalKey can only be specified on one widget at a time in the widget tree.'));
        throw FlutterError.fromParts(information);
      }
      return true;
    }());
  }

  /// Complete the element build pass by unmounting any elements that are no
  /// longer active.
  ///
  /// This is called by [WidgetsBinding.drawFrame].
  ///
  /// In debug mode, this also runs some sanity checks, for example checking for
  /// duplicate global keys.
  ///
  /// After the current call stack unwinds, a microtask that notifies listeners
  /// about changes to global keys will run.
  @pragma('vm:notify-debugger-on-exception')
  void finalizeTree() {
    if (!kReleaseMode) {
      Timeline.startSync('FINALIZE TREE');
    }
    try {
      lockState(_inactiveElements._unmountAll); // this unregisters the GlobalKeys
      assert(() {
        try {
          _debugVerifyGlobalKeyReservation();
          _debugVerifyIllFatedPopulation();
          if (_debugElementsThatWillNeedToBeRebuiltDueToGlobalKeyShenanigans != null &&
              _debugElementsThatWillNeedToBeRebuiltDueToGlobalKeyShenanigans!.isNotEmpty) {
            final Set<GlobalKey> keys = HashSet<GlobalKey>();
            for (final Element element in _debugElementsThatWillNeedToBeRebuiltDueToGlobalKeyShenanigans!.keys) {
              if (element._lifecycleState != _ElementLifecycle.defunct) {
                keys.addAll(_debugElementsThatWillNeedToBeRebuiltDueToGlobalKeyShenanigans![element]!);
              }
            }
            if (keys.isNotEmpty) {
              final Map<String, int> keyStringCount = HashMap<String, int>();
              for (final String key in keys.map<String>((GlobalKey key) => key.toString())) {
                if (keyStringCount.containsKey(key)) {
                  keyStringCount.update(key, (int value) => value + 1);
                } else {
                  keyStringCount[key] = 1;
                }
              }
              final List<String> keyLabels = <String>[];
              keyStringCount.forEach((String key, int count) {
                if (count == 1) {
                  keyLabels.add(key);
                } else {
                  keyLabels.add('\$key (\$count different affected keys had this toString representation)');
                }
              });
              final Iterable<Element> elements = _debugElementsThatWillNeedToBeRebuiltDueToGlobalKeyShenanigans!.keys;
              final Map<String, int> elementStringCount = HashMap<String, int>();
              for (final String element in elements.map<String>((Element element) => element.toString())) {
                if (elementStringCount.containsKey(element)) {
                  elementStringCount.update(element, (int value) => value + 1);
                } else {
                  elementStringCount[element] = 1;
                }
              }
              final List<String> elementLabels = <String>[];
              elementStringCount.forEach((String element, int count) {
                if (count == 1) {
                  elementLabels.add(element);
                } else {
                  elementLabels.add('\$element (\$count different affected elements had this toString representation)');
                }
              });
              assert(keyLabels.isNotEmpty);
              final String the = keys.length == 1 ? ' the' : '';
              final String s = keys.length == 1 ? '' : 's';
              final String were = keys.length == 1 ? 'was' : 'were';
              final String their = keys.length == 1 ? 'its' : 'their';
              final String respective = elementLabels.length == 1 ? '' : ' respective';
              final String those = keys.length == 1 ? 'that' : 'those';
              final String s2 = elementLabels.length == 1 ? '' : 's';
              final String those2 = elementLabels.length == 1 ? 'that' : 'those';
              final String they = elementLabels.length == 1 ? 'it' : 'they';
              final String think = elementLabels.length == 1 ? 'thinks' : 'think';
              final String are = elementLabels.length == 1 ? 'is' : 'are';
              // TODO(jacobr): make this error more structured to better expose which widgets had problems.
              throw FlutterError.fromParts(<DiagnosticsNode>[
                ErrorSummary('Duplicate GlobalKey\$s detected in widget tree.'),
                // TODO(jacobr): refactor this code so the elements are clickable
                // in GUI debug tools.
                ErrorDescription(
                  'The following GlobalKey\$s \$were specified multiple times in the widget tree. This will lead to '
                  'parts of the widget tree being truncated unexpectedly, because the second time a key is seen, '
                  'the previous instance is moved to the new location. The key\$s \$were:\n'
                  '- \${keyLabels.join("\n  ")}\n'
                  'This was determined by noticing that after\$the widget\$s with the above global key\$s \$were moved '
                  'out of \$their\$respective previous parent\$s2, \$those2 previous parent\$s2 never updated during this frame, meaning '
                  'that \$they either did not update at all or updated before the widget\$s \$were moved, in either case '
                  'implying that \$they still \$think that \$they should have a child with \$those global key\$s.\n'
                  'The specific parent\$s2 that did not update after having one or more children forcibly removed '
                  'due to GlobalKey reparenting \$are:\n'
                  '- \${elementLabels.join("\n  ")}'
                  '\nA GlobalKey can only be specified on one widget at a time in the widget tree.',
                ),
              ]);
            }
          }
        } finally {
          _debugElementsThatWillNeedToBeRebuiltDueToGlobalKeyShenanigans?.clear();
        }
        return true;
      }());
    } catch (e, stack) {
      // Catching the exception directly to avoid activating the ErrorWidget.
      // Since the tree is in a broken state, adding the ErrorWidget would
      // cause more exceptions.
      _reportException(ErrorSummary('while finalizing the widget tree'), e, stack);
    } finally {
      if (!kReleaseMode) {
        Timeline.finishSync();
      }
    }
  }

  /// Cause the entire subtree rooted at the given [Element] to be entirely
  /// rebuilt. This is used by development tools when the application code has
  /// changed and is being hot-reloaded, to cause the widget tree to pick up any
  /// changed implementations.
  ///
  /// This is expensive and should not be called except during development.
  void reassemble(Element root, DebugReassembleConfig? reassembleConfig) {
    if (!kReleaseMode) {
      Timeline.startSync('Preparing Hot Reload (widgets)');
    }
    try {
      assert(root._parent == null);
      assert(root.owner == this);
      root._debugReassembleConfig = reassembleConfig;
      root.reassemble();
    } finally {
      if (!kReleaseMode) {
        Timeline.finishSync();
      }
    }
  }
}

/// Mixin this class to allow receiving [Notification] objects dispatched by
/// child elements.
///
/// See also:
///   * [NotificationListener], for a widget that allows consuming notifications.
mixin NotifiableElementMixin on Element {
  /// Called when a notification of the appropriate type arrives at this
  /// location in the tree.
  ///
  /// Return true to cancel the notification bubbling. Return false to
  /// allow the notification to continue to be dispatched to further ancestors.
  bool onNotification(Notification notification);

  @override
  void attachNotificationTree() {
    _notificationTree = _NotificationNode(_parent?._notificationTree, this);
  }
}

class _NotificationNode {
  _NotificationNode(this.parent, this.current);

  NotifiableElementMixin? current;
  _NotificationNode? parent;

  void dispatchNotification(Notification notification) {
    if (current?.onNotification(notification) ?? true) {
      return;
    }
    parent?.dispatchNotification(notification);
  }
}

bool _isProfileBuildsEnabledFor(Widget widget) {
  return debugProfileBuildsEnabled ||
      (debugProfileBuildsEnabledUserWidgets &&
          debugIsWidgetLocalCreation(widget));
}

/// An instantiation of a [Widget] at a particular location in the tree.
///
/// Widgets describe how to configure a subtree but the same widget can be used
/// to configure multiple subtrees simultaneously because widgets are immutable.
/// An [Element] represents the use of a widget to configure a specific location
/// in the tree. Over time, the widget associated with a given element can
/// change, for example, if the parent widget rebuilds and creates a new widget
/// for this location.
///
/// Elements form a tree. Most elements have a unique child, but some widgets
/// (e.g., subclasses of [RenderObjectElement]) can have multiple children.
///
/// Elements have the following lifecycle:
///
///  * The framework creates an element by calling [Widget.createElement] on the
///    widget that will be used as the element's initial configuration.
///  * The framework calls [mount] to add the newly created element to the tree
///    at a given slot in a given parent. The [mount] method is responsible for
///    inflating any child widgets and calling [attachRenderObject] as
///    necessary to attach any associated render objects to the render tree.
///  * At this point, the element is considered "active" and might appear on
///    screen.
///  * At some point, the parent might decide to change the widget used to
///    configure this element, for example because the parent rebuilt with new
///    state. When this happens, the framework will call [update] with the new
///    widget. The new widget will always have the same [runtimeType] and key as
///    old widget. If the parent wishes to change the [runtimeType] or key of
///    the widget at this location in the tree, it can do so by unmounting this
///    element and inflating the new widget at this location.
///  * At some point, an ancestor might decide to remove this element (or an
///    intermediate ancestor) from the tree, which the ancestor does by calling
///    [deactivateChild] on itself. Deactivating the intermediate ancestor will
///    remove that element's render object from the render tree and add this
///    element to the [owner]'s list of inactive elements, causing the framework
///    to call [deactivate] on this element.
///  * At this point, the element is considered "inactive" and will not appear
///    on screen. An element can remain in the inactive state only until
///    the end of the current animation frame. At the end of the animation
///    frame, any elements that are still inactive will be unmounted.
///  * If the element gets reincorporated into the tree (e.g., because it or one
///    of its ancestors has a global key that is reused), the framework will
///    remove the element from the [owner]'s list of inactive elements, call
///    [activate] on the element, and reattach the element's render object to
///    the render tree. (At this point, the element is again considered "active"
///    and might appear on screen.)
///  * If the element does not get reincorporated into the tree by the end of
///    the current animation frame, the framework will call [unmount] on the
///    element.
///  * At this point, the element is considered "defunct" and will not be
///    incorporated into the tree in the future.
abstract class Element extends DiagnosticableTree implements BuildContext {
  /// Creates an element that uses the given widget as its configuration.
  ///
  /// Typically called by an override of [Widget.createElement].
  Element(Widget widget)
    : _widget = widget {
    if (kFlutterMemoryAllocationsEnabled) {
      MemoryAllocations.instance.dispatchObjectCreated(
        library: _flutterWidgetsLibrary,
        className: '\$Element',
        object: this,
      );
    }
  }

  Element? _parent;
  DebugReassembleConfig? _debugReassembleConfig;
  _NotificationNode? _notificationTree;

  /// Compare two widgets for equality.
  ///
  /// When a widget is rebuilt with another that compares equal according
  /// to `operator ==`, it is assumed that the update is redundant and the
  /// work to update that branch of the tree is skipped.
  ///
  /// It is generally discouraged to override `operator ==` on any widget that
  /// has children, since a correct implementation would have to defer to the
  /// children's equality operator also, and that is an O(N²) operation: each
  /// child would need to itself walk all its children, each step of the tree.
  ///
  /// It is sometimes reasonable for a leaf widget (one with no children) to
  /// implement this method, if rebuilding the widget is known to be much more
  /// expensive than checking the widgets' parameters for equality and if the
  /// widget is expected to often be rebuilt with identical parameters.
  ///
  /// In general, however, it is more efficient to cache the widgets used
  /// in a build method if it is known that they will not change.
  @nonVirtual
  @override
  // ignore: avoid_equals_and_hash_code_on_mutable_classes, hash_and_equals
  bool operator ==(Object other) => identical(this, other);

  /// Information set by parent to define where this child fits in its parent's
  /// child list.
  ///
  /// A child widget's slot is determined when the parent's [updateChild] method
  /// is called to inflate the child widget. See [RenderObjectElement] for more
  /// details on slots.
  Object? get slot => _slot;
  Object? _slot;

  /// An integer that is guaranteed to be greater than the parent's, if any.
  /// The element at the root of the tree must have a depth greater than 0.
  int get depth {
    assert(() {
      if (_lifecycleState == _ElementLifecycle.initial) {
        throw FlutterError('Depth is only available when element has been mounted.');
      }
      return true;
    }());
    return _depth;
  }
  late int _depth;

  /// Returns result < 0 when [a] < [b], result == 0 when [a] == [b], result > 0
  /// when [a] > [b].
  static int _sort(Element a, Element b) {
    final int diff = a.depth - b.depth;
    // If depths are not equal, return the difference.
    if (diff != 0) {
      return diff;
    }
    // If the `dirty` values are not equal, sort with non-dirty elements being
    // less than dirty elements.
    final bool isBDirty = b.dirty;
    if (a.dirty != isBDirty) {
      return isBDirty ? -1 : 1;
    }
    // Otherwise, `depth`s and `dirty`s are equal.
    return 0;
  }

  // Return a numeric encoding of the specific `Element` concrete subtype.
  // This is used in `Element.updateChild` to determine if a hot reload modified the
  // superclass of a mounted element's configuration. The encoding of each `Element`
  // must match the corresponding `Widget` encoding in `Widget._debugConcreteSubtype`.
  static int _debugConcreteSubtype(Element element) {
    return element is StatefulElement ? 1 :
           element is StatelessElement ? 2 :
           0;
  }

  /// The configuration for this element.
  ///
  /// Avoid overriding this field on [Element] subtypes to provide a more
  /// specific widget type (i.e. [StatelessElement] and [StatelessWidget]).
  /// Instead, cast at any call sites where the more specific type is required.
  /// This avoids significant cast overhead on the getter which is accessed
  /// throughout the framework internals during the build phase - and for which
  /// the more specific type information is not used.
  @override
  Widget get widget => _widget!;
  Widget? _widget;

  @override
  bool get mounted => _widget != null;

  /// Returns true if the Element is defunct.
  ///
  /// This getter always returns false in profile and release builds.
  /// See the lifecycle documentation for [Element] for additional information.
  bool get debugIsDefunct {
    bool isDefunct = false;
    assert(() {
      isDefunct = _lifecycleState == _ElementLifecycle.defunct;
      return true;
    }());
    return isDefunct;
  }

  /// Returns true if the Element is active.
  ///
  /// This getter always returns false in profile and release builds.
  /// See the lifecycle documentation for [Element] for additional information.
  bool get debugIsActive {
    bool isActive = false;
    assert(() {
      isActive = _lifecycleState == _ElementLifecycle.active;
      return true;
    }());
    return isActive;
  }

  /// The object that manages the lifecycle of this element.
  @override
  BuildOwner? get owner => _owner;
  BuildOwner? _owner;

  /// {@template flutter.widgets.Element.reassemble}
  /// Called whenever the application is reassembled during debugging, for
  /// example during hot reload.
  ///
  /// This method should rerun any initialization logic that depends on global
  /// state, for example, image loading from asset bundles (since the asset
  /// bundle may have changed).
  ///
  /// This function will only be called during development. In release builds,
  /// the `ext.flutter.reassemble` hook is not available, and so this code will
  /// never execute.
  ///
  /// Implementers should not rely on any ordering for hot reload source update,
  /// reassemble, and build methods after a hot reload has been initiated. It is
  /// possible that a [Timer] (e.g. an [Animation]) or a debugging session
  /// attached to the isolate could trigger a build with reloaded code _before_
  /// reassemble is called. Code that expects preconditions to be set by
  /// reassemble after a hot reload must be resilient to being called out of
  /// order, e.g. by fizzling instead of throwing. That said, once reassemble is
  /// called, build will be called after it at least once.
  /// {@endtemplate}
  ///
  /// See also:
  ///
  ///  * [State.reassemble]
  ///  * [BindingBase.reassembleApplication]
  ///  * [Image], which uses this to reload images.
  @mustCallSuper
  @protected
  void reassemble() {
    if (_debugShouldReassemble(_debugReassembleConfig, _widget)) {
      markNeedsBuild();
      _debugReassembleConfig = null;
    }
    visitChildren((Element child) {
      child._debugReassembleConfig = _debugReassembleConfig;
      child.reassemble();
    });
    _debugReassembleConfig = null;
  }

  bool _debugIsInScope(Element target) {
    Element? current = this;
    while (current != null) {
      if (target == current) {
        return true;
      }
      current = current._parent;
    }
    return false;
  }

  /// The render object at (or below) this location in the tree.
  ///
  /// If this object is a [RenderObjectElement], the render object is the one at
  /// this location in the tree. Otherwise, this getter will walk down the tree
  /// until it finds a [RenderObjectElement].
  RenderObject? get renderObject {
    Element? current = this;
    while (current != null) {
      if (current._lifecycleState == _ElementLifecycle.defunct) {
        break;
      } else if (current is RenderObjectElement) {
        return current.renderObject;
      } else {
        Element? next;
        current.visitChildren((Element child) {
          assert(next == null);  // This verifies that there's only one child.
          next = child;
        });
        current = next;
      }
    }
    return null;
  }

  @override
  List<DiagnosticsNode> describeMissingAncestor({ required Type expectedAncestorType }) {
    final List<DiagnosticsNode> information = <DiagnosticsNode>[];
    final List<Element> ancestors = <Element>[];
    visitAncestorElements((Element element) {
      ancestors.add(element);
      return true;
    });

    information.add(DiagnosticsProperty<Element>(
      'The specific widget that could not find a \$expectedAncestorType ancestor was',
      this,
      style: DiagnosticsTreeStyle.errorProperty,
    ));

    if (ancestors.isNotEmpty) {
      information.add(describeElements('The ancestors of this widget were', ancestors));
    } else {
      information.add(ErrorDescription(
        'This widget is the root of the tree, so it has no '
        'ancestors, let alone a "\$expectedAncestorType" ancestor.',
      ));
    }
    return information;
  }

  /// Returns a list of [Element]s from the current build context to the error report.
  static DiagnosticsNode describeElements(String name, Iterable<Element> elements) {
    return DiagnosticsBlock(
      name: name,
      children: elements.map<DiagnosticsNode>((Element element) => DiagnosticsProperty<Element>('', element)).toList(),
      allowTruncate: true,
    );
  }

  @override
  DiagnosticsNode describeElement(String name, {DiagnosticsTreeStyle style = DiagnosticsTreeStyle.errorProperty}) {
    return DiagnosticsProperty<Element>(name, this, style: style);
  }

  @override
  DiagnosticsNode describeWidget(String name, {DiagnosticsTreeStyle style = DiagnosticsTreeStyle.errorProperty}) {
    return DiagnosticsProperty<Element>(name, this, style: style);
  }

  @override
  DiagnosticsNode describeOwnershipChain(String name) {
    // TODO(jacobr): make this structured so clients can support clicks on
    // individual entries. For example, is this an iterable with arrows as
    // separators?
    return StringProperty(name, debugGetCreatorChain(10));
  }

  // This is used to verify that Element objects move through life in an
  // orderly fashion.
  _ElementLifecycle _lifecycleState = _ElementLifecycle.initial;

  /// Calls the argument for each child. Must be overridden by subclasses that
  /// support having children.
  ///
  /// There is no guaranteed order in which the children will be visited, though
  /// it should be consistent over time.
  ///
  /// Calling this during build is dangerous: the child list might still be
  /// being updated at that point, so the children might not be constructed yet,
  /// or might be old children that are going to be replaced. This method should
  /// only be called if it is provable that the children are available.
  void visitChildren(ElementVisitor visitor) { }

  /// Calls the argument for each child considered onstage.
  ///
  /// Classes like [Offstage] and [Overlay] override this method to hide their
  /// children.
  ///
  /// Being onstage affects the element's discoverability during testing when
  /// you use Flutter's [Finder] objects. For example, when you instruct the
  /// test framework to tap on a widget, by default the finder will look for
  /// onstage elements and ignore the offstage ones.
  ///
  /// The default implementation defers to [visitChildren] and therefore treats
  /// the element as onstage.
  ///
  /// See also:
  ///
  ///  * [Offstage] widget that hides its children.
  ///  * [Finder] that skips offstage widgets by default.
  ///  * [RenderObject.visitChildrenForSemantics], in contrast to this method,
  ///    designed specifically for excluding parts of the UI from the semantics
  ///    tree.
  void debugVisitOnstageChildren(ElementVisitor visitor) => visitChildren(visitor);

  /// Wrapper around [visitChildren] for [BuildContext].
  @override
  void visitChildElements(ElementVisitor visitor) {
    assert(() {
      if (owner == null || !owner!._debugStateLocked) {
        return true;
      }
      throw FlutterError.fromParts(<DiagnosticsNode>[
        ErrorSummary('visitChildElements() called during build.'),
        ErrorDescription(
          "The BuildContext.visitChildElements() method can't be called during "
          'build because the child list is still being updated at that point, '
          'so the children might not be constructed yet, or might be old children '
          'that are going to be replaced.',
        ),
      ]);
    }());
    visitChildren(visitor);
  }

  /// Update the given child with the given new configuration.
  ///
  /// This method is the core of the widgets system. It is called each time we
  /// are to add, update, or remove a child based on an updated configuration.
  ///
  /// The `newSlot` argument specifies the new value for this element's [slot].
  ///
  /// If the `child` is null, and the `newWidget` is not null, then we have a new
  /// child for which we need to create an [Element], configured with `newWidget`.
  ///
  /// If the `newWidget` is null, and the `child` is not null, then we need to
  /// remove it because it no longer has a configuration.
  ///
  /// If neither are null, then we need to update the `child`'s configuration to
  /// be the new configuration given by `newWidget`. If `newWidget` can be given
  /// to the existing child (as determined by [Widget.canUpdate]), then it is so
  /// given. Otherwise, the old child needs to be disposed and a new child
  /// created for the new configuration.
  ///
  /// If both are null, then we don't have a child and won't have a child, so we
  /// do nothing.
  ///
  /// The [updateChild] method returns the new child, if it had to create one,
  /// or the child that was passed in, if it just had to update the child, or
  /// null, if it removed the child and did not replace it.
  ///
  /// The following table summarizes the above:
  ///
  /// |                     | **newWidget == null**  | **newWidget != null**   |
  /// | :-----------------: | :--------------------- | :---------------------- |
  /// |  **child == null**  |  Returns null.         |  Returns new [Element]. |
  /// |  **child != null**  |  Old child is removed, returns null. | Old child updated if possible, returns child or new [Element]. |
  ///
  /// The `newSlot` argument is used only if `newWidget` is not null. If `child`
  /// is null (or if the old child cannot be updated), then the `newSlot` is
  /// given to the new [Element] that is created for the child, via
  /// [inflateWidget]. If `child` is not null (and the old child _can_ be
  /// updated), then the `newSlot` is given to [updateSlotForChild] to update
  /// its slot, in case it has moved around since it was last built.
  ///
  /// See the [RenderObjectElement] documentation for more information on slots.
  @protected
  @pragma('vm:prefer-inline')
  Element? updateChild(Element? child, Widget? newWidget, Object? newSlot) {
    if (newWidget == null) {
      if (child != null) {
        deactivateChild(child);
      }
      return null;
    }

    final Element newChild;
    if (child != null) {
      bool hasSameSuperclass = true;
      // When the type of a widget is changed between Stateful and Stateless via
      // hot reload, the element tree will end up in a partially invalid state.
      // That is, if the widget was a StatefulWidget and is now a StatelessWidget,
      // then the element tree currently contains a StatefulElement that is incorrectly
      // referencing a StatelessWidget (and likewise with StatelessElement).
      //
      // To avoid crashing due to type errors, we need to gently guide the invalid
      // element out of the tree. To do so, we ensure that the `hasSameSuperclass` condition
      // returns false which prevents us from trying to update the existing element
      // incorrectly.
      //
      // For the case where the widget becomes Stateful, we also need to avoid
      // accessing `StatelessElement.widget` as the cast on the getter will
      // cause a type error to be thrown. Here we avoid that by short-circuiting
      // the `Widget.canUpdate` check once `hasSameSuperclass` is false.
      assert(() {
        final int oldElementClass = Element._debugConcreteSubtype(child);
        final int newWidgetClass = Widget._debugConcreteSubtype(newWidget);
        hasSameSuperclass = oldElementClass == newWidgetClass;
        return true;
      }());
      if (hasSameSuperclass && child.widget == newWidget) {
        // We don't insert a timeline event here, because otherwise it's
        // confusing that widgets that "don't update" (because they didn't
        // change) get "charged" on the timeline.
        if (child.slot != newSlot) {
          updateSlotForChild(child, newSlot);
        }
        newChild = child;
      } else if (hasSameSuperclass && Widget.canUpdate(child.widget, newWidget)) {
        if (child.slot != newSlot) {
          updateSlotForChild(child, newSlot);
        }
        final bool isTimelineTracked = !kReleaseMode && _isProfileBuildsEnabledFor(newWidget);
        if (isTimelineTracked) {
          Map<String, String>? debugTimelineArguments;
          assert(() {
            if (kDebugMode && debugEnhanceBuildTimelineArguments) {
              debugTimelineArguments = newWidget.toDiagnosticsNode().toTimelineArguments();
            }
            return true;
          }());
          Timeline.startSync(
            '\${newWidget.runtimeType}',
            arguments: debugTimelineArguments,
          );
        }
        child.update(newWidget);
        if (isTimelineTracked) {
          Timeline.finishSync();
        }
        assert(child.widget == newWidget);
        assert(() {
          child.owner!._debugElementWasRebuilt(child);
          return true;
        }());
        newChild = child;
      } else {
        deactivateChild(child);
        assert(child._parent == null);
        // The [debugProfileBuildsEnabled] code for this branch is inside
        // [inflateWidget], since some [Element]s call [inflateWidget] directly
        // instead of going through [updateChild].
        newChild = inflateWidget(newWidget, newSlot);
      }
    } else {
      // The [debugProfileBuildsEnabled] code for this branch is inside
      // [inflateWidget], since some [Element]s call [inflateWidget] directly
      // instead of going through [updateChild].
      newChild = inflateWidget(newWidget, newSlot);
    }

    assert(() {
      if (child != null) {
        _debugRemoveGlobalKeyReservation(child);
      }
      final Key? key = newWidget.key;
      if (key is GlobalKey) {
        assert(owner != null);
        owner!._debugReserveGlobalKeyFor(this, newChild, key);
      }
      return true;
    }());

    return newChild;
  }

  /// Add this element to the tree in the given slot of the given parent.
  ///
  /// The framework calls this function when a newly created element is added to
  /// the tree for the first time. Use this method to initialize state that
  /// depends on having a parent. State that is independent of the parent can
  /// more easily be initialized in the constructor.
  ///
  /// This method transitions the element from the "initial" lifecycle state to
  /// the "active" lifecycle state.
  ///
  /// Subclasses that override this method are likely to want to also override
  /// [update], [visitChildren], [RenderObjectElement.insertRenderObjectChild],
  /// [RenderObjectElement.moveRenderObjectChild], and
  /// [RenderObjectElement.removeRenderObjectChild].
  ///
  /// Implementations of this method should start with a call to the inherited
  /// method, as in `super.mount(parent, newSlot)`.
  @mustCallSuper
  void mount(Element? parent, Object? newSlot) {
    assert(_lifecycleState == _ElementLifecycle.initial);
    assert(_parent == null);
    assert(parent == null || parent._lifecycleState == _ElementLifecycle.active);
    assert(slot == null);
    _parent = parent;
    _slot = newSlot;
    _lifecycleState = _ElementLifecycle.active;
    _depth = _parent != null ? _parent!.depth + 1 : 1;
    if (parent != null) {
      // Only assign ownership if the parent is non-null. If parent is null
      // (the root node), the owner should have already been assigned.
      // See RootRenderObjectElement.assignOwner().
      _owner = parent.owner;
    }
    assert(owner != null);
    final Key? key = widget.key;
    if (key is GlobalKey) {
      owner!._registerGlobalKey(key, this);
    }
    _updateInheritance();
    attachNotificationTree();
  }

  void _debugRemoveGlobalKeyReservation(Element child) {
    assert(owner != null);
    owner!._debugRemoveGlobalKeyReservationFor(this, child);
  }

  /// Change the widget used to configure this element.
  ///
  /// The framework calls this function when the parent wishes to use a
  /// different widget to configure this element. The new widget is guaranteed
  /// to have the same [runtimeType] as the old widget.
  ///
  /// This function is called only during the "active" lifecycle state.
  @mustCallSuper
  void update(covariant Widget newWidget) {
    // This code is hot when hot reloading, so we try to
    // only call _AssertionError._evaluateAssertion once.
    assert(
      _lifecycleState == _ElementLifecycle.active
        && newWidget != widget
        && Widget.canUpdate(widget, newWidget),
    );
    // This Element was told to update and we can now release all the global key
    // reservations of forgotten children. We cannot do this earlier because the
    // forgotten children still represent global key duplications if the element
    // never updates (the forgotten children are not removed from the tree
    // until the call to update happens)
    assert(() {
      _debugForgottenChildrenWithGlobalKey?.forEach(_debugRemoveGlobalKeyReservation);
      _debugForgottenChildrenWithGlobalKey?.clear();
      return true;
    }());
    _widget = newWidget;
  }

  /// Change the slot that the given child occupies in its parent.
  ///
  /// Called by [MultiChildRenderObjectElement], and other [RenderObjectElement]
  /// subclasses that have multiple children, when child moves from one position
  /// to another in this element's child list.
  @protected
  void updateSlotForChild(Element child, Object? newSlot) {
    assert(_lifecycleState == _ElementLifecycle.active);
    assert(child._parent == this);
    void visit(Element element) {
      element._updateSlot(newSlot);
      if (element is! RenderObjectElement) {
        element.visitChildren(visit);
      }
    }
    visit(child);
  }

  void _updateSlot(Object? newSlot) {
    assert(_lifecycleState == _ElementLifecycle.active);
    assert(_parent != null);
    assert(_parent!._lifecycleState == _ElementLifecycle.active);
    _slot = newSlot;
  }

  void _updateDepth(int parentDepth) {
    final int expectedDepth = parentDepth + 1;
    if (_depth < expectedDepth) {
      _depth = expectedDepth;
      visitChildren((Element child) {
        child._updateDepth(expectedDepth);
      });
    }
  }

  /// Remove [renderObject] from the render tree.
  ///
  /// The default implementation of this function calls
  /// [detachRenderObject] recursively on each child. The
  /// [RenderObjectElement.detachRenderObject] override does the actual work of
  /// removing [renderObject] from the render tree.
  ///
  /// This is called by [deactivateChild].
  void detachRenderObject() {
    visitChildren((Element child) {
      child.detachRenderObject();
    });
    _slot = null;
  }

  /// Add [renderObject] to the render tree at the location specified by `newSlot`.
  ///
  /// The default implementation of this function calls
  /// [attachRenderObject] recursively on each child. The
  /// [RenderObjectElement.attachRenderObject] override does the actual work of
  /// adding [renderObject] to the render tree.
  ///
  /// The `newSlot` argument specifies the new value for this element's [slot].
  void attachRenderObject(Object? newSlot) {
    assert(_slot == null);
    visitChildren((Element child) {
      child.attachRenderObject(newSlot);
    });
    _slot = newSlot;
  }

  Element? _retakeInactiveElement(GlobalKey key, Widget newWidget) {
    // The "inactivity" of the element being retaken here may be forward-looking: if
    // we are taking an element with a GlobalKey from an element that currently has
    // it as a child, then we know that element will soon no longer have that
    // element as a child. The only way that assumption could be false is if the
    // global key is being duplicated, and we'll try to track that using the
    // _debugTrackElementThatWillNeedToBeRebuiltDueToGlobalKeyShenanigans call below.
    final Element? element = key._currentElement;
    if (element == null) {
      return null;
    }
    if (!Widget.canUpdate(element.widget, newWidget)) {
      return null;
    }
    assert(() {
      if (debugPrintGlobalKeyedWidgetLifecycle) {
        debugPrint('Attempting to take \$element from \${element._parent ?? "inactive elements list"} to put in \$this.');
      }
      return true;
    }());
    final Element? parent = element._parent;
    if (parent != null) {
      assert(() {
        if (parent == this) {
          throw FlutterError.fromParts(<DiagnosticsNode>[
            ErrorSummary("A GlobalKey was used multiple times inside one widget's child list."),
            DiagnosticsProperty<GlobalKey>('The offending GlobalKey was', key),
            parent.describeElement('The parent of the widgets with that key was'),
            element.describeElement('The first child to get instantiated with that key became'),
            DiagnosticsProperty<Widget>('The second child that was to be instantiated with that key was', widget, style: DiagnosticsTreeStyle.errorProperty),
            ErrorDescription('A GlobalKey can only be specified on one widget at a time in the widget tree.'),
          ]);
        }
        parent.owner!._debugTrackElementThatWillNeedToBeRebuiltDueToGlobalKeyShenanigans(
          parent,
          key,
        );
        return true;
      }());
      parent.forgetChild(element);
      parent.deactivateChild(element);
    }
    assert(element._parent == null);
    owner!._inactiveElements.remove(element);
    return element;
  }

  /// Create an element for the given widget and add it as a child of this
  /// element in the given slot.
  ///
  /// This method is typically called by [updateChild] but can be called
  /// directly by subclasses that need finer-grained control over creating
  /// elements.
  ///
  /// If the given widget has a global key and an element already exists that
  /// has a widget with that global key, this function will reuse that element
  /// (potentially grafting it from another location in the tree or reactivating
  /// it from the list of inactive elements) rather than creating a new element.
  ///
  /// The `newSlot` argument specifies the new value for this element's [slot].
  ///
  /// The element returned by this function will already have been mounted and
  /// will be in the "active" lifecycle state.
  @protected
  @pragma('vm:prefer-inline')
  Element inflateWidget(Widget newWidget, Object? newSlot) {

    final bool isTimelineTracked = !kReleaseMode && _isProfileBuildsEnabledFor(newWidget);
    if (isTimelineTracked) {
      Map<String, String>? debugTimelineArguments;
      assert(() {
        if (kDebugMode && debugEnhanceBuildTimelineArguments) {
          debugTimelineArguments = newWidget.toDiagnosticsNode().toTimelineArguments();
        }
        return true;
      }());
      Timeline.startSync(
        '\${newWidget.runtimeType}',
        arguments: debugTimelineArguments,
      );
    }

    try {
      final Key? key = newWidget.key;
      if (key is GlobalKey) {
        final Element? newChild = _retakeInactiveElement(key, newWidget);
        if (newChild != null) {
          assert(newChild._parent == null);
          assert(() {
            _debugCheckForCycles(newChild);
            return true;
          }());
          newChild._activateWithParent(this, newSlot);
          final Element? updatedChild = updateChild(newChild, newWidget, newSlot);
          assert(newChild == updatedChild);
          return updatedChild!;
        }
      }
      final Element newChild = newWidget.createElement();
      assert(() {
        _debugCheckForCycles(newChild);
        return true;
      }());
      newChild.mount(this, newSlot);
      assert(newChild._lifecycleState == _ElementLifecycle.active);

      return newChild;
    } finally {
      if (isTimelineTracked) {
        Timeline.finishSync();
      }
    }
  }

  void _debugCheckForCycles(Element newChild) {
    assert(newChild._parent == null);
    assert(() {
      Element node = this;
      while (node._parent != null) {
        node = node._parent!;
      }
      assert(node != newChild); // indicates we are about to create a cycle
      return true;
    }());
  }

  /// Move the given element to the list of inactive elements and detach its
  /// render object from the render tree.
  ///
  /// This method stops the given element from being a child of this element by
  /// detaching its render object from the render tree and moving the element to
  /// the list of inactive elements.
  ///
  /// This method (indirectly) calls [deactivate] on the child.
  ///
  /// The caller is responsible for removing the child from its child model.
  /// Typically [deactivateChild] is called by the element itself while it is
  /// updating its child model; however, during [GlobalKey] reparenting, the new
  /// parent proactively calls the old parent's [deactivateChild], first using
  /// [forgetChild] to cause the old parent to update its child model.
  @protected
  void deactivateChild(Element child) {
    assert(child._parent == this);
    child._parent = null;
    child.detachRenderObject();
    owner!._inactiveElements.add(child); // this eventually calls child.deactivate()
    assert(() {
      if (debugPrintGlobalKeyedWidgetLifecycle) {
        if (child.widget.key is GlobalKey) {
          debugPrint('Deactivated \$child (keyed child of \$this)');
        }
      }
      return true;
    }());
  }

  // The children that have been forgotten by forgetChild. This will be used in
  // [update] to remove the global key reservations of forgotten children.
  //
  // In Profile/Release mode this field is initialized to `null`. The Dart compiler can
  // eliminate unused fields, but not their initializers.
  @_debugOnly
  final Set<Element>? _debugForgottenChildrenWithGlobalKey = kDebugMode ? HashSet<Element>() : null;

  /// Remove the given child from the element's child list, in preparation for
  /// the child being reused elsewhere in the element tree.
  ///
  /// This updates the child model such that, e.g., [visitChildren] does not
  /// walk that child anymore.
  ///
  /// The element will still have a valid parent when this is called, and the
  /// child's [Element.slot] value will be valid in the context of that parent.
  /// After this is called, [deactivateChild] is called to sever the link to
  /// this object.
  ///
  /// The [update] is responsible for updating or creating the new child that
  /// will replace this [child].
  @protected
  @mustCallSuper
  void forgetChild(Element child) {
    // This method is called on the old parent when the given child (with a
    // global key) is given a new parent. We cannot remove the global key
    // reservation directly in this method because the forgotten child is not
    // removed from the tree until this Element is updated in [update]. If
    // [update] is never called, the forgotten child still represents a global
    // key duplication that we need to catch.
    assert(() {
      if (child.widget.key is GlobalKey) {
        _debugForgottenChildrenWithGlobalKey?.add(child);
      }
      return true;
    }());
  }

  void _activateWithParent(Element parent, Object? newSlot) {
    assert(_lifecycleState == _ElementLifecycle.inactive);
    _parent = parent;
    assert(() {
      if (debugPrintGlobalKeyedWidgetLifecycle) {
        debugPrint('Reactivating \$this (now child of \$_parent).');
      }
      return true;
    }());
    _updateDepth(_parent!.depth);
    _activateRecursively(this);
    attachRenderObject(newSlot);
    assert(_lifecycleState == _ElementLifecycle.active);
  }

  static void _activateRecursively(Element element) {
    assert(element._lifecycleState == _ElementLifecycle.inactive);
    element.activate();
    assert(element._lifecycleState == _ElementLifecycle.active);
    element.visitChildren(_activateRecursively);
  }

  /// Transition from the "inactive" to the "active" lifecycle state.
  ///
  /// The framework calls this method when a previously deactivated element has
  /// been reincorporated into the tree. The framework does not call this method
  /// the first time an element becomes active (i.e., from the "initial"
  /// lifecycle state). Instead, the framework calls [mount] in that situation.
  ///
  /// See the lifecycle documentation for [Element] for additional information.
  ///
  /// Implementations of this method should start with a call to the inherited
  /// method, as in `super.activate()`.
  @mustCallSuper
  void activate() {
    assert(_lifecycleState == _ElementLifecycle.inactive);
    assert(owner != null);
    final bool hadDependencies = (_dependencies != null && _dependencies!.isNotEmpty) || _hadUnsatisfiedDependencies;
    _lifecycleState = _ElementLifecycle.active;
    // We unregistered our dependencies in deactivate, but never cleared the list.
    // Since we're going to be reused, let's clear our list now.
    _dependencies?.clear();
    _hadUnsatisfiedDependencies = false;
    _updateInheritance();
    attachNotificationTree();
    if (_dirty) {
      owner!.scheduleBuildFor(this);
    }
    if (hadDependencies) {
      didChangeDependencies();
    }
  }

  /// Transition from the "active" to the "inactive" lifecycle state.
  ///
  /// The framework calls this method when a previously active element is moved
  /// to the list of inactive elements. While in the inactive state, the element
  /// will not appear on screen. The element can remain in the inactive state
  /// only until the end of the current animation frame. At the end of the
  /// animation frame, if the element has not be reactivated, the framework will
  /// unmount the element.
  ///
  /// This is (indirectly) called by [deactivateChild].
  ///
  /// See the lifecycle documentation for [Element] for additional information.
  ///
  /// Implementations of this method should end with a call to the inherited
  /// method, as in `super.deactivate()`.
  @mustCallSuper
  void deactivate() {
    assert(_lifecycleState == _ElementLifecycle.active);
    assert(_widget != null); // Use the private property to avoid a CastError during hot reload.
    if (_dependencies != null && _dependencies!.isNotEmpty) {
      for (final InheritedElement dependency in _dependencies!) {
        dependency._dependents.remove(this);
      }
      // For expediency, we don't actually clear the list here, even though it's
      // no longer representative of what we are registered with. If we never
      // get re-used, it doesn't matter. If we do, then we'll clear the list in
      // activate(). The benefit of this is that it allows Element's activate()
      // implementation to decide whether to rebuild based on whether we had
      // dependencies here.
    }
    _inheritedElements = null;
    _lifecycleState = _ElementLifecycle.inactive;
  }

  /// Called, in debug mode, after children have been deactivated (see [deactivate]).
  ///
  /// This method is not called in release builds.
  @mustCallSuper
  void debugDeactivated() {
    assert(_lifecycleState == _ElementLifecycle.inactive);
  }

  /// Transition from the "inactive" to the "defunct" lifecycle state.
  ///
  /// Called when the framework determines that an inactive element will never
  /// be reactivated. At the end of each animation frame, the framework calls
  /// [unmount] on any remaining inactive elements, preventing inactive elements
  /// from remaining inactive for longer than a single animation frame.
  ///
  /// After this function is called, the element will not be incorporated into
  /// the tree again.
  ///
  /// Any resources this element holds should be released at this point. For
  /// example, [RenderObjectElement.unmount] calls [RenderObject.dispose] and
  /// nulls out its reference to the render object.
  ///
  /// See the lifecycle documentation for [Element] for additional information.
  ///
  /// Implementations of this method should end with a call to the inherited
  /// method, as in `super.unmount()`.
  @mustCallSuper
  void unmount() {
    assert(_lifecycleState == _ElementLifecycle.inactive);
    assert(_widget != null); // Use the private property to avoid a CastError during hot reload.
    assert(owner != null);
    if (kFlutterMemoryAllocationsEnabled) {
      MemoryAllocations.instance.dispatchObjectDisposed(object: this);
    }
    // Use the private property to avoid a CastError during hot reload.
    final Key? key = _widget?.key;
    if (key is GlobalKey) {
      owner!._unregisterGlobalKey(key, this);
    }
    // Release resources to reduce the severity of memory leaks caused by
    // defunct, but accidentally retained Elements.
    _widget = null;
    _dependencies = null;
    _lifecycleState = _ElementLifecycle.defunct;
  }

  @override
  RenderObject? findRenderObject() {
    assert(() {
      if (_lifecycleState != _ElementLifecycle.active) {
        throw FlutterError.fromParts(<DiagnosticsNode>[
          ErrorSummary('Cannot get renderObject of inactive element.'),
          ErrorDescription(
            'In order for an element to have a valid renderObject, it must be '
            'active, which means it is part of the tree.\n'
            'Instead, this element is in the \$_lifecycleState state.\n'
            'If you called this method from a State object, consider guarding '
            'it with State.mounted.',
          ),
          describeElement('The findRenderObject() method was called for the following element'),
        ]);
      }
      return true;
    }());
    return renderObject;
  }

  @override
  Size? get size {
    assert(() {
      if (_lifecycleState != _ElementLifecycle.active) {
        // TODO(jacobr): is this a good separation into contract and violation?
        // I have added a line of white space.
        throw FlutterError.fromParts(<DiagnosticsNode>[
          ErrorSummary('Cannot get size of inactive element.'),
          ErrorDescription(
            'In order for an element to have a valid size, the element must be '
            'active, which means it is part of the tree.\n'
            'Instead, this element is in the \$_lifecycleState state.',
          ),
          describeElement('The size getter was called for the following element'),
        ]);
      }
      if (owner!._debugBuilding) {
        throw FlutterError.fromParts(<DiagnosticsNode>[
          ErrorSummary('Cannot get size during build.'),
          ErrorDescription(
            'The size of this render object has not yet been determined because '
            'the framework is still in the process of building widgets, which '
            'means the render tree for this frame has not yet been determined. '
            'The size getter should only be called from paint callbacks or '
            'interaction event handlers (e.g. gesture callbacks).',
          ),
          ErrorSpacer(),
          ErrorHint(
            'If you need some sizing information during build to decide which '
            'widgets to build, consider using a LayoutBuilder widget, which can '
            'tell you the layout constraints at a given location in the tree. See '
            '<https://api.flutter.dev/flutter/widgets/LayoutBuilder-class.html> '
            'for more details.',
          ),
          ErrorSpacer(),
          describeElement('The size getter was called for the following element'),
        ]);
      }
      return true;
    }());
    final RenderObject? renderObject = findRenderObject();
    assert(() {
      if (renderObject == null) {
        throw FlutterError.fromParts(<DiagnosticsNode>[
          ErrorSummary('Cannot get size without a render object.'),
          ErrorHint(
            'In order for an element to have a valid size, the element must have '
            'an associated render object. This element does not have an associated '
            'render object, which typically means that the size getter was called '
            'too early in the pipeline (e.g., during the build phase) before the '
            'framework has created the render tree.',
          ),
          describeElement('The size getter was called for the following element'),
        ]);
      }
      if (renderObject is RenderSliver) {
        throw FlutterError.fromParts(<DiagnosticsNode>[
          ErrorSummary('Cannot get size from a RenderSliver.'),
          ErrorHint(
            'The render object associated with this element is a '
            '\${renderObject.runtimeType}, which is a subtype of RenderSliver. '
            'Slivers do not have a size per se. They have a more elaborate '
            'geometry description, which can be accessed by calling '
            'findRenderObject and then using the "geometry" getter on the '
            'resulting object.',
          ),
          describeElement('The size getter was called for the following element'),
          renderObject.describeForError('The associated render sliver was'),
        ]);
      }
      if (renderObject is! RenderBox) {
        throw FlutterError.fromParts(<DiagnosticsNode>[
          ErrorSummary('Cannot get size from a render object that is not a RenderBox.'),
          ErrorHint(
            'Instead of being a subtype of RenderBox, the render object associated '
            'with this element is a \${renderObject.runtimeType}. If this type of '
            'render object does have a size, consider calling findRenderObject '
            'and extracting its size manually.',
          ),
          describeElement('The size getter was called for the following element'),
          renderObject.describeForError('The associated render object was'),
        ]);
      }
      final RenderBox box = renderObject;
      if (!box.hasSize) {
        throw FlutterError.fromParts(<DiagnosticsNode>[
          ErrorSummary('Cannot get size from a render object that has not been through layout.'),
          ErrorHint(
            'The size of this render object has not yet been determined because '
            'this render object has not yet been through layout, which typically '
            'means that the size getter was called too early in the pipeline '
            '(e.g., during the build phase) before the framework has determined '
            'the size and position of the render objects during layout.',
          ),
          describeElement('The size getter was called for the following element'),
          box.describeForError('The render object from which the size was to be obtained was'),
        ]);
      }
      if (box.debugNeedsLayout) {
        throw FlutterError.fromParts(<DiagnosticsNode>[
          ErrorSummary('Cannot get size from a render object that has been marked dirty for layout.'),
          ErrorHint(
            'The size of this render object is ambiguous because this render object has '
            'been modified since it was last laid out, which typically means that the size '
            'getter was called too early in the pipeline (e.g., during the build phase) '
            'before the framework has determined the size and position of the render '
            'objects during layout.',
          ),
          describeElement('The size getter was called for the following element'),
          box.describeForError('The render object from which the size was to be obtained was'),
          ErrorHint(
            'Consider using debugPrintMarkNeedsLayoutStacks to determine why the render '
            'object in question is dirty, if you did not expect this.',
          ),
        ]);
      }
      return true;
    }());
    if (renderObject is RenderBox) {
      return renderObject.size;
    }
    return null;
  }

  PersistentHashMap<Type, InheritedElement>? _inheritedElements;
  Set<InheritedElement>? _dependencies;
  bool _hadUnsatisfiedDependencies = false;

  bool _debugCheckStateIsActiveForAncestorLookup() {
    assert(() {
      if (_lifecycleState != _ElementLifecycle.active) {
        throw FlutterError.fromParts(<DiagnosticsNode>[
          ErrorSummary("Looking up a deactivated widget's ancestor is unsafe."),
          ErrorDescription(
            "At this point the state of the widget's element tree is no longer "
            'stable.',
          ),
          ErrorHint(
            "To safely refer to a widget's ancestor in its dispose() method, "
            'save a reference to the ancestor by calling dependOnInheritedWidgetOfExactType() '
            "in the widget's didChangeDependencies() method.",
          ),
        ]);
      }
      return true;
    }());
    return true;
  }

  /// Returns `true` if [dependOnInheritedElement] was previously called with [ancestor].
  @protected
  bool doesDependOnInheritedElement(InheritedElement ancestor) =>
      _dependencies != null && _dependencies!.contains(ancestor);

  @override
  InheritedWidget dependOnInheritedElement(InheritedElement ancestor, { Object? aspect }) {
    _dependencies ??= HashSet<InheritedElement>();
    _dependencies!.add(ancestor);
    ancestor.updateDependencies(this, aspect);
    return ancestor.widget as InheritedWidget;
  }

  @override
  T? dependOnInheritedWidgetOfExactType<T extends InheritedWidget>({Object? aspect}) {
    assert(_debugCheckStateIsActiveForAncestorLookup());
    final InheritedElement? ancestor = _inheritedElements == null ? null : _inheritedElements![T];
    if (ancestor != null) {
      return dependOnInheritedElement(ancestor, aspect: aspect) as T;
    }
    _hadUnsatisfiedDependencies = true;
    return null;
  }

  @override
  T? getInheritedWidgetOfExactType<T extends InheritedWidget>() {
    return getElementForInheritedWidgetOfExactType<T>()?.widget as T?;
  }

  @override
  InheritedElement? getElementForInheritedWidgetOfExactType<T extends InheritedWidget>() {
    assert(_debugCheckStateIsActiveForAncestorLookup());
    final InheritedElement? ancestor = _inheritedElements == null ? null : _inheritedElements![T];
    return ancestor;
  }

  /// Called in [Element.mount] and [Element.activate] to register this element in
  /// the notification tree.
  ///
  /// This method is only exposed so that [NotifiableElementMixin] can be implemented.
  /// Subclasses of [Element] that wish to respond to notifications should mix that
  /// in instead.
  ///
  /// See also:
  ///   * [NotificationListener], a widget that allows listening to notifications.
  @protected
  void attachNotificationTree() {
    _notificationTree = _parent?._notificationTree;
  }

  void _updateInheritance() {
    assert(_lifecycleState == _ElementLifecycle.active);
    _inheritedElements = _parent?._inheritedElements;
  }

  @override
  T? findAncestorWidgetOfExactType<T extends Widget>() {
    assert(_debugCheckStateIsActiveForAncestorLookup());
    Element? ancestor = _parent;
    while (ancestor != null && ancestor.widget.runtimeType != T) {
      ancestor = ancestor._parent;
    }
    return ancestor?.widget as T?;
  }

  @override
  T? findAncestorStateOfType<T extends State<StatefulWidget>>() {
    assert(_debugCheckStateIsActiveForAncestorLookup());
    Element? ancestor = _parent;
    while (ancestor != null) {
      if (ancestor is StatefulElement && ancestor.state is T) {
        break;
      }
      ancestor = ancestor._parent;
    }
    final StatefulElement? statefulAncestor = ancestor as StatefulElement?;
    return statefulAncestor?.state as T?;
  }

  @override
  T? findRootAncestorStateOfType<T extends State<StatefulWidget>>() {
    assert(_debugCheckStateIsActiveForAncestorLookup());
    Element? ancestor = _parent;
    StatefulElement? statefulAncestor;
    while (ancestor != null) {
      if (ancestor is StatefulElement && ancestor.state is T) {
        statefulAncestor = ancestor;
      }
      ancestor = ancestor._parent;
    }
    return statefulAncestor?.state as T?;
  }

  @override
  T? findAncestorRenderObjectOfType<T extends RenderObject>() {
    assert(_debugCheckStateIsActiveForAncestorLookup());
    Element? ancestor = _parent;
    while (ancestor != null) {
      if (ancestor is RenderObjectElement && ancestor.renderObject is T) {
        return ancestor.renderObject as T;
      }
      ancestor = ancestor._parent;
    }
    return null;
  }

  @override
  void visitAncestorElements(ConditionalElementVisitor visitor) {
    assert(_debugCheckStateIsActiveForAncestorLookup());
    Element? ancestor = _parent;
    while (ancestor != null && visitor(ancestor)) {
      ancestor = ancestor._parent;
    }
  }

  /// Called when a dependency of this element changes.
  ///
  /// The [dependOnInheritedWidgetOfExactType] registers this element as depending on
  /// inherited information of the given type. When the information of that type
  /// changes at this location in the tree (e.g., because the [InheritedElement]
  /// updated to a new [InheritedWidget] and
  /// [InheritedWidget.updateShouldNotify] returned true), the framework calls
  /// this function to notify this element of the change.
  @mustCallSuper
  void didChangeDependencies() {
    assert(_lifecycleState == _ElementLifecycle.active); // otherwise markNeedsBuild is a no-op
    assert(_debugCheckOwnerBuildTargetExists('didChangeDependencies'));
    markNeedsBuild();
  }

  bool _debugCheckOwnerBuildTargetExists(String methodName) {
    assert(() {
      if (owner!._debugCurrentBuildTarget == null) {
        throw FlutterError.fromParts(<DiagnosticsNode>[
          ErrorSummary(
            '\$methodName for \${widget.runtimeType} was called at an '
            'inappropriate time.',
          ),
          ErrorDescription('It may only be called while the widgets are being built.'),
          ErrorHint(
            'A possible cause of this error is when \$methodName is called during '
            'one of:\n'
            ' * network I/O event\n'
            ' * file I/O event\n'
            ' * timer\n'
            ' * microtask (caused by Future.then, async/await, scheduleMicrotask)',
          ),
        ]);
      }
      return true;
    }());
    return true;
  }

  /// Returns a description of what caused this element to be created.
  ///
  /// Useful for debugging the source of an element.
  String debugGetCreatorChain(int limit) {
    final List<String> chain = <String>[];
    Element? node = this;
    while (chain.length < limit && node != null) {
      chain.add(node.toStringShort());
      node = node._parent;
    }
    if (node != null) {
      chain.add('\u22EF');
    }
    return chain.join(' \u2190 ');
  }

  /// Returns the parent chain from this element back to the root of the tree.
  ///
  /// Useful for debug display of a tree of Elements with only nodes in the path
  /// from the root to this Element expanded.
  List<Element> debugGetDiagnosticChain() {
    final List<Element> chain = <Element>[this];
    Element? node = _parent;
    while (node != null) {
      chain.add(node);
      node = node._parent;
    }
    return chain;
  }

  @override
  void dispatchNotification(Notification notification) {
    _notificationTree?.dispatchNotification(notification);
  }

  /// A short, textual description of this element.
  @override
  String toStringShort() => _widget?.toStringShort() ?? '\${describeIdentity(this)}(DEFUNCT)';

  @override
  DiagnosticsNode toDiagnosticsNode({ String? name, DiagnosticsTreeStyle? style }) {
    return _ElementDiagnosticableTreeNode(
      name: name,
      value: this,
      style: style,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.defaultDiagnosticsTreeStyle= DiagnosticsTreeStyle.dense;
    if (_lifecycleState != _ElementLifecycle.initial) {
      properties.add(ObjectFlagProperty<int>('depth', depth, ifNull: 'no depth'));
    }
    properties.add(ObjectFlagProperty<Widget>('widget', _widget, ifNull: 'no widget'));
    properties.add(DiagnosticsProperty<Key>('key', _widget?.key, showName: false, defaultValue: null, level: DiagnosticLevel.hidden));
    _widget?.debugFillProperties(properties);
    properties.add(FlagProperty('dirty', value: dirty, ifTrue: 'dirty'));
    final Set<InheritedElement>? deps = _dependencies;
    if (deps != null && deps.isNotEmpty) {
      final List<InheritedElement> sortedDependencies = deps.toList()
        ..sort((InheritedElement a, InheritedElement b) =>
            a.toStringShort().compareTo(b.toStringShort()));
      final List<DiagnosticsNode> diagnosticsDependencies = sortedDependencies
        .map((InheritedElement element) => element.widget.toDiagnosticsNode(style: DiagnosticsTreeStyle.sparse))
        .toList();
      properties.add(DiagnosticsProperty<List<DiagnosticsNode>>('dependencies', diagnosticsDependencies));
    }
  }

  @override
  List<DiagnosticsNode> debugDescribeChildren() {
    final List<DiagnosticsNode> children = <DiagnosticsNode>[];
    visitChildren((Element child) {
      children.add(child.toDiagnosticsNode());
    });
    return children;
  }

  /// Returns true if the element has been marked as needing rebuilding.
  ///
  /// The flag is true when the element is first created and after
  /// [markNeedsBuild] has been called. The flag is reset to false in the
  /// [performRebuild] implementation.
  bool get dirty => _dirty;
  bool _dirty = true;

  // Whether this is in owner._dirtyElements. This is used to know whether we
  // should be adding the element back into the list when it's reactivated.
  bool _inDirtyList = false;

  // Whether we've already built or not. Set in [rebuild].
  bool _debugBuiltOnce = false;

  /// Marks the element as dirty and adds it to the global list of widgets to
  /// rebuild in the next frame.
  ///
  /// Since it is inefficient to build an element twice in one frame,
  /// applications and widgets should be structured so as to only mark
  /// widgets dirty during event handlers before the frame begins, not during
  /// the build itself.
  void markNeedsBuild() {
    assert(_lifecycleState != _ElementLifecycle.defunct);
    if (_lifecycleState != _ElementLifecycle.active) {
      return;
    }
    assert(owner != null);
    assert(_lifecycleState == _ElementLifecycle.active);
    assert(() {
      if (owner!._debugBuilding) {
        assert(owner!._debugCurrentBuildTarget != null);
        assert(owner!._debugStateLocked);
        if (_debugIsInScope(owner!._debugCurrentBuildTarget!)) {
          return true;
        }
        final List<DiagnosticsNode> information = <DiagnosticsNode>[
          ErrorSummary('setState() or markNeedsBuild() called during build.'),
          ErrorDescription(
            'This \${widget.runtimeType} widget cannot be marked as needing to build because the framework '
            'is already in the process of building widgets. A widget can be marked as '
            'needing to be built during the build phase only if one of its ancestors '
            'is currently building. This exception is allowed because the framework '
            'builds parent widgets before children, which means a dirty descendant '
            'will always be built. Otherwise, the framework might not visit this '
            'widget during this build phase.',
          ),
          describeElement('The widget on which setState() or markNeedsBuild() was called was'),
        ];
        if (owner!._debugCurrentBuildTarget != null) {
          information.add(owner!._debugCurrentBuildTarget!.describeWidget('The widget which was currently being built when the offending call was made was'));
        }
        throw FlutterError.fromParts(information);
      } else if (owner!._debugStateLocked) {
        throw FlutterError.fromParts(<DiagnosticsNode>[
          ErrorSummary('setState() or markNeedsBuild() called when widget tree was locked.'),
          ErrorDescription(
            'This \${widget.runtimeType} widget cannot be marked as needing to build '
            'because the framework is locked.',
          ),
          describeElement('The widget on which setState() or markNeedsBuild() was called was'),
        ]);
      }
      return true;
    }());
    if (dirty) {
      return;
    }
    _dirty = true;
    owner!.scheduleBuildFor(this);
  }

  /// Cause the widget to update itself. In debug builds, also verify various
  /// invariants.
  ///
  /// Called by the [BuildOwner] when [BuildOwner.scheduleBuildFor] has been
  /// called to mark this element dirty, by [mount] when the element is first
  /// built, and by [update] when the widget has changed.
  ///
  /// The method will only rebuild if [dirty] is true. To rebuild regardless
  /// of the [dirty] flag, set `force` to true. Forcing a rebuild is convenient
  /// from [update], during which [dirty] is false.
  ///
  /// ## When rebuilds happen
  ///
  /// ### Terminology
  ///
  /// [Widget]s represent the configuration of [Element]s. Each [Element] has a
  /// widget, specified in [Element.widget]. The term "widget" is often used
  /// when strictly speaking "element" would be more correct.
  ///
  /// While an [Element] has a current [Widget], over time, that widget may be
  /// replaced by others. For example, the element backing a [ColoredBox] may
  /// first have as its widget a [ColoredBox] whose [ColoredBox.color] is blue,
  /// then later be given a new [ColoredBox] whose color is green.
  ///
  /// At any particular time, multiple [Element]s in the same tree may have the
  /// same [Widget]. For example, the same [ColoredBox] with the green color may
  /// be used in multiple places in the widget tree at the same time, each being
  /// backed by a different [Element].
  ///
  /// ### Marking an element dirty
  ///
  /// An [Element] can be marked dirty between frames. This can happen for various
  /// reasons, including the following:
  ///
  /// * The [State] of a [StatefulWidget] can cause its [Element] to be marked
  ///   dirty by calling the [State.setState] method.
  ///
  /// * When an [InheritedWidget] changes, descendants that have previously
  ///   subscribed to it will be marked dirty.
  ///
  /// * During a hot reload, every element is marked dirty (using [Element.reassemble]).
  ///
  /// ### Rebuilding
  ///
  /// Dirty elements are rebuilt during the next frame. Precisely how this is
  /// done depends on the kind of element. A [StatelessElement] rebuilds by
  /// using its widget's [StatelessWidget.build] method. A [StatefulElement]
  /// rebuilds by using its widget's state's [State.build] method. A
  /// [RenderObjectElement] rebuilds by updating its [RenderObject].
  ///
  /// In many cases, the end result of rebuilding is a single child widget
  /// or (for [MultiChildRenderObjectElement]s) a list of children widgets.
  ///
  /// These child widgets are used to update the [widget] property of the
  /// element's child (or children) elements. The new [Widget] is considered to
  /// correspond to an existing [Element] if it has the same [Type] and [Key].
  /// (In the case of [MultiChildRenderObjectElement]s, some effort is put into
  /// tracking widgets even when they change order; see
  /// [RenderObjectElement.updateChildren].)
  ///
  /// If there was no corresponding previous child, this results in a new
  /// [Element] being created (using [Widget.createElement]); that element is
  /// then itself built, recursively.
  ///
  /// If there was a child previously but the build did not provide a
  /// corresponding child to update it, then the old child is discarded (or, in
  /// cases involving [GlobalKey] reparenting, reused elsewhere in the element
  /// tree).
  ///
  /// The most common case, however, is that there was a corresponding previous
  /// child. This is handled by asking the child [Element] to update itself
  /// using the new child [Widget]. In the case of [StatefulElement]s, this
  /// is what triggers [State.didUpdateWidget].
  ///
  /// ### Not rebuilding
  ///
  /// Before an [Element] is told to update itself with a new [Widget], the old
  /// and new objects are compared using `operator ==`.
  ///
  /// In general, this is equivalent to doing a comparison using [identical] to
  /// see if the two objects are in fact the exact same instance. If they are,
  /// and if the element is not already marked dirty for other reasons, then the
  /// element skips updating itself as it can determine with certainty that
  /// there would be no value in updating itself or its descendants.
  ///
  /// It is strongly advised to avoid overriding `operator ==` on [Widget]
  /// objects. While doing so seems like it could improve performance, in
  /// practice, for non-leaf widgets, it results in O(N²) behavior. This is
  /// because by necessity the comparison would have to include comparing child
  /// widgets, and if those child widgets also implement `operator ==`, it
  /// ultimately results in a complete walk of the widget tree... which is then
  /// repeated at each level of the tree. In practice, just rebuilding is
  /// cheaper. (Additionally, if _any_ subclass of [Widget] used in an
  /// application implements `operator ==`, then the compiler cannot inline the
  /// comparison anywhere, because it has to treat the call as virtual just in
  /// case the instance happens to be one that has an overridden operator.)
  ///
  /// Instead, the best way to avoid unnecessary rebuilds is to cache the
  /// widgets that are returned from [State.build], so that each frame the same
  /// widgets are used until such time as they change. Several mechanisms exist
  /// to encourage this: `const` widgets, for example, are a form of automatic
  /// caching (if a widget is constructed using the `const` keyword, the same
  /// instance is returned each time it is constructed with the same arguments).
  ///
  /// Another example is the [AnimatedBuilder.child] property, which allows the
  /// non-animating parts of a subtree to remain static even as the
  /// [AnimatedBuilder.builder] callback recreates the other components.
  @pragma('vm:prefer-inline')
  void rebuild({bool force = false}) {
    assert(_lifecycleState != _ElementLifecycle.initial);
    if (_lifecycleState != _ElementLifecycle.active || (!_dirty && !force)) {
      return;
    }
    assert(() {
      debugOnRebuildDirtyWidget?.call(this, _debugBuiltOnce);
      if (debugPrintRebuildDirtyWidgets) {
        if (!_debugBuiltOnce) {
          debugPrint('Building \$this');
          _debugBuiltOnce = true;
        } else {
          debugPrint('Rebuilding \$this');
        }
      }
      return true;
    }());
    assert(_lifecycleState == _ElementLifecycle.active);
    assert(owner!._debugStateLocked);
    Element? debugPreviousBuildTarget;
    assert(() {
      debugPreviousBuildTarget = owner!._debugCurrentBuildTarget;
      owner!._debugCurrentBuildTarget = this;
      return true;
    }());
    try {
      performRebuild();
    } finally {
      assert(() {
        owner!._debugElementWasRebuilt(this);
        assert(owner!._debugCurrentBuildTarget == this);
        owner!._debugCurrentBuildTarget = debugPreviousBuildTarget;
        return true;
      }());
    }
    assert(!_dirty);
  }

  /// Cause the widget to update itself.
  ///
  /// Called by [rebuild] after the appropriate checks have been made.
  ///
  /// The base implementation only clears the [dirty] flag.
  @protected
  @mustCallSuper
  void performRebuild() {
    _dirty = false;
  }
}

class _ElementDiagnosticableTreeNode extends DiagnosticableTreeNode {
  _ElementDiagnosticableTreeNode({
    super.name,
    required Element super.value,
    required super.style,
    this.stateful = false,
  });

  final bool stateful;

  @override
  Map<String, Object?> toJsonMap(DiagnosticsSerializationDelegate delegate) {
    final Map<String, Object?> json = super.toJsonMap(delegate);
    final Element element = value as Element;
    if (!element.debugIsDefunct) {
      json['widgetRuntimeType'] = element.widget.runtimeType.toString();
    }
    json['stateful'] = stateful;
    return json;
  }
}

/// Signature for the constructor that is called when an error occurs while
/// building a widget.
///
/// The argument provides information regarding the cause of the error.
///
/// See also:
///
///  * [ErrorWidget.builder], which can be set to override the default
///    [ErrorWidget] builder.
///  * [FlutterError.reportError], which is typically called with the same
///    [FlutterErrorDetails] object immediately prior to [ErrorWidget.builder]
///    being called.
typedef ErrorWidgetBuilder = Widget Function(FlutterErrorDetails details);

/// A widget that renders an exception's message.
///
/// This widget is used when a build method fails, to help with determining
/// where the problem lies. Exceptions are also logged to the console, which you
/// can read using `flutter logs`. The console will also include additional
/// information such as the stack trace for the exception.
///
/// It is possible to override this widget.
///
/// {@tool dartpad}
/// This example shows how to override the standard error widget builder in release
/// mode, but use the standard one in debug mode.
///
/// The error occurs when you click the "Error Prone" button.
///
/// ** See code in examples/api/lib/widgets/framework/error_widget.0.dart **
/// {@end-tool}
///
/// See also:
///
///  * [FlutterError.onError], which can be set to a method that exits the
///    application if that is preferable to showing an error message.
///  * <https://flutter.dev/docs/testing/errors>, more information about error
///    handling in Flutter.
class ErrorWidget extends LeafRenderObjectWidget {
  /// Creates a widget that displays the given exception.
  ///
  /// The message will be the stringification of the given exception, unless
  /// computing that value itself throws an exception, in which case it will
  /// be the string "Error".
  ///
  /// If this object is inspected from an IDE or the devtools, and the original
  /// exception is a [FlutterError] object, the original exception itself will
  /// be shown in the inspection output.
  ErrorWidget(Object exception)
    : message = _stringify(exception),
      _flutterError = exception is FlutterError ? exception : null,
      super(key: UniqueKey());

  /// Creates a widget that displays the given error message.
  ///
  /// An explicit [FlutterError] can be provided to be reported to inspection
  /// tools. It need not match the message.
  ErrorWidget.withDetails({ this.message = '', FlutterError? error })
    : _flutterError = error,
      super(key: UniqueKey());

  /// The configurable factory for [ErrorWidget].
  ///
  /// When an error occurs while building a widget, the broken widget is
  /// replaced by the widget returned by this function. By default, an
  /// [ErrorWidget] is returned.
  ///
  /// The system is typically in an unstable state when this function is called.
  /// An exception has just been thrown in the middle of build (and possibly
  /// layout), so surrounding widgets and render objects may be in a rather
  /// fragile state. The framework itself (especially the [BuildOwner]) may also
  /// be confused, and additional exceptions are quite likely to be thrown.
  ///
  /// Because of this, it is highly recommended that the widget returned from
  /// this function perform the least amount of work possible. A
  /// [LeafRenderObjectWidget] is the best choice, especially one that
  /// corresponds to a [RenderBox] that can handle the most absurd of incoming
  /// constraints. The default constructor maps to a [RenderErrorBox].
  ///
  /// The default behavior is to show the exception's message in debug mode,
  /// and to show nothing but a gray background in release builds.
  ///
  /// See also:
  ///
  ///  * [FlutterError.onError], which is typically called with the same
  ///    [FlutterErrorDetails] object immediately prior to this callback being
  ///    invoked, and which can also be configured to control how errors are
  ///    reported.
  ///  * <https://flutter.dev/docs/testing/errors>, more information about error
  ///    handling in Flutter.
  static ErrorWidgetBuilder builder = _defaultErrorWidgetBuilder;

  static Widget _defaultErrorWidgetBuilder(FlutterErrorDetails details) {
    String message = '';
    assert(() {
      message = '\${_stringify(details.exception)}\nSee also: https://flutter.dev/docs/testing/errors';
      return true;
    }());
    final Object exception = details.exception;
    return ErrorWidget.withDetails(message: message, error: exception is FlutterError ? exception : null);
  }

  static String _stringify(Object? exception) {
    try {
      return exception.toString();
    } catch (error) {
      // If we get here, it means things have really gone off the rails, and we're better
      // off just returning a simple string and letting the developer find out what the
      // root cause of all their problems are by looking at the console logs.
    }
    return 'Error';
  }

  /// The message to display.
  final String message;
  final FlutterError? _flutterError;

  @override
  RenderBox createRenderObject(BuildContext context) => RenderErrorBox(message);

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    if (_flutterError == null) {
      properties.add(StringProperty('message', message, quoted: false));
    } else {
      properties.add(_flutterError!.toDiagnosticsNode(style: DiagnosticsTreeStyle.whitespace));
    }
  }
}

/// Signature for a function that creates a widget, e.g. [StatelessWidget.build]
/// or [State.build].
///
/// Used by [Builder.builder], [OverlayEntry.builder], etc.
///
/// See also:
///
///  * [IndexedWidgetBuilder], which is similar but also takes an index.
///  * [TransitionBuilder], which is similar but also takes a child.
///  * [ValueWidgetBuilder], which is similar but takes a value and a child.
typedef WidgetBuilder = Widget Function(BuildContext context);

/// Signature for a function that creates a widget for a given index, e.g., in a
/// list.
///
/// Used by [ListView.builder] and other APIs that use lazily-generated widgets.
///
/// See also:
///
///  * [WidgetBuilder], which is similar but only takes a [BuildContext].
///  * [TransitionBuilder], which is similar but also takes a child.
///  * [NullableIndexedWidgetBuilder], which is similar but may return null.
typedef IndexedWidgetBuilder = Widget Function(BuildContext context, int index);

/// Signature for a function that creates a widget for a given index, e.g., in a
/// list, but may return null.
///
/// Used by [SliverChildBuilderDelegate.builder] and other APIs that
/// use lazily-generated widgets where the child count is not known
/// ahead of time.
///
/// Unlike most builders, this callback can return null, indicating the index
/// is out of range. Whether and when this is valid depends on the semantics
/// of the builder. For example, [SliverChildBuilderDelegate.builder] returns
/// null when the index is out of range, where the range is defined by the
/// [SliverChildBuilderDelegate.childCount]; so in that case the `index`
/// parameter's value may determine whether returning null is valid or not.
///
/// See also:
///
///  * [WidgetBuilder], which is similar but only takes a [BuildContext].
///  * [TransitionBuilder], which is similar but also takes a child.
///  * [IndexedWidgetBuilder], which is similar but not nullable.
typedef NullableIndexedWidgetBuilder = Widget? Function(BuildContext context, int index);

/// A builder that builds a widget given a child.
///
/// The child should typically be part of the returned widget tree.
///
/// Used by [AnimatedBuilder.builder], [ListenableBuilder.builder],
/// [WidgetsApp.builder], and [MaterialApp.builder].
///
/// See also:
///
/// * [WidgetBuilder], which is similar but only takes a [BuildContext].
/// * [IndexedWidgetBuilder], which is similar but also takes an index.
/// * [ValueWidgetBuilder], which is similar but takes a value and a child.
typedef TransitionBuilder = Widget Function(BuildContext context, Widget? child);

/// An [Element] that composes other [Element]s.
///
/// Rather than creating a [RenderObject] directly, a [ComponentElement] creates
/// [RenderObject]s indirectly by creating other [Element]s.
///
/// Contrast with [RenderObjectElement].
abstract class ComponentElement extends Element {
  /// Creates an element that uses the given widget as its configuration.
  ComponentElement(super.widget);

  Element? _child;

  bool _debugDoingBuild = false;
  @override
  bool get debugDoingBuild => _debugDoingBuild;

  @override
  void mount(Element? parent, Object? newSlot) {
    super.mount(parent, newSlot);
    assert(_child == null);
    assert(_lifecycleState == _ElementLifecycle.active);
    _firstBuild();
    assert(_child != null);
  }

  void _firstBuild() {
    // StatefulElement overrides this to also call state.didChangeDependencies.
    rebuild(); // This eventually calls performRebuild.
  }

  /// Calls the [StatelessWidget.build] method of the [StatelessWidget] object
  /// (for stateless widgets) or the [State.build] method of the [State] object
  /// (for stateful widgets) and then updates the widget tree.
  ///
  /// Called automatically during [mount] to generate the first build, and by
  /// [rebuild] when the element needs updating.
  @override
  @pragma('vm:notify-debugger-on-exception')
  void performRebuild() {
    Widget? built;
    try {
      assert(() {
        _debugDoingBuild = true;
        return true;
      }());
      built = build();
      assert(() {
        _debugDoingBuild = false;
        return true;
      }());
      debugWidgetBuilderValue(widget, built);
    } catch (e, stack) {
      _debugDoingBuild = false;
      built = ErrorWidget.builder(
        _reportException(
          ErrorDescription('building \$this'),
          e,
          stack,
          informationCollector: () => <DiagnosticsNode>[
            if (kDebugMode)
              DiagnosticsDebugCreator(DebugCreator(this)),
          ],
        ),
      );
    } finally {
      // We delay marking the element as clean until after calling build() so
      // that attempts to markNeedsBuild() during build() will be ignored.
      super.performRebuild(); // clears the "dirty" flag
    }
    try {
      _child = updateChild(_child, built, slot);
      assert(_child != null);
    } catch (e, stack) {
      built = ErrorWidget.builder(
        _reportException(
          ErrorDescription('building \$this'),
          e,
          stack,
          informationCollector: () => <DiagnosticsNode>[
            if (kDebugMode)
              DiagnosticsDebugCreator(DebugCreator(this)),
          ],
        ),
      );
      _child = updateChild(null, built, slot);
    }
  }

  /// Subclasses should override this function to actually call the appropriate
  /// `build` function (e.g., [StatelessWidget.build] or [State.build]) for
  /// their widget.
  @protected
  Widget build();

  @override
  void visitChildren(ElementVisitor visitor) {
    if (_child != null) {
      visitor(_child!);
    }
  }

  @override
  void forgetChild(Element child) {
    assert(child == _child);
    _child = null;
    super.forgetChild(child);
  }
}

/// An [Element] that uses a [StatelessWidget] as its configuration.
class StatelessElement extends ComponentElement {
  /// Creates an element that uses the given widget as its configuration.
  StatelessElement(StatelessWidget super.widget);

  @override
  Widget build() => (widget as StatelessWidget).build(this);

  @override
  void update(StatelessWidget newWidget) {
    super.update(newWidget);
    assert(widget == newWidget);
    rebuild(force: true);
  }
}

/// An [Element] that uses a [StatefulWidget] as its configuration.
class StatefulElement extends ComponentElement {
  /// Creates an element that uses the given widget as its configuration.
  StatefulElement(StatefulWidget widget)
      : _state = widget.createState(),
        super(widget) {
    assert(() {
      if (!state._debugTypesAreRight(widget)) {
        throw FlutterError.fromParts(<DiagnosticsNode>[
          ErrorSummary('StatefulWidget.createState must return a subtype of State<\${widget.runtimeType}>'),
          ErrorDescription(
            'The createState function for \${widget.runtimeType} returned a state '
            'of type \${state.runtimeType}, which is not a subtype of '
            'State<\${widget.runtimeType}>, violating the contract for createState.',
          ),
        ]);
      }
      return true;
    }());
    assert(state._element == null);
    state._element = this;
    assert(
      state._widget == null,
      'The createState function for \$widget returned an old or invalid state '
      'instance: \${state._widget}, which is not null, violating the contract '
      'for createState.',
    );
    state._widget = widget;
    assert(state._debugLifecycleState == _StateLifecycle.created);
  }

  @override
  Widget build() => state.build(this);

  /// The [State] instance associated with this location in the tree.
  ///
  /// There is a one-to-one relationship between [State] objects and the
  /// [StatefulElement] objects that hold them. The [State] objects are created
  /// by [StatefulElement] in [mount].
  State<StatefulWidget> get state => _state!;
  State<StatefulWidget>? _state;

  @override
  void reassemble() {
    if (_debugShouldReassemble(_debugReassembleConfig, _widget)) {
      state.reassemble();
    }
    super.reassemble();
  }

  @override
  void _firstBuild() {
    assert(state._debugLifecycleState == _StateLifecycle.created);
    final Object? debugCheckForReturnedFuture = state.initState() as dynamic;
    assert(() {
      if (debugCheckForReturnedFuture is Future) {
        throw FlutterError.fromParts(<DiagnosticsNode>[
          ErrorSummary('\${state.runtimeType}.initState() returned a Future.'),
          ErrorDescription('State.initState() must be a void method without an `async` keyword.'),
          ErrorHint(
            'Rather than awaiting on asynchronous work directly inside of initState, '
            'call a separate method to do this work without awaiting it.',
          ),
        ]);
      }
      return true;
    }());
    assert(() {
      state._debugLifecycleState = _StateLifecycle.initialized;
      return true;
    }());
    state.didChangeDependencies();
    assert(() {
      state._debugLifecycleState = _StateLifecycle.ready;
      return true;
    }());
    super._firstBuild();
  }

  @override
  void performRebuild() {
    if (_didChangeDependencies) {
      state.didChangeDependencies();
      _didChangeDependencies = false;
    }
    super.performRebuild();
  }

  @override
  void update(StatefulWidget newWidget) {
    super.update(newWidget);
    assert(widget == newWidget);
    final StatefulWidget oldWidget = state._widget!;
    state._widget = widget as StatefulWidget;
    final Object? debugCheckForReturnedFuture = state.didUpdateWidget(oldWidget) as dynamic;
    assert(() {
      if (debugCheckForReturnedFuture is Future) {
        throw FlutterError.fromParts(<DiagnosticsNode>[
          ErrorSummary('\${state.runtimeType}.didUpdateWidget() returned a Future.'),
          ErrorDescription( 'State.didUpdateWidget() must be a void method without an `async` keyword.'),
          ErrorHint(
            'Rather than awaiting on asynchronous work directly inside of didUpdateWidget, '
            'call a separate method to do this work without awaiting it.',
          ),
        ]);
      }
      return true;
    }());
    rebuild(force: true);
  }

  @override
  void activate() {
    super.activate();
    state.activate();
    // Since the State could have observed the deactivate() and thus disposed of
    // resources allocated in the build method, we have to rebuild the widget
    // so that its State can reallocate its resources.
    assert(_lifecycleState == _ElementLifecycle.active); // otherwise markNeedsBuild is a no-op
    markNeedsBuild();
  }

  @override
  void deactivate() {
    state.deactivate();
    super.deactivate();
  }

  @override
  void unmount() {
    super.unmount();
    state.dispose();
    assert(() {
      if (state._debugLifecycleState == _StateLifecycle.defunct) {
        return true;
      }
      throw FlutterError.fromParts(<DiagnosticsNode>[
        ErrorSummary('\${state.runtimeType}.dispose failed to call super.dispose.'),
        ErrorDescription(
          'dispose() implementations must always call their superclass dispose() method, to ensure '
          'that all the resources used by the widget are fully released.',
        ),
      ]);
    }());
    state._element = null;
    // Release resources to reduce the severity of memory leaks caused by
    // defunct, but accidentally retained Elements.
    _state = null;
  }

  @override
  InheritedWidget dependOnInheritedElement(Element ancestor, { Object? aspect }) {
    assert(() {
      final Type targetType = ancestor.widget.runtimeType;
      if (state._debugLifecycleState == _StateLifecycle.created) {
        throw FlutterError.fromParts(<DiagnosticsNode>[
          ErrorSummary('dependOnInheritedWidgetOfExactType<\$targetType>() or dependOnInheritedElement() was called before \${state.runtimeType}.initState() completed.'),
          ErrorDescription(
            'When an inherited widget changes, for example if the value of Theme.of() changes, '
            "its dependent widgets are rebuilt. If the dependent widget's reference to "
            'the inherited widget is in a constructor or an initState() method, '
            'then the rebuilt dependent widget will not reflect the changes in the '
            'inherited widget.',
          ),
          ErrorHint(
            'Typically references to inherited widgets should occur in widget build() methods. Alternatively, '
            'initialization based on inherited widgets can be placed in the didChangeDependencies method, which '
            'is called after initState and whenever the dependencies change thereafter.',
          ),
        ]);
      }
      if (state._debugLifecycleState == _StateLifecycle.defunct) {
        throw FlutterError.fromParts(<DiagnosticsNode>[
          ErrorSummary('dependOnInheritedWidgetOfExactType<\$targetType>() or dependOnInheritedElement() was called after dispose(): \$this'),
          ErrorDescription(
            'This error happens if you call dependOnInheritedWidgetOfExactType() on the '
            'BuildContext for a widget that no longer appears in the widget tree '
            '(e.g., whose parent widget no longer includes the widget in its '
            'build). This error can occur when code calls '
            'dependOnInheritedWidgetOfExactType() from a timer or an animation callback.',
          ),
          ErrorHint(
            'The preferred solution is to cancel the timer or stop listening to the '
            'animation in the dispose() callback. Another solution is to check the '
            '"mounted" property of this object before calling '
            'dependOnInheritedWidgetOfExactType() to ensure the object is still in the '
            'tree.',
          ),
          ErrorHint(
            'This error might indicate a memory leak if '
            'dependOnInheritedWidgetOfExactType() is being called because another object '
            'is retaining a reference to this State object after it has been '
            'removed from the tree. To avoid memory leaks, consider breaking the '
            'reference to this object during dispose().',
          ),
        ]);
      }
      return true;
    }());
    return super.dependOnInheritedElement(ancestor as InheritedElement, aspect: aspect);
  }

  /// This controls whether we should call [State.didChangeDependencies] from
  /// the start of [build], to avoid calls when the [State] will not get built.
  /// This can happen when the widget has dropped out of the tree, but depends
  /// on an [InheritedWidget] that is still in the tree.
  ///
  /// It is set initially to false, since [_firstBuild] makes the initial call
  /// on the [state]. When it is true, [build] will call
  /// `state.didChangeDependencies` and then sets it to false. Subsequent calls
  /// to [didChangeDependencies] set it to true.
  bool _didChangeDependencies = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _didChangeDependencies = true;
  }

  @override
  DiagnosticsNode toDiagnosticsNode({ String? name, DiagnosticsTreeStyle? style }) {
    return _ElementDiagnosticableTreeNode(
      name: name,
      value: this,
      style: style,
      stateful: true,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<State<StatefulWidget>>('state', _state, defaultValue: null));
  }
}

/// An [Element] that uses a [ProxyWidget] as its configuration.
abstract class ProxyElement extends ComponentElement {
  /// Initializes fields for subclasses.
  ProxyElement(ProxyWidget super.widget);

  @override
  Widget build() => (widget as ProxyWidget).child;

  @override
  void update(ProxyWidget newWidget) {
    final ProxyWidget oldWidget = widget as ProxyWidget;
    assert(widget != newWidget);
    super.update(newWidget);
    assert(widget == newWidget);
    updated(oldWidget);
    rebuild(force: true);
  }

  /// Called during build when the [widget] has changed.
  ///
  /// By default, calls [notifyClients]. Subclasses may override this method to
  /// avoid calling [notifyClients] unnecessarily (e.g. if the old and new
  /// widgets are equivalent).
  @protected
  void updated(covariant ProxyWidget oldWidget) {
    notifyClients(oldWidget);
  }

  /// Notify other objects that the widget associated with this element has
  /// changed.
  ///
  /// Called during [update] (via [updated]) after changing the widget
  /// associated with this element but before rebuilding this element.
  @protected
  void notifyClients(covariant ProxyWidget oldWidget);
}

/// An [Element] that uses a [ParentDataWidget] as its configuration.
class ParentDataElement<T extends ParentData> extends ProxyElement {
  /// Creates an element that uses the given widget as its configuration.
  ParentDataElement(ParentDataWidget<T> super.widget);

  void _applyParentData(ParentDataWidget<T> widget) {
    void applyParentDataToChild(Element child) {
      if (child is RenderObjectElement) {
        child._updateParentData(widget);
      } else {
        assert(child is! ParentDataElement<ParentData>);
        child.visitChildren(applyParentDataToChild);
      }
    }
    visitChildren(applyParentDataToChild);
  }

  /// Calls [ParentDataWidget.applyParentData] on the given widget, passing it
  /// the [RenderObject] whose parent data this element is ultimately
  /// responsible for.
  ///
  /// This allows a render object's [RenderObject.parentData] to be modified
  /// without triggering a build. This is generally ill-advised, but makes sense
  /// in situations such as the following:
  ///
  ///  * Build and layout are currently under way, but the [ParentData] in question
  ///    does not affect layout, and the value to be applied could not be
  ///    determined before build and layout (e.g. it depends on the layout of a
  ///    descendant).
  ///
  ///  * Paint is currently under way, but the [ParentData] in question does not
  ///    affect layout or paint, and the value to be applied could not be
  ///    determined before paint (e.g. it depends on the compositing phase).
  ///
  /// In either case, the next build is expected to cause this element to be
  /// configured with the given new widget (or a widget with equivalent data).
  ///
  /// Only [ParentDataWidget]s that return true for
  /// [ParentDataWidget.debugCanApplyOutOfTurn] can be applied this way.
  ///
  /// The new widget must have the same child as the current widget.
  ///
  /// An example of when this is used is the [AutomaticKeepAlive] widget. If it
  /// receives a notification during the build of one of its descendants saying
  /// that its child must be kept alive, it will apply a [KeepAlive] widget out
  /// of turn. This is safe, because by definition the child is already alive,
  /// and therefore this will not change the behavior of the parent this frame.
  /// It is more efficient than requesting an additional frame just for the
  /// purpose of updating the [KeepAlive] widget.
  void applyWidgetOutOfTurn(ParentDataWidget<T> newWidget) {
    assert(newWidget.debugCanApplyOutOfTurn());
    assert(newWidget.child == (widget as ParentDataWidget<T>).child);
    _applyParentData(newWidget);
  }

  @override
  void notifyClients(ParentDataWidget<T> oldWidget) {
    _applyParentData(widget as ParentDataWidget<T>);
  }
}

/// An [Element] that uses an [InheritedWidget] as its configuration.
class InheritedElement extends ProxyElement {
  /// Creates an element that uses the given widget as its configuration.
  InheritedElement(InheritedWidget super.widget);

  final Map<Element, Object?> _dependents = HashMap<Element, Object?>();

  @override
  void _updateInheritance() {
    assert(_lifecycleState == _ElementLifecycle.active);
    final PersistentHashMap<Type, InheritedElement> incomingWidgets =
        _parent?._inheritedElements ?? const PersistentHashMap<Type, InheritedElement>.empty();
    _inheritedElements = incomingWidgets.put(widget.runtimeType, this);
  }

  @override
  void debugDeactivated() {
    assert(() {
      assert(_dependents.isEmpty);
      return true;
    }());
    super.debugDeactivated();
  }

  /// Returns the dependencies value recorded for [dependent]
  /// with [setDependencies].
  ///
  /// Each dependent element is mapped to a single object value
  /// which represents how the element depends on this
  /// [InheritedElement]. This value is null by default and by default
  /// dependent elements are rebuilt unconditionally.
  ///
  /// Subclasses can manage these values with [updateDependencies]
  /// so that they can selectively rebuild dependents in
  /// [notifyDependent].
  ///
  /// This method is typically only called in overrides of [updateDependencies].
  ///
  /// See also:
  ///
  ///  * [updateDependencies], which is called each time a dependency is
  ///    created with [dependOnInheritedWidgetOfExactType].
  ///  * [setDependencies], which sets dependencies value for a dependent
  ///    element.
  ///  * [notifyDependent], which can be overridden to use a dependent's
  ///    dependencies value to decide if the dependent needs to be rebuilt.
  ///  * [InheritedModel], which is an example of a class that uses this method
  ///    to manage dependency values.
  @protected
  Object? getDependencies(Element dependent) {
    return _dependents[dependent];
  }

  /// Sets the value returned by [getDependencies] value for [dependent].
  ///
  /// Each dependent element is mapped to a single object value
  /// which represents how the element depends on this
  /// [InheritedElement]. The [updateDependencies] method sets this value to
  /// null by default so that dependent elements are rebuilt unconditionally.
  ///
  /// Subclasses can manage these values with [updateDependencies]
  /// so that they can selectively rebuild dependents in [notifyDependent].
  ///
  /// This method is typically only called in overrides of [updateDependencies].
  ///
  /// See also:
  ///
  ///  * [updateDependencies], which is called each time a dependency is
  ///    created with [dependOnInheritedWidgetOfExactType].
  ///  * [getDependencies], which returns the current value for a dependent
  ///    element.
  ///  * [notifyDependent], which can be overridden to use a dependent's
  ///    [getDependencies] value to decide if the dependent needs to be rebuilt.
  ///  * [InheritedModel], which is an example of a class that uses this method
  ///    to manage dependency values.
  @protected
  void setDependencies(Element dependent, Object? value) {
    _dependents[dependent] = value;
  }

  /// Called by [dependOnInheritedWidgetOfExactType] when a new [dependent] is added.
  ///
  /// Each dependent element can be mapped to a single object value with
  /// [setDependencies]. This method can lookup the existing dependencies with
  /// [getDependencies].
  ///
  /// By default this method sets the inherited dependencies for [dependent]
  /// to null. This only serves to record an unconditional dependency on
  /// [dependent].
  ///
  /// Subclasses can manage their own dependencies values so that they
  /// can selectively rebuild dependents in [notifyDependent].
  ///
  /// See also:
  ///
  ///  * [getDependencies], which returns the current value for a dependent
  ///    element.
  ///  * [setDependencies], which sets the value for a dependent element.
  ///  * [notifyDependent], which can be overridden to use a dependent's
  ///    dependencies value to decide if the dependent needs to be rebuilt.
  ///  * [InheritedModel], which is an example of a class that uses this method
  ///    to manage dependency values.
  @protected
  void updateDependencies(Element dependent, Object? aspect) {
    setDependencies(dependent, null);
  }

  /// Called by [notifyClients] for each dependent.
  ///
  /// Calls `dependent.didChangeDependencies()` by default.
  ///
  /// Subclasses can override this method to selectively call
  /// [didChangeDependencies] based on the value of [getDependencies].
  ///
  /// See also:
  ///
  ///  * [updateDependencies], which is called each time a dependency is
  ///    created with [dependOnInheritedWidgetOfExactType].
  ///  * [getDependencies], which returns the current value for a dependent
  ///    element.
  ///  * [setDependencies], which sets the value for a dependent element.
  ///  * [InheritedModel], which is an example of a class that uses this method
  ///    to manage dependency values.
  @protected
  void notifyDependent(covariant InheritedWidget oldWidget, Element dependent) {
    dependent.didChangeDependencies();
  }

  /// Calls [Element.didChangeDependencies] of all dependent elements, if
  /// [InheritedWidget.updateShouldNotify] returns true.
  ///
  /// Called by [update], immediately prior to [build].
  ///
  /// Calls [notifyClients] to actually trigger the notifications.
  @override
  void updated(InheritedWidget oldWidget) {
    if ((widget as InheritedWidget).updateShouldNotify(oldWidget)) {
      super.updated(oldWidget);
    }
  }

  /// Notifies all dependent elements that this inherited widget has changed, by
  /// calling [Element.didChangeDependencies].
  ///
  /// This method must only be called during the build phase. Usually this
  /// method is called automatically when an inherited widget is rebuilt, e.g.
  /// as a result of calling [State.setState] above the inherited widget.
  ///
  /// See also:
  ///
  ///  * [InheritedNotifier], a subclass of [InheritedWidget] that also calls
  ///    this method when its [Listenable] sends a notification.
  @override
  void notifyClients(InheritedWidget oldWidget) {
    assert(_debugCheckOwnerBuildTargetExists('notifyClients'));
    for (final Element dependent in _dependents.keys) {
      assert(() {
        // check that it really is our descendant
        Element? ancestor = dependent._parent;
        while (ancestor != this && ancestor != null) {
          ancestor = ancestor._parent;
        }
        return ancestor == this;
      }());
      // check that it really depends on us
      assert(dependent._dependencies!.contains(this));
      notifyDependent(oldWidget, dependent);
    }
  }
}

/// An [Element] that uses a [RenderObjectWidget] as its configuration.
///
/// [RenderObjectElement] objects have an associated [RenderObject] widget in
/// the render tree, which handles concrete operations like laying out,
/// painting, and hit testing.
///
/// Contrast with [ComponentElement].
///
/// For details on the lifecycle of an element, see the discussion at [Element].
///
/// ## Writing a RenderObjectElement subclass
///
/// There are three common child models used by most [RenderObject]s:
///
/// * Leaf render objects, with no children: The [LeafRenderObjectElement] class
///   handles this case.
///
/// * A single child: The [SingleChildRenderObjectElement] class handles this
///   case.
///
/// * A linked list of children: The [MultiChildRenderObjectElement] class
///   handles this case.
///
/// Sometimes, however, a render object's child model is more complicated. Maybe
/// it has a two-dimensional array of children. Maybe it constructs children on
/// demand. Maybe it features multiple lists. In such situations, the
/// corresponding [Element] for the [Widget] that configures that [RenderObject]
/// will be a new subclass of [RenderObjectElement].
///
/// Such a subclass is responsible for managing children, specifically the
/// [Element] children of this object, and the [RenderObject] children of its
/// corresponding [RenderObject].
///
/// ### Specializing the getters
///
/// [RenderObjectElement] objects spend much of their time acting as
/// intermediaries between their [widget] and their [renderObject]. It is
/// generally recommended against specializing the [widget] getter and
/// instead casting at the various call sites to avoid adding overhead
/// outside of this particular implementation.
///
/// ```dart
/// class FooElement extends RenderObjectElement {
///   FooElement(super.widget);
///
///   // Specializing the renderObject getter is fine because
///   // it is not performance sensitive.
///   @override
///   RenderFoo get renderObject => super.renderObject as RenderFoo;
///
///   void _foo() {
///     // For the widget getter, though, we prefer to cast locally
///     // since that results in better overall performance where the
///     // casting isn't needed:
///     final Foo foo = widget as Foo;
///     // ...
///   }
///
///   // ...
/// }
/// ```
///
/// ### Slots
///
/// Each child [Element] corresponds to a [RenderObject] which should be
/// attached to this element's render object as a child.
///
/// However, the immediate children of the element may not be the ones that
/// eventually produce the actual [RenderObject] that they correspond to. For
/// example, a [StatelessElement] (the element of a [StatelessWidget])
/// corresponds to whatever [RenderObject] its child (the element returned by
/// its [StatelessWidget.build] method) corresponds to.
///
/// Each child is therefore assigned a _[slot]_ token. This is an identifier whose
/// meaning is private to this [RenderObjectElement] node. When the descendant
/// that finally produces the [RenderObject] is ready to attach it to this
/// node's render object, it passes that slot token back to this node, and that
/// allows this node to cheaply identify where to put the child render object
/// relative to the others in the parent render object.
///
/// A child's [slot] is determined when the parent calls [updateChild] to
/// inflate the child (see the next section). It can be updated by calling
/// [updateSlotForChild].
///
/// ### Updating children
///
/// Early in the lifecycle of an element, the framework calls the [mount]
/// method. This method should call [updateChild] for each child, passing in
/// the widget for that child, and the slot for that child, thus obtaining a
/// list of child [Element]s.
///
/// Subsequently, the framework will call the [update] method. In this method,
/// the [RenderObjectElement] should call [updateChild] for each child, passing
/// in the [Element] that was obtained during [mount] or the last time [update]
/// was run (whichever happened most recently), the new [Widget], and the slot.
/// This provides the object with a new list of [Element] objects.
///
/// Where possible, the [update] method should attempt to map the elements from
/// the last pass to the widgets in the new pass. For example, if one of the
/// elements from the last pass was configured with a particular [Key], and one
/// of the widgets in this new pass has that same key, they should be paired up,
/// and the old element should be updated with the widget (and the slot
/// corresponding to the new widget's new position, also). The [updateChildren]
/// method may be useful in this regard.
///
/// [updateChild] should be called for children in their logical order. The
/// order can matter; for example, if two of the children use [PageStorage]'s
/// `writeState` feature in their build method (and neither has a [Widget.key]),
/// then the state written by the first will be overwritten by the second.
///
/// #### Dynamically determining the children during the build phase
///
/// The child widgets need not necessarily come from this element's widget
/// verbatim. They could be generated dynamically from a callback, or generated
/// in other more creative ways.
///
/// #### Dynamically determining the children during layout
///
/// If the widgets are to be generated at layout time, then generating them in
/// the [mount] and [update] methods won't work: layout of this element's render
/// object hasn't started yet at that point. Instead, the [update] method can
/// mark the render object as needing layout (see
/// [RenderObject.markNeedsLayout]), and then the render object's
/// [RenderObject.performLayout] method can call back to the element to have it
/// generate the widgets and call [updateChild] accordingly.
///
/// For a render object to call an element during layout, it must use
/// [RenderObject.invokeLayoutCallback]. For an element to call [updateChild]
/// outside of its [update] method, it must use [BuildOwner.buildScope].
///
/// The framework provides many more checks in normal operation than it does
/// when doing a build during layout. For this reason, creating widgets with
/// layout-time build semantics should be done with great care.
///
/// #### Handling errors when building
///
/// If an element calls a builder function to obtain widgets for its children,
/// it may find that the build throws an exception. Such exceptions should be
/// caught and reported using [FlutterError.reportError]. If a child is needed
/// but a builder has failed in this way, an instance of [ErrorWidget] can be
/// used instead.
///
/// ### Detaching children
///
/// It is possible, when using [GlobalKey]s, for a child to be proactively
/// removed by another element before this element has been updated.
/// (Specifically, this happens when the subtree rooted at a widget with a
/// particular [GlobalKey] is being moved from this element to an element
/// processed earlier in the build phase.) When this happens, this element's
/// [forgetChild] method will be called with a reference to the affected child
/// element.
///
/// The [forgetChild] method of a [RenderObjectElement] subclass must remove the
/// child element from its child list, so that when it next [update]s its
/// children, the removed child is not considered.
///
/// For performance reasons, if there are many elements, it may be quicker to
/// track which elements were forgotten by storing them in a [Set], rather than
/// proactively mutating the local record of the child list and the identities
/// of all the slots. For example, see the implementation of
/// [MultiChildRenderObjectElement].
///
/// ### Maintaining the render object tree
///
/// Once a descendant produces a render object, it will call
/// [insertRenderObjectChild]. If the descendant's slot changes identity, it
/// will call [moveRenderObjectChild]. If a descendant goes away, it will call
/// [removeRenderObjectChild].
///
/// These three methods should update the render tree accordingly, attaching,
/// moving, and detaching the given child render object from this element's own
/// render object respectively.
///
/// ### Walking the children
///
/// If a [RenderObjectElement] object has any children [Element]s, it must
/// expose them in its implementation of the [visitChildren] method. This method
/// is used by many of the framework's internal mechanisms, and so should be
/// fast. It is also used by the test framework and [debugDumpApp].
abstract class RenderObjectElement extends Element {
  /// Creates an element that uses the given widget as its configuration.
  RenderObjectElement(RenderObjectWidget super.widget);

  /// The underlying [RenderObject] for this element.
  ///
  /// If this element has been [unmount]ed, this getter will throw.
  @override
  RenderObject get renderObject {
    assert(_renderObject != null, '\$runtimeType unmounted');
    return _renderObject!;
  }
  RenderObject? _renderObject;

  bool _debugDoingBuild = false;
  @override
  bool get debugDoingBuild => _debugDoingBuild;

  RenderObjectElement? _ancestorRenderObjectElement;

  RenderObjectElement? _findAncestorRenderObjectElement() {
    Element? ancestor = _parent;
    while (ancestor != null && ancestor is! RenderObjectElement) {
      ancestor = ancestor._parent;
    }
    return ancestor as RenderObjectElement?;
  }

  ParentDataElement<ParentData>? _findAncestorParentDataElement() {
    Element? ancestor = _parent;
    ParentDataElement<ParentData>? result;
    while (ancestor != null && ancestor is! RenderObjectElement) {
      if (ancestor is ParentDataElement<ParentData>) {
        result = ancestor;
        break;
      }
      ancestor = ancestor._parent;
    }
    assert(() {
      if (result == null || ancestor == null) {
        return true;
      }
      // Check that no other ParentDataWidgets want to provide parent data.
      final List<ParentDataElement<ParentData>> badAncestors = <ParentDataElement<ParentData>>[];
      ancestor = ancestor!._parent;
      while (ancestor != null && ancestor is! RenderObjectElement) {
        if (ancestor is ParentDataElement<ParentData>) {
          badAncestors.add(ancestor! as ParentDataElement<ParentData>);
        }
        ancestor = ancestor!._parent;
      }
      if (badAncestors.isNotEmpty) {
        badAncestors.insert(0, result);
        try {
          // We explicitly throw here (even though we immediately redirect the
          // exception elsewhere) so that debuggers will notice it when they
          // have "break on exception" enabled.
          throw FlutterError.fromParts(<DiagnosticsNode>[
            ErrorSummary('Incorrect use of ParentDataWidget.'),
            ErrorDescription('The following ParentDataWidgets are providing parent data to the same RenderObject:'),
            for (final ParentDataElement<ParentData> ancestor in badAncestors)
              ErrorDescription('- \${ancestor.widget} (typically placed directly inside a \${(ancestor.widget as ParentDataWidget<ParentData>).debugTypicalAncestorWidgetClass} widget)'),
            ErrorDescription('However, a RenderObject can only receive parent data from at most one ParentDataWidget.'),
            ErrorHint('Usually, this indicates that at least one of the offending ParentDataWidgets listed above is not placed directly inside a compatible ancestor widget.'),
            ErrorDescription('The ownership chain for the RenderObject that received the parent data was:\n  \${debugGetCreatorChain(10)}'),
          ]);
        } on FlutterError catch (e) {
          _reportException(ErrorSummary('while looking for parent data.'), e, e.stackTrace);
        }
      }
      return true;
    }());
    return result;
  }

  @override
  void mount(Element? parent, Object? newSlot) {
    super.mount(parent, newSlot);
    assert(() {
      _debugDoingBuild = true;
      return true;
    }());
    _renderObject = (widget as RenderObjectWidget).createRenderObject(this);
    assert(!_renderObject!.debugDisposed!);
    assert(() {
      _debugDoingBuild = false;
      return true;
    }());
    assert(() {
      _debugUpdateRenderObjectOwner();
      return true;
    }());
    assert(_slot == newSlot);
    attachRenderObject(newSlot);
    super.performRebuild(); // clears the "dirty" flag
  }

  @override
  void update(covariant RenderObjectWidget newWidget) {
    super.update(newWidget);
    assert(widget == newWidget);
    assert(() {
      _debugUpdateRenderObjectOwner();
      return true;
    }());
    _performRebuild(); // calls widget.updateRenderObject()
  }

  void _debugUpdateRenderObjectOwner() {
    assert(() {
      renderObject.debugCreator = DebugCreator(this);
      return true;
    }());
  }

  @override
  void performRebuild() { // ignore: must_call_super, _performRebuild calls super.
    _performRebuild(); // calls widget.updateRenderObject()
  }

  @pragma('vm:prefer-inline')
  void _performRebuild() {
    assert(() {
      _debugDoingBuild = true;
      return true;
    }());
    (widget as RenderObjectWidget).updateRenderObject(this, renderObject);
    assert(() {
      _debugDoingBuild = false;
      return true;
    }());
    super.performRebuild(); // clears the "dirty" flag
  }

  /// Updates the children of this element to use new widgets.
  ///
  /// Attempts to update the given old children list using the given new
  /// widgets, removing obsolete elements and introducing new ones as necessary,
  /// and then returns the new child list.
  ///
  /// During this function the `oldChildren` list must not be modified. If the
  /// caller wishes to remove elements from `oldChildren` reentrantly while
  /// this function is on the stack, the caller can supply a `forgottenChildren`
  /// argument, which can be modified while this function is on the stack.
  /// Whenever this function reads from `oldChildren`, this function first
  /// checks whether the child is in `forgottenChildren`. If it is, the function
  /// acts as if the child was not in `oldChildren`.
  ///
  /// This function is a convenience wrapper around [updateChild], which updates
  /// each individual child. If `slots` is non-null, the value for the `newSlot`
  /// argument of [updateChild] is retrieved from that list using the index that
  /// the currently processed `child` corresponds to in the `newWidgets` list
  /// (`newWidgets` and `slots` must have the same length). If `slots` is null,
  /// an [IndexedSlot<Element>] is used as the value for the `newSlot` argument.
  /// In that case, [IndexedSlot.index] is set to the index that the currently
  /// processed `child` corresponds to in the `newWidgets` list and
  /// [IndexedSlot.value] is set to the [Element] of the previous widget in that
  /// list (or null if it is the first child).
  ///
  /// When the [slot] value of an [Element] changes, its
  /// associated [renderObject] needs to move to a new position in the child
  /// list of its parents. If that [RenderObject] organizes its children in a
  /// linked list (as is done by the [ContainerRenderObjectMixin]) this can
  /// be implemented by re-inserting the child [RenderObject] into the
  /// list after the [RenderObject] associated with the [Element] provided as
  /// [IndexedSlot.value] in the [slot] object.
  ///
  /// Using the previous sibling as a [slot] is not enough, though, because
  /// child [RenderObject]s are only moved around when the [slot] of their
  /// associated [RenderObjectElement]s is updated. When the order of child
  /// [Element]s is changed, some elements in the list may move to a new index
  /// but still have the same previous sibling. For example, when
  /// `[e1, e2, e3, e4]` is changed to `[e1, e3, e4, e2]` the element e4
  /// continues to have e3 as a previous sibling even though its index in the list
  /// has changed and its [RenderObject] needs to move to come before e2's
  /// [RenderObject]. In order to trigger this move, a new [slot] value needs to
  /// be assigned to its [Element] whenever its index in its
  /// parent's child list changes. Using an [IndexedSlot<Element>] achieves
  /// exactly that and also ensures that the underlying parent [RenderObject]
  /// knows where a child needs to move to in a linked list by providing its new
  /// previous sibling.
  @protected
  List<Element> updateChildren(List<Element> oldChildren, List<Widget> newWidgets, { Set<Element>? forgottenChildren, List<Object?>? slots }) {
    assert(slots == null || newWidgets.length == slots.length);

    Element? replaceWithNullIfForgotten(Element child) {
      return forgottenChildren != null && forgottenChildren.contains(child) ? null : child;
    }

    Object? slotFor(int newChildIndex, Element? previousChild) {
      return slots != null
        ? slots[newChildIndex]
        : IndexedSlot<Element?>(newChildIndex, previousChild);
    }

    // This attempts to diff the new child list (newWidgets) with
    // the old child list (oldChildren), and produce a new list of elements to
    // be the new list of child elements of this element. The called of this
    // method is expected to update this render object accordingly.

    // The cases it tries to optimize for are:
    //  - the old list is empty
    //  - the lists are identical
    //  - there is an insertion or removal of one or more widgets in
    //    only one place in the list
    // If a widget with a key is in both lists, it will be synced.
    // Widgets without keys might be synced but there is no guarantee.

    // The general approach is to sync the entire new list backwards, as follows:
    // 1. Walk the lists from the top, syncing nodes, until you no longer have
    //    matching nodes.
    // 2. Walk the lists from the bottom, without syncing nodes, until you no
    //    longer have matching nodes. We'll sync these nodes at the end. We
    //    don't sync them now because we want to sync all the nodes in order
    //    from beginning to end.
    // At this point we narrowed the old and new lists to the point
    // where the nodes no longer match.
    // 3. Walk the narrowed part of the old list to get the list of
    //    keys and sync null with non-keyed items.
    // 4. Walk the narrowed part of the new list forwards:
    //     * Sync non-keyed items with null
    //     * Sync keyed items with the source if it exists, else with null.
    // 5. Walk the bottom of the list again, syncing the nodes.
    // 6. Sync null with any items in the list of keys that are still
    //    mounted.

    int newChildrenTop = 0;
    int oldChildrenTop = 0;
    int newChildrenBottom = newWidgets.length - 1;
    int oldChildrenBottom = oldChildren.length - 1;

    final List<Element> newChildren = List<Element>.filled(newWidgets.length, _NullElement.instance);

    Element? previousChild;

    // Update the top of the list.
    while ((oldChildrenTop <= oldChildrenBottom) && (newChildrenTop <= newChildrenBottom)) {
      final Element? oldChild = replaceWithNullIfForgotten(oldChildren[oldChildrenTop]);
      final Widget newWidget = newWidgets[newChildrenTop];
      assert(oldChild == null || oldChild._lifecycleState == _ElementLifecycle.active);
      if (oldChild == null || !Widget.canUpdate(oldChild.widget, newWidget)) {
        break;
      }
      final Element newChild = updateChild(oldChild, newWidget, slotFor(newChildrenTop, previousChild))!;
      assert(newChild._lifecycleState == _ElementLifecycle.active);
      newChildren[newChildrenTop] = newChild;
      previousChild = newChild;
      newChildrenTop += 1;
      oldChildrenTop += 1;
    }

    // Scan the bottom of the list.
    while ((oldChildrenTop <= oldChildrenBottom) && (newChildrenTop <= newChildrenBottom)) {
      final Element? oldChild = replaceWithNullIfForgotten(oldChildren[oldChildrenBottom]);
      final Widget newWidget = newWidgets[newChildrenBottom];
      assert(oldChild == null || oldChild._lifecycleState == _ElementLifecycle.active);
      if (oldChild == null || !Widget.canUpdate(oldChild.widget, newWidget)) {
        break;
      }
      oldChildrenBottom -= 1;
      newChildrenBottom -= 1;
    }

    // Scan the old children in the middle of the list.
    final bool haveOldChildren = oldChildrenTop <= oldChildrenBottom;
    Map<Key, Element>? oldKeyedChildren;
    if (haveOldChildren) {
      oldKeyedChildren = <Key, Element>{};
      while (oldChildrenTop <= oldChildrenBottom) {
        final Element? oldChild = replaceWithNullIfForgotten(oldChildren[oldChildrenTop]);
        assert(oldChild == null || oldChild._lifecycleState == _ElementLifecycle.active);
        if (oldChild != null) {
          if (oldChild.widget.key != null) {
            oldKeyedChildren[oldChild.widget.key!] = oldChild;
          } else {
            deactivateChild(oldChild);
          }
        }
        oldChildrenTop += 1;
      }
    }

    // Update the middle of the list.
    while (newChildrenTop <= newChildrenBottom) {
      Element? oldChild;
      final Widget newWidget = newWidgets[newChildrenTop];
      if (haveOldChildren) {
        final Key? key = newWidget.key;
        if (key != null) {
          oldChild = oldKeyedChildren![key];
          if (oldChild != null) {
            if (Widget.canUpdate(oldChild.widget, newWidget)) {
              // we found a match!
              // remove it from oldKeyedChildren so we don't unsync it later
              oldKeyedChildren.remove(key);
            } else {
              // Not a match, let's pretend we didn't see it for now.
              oldChild = null;
            }
          }
        }
      }
      assert(oldChild == null || Widget.canUpdate(oldChild.widget, newWidget));
      final Element newChild = updateChild(oldChild, newWidget, slotFor(newChildrenTop, previousChild))!;
      assert(newChild._lifecycleState == _ElementLifecycle.active);
      assert(oldChild == newChild || oldChild == null || oldChild._lifecycleState != _ElementLifecycle.active);
      newChildren[newChildrenTop] = newChild;
      previousChild = newChild;
      newChildrenTop += 1;
    }

    // We've scanned the whole list.
    assert(oldChildrenTop == oldChildrenBottom + 1);
    assert(newChildrenTop == newChildrenBottom + 1);
    assert(newWidgets.length - newChildrenTop == oldChildren.length - oldChildrenTop);
    newChildrenBottom = newWidgets.length - 1;
    oldChildrenBottom = oldChildren.length - 1;

    // Update the bottom of the list.
    while ((oldChildrenTop <= oldChildrenBottom) && (newChildrenTop <= newChildrenBottom)) {
      final Element oldChild = oldChildren[oldChildrenTop];
      assert(replaceWithNullIfForgotten(oldChild) != null);
      assert(oldChild._lifecycleState == _ElementLifecycle.active);
      final Widget newWidget = newWidgets[newChildrenTop];
      assert(Widget.canUpdate(oldChild.widget, newWidget));
      final Element newChild = updateChild(oldChild, newWidget, slotFor(newChildrenTop, previousChild))!;
      assert(newChild._lifecycleState == _ElementLifecycle.active);
      assert(oldChild == newChild || oldChild._lifecycleState != _ElementLifecycle.active);
      newChildren[newChildrenTop] = newChild;
      previousChild = newChild;
      newChildrenTop += 1;
      oldChildrenTop += 1;
    }

    // Clean up any of the remaining middle nodes from the old list.
    if (haveOldChildren && oldKeyedChildren!.isNotEmpty) {
      for (final Element oldChild in oldKeyedChildren.values) {
        if (forgottenChildren == null || !forgottenChildren.contains(oldChild)) {
          deactivateChild(oldChild);
        }
      }
    }
    assert(newChildren.every((Element element) => element is! _NullElement));
    return newChildren;
  }

  @override
  void deactivate() {
    super.deactivate();
    assert(
      !renderObject.attached,
      'A RenderObject was still attached when attempting to deactivate its '
      'RenderObjectElement: \$renderObject',
    );
  }

  @override
  void unmount() {
    assert(
      !renderObject.debugDisposed!,
      'A RenderObject was disposed prior to its owning element being unmounted: '
      '\$renderObject',
    );
    final RenderObjectWidget oldWidget = widget as RenderObjectWidget;
    super.unmount();
    assert(
      !renderObject.attached,
      'A RenderObject was still attached when attempting to unmount its '
      'RenderObjectElement: \$renderObject',
    );
    oldWidget.didUnmountRenderObject(renderObject);
    _renderObject!.dispose();
    _renderObject = null;
  }

  void _updateParentData(ParentDataWidget<ParentData> parentDataWidget) {
    bool applyParentData = true;
    assert(() {
      try {
        if (!parentDataWidget.debugIsValidRenderObject(renderObject)) {
          applyParentData = false;
          throw FlutterError.fromParts(<DiagnosticsNode>[
            ErrorSummary('Incorrect use of ParentDataWidget.'),
            ...parentDataWidget._debugDescribeIncorrectParentDataType(
              parentData: renderObject.parentData,
              parentDataCreator: _ancestorRenderObjectElement!.widget as RenderObjectWidget,
              ownershipChain: ErrorDescription(debugGetCreatorChain(10)),
            ),
          ]);
        }
      } on FlutterError catch (e) {
        // We catch the exception directly to avoid activating the ErrorWidget,
        // while still allowing debuggers to break on exception. Since the tree
        // is in a broken state, adding the ErrorWidget would likely cause more
        // exceptions, which is not good for the debugging experience.
        _reportException(ErrorSummary('while applying parent data.'), e, e.stackTrace);
      }
      return true;
    }());
    if (applyParentData) {
      parentDataWidget.applyParentData(renderObject);
    }
  }

  @override
  void _updateSlot(Object? newSlot) {
    final Object? oldSlot = slot;
    assert(oldSlot != newSlot);
    super._updateSlot(newSlot);
    assert(slot == newSlot);
    _ancestorRenderObjectElement!.moveRenderObjectChild(renderObject, oldSlot, slot);
  }

  @override
  void attachRenderObject(Object? newSlot) {
    assert(_ancestorRenderObjectElement == null);
    _slot = newSlot;
    _ancestorRenderObjectElement = _findAncestorRenderObjectElement();
    _ancestorRenderObjectElement?.insertRenderObjectChild(renderObject, newSlot);
    final ParentDataElement<ParentData>? parentDataElement = _findAncestorParentDataElement();
    if (parentDataElement != null) {
      _updateParentData(parentDataElement.widget as ParentDataWidget<ParentData>);
    }
  }

  @override
  void detachRenderObject() {
    if (_ancestorRenderObjectElement != null) {
      _ancestorRenderObjectElement!.removeRenderObjectChild(renderObject, slot);
      _ancestorRenderObjectElement = null;
    }
    _slot = null;
  }

  /// Insert the given child into [renderObject] at the given slot.
  ///
  /// {@template flutter.widgets.RenderObjectElement.insertRenderObjectChild}
  /// The semantics of `slot` are determined by this element. For example, if
  /// this element has a single child, the slot should always be null. If this
  /// element has a list of children, the previous sibling element wrapped in an
  /// [IndexedSlot] is a convenient value for the slot.
  /// {@endtemplate}
  @protected
  void insertRenderObjectChild(covariant RenderObject child, covariant Object? slot);

  /// Move the given child from the given old slot to the given new slot.
  ///
  /// The given child is guaranteed to have [renderObject] as its parent.
  ///
  /// {@macro flutter.widgets.RenderObjectElement.insertRenderObjectChild}
  ///
  /// This method is only ever called if [updateChild] can end up being called
  /// with an existing [Element] child and a `slot` that differs from the slot
  /// that element was previously given. [MultiChildRenderObjectElement] does this,
  /// for example. [SingleChildRenderObjectElement] does not (since the `slot` is
  /// always null). An [Element] that has a specific set of slots with each child
  /// always having the same slot (and where children in different slots are never
  /// compared against each other for the purposes of updating one slot with the
  /// element from another slot) would never call this.
  @protected
  void moveRenderObjectChild(covariant RenderObject child, covariant Object? oldSlot, covariant Object? newSlot);

  /// Remove the given child from [renderObject].
  ///
  /// The given child is guaranteed to have been inserted at the given `slot`
  /// and have [renderObject] as its parent.
  @protected
  void removeRenderObjectChild(covariant RenderObject child, covariant Object? slot);

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<RenderObject>('renderObject', _renderObject, defaultValue: null));
  }
}

/// Deprecated. Unused in the framework and will be removed in a future version
/// of Flutter.
///
/// Classes that extend this class can extend [RenderObjectElement] and mixin
/// [RootElementMixin] instead.
@Deprecated(
  'Use RootElementMixin instead. '
  'This feature was deprecated after v3.9.0-16.0.pre.'
)
abstract class RootRenderObjectElement extends RenderObjectElement with RootElementMixin {
  /// Initializes fields for subclasses.
  @Deprecated(
    'Use RootElementMixin instead. '
    'This feature was deprecated after v3.9.0-16.0.pre.'
  )
  RootRenderObjectElement(super.widget);
}

/// Mixin for the element at the root of the tree.
///
/// Only root elements may have their owner set explicitly. All other
/// elements inherit their owner from their parent.
mixin RootElementMixin on Element {
  /// Set the owner of the element. The owner will be propagated to all the
  /// descendants of this element.
  ///
  /// The owner manages the dirty elements list.
  ///
  /// The [WidgetsBinding] introduces the primary owner,
  /// [WidgetsBinding.buildOwner], and assigns it to the widget tree in the call
  /// to [runApp]. The binding is responsible for driving the build pipeline by
  /// calling the build owner's [BuildOwner.buildScope] method. See
  /// [WidgetsBinding.drawFrame].
  // ignore: use_setters_to_change_properties, (API predates enforcing the lint)
  void assignOwner(BuildOwner owner) {
    _owner = owner;
  }

  @override
  void mount(Element? parent, Object? newSlot) {
    // Root elements should never have parents.
    assert(parent == null);
    assert(newSlot == null);
    super.mount(parent, newSlot);
  }
}

/// An [Element] that uses a [LeafRenderObjectWidget] as its configuration.
class LeafRenderObjectElement extends RenderObjectElement {
  /// Creates an element that uses the given widget as its configuration.
  LeafRenderObjectElement(LeafRenderObjectWidget super.widget);

  @override
  void forgetChild(Element child) {
    assert(false);
    super.forgetChild(child);
  }

  @override
  void insertRenderObjectChild(RenderObject child, Object? slot) {
    assert(false);
  }

  @override
  void moveRenderObjectChild(RenderObject child, Object? oldSlot, Object? newSlot) {
    assert(false);
  }

  @override
  void removeRenderObjectChild(RenderObject child, Object? slot) {
    assert(false);
  }

  @override
  List<DiagnosticsNode> debugDescribeChildren() {
    return widget.debugDescribeChildren();
  }
}

/// An [Element] that uses a [SingleChildRenderObjectWidget] as its configuration.
///
/// The child is optional.
///
/// This element subclass can be used for RenderObjectWidgets whose
/// RenderObjects use the [RenderObjectWithChildMixin] mixin. Such widgets are
/// expected to inherit from [SingleChildRenderObjectWidget].
class SingleChildRenderObjectElement extends RenderObjectElement {
  /// Creates an element that uses the given widget as its configuration.
  SingleChildRenderObjectElement(SingleChildRenderObjectWidget super.widget);

  Element? _child;

  @override
  void visitChildren(ElementVisitor visitor) {
    if (_child != null) {
      visitor(_child!);
    }
  }

  @override
  void forgetChild(Element child) {
    assert(child == _child);
    _child = null;
    super.forgetChild(child);
  }

  @override
  void mount(Element? parent, Object? newSlot) {
    super.mount(parent, newSlot);
    _child = updateChild(_child, (widget as SingleChildRenderObjectWidget).child, null);
  }

  @override
  void update(SingleChildRenderObjectWidget newWidget) {
    super.update(newWidget);
    assert(widget == newWidget);
    _child = updateChild(_child, (widget as SingleChildRenderObjectWidget).child, null);
  }

  @override
  void insertRenderObjectChild(RenderObject child, Object? slot) {
    final RenderObjectWithChildMixin<RenderObject> renderObject = this.renderObject as RenderObjectWithChildMixin<RenderObject>;
    assert(slot == null);
    assert(renderObject.debugValidateChild(child));
    renderObject.child = child;
    assert(renderObject == this.renderObject);
  }

  @override
  void moveRenderObjectChild(RenderObject child, Object? oldSlot, Object? newSlot) {
    assert(false);
  }

  @override
  void removeRenderObjectChild(RenderObject child, Object? slot) {
    final RenderObjectWithChildMixin<RenderObject> renderObject = this.renderObject as RenderObjectWithChildMixin<RenderObject>;
    assert(slot == null);
    assert(renderObject.child == child);
    renderObject.child = null;
    assert(renderObject == this.renderObject);
  }
}

/// An [Element] that uses a [MultiChildRenderObjectWidget] as its configuration.
///
/// This element subclass can be used for RenderObjectWidgets whose
/// RenderObjects use the [ContainerRenderObjectMixin] mixin with a parent data
/// type that implements [ContainerParentDataMixin<RenderObject>]. Such widgets
/// are expected to inherit from [MultiChildRenderObjectWidget].
///
/// See also:
///
/// * [IndexedSlot], which is used as [Element.slot]s for the children of a
///   [MultiChildRenderObjectElement].
/// * [RenderObjectElement.updateChildren], which discusses why [IndexedSlot]
///   is used for the slots of the children.
class MultiChildRenderObjectElement extends RenderObjectElement {
  /// Creates an element that uses the given widget as its configuration.
  MultiChildRenderObjectElement(MultiChildRenderObjectWidget super.widget)
    : assert(!debugChildrenHaveDuplicateKeys(widget, widget.children));

  @override
  ContainerRenderObjectMixin<RenderObject, ContainerParentDataMixin<RenderObject>> get renderObject {
    return super.renderObject as ContainerRenderObjectMixin<RenderObject, ContainerParentDataMixin<RenderObject>>;
  }

  /// The current list of children of this element.
  ///
  /// This list is filtered to hide elements that have been forgotten (using
  /// [forgetChild]).
  @protected
  @visibleForTesting
  Iterable<Element> get children => _children.where((Element child) => !_forgottenChildren.contains(child));

  late List<Element> _children;
  // We keep a set of forgotten children to avoid O(n^2) work walking _children
  // repeatedly to remove children.
  final Set<Element> _forgottenChildren = HashSet<Element>();

  @override
  void insertRenderObjectChild(RenderObject child, IndexedSlot<Element?> slot) {
    final ContainerRenderObjectMixin<RenderObject, ContainerParentDataMixin<RenderObject>> renderObject = this.renderObject;
    assert(renderObject.debugValidateChild(child));
    renderObject.insert(child, after: slot.value?.renderObject);
    assert(renderObject == this.renderObject);
  }

  @override
  void moveRenderObjectChild(RenderObject child, IndexedSlot<Element?> oldSlot, IndexedSlot<Element?> newSlot) {
    final ContainerRenderObjectMixin<RenderObject, ContainerParentDataMixin<RenderObject>> renderObject = this.renderObject;
    assert(child.parent == renderObject);
    renderObject.move(child, after: newSlot.value?.renderObject);
    assert(renderObject == this.renderObject);
  }

  @override
  void removeRenderObjectChild(RenderObject child, Object? slot) {
    final ContainerRenderObjectMixin<RenderObject, ContainerParentDataMixin<RenderObject>> renderObject = this.renderObject;
    assert(child.parent == renderObject);
    renderObject.remove(child);
    assert(renderObject == this.renderObject);
  }

  @override
  void visitChildren(ElementVisitor visitor) {
    for (final Element child in _children) {
      if (!_forgottenChildren.contains(child)) {
        visitor(child);
      }
    }
  }

  @override
  void forgetChild(Element child) {
    assert(_children.contains(child));
    assert(!_forgottenChildren.contains(child));
    _forgottenChildren.add(child);
    super.forgetChild(child);
  }

  bool _debugCheckHasAssociatedRenderObject(Element newChild) {
    assert(() {
      if (newChild.renderObject == null) {
        FlutterError.reportError(
          FlutterErrorDetails(
            exception: FlutterError.fromParts(<DiagnosticsNode>[
              ErrorSummary('The children of `MultiChildRenderObjectElement` must each has an associated render object.'),
              ErrorHint(
                'This typically means that the `\${newChild.widget}` or its children\n'
                'are not a subtype of `RenderObjectWidget`.',
              ),
              newChild.describeElement('The following element does not have an associated render object'),
              DiagnosticsDebugCreator(DebugCreator(newChild)),
            ]),
          ),
        );
      }
      return true;
    }());
    return true;
  }

  @override
  Element inflateWidget(Widget newWidget, Object? newSlot) {
    final Element newChild = super.inflateWidget(newWidget, newSlot);
    assert(_debugCheckHasAssociatedRenderObject(newChild));
    return newChild;
  }

  @override
  void mount(Element? parent, Object? newSlot) {
    super.mount(parent, newSlot);
    final MultiChildRenderObjectWidget multiChildRenderObjectWidget = widget as MultiChildRenderObjectWidget;
    final List<Element> children = List<Element>.filled(multiChildRenderObjectWidget.children.length, _NullElement.instance);
    Element? previousChild;
    for (int i = 0; i < children.length; i += 1) {
      final Element newChild = inflateWidget(multiChildRenderObjectWidget.children[i], IndexedSlot<Element?>(i, previousChild));
      children[i] = newChild;
      previousChild = newChild;
    }
    _children = children;
  }

  @override
  void update(MultiChildRenderObjectWidget newWidget) {
    super.update(newWidget);
    final MultiChildRenderObjectWidget multiChildRenderObjectWidget = widget as MultiChildRenderObjectWidget;
    assert(widget == newWidget);
    assert(!debugChildrenHaveDuplicateKeys(widget, multiChildRenderObjectWidget.children));
    _children = updateChildren(_children, multiChildRenderObjectWidget.children, forgottenChildren: _forgottenChildren);
    _forgottenChildren.clear();
  }
}

/// A wrapper class for the [Element] that is the creator of a [RenderObject].
///
/// Setting a [DebugCreator] as [RenderObject.debugCreator] will lead to better
/// error messages.
class DebugCreator {
  /// Create a [DebugCreator] instance with input [Element].
  DebugCreator(this.element);

  /// The creator of the [RenderObject].
  final Element element;

  @override
  String toString() => element.debugGetCreatorChain(12);
}

FlutterErrorDetails _reportException(
  DiagnosticsNode context,
  Object exception,
  StackTrace? stack, {
  InformationCollector? informationCollector,
}) {
  final FlutterErrorDetails details = FlutterErrorDetails(
    exception: exception,
    stack: stack,
    library: 'widgets library',
    context: context,
    informationCollector: informationCollector,
  );
  FlutterError.reportError(details);
  return details;
}

/// A value for [Element.slot] used for children of
/// [MultiChildRenderObjectElement]s.
///
/// A slot for a [MultiChildRenderObjectElement] consists of an [index]
/// identifying where the child occupying this slot is located in the
/// [MultiChildRenderObjectElement]'s child list and an arbitrary [value] that
/// can further define where the child occupying this slot fits in its
/// parent's child list.
///
/// See also:
///
///  * [RenderObjectElement.updateChildren], which discusses why this class is
///    used as slot values for the children of a [MultiChildRenderObjectElement].
@immutable
class IndexedSlot<T extends Element?> {
  /// Creates an [IndexedSlot] with the provided [index] and slot [value].
  const IndexedSlot(this.index, this.value);

  /// Information to define where the child occupying this slot fits in its
  /// parent's child list.
  final T value;

  /// The index of this slot in the parent's child list.
  final int index;

  @override
  bool operator ==(Object other) {
    if (other.runtimeType != runtimeType) {
      return false;
    }
    return other is IndexedSlot
        && index == other.index
        && value == other.value;
  }

  @override
  int get hashCode => Object.hash(index, value);
}

/// Used as a placeholder in [List<Element>] objects when the actual
/// elements are not yet determined.
class _NullElement extends Element {
  _NullElement() : super(const _NullWidget());

  static _NullElement instance = _NullElement();

  @override
  bool get debugDoingBuild => throw UnimplementedError();
}

class _NullWidget extends Widget {
  const _NullWidget();

  @override
  Element createElement() => throw UnimplementedError();
}

// Whether a [DebugReassembleConfig] indicates that an element holding [widget] can skip
// a reassemble.
bool _debugShouldReassemble(DebugReassembleConfig? config, Widget? widget) {
  return config == null || config.widgetName == null || widget?.runtimeType.toString() == config.widgetName;
}

""";

String outlinedButton = """
// Copyright 2014 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:math' as math;
import 'dart:ui' show lerpDouble;

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'button_style.dart';
import 'button_style_button.dart';
import 'color_scheme.dart';
import 'colors.dart';
import 'constants.dart';
import 'ink_ripple.dart';
import 'ink_well.dart';
import 'material_state.dart';
import 'outlined_button_theme.dart';
import 'theme.dart';
import 'theme_data.dart';

/// A Material Design "Outlined Button"; essentially a [TextButton]
/// with an outlined border.
///
/// Outlined buttons are medium-emphasis buttons. They contain actions
/// that are important, but they aren’t the primary action in an app.
///
/// An outlined button is a label [child] displayed on a (zero
/// elevation) [Material] widget. The label's [Text] and [Icon]
/// widgets are displayed in the [style]'s
/// [ButtonStyle.foregroundColor] and the outline's weight and color
/// are defined by [ButtonStyle.side]. The button reacts to touches
/// by filling with the [style]'s [ButtonStyle.overlayColor].
///
/// The outlined button's default style is defined by [defaultStyleOf].
/// The style of this outline button can be overridden with its [style]
/// parameter. The style of all text buttons in a subtree can be
/// overridden with the [OutlinedButtonTheme] and the style of all of the
/// outlined buttons in an app can be overridden with the [Theme]'s
/// [ThemeData.outlinedButtonTheme] property.
///
/// Unlike [TextButton] or [ElevatedButton], outline buttons have a
/// default [ButtonStyle.side] which defines the appearance of the
/// outline. Because the default `side` is non-null, it
/// unconditionally overrides the shape's [OutlinedBorder.side]. In
/// other words, to specify an outlined button's shape _and_ the
/// appearance of its outline, both the [ButtonStyle.shape] and
/// [ButtonStyle.side] properties must be specified.
///
/// {@tool dartpad}
/// Here is an example of a basic [OutlinedButton].
///
/// ** See code in examples/api/lib/material/outlined_button/outlined_button.0.dart **
/// {@end-tool}
///
/// The static [styleFrom] method is a convenient way to create a
/// outlined button [ButtonStyle] from simple values.
///
/// See also:
///
///  * [ElevatedButton], a filled button whose material elevates when pressed.
///  * [FilledButton], a filled button that doesn't elevate when pressed.
///  * [FilledButton.tonal], a filled button variant that uses a secondary fill color.
///  * [TextButton], a button with no outline or fill color.
///  * <https://material.io/design/components/buttons.html>
///  * <https://m3.material.io/components/buttons>
class OutlinedButton extends ButtonStyleButton {
  /// Create an OutlinedButton.
  ///
  /// The [autofocus] and [clipBehavior] arguments must not be null.
  const OutlinedButton({
    super.key,
    required super.onPressed,
    super.onLongPress,
    super.onHover,
    super.onFocusChange,
    super.style,
    super.focusNode,
    super.autofocus = false,
    super.clipBehavior = Clip.none,
    super.statesController,
    required super.child,
  });

  /// Create a text button from a pair of widgets that serve as the button's
  /// [icon] and [label].
  ///
  /// The icon and label are arranged in a row and padded by 12 logical pixels
  /// at the start, and 16 at the end, with an 8 pixel gap in between.
  ///
  /// The [icon] and [label] arguments must not be null.
  factory OutlinedButton.icon({
    Key? key,
    required VoidCallback? onPressed,
    VoidCallback? onLongPress,
    ButtonStyle? style,
    FocusNode? focusNode,
    bool? autofocus,
    Clip? clipBehavior,
    MaterialStatesController? statesController,
    required Widget icon,
    required Widget label,
  }) = _OutlinedButtonWithIcon;

  /// A static convenience method that constructs an outlined button
  /// [ButtonStyle] given simple values.
  ///
  ///
  /// The [foregroundColor] and [disabledForegroundColor] colors are used
  /// to create a [MaterialStateProperty] [ButtonStyle.foregroundColor], and
  /// a derived [ButtonStyle.overlayColor].
  ///
  /// The [backgroundColor] and [disabledBackgroundColor] colors are
  /// used to create a [MaterialStateProperty] [ButtonStyle.backgroundColor].
  ///
  /// Similarly, the [enabledMouseCursor] and [disabledMouseCursor]
  /// parameters are used to construct [ButtonStyle.mouseCursor].
  ///
  /// All of the other parameters are either used directly or used to
  /// create a [MaterialStateProperty] with a single value for all
  /// states.
  ///
  /// All parameters default to null, by default this method returns
  /// a [ButtonStyle] that doesn't override anything.
  ///
  /// For example, to override the default shape and outline for an
  /// [OutlinedButton], one could write:
  ///
  /// ```dart
  /// OutlinedButton(
  ///   style: OutlinedButton.styleFrom(
  ///      shape: const StadiumBorder(),
  ///      side: const BorderSide(width: 2, color: Colors.green),
  ///   ),
  ///   child: const Text('Seasons of Love'),
  ///   onPressed: () {
  ///     // ...
  ///   },
  /// ),
  /// ```
  static ButtonStyle styleFrom({
    Color? foregroundColor,
    Color? backgroundColor,
    Color? disabledForegroundColor,
    Color? disabledBackgroundColor,
    Color? shadowColor,
    Color? surfaceTintColor,
    double? elevation,
    TextStyle? textStyle,
    EdgeInsetsGeometry? padding,
    Size? minimumSize,
    Size? fixedSize,
    Size? maximumSize,
    BorderSide? side,
    OutlinedBorder? shape,
    MouseCursor? enabledMouseCursor,
    MouseCursor? disabledMouseCursor,
    VisualDensity? visualDensity,
    MaterialTapTargetSize? tapTargetSize,
    Duration? animationDuration,
    bool? enableFeedback,
    AlignmentGeometry? alignment,
    InteractiveInkFeatureFactory? splashFactory,
    @Deprecated(
      'Use foregroundColor instead. '
      'This feature was deprecated after v3.1.0.'
    )
    Color? primary,
    @Deprecated(
      'Use disabledForegroundColor instead. '
      'This feature was deprecated after v3.1.0.'
    )
    Color? onSurface,
  }) {
    final Color? foreground = foregroundColor ?? primary;
    final Color? disabledForeground = disabledForegroundColor ?? onSurface?.withOpacity(0.38);
    final MaterialStateProperty<Color?>? foregroundColorProp = (foreground == null && disabledForeground == null)
      ? null
      : _OutlinedButtonDefaultColor(foreground, disabledForeground);
    final MaterialStateProperty<Color?>? backgroundColorProp = (backgroundColor == null && disabledBackgroundColor == null)
      ? null
      : disabledBackgroundColor == null
        ? ButtonStyleButton.allOrNull<Color?>(backgroundColor)
        : _OutlinedButtonDefaultColor(backgroundColor, disabledBackgroundColor);
    final MaterialStateProperty<Color?>? overlayColor = (foreground == null)
      ? null
      : _OutlinedButtonDefaultOverlay(foreground);
    final MaterialStateProperty<MouseCursor>? mouseCursor = (enabledMouseCursor == null && disabledMouseCursor == null)
      ? null
      : _OutlinedButtonDefaultMouseCursor(enabledMouseCursor!, disabledMouseCursor!);

    return ButtonStyle(
      textStyle: ButtonStyleButton.allOrNull<TextStyle>(textStyle),
      foregroundColor: foregroundColorProp,
      backgroundColor: backgroundColorProp,
      overlayColor: overlayColor,
      shadowColor: ButtonStyleButton.allOrNull<Color>(shadowColor),
      surfaceTintColor: ButtonStyleButton.allOrNull<Color>(surfaceTintColor),
      elevation: ButtonStyleButton.allOrNull<double>(elevation),
      padding: ButtonStyleButton.allOrNull<EdgeInsetsGeometry>(padding),
      minimumSize: ButtonStyleButton.allOrNull<Size>(minimumSize),
      fixedSize: ButtonStyleButton.allOrNull<Size>(fixedSize),
      maximumSize: ButtonStyleButton.allOrNull<Size>(maximumSize),
      side: ButtonStyleButton.allOrNull<BorderSide>(side),
      shape: ButtonStyleButton.allOrNull<OutlinedBorder>(shape),
      mouseCursor: mouseCursor,
      visualDensity: visualDensity,
      tapTargetSize: tapTargetSize,
      animationDuration: animationDuration,
      enableFeedback: enableFeedback,
      alignment: alignment,
      splashFactory: splashFactory,
    );
  }

  /// Defines the button's default appearance.
  ///
  /// With the exception of [ButtonStyle.side], which defines the
  /// outline, and [ButtonStyle.padding], the returned style is the
  /// same as for [TextButton].
  ///
  /// The button [child]'s [Text] and [Icon] widgets are rendered with
  /// the [ButtonStyle]'s foreground color. The button's [InkWell] adds
  /// the style's overlay color when the button is focused, hovered
  /// or pressed. The button's background color becomes its [Material]
  /// color and is transparent by default.
  ///
  /// All of the ButtonStyle's defaults appear below. In this list
  /// "Theme.foo" is shorthand for `Theme.of(context).foo`. Color
  /// scheme values like "onSurface(0.38)" are shorthand for
  /// `onSurface.withOpacity(0.38)`. [MaterialStateProperty] valued
  /// properties that are not followed by a sublist have the same
  /// value for all states, otherwise the values are as specified for
  /// each state and "others" means all other states.
  ///
  /// The color of the [ButtonStyle.textStyle] is not used, the
  /// [ButtonStyle.foregroundColor] is used instead.
  ///
  /// ## Material 2 defaults
  ///
  /// * `textStyle` - Theme.textTheme.button
  /// * `backgroundColor` - transparent
  /// * `foregroundColor`
  ///   * disabled - Theme.colorScheme.onSurface(0.38)
  ///   * others - Theme.colorScheme.primary
  /// * `overlayColor`
  ///   * hovered - Theme.colorScheme.primary(0.04)
  ///   * focused or pressed - Theme.colorScheme.primary(0.12)
  /// * `shadowColor` - Theme.shadowColor
  /// * `elevation` - 0
  /// * `padding`
  ///   * `textScaleFactor <= 1` - horizontal(16)
  ///   * `1 < textScaleFactor <= 2` - lerp(horizontal(16), horizontal(8))
  ///   * `2 < textScaleFactor <= 3` - lerp(horizontal(8), horizontal(4))
  ///   * `3 < textScaleFactor` - horizontal(4)
  /// * `minimumSize` - Size(64, 36)
  /// * `fixedSize` - null
  /// * `maximumSize` - Size.infinite
  /// * `side` - BorderSide(width: 1, color: Theme.colorScheme.onSurface(0.12))
  /// * `shape` - RoundedRectangleBorder(borderRadius: BorderRadius.circular(4))
  /// * `mouseCursor`
  ///   * disabled - SystemMouseCursors.basic
  ///   * others - SystemMouseCursors.click
  /// * `visualDensity` - theme.visualDensity
  /// * `tapTargetSize` - theme.materialTapTargetSize
  /// * `animationDuration` - kThemeChangeDuration
  /// * `enableFeedback` - true
  /// * `alignment` - Alignment.center
  /// * `splashFactory` - InkRipple.splashFactory
  ///
  /// ## Material 3 defaults
  ///
  /// If [ThemeData.useMaterial3] is set to true the following defaults will
  /// be used:
  ///
  /// * `textStyle` - Theme.textTheme.labelLarge
  /// * `backgroundColor` - transparent
  /// * `foregroundColor`
  ///   * disabled - Theme.colorScheme.onSurface(0.38)
  ///   * others - Theme.colorScheme.primary
  /// * `overlayColor`
  ///   * hovered - Theme.colorScheme.primary(0.08)
  ///   * focused or pressed - Theme.colorScheme.primary(0.12)
  ///   * others - null
  /// * `shadowColor` - null
  /// * `surfaceTintColor` - null
  /// * `elevation` - 0
  /// * `padding`
  ///   * `textScaleFactor <= 1` - horizontal(24)
  ///   * `1 < textScaleFactor <= 2` - lerp(horizontal(24), horizontal(12))
  ///   * `2 < textScaleFactor <= 3` - lerp(horizontal(12), horizontal(6))
  ///   * `3 < textScaleFactor` - horizontal(6)
  /// * `minimumSize` - Size(64, 40)
  /// * `fixedSize` - null
  /// * `maximumSize` - Size.infinite
  /// * `side`
  ///   * disabled - BorderSide(color: Theme.colorScheme.onSurface(0.12))
  ///   * others - BorderSide(color: Theme.colorScheme.outline)
  /// * `shape` - StadiumBorder()
  /// * `mouseCursor`
  ///   * disabled - SystemMouseCursors.basic
  ///   * others - SystemMouseCursors.click
  /// * `visualDensity` - theme.visualDensity
  /// * `tapTargetSize` - theme.materialTapTargetSize
  /// * `animationDuration` - kThemeChangeDuration
  /// * `enableFeedback` - true
  /// * `alignment` - Alignment.center
  /// * `splashFactory` - Theme.splashFactory
  ///
  /// For the [OutlinedButton.icon] factory, the start (generally the left) value of
  /// [padding] is reduced from 24 to 16.
  @override
  ButtonStyle defaultStyleOf(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme colorScheme = theme.colorScheme;

    return Theme.of(context).useMaterial3
      ? _OutlinedButtonDefaultsM3(context)
      : styleFrom(
          foregroundColor: colorScheme.primary,
          disabledForegroundColor: colorScheme.onSurface.withOpacity(0.38),
          backgroundColor: Colors.transparent,
          disabledBackgroundColor: Colors.transparent,
          shadowColor: theme.shadowColor,
          elevation: 0,
          textStyle: theme.textTheme.labelLarge,
          padding: _scaledPadding(context),
          minimumSize: const Size(64, 36),
          maximumSize: Size.infinite,
          side: BorderSide(
            color: Theme.of(context).colorScheme.onSurface.withOpacity(0.12),
          ),
          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(4))),
          enabledMouseCursor: SystemMouseCursors.click,
          disabledMouseCursor: SystemMouseCursors.basic,
          visualDensity: theme.visualDensity,
          tapTargetSize: theme.materialTapTargetSize,
          animationDuration: kThemeChangeDuration,
          enableFeedback: true,
          alignment: Alignment.center,
          splashFactory: InkRipple.splashFactory,
        );
  }

  @override
  ButtonStyle? themeStyleOf(BuildContext context) {
    return OutlinedButtonTheme.of(context).style;
  }
}

EdgeInsetsGeometry _scaledPadding(BuildContext context) {
  final bool useMaterial3 = Theme.of(context).useMaterial3;
  final double padding1x = useMaterial3 ? 24.0 : 16.0;
  return ButtonStyleButton.scaledPadding(
     EdgeInsets.symmetric(horizontal: padding1x),
     EdgeInsets.symmetric(horizontal: padding1x / 2),
     EdgeInsets.symmetric(horizontal: padding1x / 2 / 2),
    MediaQuery.textScaleFactorOf(context),
  );
}

@immutable
class _OutlinedButtonDefaultColor extends MaterialStateProperty<Color?>  with Diagnosticable {
  _OutlinedButtonDefaultColor(this.color, this.disabled);

  final Color? color;
  final Color? disabled;

  @override
  Color? resolve(Set<MaterialState> states) {
    if (states.contains(MaterialState.disabled)) {
      return disabled;
    }
    return color;
  }
}

@immutable
class _OutlinedButtonDefaultOverlay extends MaterialStateProperty<Color?> with Diagnosticable {
  _OutlinedButtonDefaultOverlay(this.foreground);

  final Color foreground;

  @override
  Color? resolve(Set<MaterialState> states) {
    if (states.contains(MaterialState.hovered)) {
      return foreground.withOpacity(0.04);
    }
    if (states.contains(MaterialState.focused) || states.contains(MaterialState.pressed)) {
      return foreground.withOpacity(0.12);
    }
    return null;
  }
}

@immutable
class _OutlinedButtonDefaultMouseCursor extends MaterialStateProperty<MouseCursor> with Diagnosticable {
  _OutlinedButtonDefaultMouseCursor(this.enabledCursor, this.disabledCursor);

  final MouseCursor enabledCursor;
  final MouseCursor disabledCursor;

  @override
  MouseCursor resolve(Set<MaterialState> states) {
    if (states.contains(MaterialState.disabled)) {
      return disabledCursor;
    }
    return enabledCursor;
  }
}

class _OutlinedButtonWithIcon extends OutlinedButton {
  _OutlinedButtonWithIcon({
    super.key,
    required super.onPressed,
    super.onLongPress,
    super.style,
    super.focusNode,
    bool? autofocus,
    Clip? clipBehavior,
    super.statesController,
    required Widget icon,
    required Widget label,
  }) : super(
         autofocus: autofocus ?? false,
         clipBehavior: clipBehavior ?? Clip.none,
         child: _OutlinedButtonWithIconChild(icon: icon, label: label),
      );

  @override
  ButtonStyle defaultStyleOf(BuildContext context) {
    final bool useMaterial3 = Theme.of(context).useMaterial3;
    if (!useMaterial3) {
      return super.defaultStyleOf(context);
    }
    final EdgeInsetsGeometry scaledPadding = ButtonStyleButton.scaledPadding(
      const EdgeInsetsDirectional.fromSTEB(16, 0, 24, 0),
      const EdgeInsetsDirectional.fromSTEB(8, 0, 12, 0),
      const EdgeInsetsDirectional.fromSTEB(4, 0, 6, 0),
      MediaQuery.textScaleFactorOf(context),
    );
    return super.defaultStyleOf(context).copyWith(
      padding: MaterialStatePropertyAll<EdgeInsetsGeometry>(scaledPadding),
    );
  }
}

class _OutlinedButtonWithIconChild extends StatelessWidget {
  const _OutlinedButtonWithIconChild({
    required this.label,
    required this.icon,
  });

  final Widget label;
  final Widget icon;

  @override
  Widget build(BuildContext context) {
    final double scale = MediaQuery.textScaleFactorOf(context);
    final double gap = scale <= 1 ? 8 : lerpDouble(8, 4, math.min(scale - 1, 1))!;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[icon, SizedBox(width: gap), Flexible(child: label)],
    );
  }
}

// BEGIN GENERATED TOKEN PROPERTIES - OutlinedButton

// Do not edit by hand. The code between the "BEGIN GENERATED" and
// "END GENERATED" comments are generated from data in the Material
// Design token database by the script:
//   dev/tools/gen_defaults/bin/gen_defaults.dart.

// Token database version: v0_162

class _OutlinedButtonDefaultsM3 extends ButtonStyle {
  _OutlinedButtonDefaultsM3(this.context)
   : super(
       animationDuration: kThemeChangeDuration,
       enableFeedback: true,
       alignment: Alignment.center,
     );

  final BuildContext context;
  late final ColorScheme _colors = Theme.of(context).colorScheme;

  @override
  MaterialStateProperty<TextStyle?> get textStyle =>
    MaterialStatePropertyAll<TextStyle?>(Theme.of(context).textTheme.labelLarge);

  @override
  MaterialStateProperty<Color?>? get backgroundColor =>
    const MaterialStatePropertyAll<Color>(Colors.transparent);

  @override
  MaterialStateProperty<Color?>? get foregroundColor =>
    MaterialStateProperty.resolveWith((Set<MaterialState> states) {
      if (states.contains(MaterialState.disabled)) {
        return _colors.onSurface.withOpacity(0.38);
      }
      return _colors.primary;
    });

  @override
  MaterialStateProperty<Color?>? get overlayColor =>
    MaterialStateProperty.resolveWith((Set<MaterialState> states) {
      if (states.contains(MaterialState.hovered)) {
        return _colors.primary.withOpacity(0.08);
      }
      if (states.contains(MaterialState.focused)) {
        return _colors.primary.withOpacity(0.12);
      }
      if (states.contains(MaterialState.pressed)) {
        return _colors.primary.withOpacity(0.12);
      }
      return null;
    });

  @override
  MaterialStateProperty<Color>? get shadowColor =>
    const MaterialStatePropertyAll<Color>(Colors.transparent);

  @override
  MaterialStateProperty<Color>? get surfaceTintColor =>
    const MaterialStatePropertyAll<Color>(Colors.transparent);

  @override
  MaterialStateProperty<double>? get elevation =>
    const MaterialStatePropertyAll<double>(0.0);

  @override
  MaterialStateProperty<EdgeInsetsGeometry>? get padding =>
    MaterialStatePropertyAll<EdgeInsetsGeometry>(_scaledPadding(context));

  @override
  MaterialStateProperty<Size>? get minimumSize =>
    const MaterialStatePropertyAll<Size>(Size(64.0, 40.0));

  // No default fixedSize

  @override
  MaterialStateProperty<Size>? get maximumSize =>
    const MaterialStatePropertyAll<Size>(Size.infinite);

  @override
  MaterialStateProperty<BorderSide>? get side =>
    MaterialStateProperty.resolveWith((Set<MaterialState> states) {
    if (states.contains(MaterialState.disabled)) {
      return BorderSide(color: _colors.onSurface.withOpacity(0.12));
    }
    return BorderSide(color: _colors.outline);
  });

  @override
  MaterialStateProperty<OutlinedBorder>? get shape =>
    const MaterialStatePropertyAll<OutlinedBorder>(StadiumBorder());

  @override
  MaterialStateProperty<MouseCursor?>? get mouseCursor =>
    MaterialStateProperty.resolveWith((Set<MaterialState> states) {
      if (states.contains(MaterialState.disabled)) {
        return SystemMouseCursors.basic;
      }
      return SystemMouseCursors.click;
    });

  @override
  VisualDensity? get visualDensity => Theme.of(context).visualDensity;

  @override
  MaterialTapTargetSize? get tapTargetSize => Theme.of(context).materialTapTargetSize;

  @override
  InteractiveInkFeatureFactory? get splashFactory => Theme.of(context).splashFactory;
}

// END GENERATED TOKEN PROPERTIES - OutlinedButton

""";

String elevatedButton = """
// Copyright 2014 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:math' as math;
import 'dart:ui' show lerpDouble;

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'button_style.dart';
import 'button_style_button.dart';
import 'color_scheme.dart';
import 'constants.dart';
import 'elevated_button_theme.dart';
import 'ink_ripple.dart';
import 'ink_well.dart';
import 'material_state.dart';
import 'theme.dart';
import 'theme_data.dart';

/// A Material Design "elevated button".
///
/// Use elevated buttons to add dimension to otherwise mostly flat
/// layouts, e.g. in long busy lists of content, or in wide
/// spaces. Avoid using elevated buttons on already-elevated content
/// such as dialogs or cards.
///
/// An elevated button is a label [child] displayed on a [Material]
/// widget whose [Material.elevation] increases when the button is
/// pressed. The label's [Text] and [Icon] widgets are displayed in
/// [style]'s [ButtonStyle.foregroundColor] and the button's filled
/// background is the [ButtonStyle.backgroundColor].
///
/// The elevated button's default style is defined by
/// [defaultStyleOf]. The style of this elevated button can be
/// overridden with its [style] parameter. The style of all elevated
/// buttons in a subtree can be overridden with the
/// [ElevatedButtonTheme], and the style of all of the elevated
/// buttons in an app can be overridden with the [Theme]'s
/// [ThemeData.elevatedButtonTheme] property.
///
/// The static [styleFrom] method is a convenient way to create a
/// elevated button [ButtonStyle] from simple values.
///
/// If [onPressed] and [onLongPress] callbacks are null, then the
/// button will be disabled.
///
/// {@tool dartpad}
/// This sample produces an enabled and a disabled ElevatedButton.
///
/// ** See code in examples/api/lib/material/elevated_button/elevated_button.0.dart **
/// {@end-tool}
///
/// See also:
///
///  * [FilledButton], a filled button that doesn't elevate when pressed.
///  * [FilledButton.tonal], a filled button variant that uses a secondary fill color.
///  * [OutlinedButton], a button with an outlined border and no fill color.
///  * [TextButton], a button with no outline or fill color.
///  * <https://material.io/design/components/buttons.html>
///  * <https://m3.material.io/components/buttons>
class ElevatedButton extends ButtonStyleButton {
  /// Create an ElevatedButton.
  ///
  /// The [autofocus] and [clipBehavior] arguments must not be null.
  const ElevatedButton({
    super.key,
    required super.onPressed,
    super.onLongPress,
    super.onHover,
    super.onFocusChange,
    super.style,
    super.focusNode,
    super.autofocus = false,
    super.clipBehavior = Clip.none,
    super.statesController,
    required super.child,
  });

  /// Create an elevated button from a pair of widgets that serve as the button's
  /// [icon] and [label].
  ///
  /// The icon and label are arranged in a row and padded by 12 logical pixels
  /// at the start, and 16 at the end, with an 8 pixel gap in between.
  ///
  /// The [icon] and [label] arguments must not be null.
  factory ElevatedButton.icon({
    Key? key,
    required VoidCallback? onPressed,
    VoidCallback? onLongPress,
    ValueChanged<bool>? onHover,
    ValueChanged<bool>? onFocusChange,
    ButtonStyle? style,
    FocusNode? focusNode,
    bool? autofocus,
    Clip? clipBehavior,
    MaterialStatesController? statesController,
    required Widget icon,
    required Widget label,
  }) = _ElevatedButtonWithIcon;

  /// A static convenience method that constructs an elevated button
  /// [ButtonStyle] given simple values.
  ///
  /// The [foregroundColor] and [disabledForegroundColor] colors are used
  /// to create a [MaterialStateProperty] [ButtonStyle.foregroundColor], and
  /// a derived [ButtonStyle.overlayColor].
  ///
  /// The [backgroundColor] and [disabledBackgroundColor] colors are
  /// used to create a [MaterialStateProperty] [ButtonStyle.backgroundColor].
  ///
  /// The button's elevations are defined relative to the [elevation]
  /// parameter. The disabled elevation is the same as the parameter
  /// value, [elevation] + 2 is used when the button is hovered
  /// or focused, and elevation + 6 is used when the button is pressed.
  ///
  /// Similarly, the [enabledMouseCursor] and [disabledMouseCursor]
  /// parameters are used to construct [ButtonStyle].mouseCursor.
  ///
  /// All of the other parameters are either used directly or used to
  /// create a [MaterialStateProperty] with a single value for all
  /// states.
  ///
  /// All parameters default to null, by default this method returns
  /// a [ButtonStyle] that doesn't override anything.
  ///
  /// For example, to override the default text and icon colors for a
  /// [ElevatedButton], as well as its overlay color, with all of the
  /// standard opacity adjustments for the pressed, focused, and
  /// hovered states, one could write:
  ///
  /// ```dart
  /// ElevatedButton(
  ///   style: ElevatedButton.styleFrom(foregroundColor: Colors.green),
  ///   onPressed: () {
  ///     // ...
  ///   },
  ///   child: const Text('Jump'),
  /// ),
  /// ```
  ///
  /// And to change the fill color:
  ///
  /// ```dart
  /// ElevatedButton(
  ///   style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
  ///   onPressed: () {
  ///     // ...
  ///   },
  ///   child: const Text('Meow'),
  /// ),
  /// ```
  ///
  static ButtonStyle styleFrom({
    Color? foregroundColor,
    Color? backgroundColor,
    Color? disabledForegroundColor,
    Color? disabledBackgroundColor,
    Color? shadowColor,
    Color? surfaceTintColor,
    double? elevation,
    TextStyle? textStyle,
    EdgeInsetsGeometry? padding,
    Size? minimumSize,
    Size? fixedSize,
    Size? maximumSize,
    BorderSide? side,
    OutlinedBorder? shape,
    MouseCursor? enabledMouseCursor,
    MouseCursor? disabledMouseCursor,
    VisualDensity? visualDensity,
    MaterialTapTargetSize? tapTargetSize,
    Duration? animationDuration,
    bool? enableFeedback,
    AlignmentGeometry? alignment,
    InteractiveInkFeatureFactory? splashFactory,
    @Deprecated('Use backgroundColor instead. '
        'This feature was deprecated after v3.1.0.')
    Color? primary,
    @Deprecated('Use foregroundColor instead. '
        'This feature was deprecated after v3.1.0.')
    Color? onPrimary,
    @Deprecated(
        'Use disabledForegroundColor and disabledBackgroundColor instead. '
        'This feature was deprecated after v3.1.0.')
    Color? onSurface,
  }) {
    final Color? background = backgroundColor ?? primary;
    final Color? disabledBackground =
        disabledBackgroundColor ?? onSurface?.withOpacity(0.12);
    final MaterialStateProperty<Color?>? backgroundColorProp =
        (background == null && disabledBackground == null)
            ? null
            : _ElevatedButtonDefaultColor(background, disabledBackground);
    final Color? foreground = foregroundColor ?? onPrimary;
    final Color? disabledForeground =
        disabledForegroundColor ?? onSurface?.withOpacity(0.38);
    final MaterialStateProperty<Color?>? foregroundColorProp =
        (foreground == null && disabledForeground == null)
            ? null
            : _ElevatedButtonDefaultColor(foreground, disabledForeground);
    final MaterialStateProperty<Color?>? overlayColor =
        (foreground == null) ? null : _ElevatedButtonDefaultOverlay(foreground);
    final MaterialStateProperty<double>? elevationValue =
        (elevation == null) ? null : _ElevatedButtonDefaultElevation(elevation);
    final MaterialStateProperty<MouseCursor?>? mouseCursor =
        (enabledMouseCursor == null && disabledMouseCursor == null)
            ? null
            : _ElevatedButtonDefaultMouseCursor(
                enabledMouseCursor, disabledMouseCursor);

    return ButtonStyle(
      textStyle: MaterialStatePropertyAll<TextStyle?>(textStyle),
      backgroundColor: backgroundColorProp,
      foregroundColor: foregroundColorProp,
      overlayColor: overlayColor,
      shadowColor: ButtonStyleButton.allOrNull<Color>(shadowColor),
      surfaceTintColor: ButtonStyleButton.allOrNull<Color>(surfaceTintColor),
      elevation: elevationValue,
      padding: ButtonStyleButton.allOrNull<EdgeInsetsGeometry>(padding),
      minimumSize: ButtonStyleButton.allOrNull<Size>(minimumSize),
      fixedSize: ButtonStyleButton.allOrNull<Size>(fixedSize),
      maximumSize: ButtonStyleButton.allOrNull<Size>(maximumSize),
      side: ButtonStyleButton.allOrNull<BorderSide>(side),
      shape: ButtonStyleButton.allOrNull<OutlinedBorder>(shape),
      mouseCursor: mouseCursor,
      visualDensity: visualDensity,
      tapTargetSize: tapTargetSize,
      animationDuration: animationDuration,
      enableFeedback: enableFeedback,
      alignment: alignment,
      splashFactory: splashFactory,
    );
  }

  /// Defines the button's default appearance.
  ///
  /// The button [child]'s [Text] and [Icon] widgets are rendered with
  /// the [ButtonStyle]'s foreground color. The button's [InkWell] adds
  /// the style's overlay color when the button is focused, hovered
  /// or pressed. The button's background color becomes its [Material]
  /// color.
  ///
  /// All of the ButtonStyle's defaults appear below. In this list
  /// "Theme.foo" is shorthand for `Theme.of(context).foo`. Color
  /// scheme values like "onSurface(0.38)" are shorthand for
  /// `onSurface.withOpacity(0.38)`. [MaterialStateProperty] valued
  /// properties that are not followed by a sublist have the same
  /// value for all states, otherwise the values are as specified for
  /// each state, and "others" means all other states.
  ///
  /// The `textScaleFactor` is the value of
  /// `MediaQuery.textScaleFactorOf(context)` and the names of the
  /// EdgeInsets constructors and `EdgeInsetsGeometry.lerp` have been
  /// abbreviated for readability.
  ///
  /// The color of the [ButtonStyle.textStyle] is not used, the
  /// [ButtonStyle.foregroundColor] color is used instead.
  ///
  /// ## Material 2 defaults
  ///
  /// * `textStyle` - Theme.textTheme.button
  /// * `backgroundColor`
  ///   * disabled - Theme.colorScheme.onSurface(0.12)
  ///   * others - Theme.colorScheme.primary
  /// * `foregroundColor`
  ///   * disabled - Theme.colorScheme.onSurface(0.38)
  ///   * others - Theme.colorScheme.onPrimary
  /// * `overlayColor`
  ///   * hovered - Theme.colorScheme.onPrimary(0.08)
  ///   * focused or pressed - Theme.colorScheme.onPrimary(0.24)
  /// * `shadowColor` - Theme.shadowColor
  /// * `elevation`
  ///   * disabled - 0
  ///   * default - 2
  ///   * hovered or focused - 4
  ///   * pressed - 8
  /// * `padding`
  ///   * `textScaleFactor <= 1` - horizontal(16)
  ///   * `1 < textScaleFactor <= 2` - lerp(horizontal(16), horizontal(8))
  ///   * `2 < textScaleFactor <= 3` - lerp(horizontal(8), horizontal(4))
  ///   * `3 < textScaleFactor` - horizontal(4)
  /// * `minimumSize` - Size(64, 36)
  /// * `fixedSize` - null
  /// * `maximumSize` - Size.infinite
  /// * `side` - null
  /// * `shape` - RoundedRectangleBorder(borderRadius: BorderRadius.circular(4))
  /// * `mouseCursor`
  ///   * disabled - SystemMouseCursors.basic
  ///   * others - SystemMouseCursors.click
  /// * `visualDensity` - theme.visualDensity
  /// * `tapTargetSize` - theme.materialTapTargetSize
  /// * `animationDuration` - kThemeChangeDuration
  /// * `enableFeedback` - true
  /// * `alignment` - Alignment.center
  /// * `splashFactory` - InkRipple.splashFactory
  ///
  /// The default padding values for the [ElevatedButton.icon] factory are slightly different:
  ///
  /// * `padding`
  ///   * `textScaleFactor <= 1` - start(12) end(16)
  ///   * `1 < textScaleFactor <= 2` - lerp(start(12) end(16), horizontal(8))
  ///   * `2 < textScaleFactor <= 3` - lerp(horizontal(8), horizontal(4))
  ///   * `3 < textScaleFactor` - horizontal(4)
  ///
  /// The default value for `side`, which defines the appearance of the button's
  /// outline, is null. That means that the outline is defined by the button
  /// shape's [OutlinedBorder.side]. Typically the default value of an
  /// [OutlinedBorder]'s side is [BorderSide.none], so an outline is not drawn.
  ///
  /// ## Material 3 defaults
  ///
  /// If [ThemeData.useMaterial3] is set to true the following defaults will
  /// be used:
  ///
  /// * `textStyle` - Theme.textTheme.labelLarge
  /// * `backgroundColor`
  ///   * disabled - Theme.colorScheme.onSurface(0.12)
  ///   * others - Theme.colorScheme.surface
  /// * `foregroundColor`
  ///   * disabled - Theme.colorScheme.onSurface(0.38)
  ///   * others - Theme.colorScheme.primary
  /// * `overlayColor`
  ///   * hovered - Theme.colorScheme.primary(0.08)
  ///   * focused or pressed - Theme.colorScheme.primary(0.12)
  /// * `shadowColor` - Theme.colorScheme.shadow
  /// * `surfaceTintColor` - Theme.colorScheme.surfaceTint
  /// * `elevation`
  ///   * disabled - 0
  ///   * default - 1
  ///   * hovered - 3
  ///   * focused or pressed - 1
  /// * `padding`
  ///   * `textScaleFactor <= 1` - horizontal(24)
  ///   * `1 < textScaleFactor <= 2` - lerp(horizontal(24), horizontal(12))
  ///   * `2 < textScaleFactor <= 3` - lerp(horizontal(12), horizontal(6))
  ///   * `3 < textScaleFactor` - horizontal(6)
  /// * `minimumSize` - Size(64, 40)
  /// * `fixedSize` - null
  /// * `maximumSize` - Size.infinite
  /// * `side` - null
  /// * `shape` - StadiumBorder()
  /// * `mouseCursor`
  ///   * disabled - SystemMouseCursors.basic
  ///   * others - SystemMouseCursors.click
  /// * `visualDensity` - Theme.visualDensity
  /// * `tapTargetSize` - Theme.materialTapTargetSize
  /// * `animationDuration` - kThemeChangeDuration
  /// * `enableFeedback` - true
  /// * `alignment` - Alignment.center
  /// * `splashFactory` - Theme.splashFactory
  ///
  /// For the [ElevatedButton.icon] factory, the start (generally the left) value of
  /// [padding] is reduced from 24 to 16.

  @override
  ButtonStyle defaultStyleOf(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme colorScheme = theme.colorScheme;

    return Theme.of(context).useMaterial3
        ? _ElevatedButtonDefaultsM3(context)
        : styleFrom(
            backgroundColor: colorScheme.primary,
            foregroundColor: colorScheme.onPrimary,
            disabledBackgroundColor: colorScheme.onSurface.withOpacity(0.12),
            disabledForegroundColor: colorScheme.onSurface.withOpacity(0.38),
            shadowColor: theme.shadowColor,
            elevation: 2,
            textStyle: theme.textTheme.labelLarge,
            padding: _scaledPadding(context),
            minimumSize: const Size(64, 36),
            maximumSize: Size.infinite,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(4))),
            enabledMouseCursor: SystemMouseCursors.click,
            disabledMouseCursor: SystemMouseCursors.basic,
            visualDensity: theme.visualDensity,
            tapTargetSize: theme.materialTapTargetSize,
            animationDuration: kThemeChangeDuration,
            enableFeedback: true,
            alignment: Alignment.center,
            splashFactory: InkRipple.splashFactory,
          );
  }

  /// Returns the [ElevatedButtonThemeData.style] of the closest
  /// [ElevatedButtonTheme] ancestor.
  @override
  ButtonStyle? themeStyleOf(BuildContext context) {
    return ElevatedButtonTheme.of(context).style;
  }
}

EdgeInsetsGeometry _scaledPadding(BuildContext context) {
  final bool useMaterial3 = Theme.of(context).useMaterial3;
  final double padding1x = useMaterial3 ? 24.0 : 16.0;
  return ButtonStyleButton.scaledPadding(
    EdgeInsets.symmetric(horizontal: padding1x),
    EdgeInsets.symmetric(horizontal: padding1x / 2),
    EdgeInsets.symmetric(horizontal: padding1x / 2 / 2),
    MediaQuery.textScaleFactorOf(context),
  );
}

@immutable
class _ElevatedButtonDefaultColor extends MaterialStateProperty<Color?>
    with Diagnosticable {
  _ElevatedButtonDefaultColor(this.color, this.disabled);

  final Color? color;
  final Color? disabled;

  @override
  Color? resolve(Set<MaterialState> states) {
    if (states.contains(MaterialState.disabled)) {
      return disabled;
    }
    return color;
  }
}

@immutable
class _ElevatedButtonDefaultOverlay extends MaterialStateProperty<Color?>
    with Diagnosticable {
  _ElevatedButtonDefaultOverlay(this.overlay);

  final Color overlay;

  @override
  Color? resolve(Set<MaterialState> states) {
    if (states.contains(MaterialState.hovered)) {
      return overlay.withOpacity(0.08);
    }
    if (states.contains(MaterialState.focused) ||
        states.contains(MaterialState.pressed)) {
      return overlay.withOpacity(0.24);
    }
    return null;
  }
}

@immutable
class _ElevatedButtonDefaultElevation extends MaterialStateProperty<double>
    with Diagnosticable {
  _ElevatedButtonDefaultElevation(this.elevation);

  final double elevation;

  @override
  double resolve(Set<MaterialState> states) {
    if (states.contains(MaterialState.disabled)) {
      return 0;
    }
    if (states.contains(MaterialState.hovered)) {
      return elevation + 2;
    }
    if (states.contains(MaterialState.focused)) {
      return elevation + 2;
    }
    if (states.contains(MaterialState.pressed)) {
      return elevation + 6;
    }
    return elevation;
  }
}

@immutable
class _ElevatedButtonDefaultMouseCursor
    extends MaterialStateProperty<MouseCursor?> with Diagnosticable {
  _ElevatedButtonDefaultMouseCursor(this.enabledCursor, this.disabledCursor);

  final MouseCursor? enabledCursor;
  final MouseCursor? disabledCursor;

  @override
  MouseCursor? resolve(Set<MaterialState> states) {
    if (states.contains(MaterialState.disabled)) {
      return disabledCursor;
    }
    return enabledCursor;
  }
}

class _ElevatedButtonWithIcon extends ElevatedButton {
  _ElevatedButtonWithIcon({
    super.key,
    required super.onPressed,
    super.onLongPress,
    super.onHover,
    super.onFocusChange,
    super.style,
    super.focusNode,
    bool? autofocus,
    Clip? clipBehavior,
    super.statesController,
    required Widget icon,
    required Widget label,
  }) : super(
          autofocus: autofocus ?? false,
          clipBehavior: clipBehavior ?? Clip.none,
          child: _ElevatedButtonWithIconChild(icon: icon, label: label),
        );

  @override
  ButtonStyle defaultStyleOf(BuildContext context) {
    final bool useMaterial3 = Theme.of(context).useMaterial3;
    final EdgeInsetsGeometry scaledPadding = useMaterial3
        ? ButtonStyleButton.scaledPadding(
            const EdgeInsetsDirectional.fromSTEB(16, 0, 24, 0),
            const EdgeInsetsDirectional.fromSTEB(8, 0, 12, 0),
            const EdgeInsetsDirectional.fromSTEB(4, 0, 6, 0),
            MediaQuery.textScaleFactorOf(context),
          )
        : ButtonStyleButton.scaledPadding(
            const EdgeInsetsDirectional.fromSTEB(12, 0, 16, 0),
            const EdgeInsets.symmetric(horizontal: 8),
            const EdgeInsetsDirectional.fromSTEB(8, 0, 4, 0),
            MediaQuery.textScaleFactorOf(context),
          );
    return super.defaultStyleOf(context).copyWith(
          padding: MaterialStatePropertyAll<EdgeInsetsGeometry>(scaledPadding),
        );
  }
}

class _ElevatedButtonWithIconChild extends StatelessWidget {
  const _ElevatedButtonWithIconChild({required this.label, required this.icon});

  final Widget label;
  final Widget icon;

  @override
  Widget build(BuildContext context) {
    final double scale = MediaQuery.textScaleFactorOf(context);
    final double gap =
        scale <= 1 ? 8 : lerpDouble(8, 4, math.min(scale - 1, 1))!;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[icon, SizedBox(width: gap), Flexible(child: label)],
    );
  }
}

// BEGIN GENERATED TOKEN PROPERTIES - ElevatedButton

// Do not edit by hand. The code between the "BEGIN GENERATED" and
// "END GENERATED" comments are generated from data in the Material
// Design token database by the script:
//   dev/tools/gen_defaults/bin/gen_defaults.dart.

// Token database version: v0_162

class _ElevatedButtonDefaultsM3 extends ButtonStyle {
  _ElevatedButtonDefaultsM3(this.context)
      : super(
          animationDuration: kThemeChangeDuration,
          enableFeedback: true,
          alignment: Alignment.center,
        );

  final BuildContext context;
  late final ColorScheme _colors = Theme.of(context).colorScheme;

  @override
  MaterialStateProperty<TextStyle?> get textStyle =>
      MaterialStatePropertyAll<TextStyle?>(
          Theme.of(context).textTheme.labelLarge);

  @override
  MaterialStateProperty<Color?>? get backgroundColor =>
      MaterialStateProperty.resolveWith((Set<MaterialState> states) {
        if (states.contains(MaterialState.disabled)) {
          return _colors.onSurface.withOpacity(0.12);
        }
        return _colors.surface;
      });

  @override
  MaterialStateProperty<Color?>? get foregroundColor =>
      MaterialStateProperty.resolveWith((Set<MaterialState> states) {
        if (states.contains(MaterialState.disabled)) {
          return _colors.onSurface.withOpacity(0.38);
        }
        return _colors.primary;
      });

  @override
  MaterialStateProperty<Color?>? get overlayColor =>
      MaterialStateProperty.resolveWith((Set<MaterialState> states) {
        if (states.contains(MaterialState.hovered)) {
          return _colors.primary.withOpacity(0.08);
        }
        if (states.contains(MaterialState.focused)) {
          return _colors.primary.withOpacity(0.12);
        }
        if (states.contains(MaterialState.pressed)) {
          return _colors.primary.withOpacity(0.12);
        }
        return null;
      });

  @override
  MaterialStateProperty<Color>? get shadowColor =>
      MaterialStatePropertyAll<Color>(_colors.shadow);

  @override
  MaterialStateProperty<Color>? get surfaceTintColor =>
      MaterialStatePropertyAll<Color>(_colors.surfaceTint);

  @override
  MaterialStateProperty<double>? get elevation =>
      MaterialStateProperty.resolveWith((Set<MaterialState> states) {
        if (states.contains(MaterialState.disabled)) {
          return 0.0;
        }
        if (states.contains(MaterialState.hovered)) {
          return 3.0;
        }
        if (states.contains(MaterialState.focused)) {
          return 1.0;
        }
        if (states.contains(MaterialState.pressed)) {
          return 1.0;
        }
        return 1.0;
      });

  @override
  MaterialStateProperty<EdgeInsetsGeometry>? get padding =>
      MaterialStatePropertyAll<EdgeInsetsGeometry>(_scaledPadding(context));

  @override
  MaterialStateProperty<Size>? get minimumSize =>
      const MaterialStatePropertyAll<Size>(Size(64.0, 40.0));

  // No default fixedSize

  @override
  MaterialStateProperty<Size>? get maximumSize =>
      const MaterialStatePropertyAll<Size>(Size.infinite);

  // No default side

  @override
  MaterialStateProperty<OutlinedBorder>? get shape =>
      const MaterialStatePropertyAll<OutlinedBorder>(StadiumBorder());

  @override
  MaterialStateProperty<MouseCursor?>? get mouseCursor =>
      MaterialStateProperty.resolveWith((Set<MaterialState> states) {
        if (states.contains(MaterialState.disabled)) {
          return SystemMouseCursors.basic;
        }
        return SystemMouseCursors.click;
      });

  @override
  VisualDensity? get visualDensity => Theme.of(context).visualDensity;

  @override
  MaterialTapTargetSize? get tapTargetSize =>
      Theme.of(context).materialTapTargetSize;

  @override
  InteractiveInkFeatureFactory? get splashFactory =>
      Theme.of(context).splashFactory;
}

// END GENERATED TOKEN PROPERTIES - ElevatedButton

""";

String dismissibleString = """
// Copyright 2014 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/gestures.dart';

import 'automatic_keep_alive.dart';
import 'basic.dart';
import 'debug.dart';
import 'framework.dart';
import 'gesture_detector.dart';
import 'ticker_provider.dart';
import 'transitions.dart';

const Curve _kResizeTimeCurve = Interval(0.4, 1.0, curve: Curves.ease);
const double _kMinFlingVelocity = 700.0;
const double _kMinFlingVelocityDelta = 400.0;
const double _kFlingVelocityScale = 1.0 / 300.0;
const double _kDismissThreshold = 0.4;

/// Signature used by [Dismissible] to indicate that it has been dismissed in
/// the given `direction`.
///
/// Used by [Dismissible.onDismissed].
typedef DismissDirectionCallback = void Function(DismissDirection direction);

/// Signature used by [Dismissible] to give the application an opportunity to
/// confirm or veto a dismiss gesture.
///
/// Used by [Dismissible.confirmDismiss].
typedef ConfirmDismissCallback = Future<bool?> Function(DismissDirection direction);

/// Signature used by [Dismissible] to indicate that the dismissible has been dragged.
///
/// Used by [Dismissible.onUpdate].
typedef DismissUpdateCallback = void Function(DismissUpdateDetails details);

/// The direction in which a [Dismissible] can be dismissed.
enum DismissDirection {
  /// The [Dismissible] can be dismissed by dragging either up or down.
  vertical,

  /// The [Dismissible] can be dismissed by dragging either left or right.
  horizontal,

  /// The [Dismissible] can be dismissed by dragging in the reverse of the
  /// reading direction (e.g., from right to left in left-to-right languages).
  endToStart,

  /// The [Dismissible] can be dismissed by dragging in the reading direction
  /// (e.g., from left to right in left-to-right languages).
  startToEnd,

  /// The [Dismissible] can be dismissed by dragging up only.
  up,

  /// The [Dismissible] can be dismissed by dragging down only.
  down,

  /// The [Dismissible] cannot be dismissed by dragging.
  none
}

/// A widget that can be dismissed by dragging in the indicated [direction].
///
/// Dragging or flinging this widget in the [DismissDirection] causes the child
/// to slide out of view. Following the slide animation, if [resizeDuration] is
/// non-null, the Dismissible widget animates its height (or width, whichever is
/// perpendicular to the dismiss direction) to zero over the [resizeDuration].
///
/// {@youtube 560 315 https://www.youtube.com/watch?v=iEMgjrfuc58}
///
/// {@tool dartpad}
/// This sample shows how you can use the [Dismissible] widget to
/// remove list items using swipe gestures. Swipe any of the list
/// tiles to the left or right to dismiss them from the [ListView].
///
/// ** See code in examples/api/lib/widgets/dismissible/dismissible.0.dart **
/// {@end-tool}
///
/// Backgrounds can be used to implement the "leave-behind" idiom. If a background
/// is specified it is stacked behind the Dismissible's child and is exposed when
/// the child moves.
///
/// The widget calls the [onDismissed] callback either after its size has
/// collapsed to zero (if [resizeDuration] is non-null) or immediately after
/// the slide animation (if [resizeDuration] is null). If the Dismissible is a
/// list item, it must have a key that distinguishes it from the other items and
/// its [onDismissed] callback must remove the item from the list.
class Dismissible extends StatefulWidget {
  /// Creates a widget that can be dismissed.
  ///
  /// The [key] argument must not be null because [Dismissible]s are commonly
  /// used in lists and removed from the list when dismissed. Without keys, the
  /// default behavior is to sync widgets based on their index in the list,
  /// which means the item after the dismissed item would be synced with the
  /// state of the dismissed item. Using keys causes the widgets to sync
  /// according to their keys and avoids this pitfall.
  const Dismissible({
    required Key key,
    required this.child,
    this.background,
    this.secondaryBackground,
    this.confirmDismiss,
    this.onResize,
    this.onUpdate,
    this.onDismissed,
    this.direction = DismissDirection.horizontal,
    this.resizeDuration = const Duration(milliseconds: 300),
    this.dismissThresholds = const <DismissDirection, double>{},
    this.movementDuration = const Duration(milliseconds: 200),
    this.crossAxisEndOffset = 0.0,
    this.dragStartBehavior = DragStartBehavior.start,
    this.behavior = HitTestBehavior.opaque,
  }) : assert(secondaryBackground == null || background != null),
       super(key: key);

  /// The widget below this widget in the tree.
  ///
  /// {@macro flutter.widgets.ProxyWidget.child}
  final Widget child;

  /// A widget that is stacked behind the child. If secondaryBackground is also
  /// specified then this widget only appears when the child has been dragged
  /// down or to the right.
  final Widget? background;

  /// A widget that is stacked behind the child and is exposed when the child
  /// has been dragged up or to the left. It may only be specified when background
  /// has also been specified.
  final Widget? secondaryBackground;

  /// Gives the app an opportunity to confirm or veto a pending dismissal.
  ///
  /// The widget cannot be dragged again until the returned future resolves.
  ///
  /// If the returned Future<bool> completes true, then this widget will be
  /// dismissed, otherwise it will be moved back to its original location.
  ///
  /// If the returned Future<bool?> completes to false or null the [onResize]
  /// and [onDismissed] callbacks will not run.
  final ConfirmDismissCallback? confirmDismiss;

  /// Called when the widget changes size (i.e., when contracting before being dismissed).
  final VoidCallback? onResize;

  /// Called when the widget has been dismissed, after finishing resizing.
  final DismissDirectionCallback? onDismissed;

  /// The direction in which the widget can be dismissed.
  final DismissDirection direction;

  /// The amount of time the widget will spend contracting before [onDismissed] is called.
  ///
  /// If null, the widget will not contract and [onDismissed] will be called
  /// immediately after the widget is dismissed.
  final Duration? resizeDuration;

  /// The offset threshold the item has to be dragged in order to be considered
  /// dismissed.
  ///
  /// Represented as a fraction, e.g. if it is 0.4 (the default), then the item
  /// has to be dragged at least 40% towards one direction to be considered
  /// dismissed. Clients can define different thresholds for each dismiss
  /// direction.
  ///
  /// Flinging is treated as being equivalent to dragging almost to 1.0, so
  /// flinging can dismiss an item past any threshold less than 1.0.
  ///
  /// Setting a threshold of 1.0 (or greater) prevents a drag in the given
  /// [DismissDirection] even if it would be allowed by the [direction]
  /// property.
  ///
  /// See also:
  ///
  ///  * [direction], which controls the directions in which the items can
  ///    be dismissed.
  final Map<DismissDirection, double> dismissThresholds;

  /// Defines the duration for card to dismiss or to come back to original position if not dismissed.
  final Duration movementDuration;

  /// Defines the end offset across the main axis after the card is dismissed.
  ///
  /// If non-zero value is given then widget moves in cross direction depending on whether
  /// it is positive or negative.
  final double crossAxisEndOffset;

  /// Determines the way that drag start behavior is handled.
  ///
  /// If set to [DragStartBehavior.start], the drag gesture used to dismiss a
  /// dismissible will begin at the position where the drag gesture won the arena.
  /// If set to [DragStartBehavior.down] it will begin at the position where
  /// a down event is first detected.
  ///
  /// In general, setting this to [DragStartBehavior.start] will make drag
  /// animation smoother and setting it to [DragStartBehavior.down] will make
  /// drag behavior feel slightly more reactive.
  ///
  /// By default, the drag start behavior is [DragStartBehavior.start].
  ///
  /// See also:
  ///
  ///  * [DragGestureRecognizer.dragStartBehavior], which gives an example for the different behaviors.
  final DragStartBehavior dragStartBehavior;

  /// How to behave during hit tests.
  ///
  /// This defaults to [HitTestBehavior.opaque].
  final HitTestBehavior behavior;

  /// Called when the dismissible widget has been dragged.
  ///
  /// If [onUpdate] is not null, then it will be invoked for every pointer event
  /// to dispatch the latest state of the drag. For example, this callback
  /// can be used to for example change the color of the background widget
  /// depending on whether the dismiss threshold is currently reached.
  final DismissUpdateCallback? onUpdate;

  @override
  State<Dismissible> createState() => _DismissibleState();
}

/// Details for [DismissUpdateCallback].
///
/// See also:
///
///   * [Dismissible.onUpdate], which receives this information.
class DismissUpdateDetails {
  /// Create a new instance of [DismissUpdateDetails].
  DismissUpdateDetails({
    this.direction = DismissDirection.horizontal,
    this.reached = false,
    this.previousReached = false,
    this.progress = 0.0,
  });

  /// The direction that the dismissible is being dragged.
  final DismissDirection direction;

  /// Whether the dismiss threshold is currently reached.
  final bool reached;

  /// Whether the dismiss threshold was reached the last time this callback was invoked.
  ///
  /// This can be used in conjunction with [DismissUpdateDetails.reached] to catch the moment
  /// that the [Dismissible] is dragged across the threshold.
  final bool previousReached;

  /// The offset ratio of the dismissible in its parent container.
  ///
  /// A value of 0.0 represents the normal position and 1.0 means the child is
  /// completely outside its parent.
  ///
  /// This can be used to synchronize other elements to what the dismissible is doing on screen,
  /// e.g. using this value to set the opacity thereby fading dismissible as it's dragged offscreen.
  final double progress;
}

class _DismissibleClipper extends CustomClipper<Rect> {
  _DismissibleClipper({
    required this.axis,
    required this.moveAnimation,
  }) : super(reclip: moveAnimation);

  final Axis axis;
  final Animation<Offset> moveAnimation;

  @override
  Rect getClip(Size size) {
    switch (axis) {
      case Axis.horizontal:
        final double offset = moveAnimation.value.dx * size.width;
        if (offset < 0) {
          return Rect.fromLTRB(size.width + offset, 0.0, size.width, size.height);
        }
        return Rect.fromLTRB(0.0, 0.0, offset, size.height);
      case Axis.vertical:
        final double offset = moveAnimation.value.dy * size.height;
        if (offset < 0) {
          return Rect.fromLTRB(0.0, size.height + offset, size.width, size.height);
        }
        return Rect.fromLTRB(0.0, 0.0, size.width, offset);
    }
  }

  @override
  Rect getApproximateClipRect(Size size) => getClip(size);

  @override
  bool shouldReclip(_DismissibleClipper oldClipper) {
    return oldClipper.axis != axis
        || oldClipper.moveAnimation.value != moveAnimation.value;
  }
}

enum _FlingGestureKind { none, forward, reverse }

class _DismissibleState extends State<Dismissible> with TickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    super.initState();
    _moveController = AnimationController(duration: widget.movementDuration, vsync: this)
      ..addStatusListener(_handleDismissStatusChanged)
      ..addListener(_handleDismissUpdateValueChanged);
    _updateMoveAnimation();
  }

  AnimationController? _moveController;
  late Animation<Offset> _moveAnimation;

  AnimationController? _resizeController;
  Animation<double>? _resizeAnimation;

  double _dragExtent = 0.0;
  bool _confirming = false;
  bool _dragUnderway = false;
  Size? _sizePriorToCollapse;
  bool _dismissThresholdReached = false;

  final GlobalKey _contentKey = GlobalKey();

  @override
  bool get wantKeepAlive => (_moveController?.isAnimating ?? false) || (_resizeController?.isAnimating ?? false);

  @override
  void dispose() {
    _moveController!.dispose();
    _resizeController?.dispose();
    super.dispose();
  }

  bool get _directionIsXAxis {
    return widget.direction == DismissDirection.horizontal
        || widget.direction == DismissDirection.endToStart
        || widget.direction == DismissDirection.startToEnd;
  }

  DismissDirection _extentToDirection(double extent) {
    if (extent == 0.0) {
      return DismissDirection.none;
    }
    if (_directionIsXAxis) {
      switch (Directionality.of(context)) {
        case TextDirection.rtl:
          return extent < 0 ? DismissDirection.startToEnd : DismissDirection.endToStart;
        case TextDirection.ltr:
          return extent > 0 ? DismissDirection.startToEnd : DismissDirection.endToStart;
      }
    }
    return extent > 0 ? DismissDirection.down : DismissDirection.up;
  }

  DismissDirection get _dismissDirection => _extentToDirection(_dragExtent);

  bool get _isActive {
    return _dragUnderway || _moveController!.isAnimating;
  }

  double get _overallDragAxisExtent {
    final Size size = context.size!;
    return _directionIsXAxis ? size.width : size.height;
  }

  void _handleDragStart(DragStartDetails details) {
    if (_confirming) {
      return;
    }
    _dragUnderway = true;
    if (_moveController!.isAnimating) {
      _dragExtent = _moveController!.value * _overallDragAxisExtent * _dragExtent.sign;
      _moveController!.stop();
    } else {
      _dragExtent = 0.0;
      _moveController!.value = 0.0;
    }
    setState(() {
      _updateMoveAnimation();
    });
  }

  void _handleDragUpdate(DragUpdateDetails details) {
    if (!_isActive || _moveController!.isAnimating) {
      return;
    }

    final double delta = details.primaryDelta!;
    final double oldDragExtent = _dragExtent;
    switch (widget.direction) {
      case DismissDirection.horizontal:
      case DismissDirection.vertical:
        _dragExtent += delta;

      case DismissDirection.up:
        if (_dragExtent + delta < 0) {
          _dragExtent += delta;
        }

      case DismissDirection.down:
        if (_dragExtent + delta > 0) {
          _dragExtent += delta;
        }

      case DismissDirection.endToStart:
        switch (Directionality.of(context)) {
          case TextDirection.rtl:
            if (_dragExtent + delta > 0) {
              _dragExtent += delta;
            }
          case TextDirection.ltr:
            if (_dragExtent + delta < 0) {
              _dragExtent += delta;
            }
        }

      case DismissDirection.startToEnd:
        switch (Directionality.of(context)) {
          case TextDirection.rtl:
            if (_dragExtent + delta < 0) {
              _dragExtent += delta;
            }
          case TextDirection.ltr:
            if (_dragExtent + delta > 0) {
              _dragExtent += delta;
            }
        }

      case DismissDirection.none:
        _dragExtent = 0;
    }
    if (oldDragExtent.sign != _dragExtent.sign) {
      setState(() {
        _updateMoveAnimation();
      });
    }
    if (!_moveController!.isAnimating) {
      _moveController!.value = _dragExtent.abs() / _overallDragAxisExtent;
    }
  }

  void _handleDismissUpdateValueChanged() {
    if(widget.onUpdate != null) {
      final bool oldDismissThresholdReached = _dismissThresholdReached;
      _dismissThresholdReached = _moveController!.value > (widget.dismissThresholds[_dismissDirection] ?? _kDismissThreshold);
      final DismissUpdateDetails details = DismissUpdateDetails(
          direction: _dismissDirection,
          reached: _dismissThresholdReached,
          previousReached: oldDismissThresholdReached,
          progress: _moveController!.value,
      );
      widget.onUpdate!(details);
    }
  }

  void _updateMoveAnimation() {
    final double end = _dragExtent.sign;
    _moveAnimation = _moveController!.drive(
      Tween<Offset>(
        begin: Offset.zero,
        end: _directionIsXAxis
            ? Offset(end, widget.crossAxisEndOffset)
            : Offset(widget.crossAxisEndOffset, end),
      ),
    );
  }

  _FlingGestureKind _describeFlingGesture(Velocity velocity) {
    if (_dragExtent == 0.0) {
      // If it was a fling, then it was a fling that was let loose at the exact
      // middle of the range (i.e. when there's no displacement). In that case,
      // we assume that the user meant to fling it back to the center, as
      // opposed to having wanted to drag it out one way, then fling it past the
      // center and into and out the other side.
      return _FlingGestureKind.none;
    }
    final double vx = velocity.pixelsPerSecond.dx;
    final double vy = velocity.pixelsPerSecond.dy;
    DismissDirection flingDirection;
    // Verify that the fling is in the generally right direction and fast enough.
    if (_directionIsXAxis) {
      if (vx.abs() - vy.abs() < _kMinFlingVelocityDelta || vx.abs() < _kMinFlingVelocity) {
        return _FlingGestureKind.none;
      }
      assert(vx != 0.0);
      flingDirection = _extentToDirection(vx);
    } else {
      if (vy.abs() - vx.abs() < _kMinFlingVelocityDelta || vy.abs() < _kMinFlingVelocity) {
        return _FlingGestureKind.none;
      }
      assert(vy != 0.0);
      flingDirection = _extentToDirection(vy);
    }
    if (flingDirection == _dismissDirection) {
      return _FlingGestureKind.forward;
    }
    return _FlingGestureKind.reverse;
  }

  void _handleDragEnd(DragEndDetails details) {
    if (!_isActive || _moveController!.isAnimating) {
      return;
    }
    _dragUnderway = false;
    if (_moveController!.isCompleted) {
      _handleMoveCompleted();
      return;
    }
    final double flingVelocity = _directionIsXAxis ? details.velocity.pixelsPerSecond.dx : details.velocity.pixelsPerSecond.dy;
    switch (_describeFlingGesture(details.velocity)) {
      case _FlingGestureKind.forward:
        assert(_dragExtent != 0.0);
        assert(!_moveController!.isDismissed);
        if ((widget.dismissThresholds[_dismissDirection] ?? _kDismissThreshold) >= 1.0) {
          _moveController!.reverse();
          break;
        }
        _dragExtent = flingVelocity.sign;
        _moveController!.fling(velocity: flingVelocity.abs() * _kFlingVelocityScale);
      case _FlingGestureKind.reverse:
        assert(_dragExtent != 0.0);
        assert(!_moveController!.isDismissed);
        _dragExtent = flingVelocity.sign;
        _moveController!.fling(velocity: -flingVelocity.abs() * _kFlingVelocityScale);
      case _FlingGestureKind.none:
        if (!_moveController!.isDismissed) { // we already know it's not completed, we check that above
          if (_moveController!.value > (widget.dismissThresholds[_dismissDirection] ?? _kDismissThreshold)) {
            _moveController!.forward();
          } else {
            _moveController!.reverse();
          }
        }
    }
  }

  Future<void> _handleDismissStatusChanged(AnimationStatus status) async {
    if (status == AnimationStatus.completed && !_dragUnderway) {
      await _handleMoveCompleted();
    }
    if (mounted) {
      updateKeepAlive();
    }
  }

  Future<void> _handleMoveCompleted() async {
    if ((widget.dismissThresholds[_dismissDirection] ?? _kDismissThreshold) >= 1.0) {
      _moveController!.reverse();
      return;
    }
    final bool result = await _confirmStartResizeAnimation();
    if (mounted) {
      if (result) {
        _startResizeAnimation();
      } else {
        _moveController!.reverse();
      }
    }
  }

  Future<bool> _confirmStartResizeAnimation() async {
    if (widget.confirmDismiss != null) {
      _confirming = true;
      final DismissDirection direction = _dismissDirection;
      try {
        return await widget.confirmDismiss!(direction) ?? false;
      } finally {
        _confirming = false;
      }
    }
    return true;
  }

  void _startResizeAnimation() {
    assert(_moveController!.isCompleted);
    assert(_resizeController == null);
    assert(_sizePriorToCollapse == null);
    if (widget.resizeDuration == null) {
      if (widget.onDismissed != null) {
        final DismissDirection direction = _dismissDirection;
        widget.onDismissed!(direction);
      }
    } else {
      _resizeController = AnimationController(duration: widget.resizeDuration, vsync: this)
        ..addListener(_handleResizeProgressChanged)
        ..addStatusListener((AnimationStatus status) => updateKeepAlive());
      _resizeController!.forward();
      setState(() {
        _sizePriorToCollapse = context.size;
        _resizeAnimation = _resizeController!.drive(
          CurveTween(
            curve: _kResizeTimeCurve,
          ),
        ).drive(
          Tween<double>(
            begin: 1.0,
            end: 0.0,
          ),
        );
      });
    }
  }

  void _handleResizeProgressChanged() {
    if (_resizeController!.isCompleted) {
      widget.onDismissed?.call(_dismissDirection);
    } else {
      widget.onResize?.call();
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context); // See AutomaticKeepAliveClientMixin.

    assert(!_directionIsXAxis || debugCheckHasDirectionality(context));

    Widget? background = widget.background;
    if (widget.secondaryBackground != null) {
      final DismissDirection direction = _dismissDirection;
      if (direction == DismissDirection.endToStart || direction == DismissDirection.up) {
        background = widget.secondaryBackground;
      }
    }

    if (_resizeAnimation != null) {
      // we've been dragged aside, and are now resizing.
      assert(() {
        if (_resizeAnimation!.status != AnimationStatus.forward) {
          assert(_resizeAnimation!.status == AnimationStatus.completed);
          throw FlutterError.fromParts(<DiagnosticsNode>[
            ErrorSummary('A dismissed Dismissible widget is still part of the tree.'),
            ErrorHint(
              'Make sure to implement the onDismissed handler and to immediately remove the Dismissible '
              'widget from the application once that handler has fired.',
            ),
          ]);
        }
        return true;
      }());

      return SizeTransition(
        sizeFactor: _resizeAnimation!,
        axis: _directionIsXAxis ? Axis.vertical : Axis.horizontal,
        child: SizedBox(
          width: _sizePriorToCollapse!.width,
          height: _sizePriorToCollapse!.height,
          child: background,
        ),
      );
    }

    Widget content = SlideTransition(
      position: _moveAnimation,
      child: KeyedSubtree(key: _contentKey, child: widget.child),
    );

    if (background != null) {
      content = Stack(children: <Widget>[
        if (!_moveAnimation.isDismissed)
          Positioned.fill(
            child: ClipRect(
              clipper: _DismissibleClipper(
                axis: _directionIsXAxis ? Axis.horizontal : Axis.vertical,
                moveAnimation: _moveAnimation,
              ),
              child: background,
            ),
          ),
        content,
      ]);
    }

    // If the DismissDirection is none, we do not add drag gestures because the content
    // cannot be dragged.
    if (widget.direction == DismissDirection.none) {
      return content;
    }

    // We are not resizing but we may be being dragging in widget.direction.
    return GestureDetector(
      onHorizontalDragStart: _directionIsXAxis ? _handleDragStart : null,
      onHorizontalDragUpdate: _directionIsXAxis ? _handleDragUpdate : null,
      onHorizontalDragEnd: _directionIsXAxis ? _handleDragEnd : null,
      onVerticalDragStart: _directionIsXAxis ? null : _handleDragStart,
      onVerticalDragUpdate: _directionIsXAxis ? null : _handleDragUpdate,
      onVerticalDragEnd: _directionIsXAxis ? null : _handleDragEnd,
      behavior: widget.behavior,
      dragStartBehavior: widget.dragStartBehavior,
      child: content,
    );
  }
}

""";
