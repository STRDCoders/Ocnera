import 'dart:ui';

import 'package:flutter/animation.dart';

class AnimationImpl {
  AnimationController _infoAnimationController;
  Animation<Offset> _infoAnimation;
  Tween<Offset> _infoTween ;

  AnimationImpl(this._infoAnimationController, Tween<Offset> animation) {
    infoTween = animation;
  }

  set infoTween(Tween<Offset> value) {
    _infoTween = value;
    _infoAnimation = _infoTween.animate(CurvedAnimation(
      parent: _infoAnimationController,
      curve: Curves.easeIn,
    ));
  }


  AnimationController get infoAnimationController => _infoAnimationController;

  Animation<Offset> get infoAnimation => _infoAnimation;

  factory AnimationImpl.clean(AnimationController controller) {
    return AnimationImpl(controller, Tween<Offset>(
      begin: Offset(0.0, 10000.0),
      end: Offset(0.0, 0.0),
    ));
  }

  void dispose() {
    _infoAnimationController.dispose();
  }

}
