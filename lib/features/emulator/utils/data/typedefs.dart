import 'package:flutter/foundation.dart';

Map<String, String> typeDefs = {
  "ActionListenerCallback": "void Function(Action<Intent> action)",
  "AllowedButtonsFilter": "bool Function(int buttons)",
  "AnimatableCallback": "T Function(double)",
  "AnimatedCrossFadeBuilder":
      "Widget Function(Widget topChild,   Key topChildKey,   Widget bottomChild,   Key bottomChildKey)",
  "AnimatedItemBuilder":
      "Widget Function(BuildContext context,   int index,   Animation<double> animation)",
  "AnimatedListItemBuilder":
      "Widget Function(BuildContext context,   int index,   Animation<double> animation)",
  "AnimatedListRemovedItemBuilder":
      "Widget Function(BuildContext context,   Animation<double> animation)",
  "AnimatedRemovedItemBuilder":
      "Widget Function(BuildContext context,   Animation<double> animation)",
  "AnimatedSwitcherLayoutBuilder":
      "Widget Function(Widget? currentChild,   List<Widget> previousChildren)",
  "AnimatedSwitcherTransitionBuilder":
      "Widget Function(Widget child,   Animation<double> animation)",
  "AnimatedTransitionBuilder":
      "Widget Function( BuildContext context,   Animation<double> animation,   Widget? child,   )",
  "AnimationStatusListener": "void Function(AnimationStatus status)",
  "AppPrivateCommandCallback":
      "void Function(String,   Map<String,   dynamic>)",
  "AsyncCallback": "Future<void> Function()",
  "AsyncValueGetter": "Future<T> Function()",
  "AsyncValueSetter": "Future<void> Function(T value)",
  "AsyncWidgetBuilder":
      "Widget Function(BuildContext context,   AsyncSnapshot<T> snapshot)",
  "AutocompleteFieldViewBuilder":
      "Widget Function( BuildContext context,   TextEditingController textEditingController,   FocusNode focusNode,   VoidCallback onFieldSubmitted,   )",
  "AutocompleteOnSelected": "void Function(T option)",
  "AutocompleteOptionToString": "String Function(T option)",
  "AutocompleteOptionsBuilder":
      "FutureOr<Iterable<T>> Function(TextEditingValue textEditingValue)",
  "AutocompleteOptionsViewBuilder":
      "Widget Function( BuildContext context,   AutocompleteOnSelected<T> onSelected,   Iterable<T> options,   )",
  "BottomSheetDragEndHandler":
      "void Function( DragEndDetails details,   { required bool isClosing,   })",
  "BottomSheetDragStartHandler": "void Function(DragStartDetails details)",
  "BoxConstraintsTransform": "BoxConstraints Function(BoxConstraints)",
  "BoxHitTest": "bool Function(BoxHitTestResult result,   Offset position)",
  "BoxHitTestWithOutOfBandPosition": "bool Function(BoxHitTestResult result)",
  "BytesReceivedCallback": "void Function(int cumulative,   int? total)",
  "CaretChangedHandler": "void Function(Rect caretRect)",
  "ChannelCallback":
      "void Function(ByteData? data,   PlatformMessageResponseCallback callback)",
  "ChildIndexGetter": "int? Function(Key key)",
  "ChildLayouter":
      "Size Function(RenderBox child,   BoxConstraints constraints)",
  "ChildSemanticsConfigurationsDelegate":
      "ChildSemanticsConfigurationsResult Function(List<SemanticsConfiguration>)",
  "Comparator": "int Function(T a,   T b)",
  "CompositionCallback": "void Function(Layer)",
  "ComputeCallback": "FutureOr<R> Function(M message)",
  "ComputeImpl":
      "Future<R> Function<M,   R>(ComputeCallback<M,   R> callback,   M message,   { String? debugLabel })",
  "ComputePropertyValueCallback": "T? Function()",
  "ConditionalElementVisitor": "bool Function(Element element)",
  "ConfirmDismissCallback":
      "Future<bool?> Function(DismissDirection direction)",
  "ContextMenuPreviewBuilder":
      "Widget Function( BuildContext context,   Animation<double> animation,   Widget child,   )",
  "ControlsWidgetBuilder":
      "Widget Function(BuildContext context,   ControlsDetails details)",
  "CreatePlatformViewCallback":
      "PlatformViewController Function(PlatformViewCreationParams params)",
  "CreateRectTween": "Tween<Rect?> Function(Rect? begin,   Rect? end)",
  "CupertinoContextMenuBuilder":
      "Widget Function( BuildContext context,   Animation<double> animation,   )",
  "CupertinoToolbarBuilder":
      "Widget Function( BuildContext context,   Offset anchor,   bool isAbove,   Widget child,   )",
  "DataColumnSortCallback": "void Function(int columnIndex,   bool ascending)",
  "DebugPrintCallback": "void Function(String? message,   { int? wrapWidth })",
  "DecoderBufferCallback":
      "Future<ui.Codec> Function(ui.ImmutableBuffer buffer,   {int? cacheWidth,   int? cacheHeight,   bool allowUpscaling})",
  "DecoderCallback":
      "Future<ui.Codec> Function(Uint8List buffer,   {int? cacheWidth,   int? cacheHeight,   bool allowUpscaling})",
  "DiagnosticPropertiesTransformer":
      "Iterable<DiagnosticsNode> Function(Iterable<DiagnosticsNode> properties)",
  "DismissDirectionCallback": "void Function(DismissDirection direction)",
  "DismissUpdateCallback": "void Function(DismissUpdateDetails details)",
  "DomEventListener": "void Function(DomEvent event)",
  "DragAnchorStrategy":
      "Offset Function(Draggable<Object> draggable,   BuildContext context,   Offset position)",
  "DragEndCallback": "void Function(DraggableDetails details)",
  "DragTargetAccept": "void Function(T data)",
  "DragTargetAcceptWithDetails": "void Function(DragTargetDetails<T> details)",
  "DragTargetBuilder":
      "Widget Function(BuildContext context,   List<T?> candidateData,   List<dynamic> rejectedData)",
  "DragTargetLeave": "void Function(T? data)",
  "DragTargetMove": "void Function(DragTargetDetails<T> details)",
  "DragTargetWillAccept": "bool Function(T? data)",
  "DragUpdateCallback": "void Function(DragUpdateDetails details)",
  "DraggableCanceledCallback":
      "void Function(Velocity velocity,   Offset offset)",
  "DrainChannelCallback":
      "Future<void> Function(ByteData? data,   PlatformMessageResponseCallback callback)",
  "DrawerCallback": "void Function(bool isOpened)",
  "DropdownButtonBuilder": "List<Widget> Function(BuildContext context)",
  "EditableTextContextMenuBuilder":
      "Widget Function( BuildContext context,   EditableTextState editableTextState,   )",
  "ElementVisitor": "void Function(Element element)",
  "EntryModeChangeCallback": "void Function(TimePickerEntryMode)",
  "ErrorCallback": "bool Function(Object exception,   StackTrace stackTrace)",
  "ErrorWidgetBuilder": "Widget Function(FlutterErrorDetails details)",
  "ExpansionPanelCallback": "void Function(int panelIndex,   bool isExpanded)",
  "ExpansionPanelHeaderBuilder":
      "Widget Function(BuildContext context,   bool isExpanded)",
  "FlutterExceptionHandler": "void Function(FlutterErrorDetails details)",
  "FocusOnKeyCallback":
      "KeyEventResult Function(FocusNode node,   RawKeyEvent event)",
  "FocusOnKeyEventCallback":
      "KeyEventResult Function(FocusNode node,   KeyEvent event)",
  "FormFieldBuilder": "Widget Function(FormFieldState<T> field)",
  "FormFieldSetter": "void Function(T? newValue)",
  "FormFieldValidator": "String? Function(T? value)",
  "FrameCallback": "void Function(Duration timeStamp)",
  "GenerateAppTitle": "String Function(BuildContext context)",
  "GestureCancelCallback": "void Function()",
  "GestureDoubleTapCallback": "void Function()",
  "GestureDragCancelCallback": "void Function()",
  "GestureDragDownCallback": "void Function(DragDownDetails details)",
  "GestureDragEndCallback": "void Function(DragEndDetails details)",
  "GestureDragStartCallback": "void Function(DragStartDetails details)",
  "GestureDragUpdateCallback": "void Function(DragUpdateDetails details)",
  "GestureForceInterpolation":
      "double Function(double pressureMin,   double pressureMax,   double pressure)",
  "GestureForcePressEndCallback": "void Function(ForcePressDetails details)",
  "GestureForcePressPeakCallback": "void Function(ForcePressDetails details)",
  "GestureForcePressStartCallback": "void Function(ForcePressDetails details)",
  "GestureForcePressUpdateCallback": "void Function(ForcePressDetails details)",
  "GestureLongPressCallback": "void Function()",
  "GestureLongPressCancelCallback": "void Function()",
  "GestureLongPressDownCallback": "void Function(LongPressDownDetails details)",
  "GestureLongPressEndCallback": "void Function(LongPressEndDetails details)",
  "GestureLongPressMoveUpdateCallback":
      "void Function(LongPressMoveUpdateDetails details)",
  "GestureLongPressStartCallback":
      "void Function(LongPressStartDetails details)",
  "GestureLongPressUpCallback": "void Function()",
  "GestureMultiDragStartCallback": "Drag? Function(Offset position)",
  "GestureMultiTapCallback": "void Function(int pointer)",
  "GestureMultiTapCancelCallback": "void Function(int pointer)",
  "GestureMultiTapDownCallback":
      "void Function(int pointer,   TapDownDetails details)",
  "GestureMultiTapUpCallback":
      "void Function(int pointer,   TapUpDetails details)",
  "GestureRecognizerFactoryConstructor": "T Function()",
  "GestureRecognizerFactoryInitializer": "void Function(T instance)",
  "GestureScaleEndCallback": "void Function(ScaleEndDetails details)",
  "GestureScaleStartCallback": "void Function(ScaleStartDetails details)",
  "GestureScaleUpdateCallback": "void Function(ScaleUpdateDetails details)",
  "GestureSerialTapCancelCallback":
      "void Function(SerialTapCancelDetails details)",
  "GestureSerialTapDownCallback": "void Function(SerialTapDownDetails details)",
  "GestureSerialTapUpCallback": "void Function(SerialTapUpDetails details)",
  "GestureTapCallback": "void Function()",
  "GestureTapCancelCallback": "void Function()",
  "GestureTapDownCallback": "void Function(TapDownDetails details)",
  "GestureTapDragDownCallback": "void Function(TapDragDownDetails details)",
  "GestureTapDragEndCallback": "void Function(TapDragEndDetails endDetails)",
  "GestureTapDragStartCallback": "void Function(TapDragStartDetails details)",
  "GestureTapDragUpCallback": "void Function(TapDragUpDetails details)",
  "GestureTapDragUpdateCallback": "void Function(TapDragUpdateDetails details)",
  "GestureTapUpCallback": "void Function(TapUpDetails details)",
  "GestureVelocityTrackerBuilder":
      "VelocityTracker Function(PointerEvent event)",
  "HandleEventCallback": "void Function(PointerEvent event)",
  "HeroFlightShuttleBuilder":
      "Widget Function( BuildContext flightContext,   Animation<double> animation,   HeroFlightDirection flightDirection,   BuildContext fromHeroContext,   BuildContext toHeroContext,   )",
  "HeroPlaceholderBuilder":
      "Widget Function( BuildContext context, Size heroSize,   Widget child,   )",
  "HttpClientProvider": "HttpClient Function()",
  "HttpRequestFactory": "DomXMLHttpRequest Function()",
  "ImageChunkListener": "void Function(ImageChunkEvent event)",
  "ImageDecoderCallback":
      "Future<ui.Codec> Function( ui.ImmutableBuffer buffer,   { ui.TargetImageSizeCallback? getTargetSize,   })",
  "ImageErrorListener":
      "void Function(Object exception,   StackTrace? stackTrace)",
  "ImageErrorWidgetBuilder":
      "Widget Function( BuildContext context,   Object error,   StackTrace? stackTrace,   )",
  "ImageEventCallback": "void Function(Image image)",
  "ImageFrameBuilder":
      "Widget Function( BuildContext context,   Widget child,   int? frame,   bool wasSynchronouslyLoaded,   )",
  "ImageListener": "void Function(ImageInfo image,   bool synchronousCall)",
  "ImageLoadingBuilder":
      "Widget Function( BuildContext context,   Widget child,   ImageChunkEvent? loadingProgress,   )",
  "IndexedWidgetBuilder": "Widget Function(BuildContext context,   int index)",
  "InformationCollector": "Iterable<DiagnosticsNode> Function()",
  "InitialRouteListFactory":
      "List<Route<dynamic>> Function(String initialRoute)",
  "InlineSpanVisitor": "bool Function(InlineSpan span)",
  "InputCounterWidgetBuilder":
      "Widget? Function( BuildContext context,   { required int currentLength,   required int? maxLength,   required bool isFocused,   })",
  "InspectorSelectButtonBuilder":
      "Widget Function(BuildContext context,  VoidCallback onPressed)",
  "InspectorSelectionChangedCallback": "void Function()",
  "InteractiveViewerWidgetBuilder":
      "Widget Function(BuildContext context,   Quad viewport)",
  "IterableFilter": "Iterable<T> Function(Iterable<T> input)",
  "KeyDataCallback": "bool Function(KeyData data)",
  "KeyEventCallback": "bool Function(KeyEvent event)",
  "KeyMessageHandler": "bool Function(KeyMessage message)",
  "LayoutCallback": "void Function(T constraints)",
  "LayoutWidgetBuilder":
      "Widget Function(BuildContext context,   BoxConstraints constraints)",
  "LicenseEntryCollector": "Stream<LicenseEntry> Function()",
  "LocaleListResolutionCallback":
      "Locale? Function(List<Locale>? locales,   Iterable<Locale> supportedLocales)",
  "LocaleResolutionCallback":
      "Locale? Function(Locale? locale,   Iterable<Locale> supportedLocales)",
  "MagnifierBuilder":
      "Widget? Function( BuildContext context,   MagnifierController controller,   ValueNotifier<MagnifierInfo> magnifierInfo,   )",
  "MaterialPropertyResolver": "T Function(Set<MaterialState> states)",
  "MenuAcceleratorChildBuilder":
      "Widget Function( BuildContext context,   String label,   int index,   )",
  "MenuAnchorChildBuilder":
      "Widget Function( BuildContext context,   MenuController controller,   Widget? child,   )",
  "MenuItemSerializableIdGenerator": "int Function(PlatformMenuItem item)",
  "MessageHandler": "Future<ByteData?>? Function(ByteData? message)",
  "MouseDetectorAnnotationFinder": "HitTestResult Function(Offset offset)",
  "MoveCursorHandler": "void Function(bool extendSelection)",
  "NavigatorFinderCallback": "NavigatorState Function(BuildContext context)",
  "NestedScrollViewHeaderSliversBuilder":
      "List<Widget> Function(BuildContext context,   bool innerBoxIsScrolled)",
  "NotificationListenerCallback": "bool Function(T notification)",
  "NullableIndexedWidgetBuilder":
      "Widget? Function( BuildContext context,   int index)",
  "ObjectEventListener": "void Function(ObjectEvent)",
  "OnInvokeCallback": "Object? Function(T intent)",
  "OrientationWidgetBuilder":
      "Widget Function(BuildContext context,   Orientation orientation)",
  "PageRouteFactory":
      "PageRoute<T> Function<T>(RouteSettings settings,   WidgetBuilder builder)",
  "PaintImageCallback": "void Function(ImageSizeInfo)",
  "PaintRangeValueIndicator":
      "void Function(PaintingContext context,   Offset offset)",
  "PaintValueIndicator":
      "void Function(PaintingContext context,   Offset offset)",
  "PaintingContextCallback":
      "void Function(PaintingContext context,   Offset offset)",
  "PictureEventCallback": "void Function(Picture picture)",
  "PipelineOwnerVisitor": "void Function(PipelineOwner child)",
  "PlatformMessageCallback":
      "void Function(String name,   ByteData? data,   PlatformMessageResponseCallback? callback)",
  "PlatformMessageResponseCallback": "void Function(ByteData? data)",
  "PlatformViewCreatedCallback": "void Function(int id)",
  "PlatformViewSurfaceFactory":
      "Widget Function(BuildContext context,   PlatformViewController controller)",
  "PointTransformer": "Offset Function(Offset position)",
  "PointerCancelEventListener": "void Function(PointerCancelEvent event)",
  "PointerDataPacketCallback": "void Function(PointerDataPacket packet)",
  "PointerDownEventListener": "void Function(PointerDownEvent event)",
  "PointerEnterEventListener": "void Function(PointerEnterEvent event)",
  "PointerExitEventListener": "void Function(PointerExitEvent event)",
  "PointerHoverEventListener": "void Function(PointerHoverEvent event)",
  "PointerMoveEventListener": "void Function(PointerMoveEvent event)",
  "PointerPanZoomEndEventListener":
      "void Function(PointerPanZoomEndEvent event)",
  "PointerPanZoomStartEventListener":
      "void Function(PointerPanZoomStartEvent event)",
  "PointerPanZoomUpdateEventListener":
      "void Function(PointerPanZoomUpdateEvent event)",
  "PointerRoute": "void Function(PointerEvent event)",
  "PointerSignalEventListener": "void Function(PointerSignalEvent event)",
  "PointerSignalResolvedCallback": "void Function(PointerSignalEvent event)",
  "PointerUpEventListener": "void Function(PointerUpEvent event)",
  "PopPageCallback": "bool Function(Route<dynamic> route,   dynamic result)",
  "PopupMenuCanceled": "void Function()",
  "PopupMenuItemBuilder":
      "List<PopupMenuEntry<T>> Function(BuildContext context)",
  "PopupMenuItemSelected": "void Function(T value)",
  "ProfilePaintCallback": "void Function(RenderObject renderObject)",
  "RangeThumbSelector":
      "Thumb? Function( TextDirection textDirection,   RangeValues values,   double tapValue,   Size thumbSize,   Size trackSize,   double dx,   )",
  "RawKeyEventHandler": "bool Function(RawKeyEvent event)",
  "RebuildDirtyWidgetCallback": "void Function(Element e,   bool builtOnce)",
  "RecognizerCallback": "T Function()",
  "RectCallback": "Rect Function()",
  "RefreshCallback": "Future<void> Function()",
  "RefreshControlIndicatorBuilder":
      "Widget Function( BuildContext context,   RefreshIndicatorMode refreshState,   double pulledExtent,   double refreshTriggerPullDistance,   double refreshIndicatorExtent,   )",
  "RegisterServiceExtensionCallback":
      "void Function({ required String name,   required ServiceExtensionCallback callback,   })",
  "RegisterViewFactory":
      "void Function(String,   Object Function(int viewId),   {bool isVisible})",
  "RenderObjectVisitor": "void Function(RenderObject child)",
  "ReorderCallback": "void Function(int oldIndex,   int newIndex)",
  "ReorderItemProxyDecorator":
      "Widget Function(Widget child,   int index,   Animation<double> animation)",
  "RestorableRouteBuilder":
      "Route<T> Function(BuildContext context,   Object? arguments)",
  "RouteCompletionCallback": "void Function(T result)",
  "RouteFactory": "Route<dynamic>? Function(RouteSettings settings)",
  "RouteListFactory":
      "List<Route<dynamic>> Function(NavigatorState navigator,   String initialRoute)",
  "RoutePageBuilder":
      "Widget Function(BuildContext context,   Animation<double> animation,   Animation<double> secondaryAnimation)",
  "RoutePredicate": "bool Function(Route<dynamic> route)",
  "RoutePresentationCallback":
      "String Function(NavigatorState navigator,   Object? arguments)",
  "RouteTransitionsBuilder":
      "Widget Function(BuildContext context,   Animation<double> animation,   Animation<double> secondaryAnimation,   Widget child)",
  "SchedulingStrategy":
      "bool Function({ required int priority,   required SchedulerBinding scheduler })",
  "ScrollIncrementCalculator":
      "double Function(ScrollIncrementDetails details)",
  "ScrollNotificationCallback":
      "void Function(ScrollNotification notification)",
  "ScrollNotificationPredicate":
      "bool Function(ScrollNotification notification)",
  "ScrollableWidgetBuilder":
      "Widget Function( BuildContext context,   ScrollController scrollController,   )",
  "SearchAnchorChildBuilder":
      "Widget Function(BuildContext context,   SearchController controller)",
  "SelectableDayPredicate": "bool Function(DateTime day)",
  "SelectableRegionContextMenuBuilder":
      "Widget Function( BuildContext context,   SelectableRegionState selectableRegionState,   )",
  "SelectionChangedCallback":
      "void Function(TextSelection selection,   SelectionChangedCause? cause)",
  "SemanticFormatterCallback": "String Function(double value)",
  "SemanticIndexCallback": "int? Function(Widget widget,   int localIndex)",
  "SemanticsActionCallback":
      "void Function(int nodeId,   SemanticsAction action,   ByteData? args)",
  "SemanticsActionHandler": "void Function(Object? args)",
  "SemanticsBuilderCallback":
      "List<CustomPainterSemantics> Function(Size size)",
  "SemanticsNodeVisitor": "bool Function(SemanticsNode node)",
  "SemanticsUpdateCallback": "void Function(ui.SemanticsUpdate update)",
  "ServiceExtensionCallback":
      "Future<Map<String,   dynamic>> Function(Map<String,   String> parameters)",
  "SetSelectionHandler": "void Function(TextSelection selection)",
  "SetTextHandler": "void Function(String text)",
  "ShaderCallback": "Shader Function(Rect bounds)",
  "ShaderWarmUpImageCallback": "bool Function(Image)",
  "ShaderWarmUpPictureCallback": "bool Function(Picture)",
  "SharedAppDataInitCallback": "T Function()",
  "SliverHitTest":
      "bool Function(SliverHitTestResult result,   { required double mainAxisPosition,   required double crossAxisPosition })",
  "SliverLayoutWidgetBuilder":
      "Widget Function(BuildContext context,   SliverConstraints constraints)",
  "StackTraceDemangler": "StackTrace Function(StackTrace details)",
  "StateSetter": "void Function(VoidCallback fn)",
  "StatefulWidgetBuilder":
      "Widget Function(BuildContext context,  StateSetter setState)",
  "StepIconBuilder": "Widget? Function(int stepIndex,   StepState stepState)",
  "SuggestionsBuilder":
      "Iterable<Widget> Function(BuildContext context,   SearchController controller)",
  "SystemUiChangeCallback":
      "Future<void> Function(bool systemOverlaysAreVisible)",
  "TapRegionCallback": "void Function(PointerDownEvent event)",
  "TargetImageSizeCallback":
      "TargetImageSize Function( int intrinsicWidth,   int intrinsicHeight,   )",
  "TaskCallback": "FutureOr<T> Function()",
  "TickerCallback": "void Function(Duration elapsed)",
  "TimingsCallback": "void Function(List<FrameTiming> timings)",
  "ToolbarBuilder": "Widget Function(BuildContext context,   Widget child)",
  "TooltipTriggeredCallback": "void Function()",
  "TransitionBuilder":
      "Widget Function( BuildContext context,   Widget? child)",
  "TweenConstructor": "Tween<T> Function(T targetValue)",
  "TweenVisitor":
      "Tween<T>? Function(Tween<T>? tween,   T targetValue,   TweenConstructor<T> constructor)",
  "UntilPredicate": "bool Function(int offset,   bool forward)",
  "ValueChanged": "void Function(T value)",
  "ValueGetter": "T Function()",
  "ValueListenableTransformer": "T Function(T)",
  "ValueSetter": "void Function(T value)",
  "ValueWidgetBuilder":
      "Widget Function(BuildContext context,   T value,   Widget? child)",
  "ViewBuilder": "Widget Function(Iterable<Widget> suggestions)",
  "ViewportBuilder":
      "Widget Function(BuildContext context,   ViewportOffset position)",
  "VoidCallback": "void Function()",
  "WidgetBuilder": "Widget Function(BuildContext context)",
  "WillPopCallback": "Future<bool> Function()",
};
