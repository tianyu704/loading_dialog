import 'package:flutter/material.dart';

///
/// Create by Hugo.Guo
/// Date: 2019-06-14
///

enum LoadingDialogStyle { horizontal, vertical }

class LoadingDialog {
  BuildContext _context;

  /// 是否显示
  bool _isShowing = false;

  /// BuildContext
  final BuildContext buildContext;

  /// loading view
  final Widget loadingView;

  /// loading的背景色
  final Color backgroundColor;

  /// 窗口颜色
  Color barrierColor;

  /// 空白点击是否消失
  final barrierDismissible;

  /// loading样式
  final LoadingDialogStyle style;

  /// dialog width
  final double width;

  /// dialog height
  final double height;

  /// loading大小
  final double size;

  /// loading message
  final String loadingMessage;

  /// Message字体大小
  final double textSize;

  /// Message字色
  final Color textColor;

  /// Message和loading的间距
  final double padding;

  /// 弹框的elevation
  final double elevation;

  /// 圆角
  final double radius;

  LoadingDialog({
    @required this.buildContext,
    this.loadingView ,
    this.loadingMessage = "Loading...",
    this.backgroundColor = Colors.white,
    this.barrierColor = Colors.black54,
    this.barrierDismissible = false,
    this.style,
    this.size = 40,
    this.width = 120,
    this.height = 120.0,
    this.textSize = 16.0,
    this.textColor = Colors.black54,
    this.padding = 10.0,
    this.elevation = 0.0,
    this.radius = 8.0,
  }) {
    if (barrierColor == Colors.transparent) {
      barrierColor = Color(0x00000001);
    }
  }

  bool isShowing() {
    return _isShowing;
  }

  void hide() {
    if (_isShowing) {
      _isShowing = false;
      Navigator.of(_context).pop();
    }
  }

  void show() {
    if (!_isShowing) {
      _isShowing = true;
      showDialog<dynamic>(
        context: buildContext,
        barrierDismissible: barrierDismissible,
        barrierColor: barrierColor,
        builder: (BuildContext context) {
          _context = context;
          return _Dialog(
            backgroundColor: backgroundColor,
            insetAnimationCurve: Curves.easeInOut,
            insetAnimationDuration: Duration(milliseconds: 100),
            elevation: elevation,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(radius))),
            child: SizedBox(
              width: width,
              height: height,
              child: style == LoadingDialogStyle.horizontal
                  ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  _buildLoadingView(context),
                  _buildTextView(),
                ],
              )
                  : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  _buildLoadingView(context),
                  _buildTextView(),
                ],
              ),
            ),
          );
        },
      );
    }
  }

  ///loadingView为null时默认系统的loading
  Widget _buildLoadingView(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: loadingView ??
          CircularProgressIndicator(),
    );
  }

  Widget _buildTextView() {
    return Offstage(
      offstage: loadingMessage == null,
      child: Padding(
        padding: EdgeInsets.only(top: padding),
        child: Text(
          loadingMessage ?? "",
          style: TextStyle(
            color: textColor,
            fontSize: textSize,
          ),
        ),
      ),
    );
  }
}

///
/// 以下为原生的Dialog做了部分修改
/// minWidth: 40.0, minHeight: 40
/// EdgeInsets.symmetric(horizontal: 24.0, vertical: 24.0)
///
class _Dialog extends StatelessWidget {
  /// Creates a dialog.
  ///
  /// Typically used in conjunction with [showDialog].
  const _Dialog({
    Key key,
    this.backgroundColor,
    this.elevation,
    this.insetAnimationDuration = const Duration(milliseconds: 100),
    this.insetAnimationCurve = Curves.decelerate,
    this.shape,
    this.child,
  }) : super(key: key);

  /// {@template flutter.material.dialog.backgroundColor}
  /// The background color of the surface of this [_Dialog].
  ///
  /// This sets the [Material.color] on this [_Dialog]'s [Material].
  ///
  /// If `null`, [ThemeData.cardColor] is used.
  /// {@endtemplate}
  final Color backgroundColor;

