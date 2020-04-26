import 'package:flutter/cupertino.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

PageController usePageController({
  int initialPage,
  bool keepPage,
  double viewportFraction,
  List<Object> keys,
}) =>
    Hook.use(_PageControllerHook(
      initialPage,
      keepPage,
      viewportFraction,
      keys,
    ));

class _PageControllerHook extends Hook<PageController> {
  final int initialPage;
  final bool keepPage;
  final double viewportFraction;
  const _PageControllerHook(
    this.initialPage,
    this.keepPage,
    this.viewportFraction, [
    List<Object> keys,
  ]) : super(keys: keys);

  @override
  _PageControllerHookState createState() {
    return _PageControllerHookState();
  }
}

class _PageControllerHookState
    extends HookState<PageController, _PageControllerHook> {
  PageController _pageController;

  @override
  void initHook() {
    super.initHook();
    PageController(
      initialPage: hook.initialPage,
      keepPage: hook.keepPage,
      viewportFraction: hook.viewportFraction,
    );
  }

  @override
  PageController build(BuildContext context) => _pageController;

  @override
  void dispose() => _pageController?.dispose();
}