  /// {@template flutter.material.dialog.elevation}
  /// The z-coordinate of this [_Dialog].
  ///
  /// If null then [DialogTheme.elevation] is used, and if that's null then the
  /// dialog's elevation is 24.0.
  /// {@endtemplate}
  /// {@macro flutter.material.material.elevation}
  final double elevation;

  /// The duration of the animation to show when the system keyboard intrudes
  /// into the space that the dialog is placed in.
  ///
  /// Defaults to 100 milliseconds.
  final Duration insetAnimationDuration;

  /// The curve to use for the animation shown when the system keyboard intrudes
  /// into the space that the dialog is placed in.
  ///
  /// Defaults to [Curves.fastOutSlowIn].
  final Curve insetAnimationCurve;

  /// {@template flutter.material.dialog.shape}
  /// The shape of this dialog's border.
  ///
  /// Defines the dialog's [Material.shape].
  ///
  /// The default shape is a [RoundedRectangleBorder] with a radius of 2.0.
  /// {@endtemplate}
  final ShapeBorder shape;

  /// The widget below this widget in the tree.
  ///
  /// {@macro flutter.widgets.child}
  final Widget child;

  // TODO(johnsonmh): Update default dialog border radius to 4.0 to match material spec.
  static const RoundedRectangleBorder _defaultDialogShape =
  RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(2.0)));
  static const double _defaultElevation = 24.0;

  @override
  Widget build(BuildContext context) {
    final DialogTheme dialogTheme = DialogTheme.of(context);
    return AnimatedPadding(
      padding: MediaQuery.of(context).viewInsets +
          const EdgeInsets.symmetric(horizontal: 24.0, vertical: 24.0),
      duration: insetAnimationDuration,
      curve: insetAnimationCurve,
      child: MediaQuery.removeViewInsets(
        removeLeft: true,
        removeTop: true,
        removeRight: true,
        removeBottom: true,
        context: context,
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(minWidth: 40.0, minHeight: 40),
            child: Material(
              color: backgroundColor ??
                  dialogTheme.backgroundColor ??
                  Theme.of(context).dialogBackgroundColor,
              elevation:
              elevation ?? dialogTheme.elevation ?? _defaultElevation,
              shape: shape ?? dialogTheme.shape ?? _defaultDialogShape,
              type: MaterialType.card,
              child: child,
            ),
          ),
        ),
      ),
    );
  }
}

///
/// 修改了show方法
/// 添加barrierColor改变透明背景的颜色
///
Future<T> showDialog<T>({
  @required
  BuildContext context,
  bool barrierDismissible = true,
  Color barrierColor,
  @Deprecated(
      'Instead of using the "child" argument, return the child from a closure '
          'provided to the "builder" argument. This will ensure that the BuildContext '
          'is appropriate for widgets built in the dialog.')
  Widget child,
  WidgetBuilder builder,
}) {
  assert(child == null || builder == null);
  assert(debugCheckHasMaterialLocalizations(context));

  final ThemeData theme = Theme.of(context, shadowThemeOnly: true);
  return showGeneralDialog(
    context: context,
    pageBuilder: (BuildContext buildContext, Animation<double> animation,
        Animation<double> secondaryAnimation) {
      final Widget pageChild = child ?? Builder(builder: builder);
      return SafeArea(
        child: Builder(builder: (BuildContext context) {
          return theme != null
              ? Theme(data: theme, child: pageChild)
              : pageChild;
        }),
      );
    },
    barrierDismissible: barrierDismissible,
    barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
    barrierColor: barrierColor,
    transitionDuration: const Duration(milliseconds: 150),
    transitionBuilder: _buildMaterialDialogTransitions,
  );
}

Widget _buildMaterialDialogTransitions(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child) {
  return FadeTransition(
    opacity: CurvedAnimation(
      parent: animation,
      curve: Curves.easeOut,
    ),
    child: child,
  );
}
