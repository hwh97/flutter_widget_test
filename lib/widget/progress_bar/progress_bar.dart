import 'package:flutter/material.dart';

class ProgressBar extends StatefulWidget {
  final double progress;
  final Color backgroundColor;
  final Color foregroundColor;
  final double maxProgress;
  final double minProgress;
  final int animationTime;
  final double radius;
  final double width;
  final double height;

  const ProgressBar({Key key, this.progress=0, this.backgroundColor=Colors.grey, this.foregroundColor=Colors.blueAccent, this.minProgress=0,
    this.maxProgress=100, this.animationTime=300, this.radius=10, this.width=120, this.height=40}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return new ProgressBarState(progress, backgroundColor, foregroundColor, minProgress,
        maxProgress, animationTime, radius, width, height);
  }
}

class ProgressBarState extends State<ProgressBar> with SingleTickerProviderStateMixin {
  double progress;
  Color backgroundColor;
  Color foregroundColor;
  double minProgress;
  double maxProgress;
  int animationTime;
  double radius;
  double width;
  double height;
  AnimationController _animationController;
  Animation<double> _animation;

  ProgressBarState(this.progress, this.backgroundColor, this.foregroundColor, this.minProgress,
      this.maxProgress, this.animationTime, this.radius, this.width, this.height);

  @override
  Widget build(BuildContext context) {
    return new Stack(
      children: <Widget>[
        new Container(
            width:  width,
            height: height,
            foregroundDecoration: new BoxDecoration(

            ),
            decoration: new BoxDecoration(
              color: backgroundColor,
              borderRadius: new BorderRadius.all(new Radius.circular(radius)),
            )
        ),
       AnimatedBuilder(
           animation: _animation,
           builder: (ctx, child) {
             return new Container(
//                 margin: new EdgeInsets.only(right:  width),
                 width: _animation.value / maxProgress * width,
                 height: height,
                 decoration: new BoxDecoration(
                   color: foregroundColor,
                   borderRadius: new BorderRadius.all(new Radius.circular(radius)),
                 )
             );
           }
       )
      ],
    );
  }

  @override
  void initState() {
    super.initState();
    _animationController = new AnimationController(duration: new Duration(milliseconds: animationTime), vsync: this);
    if (progress != null) {
      _animation = Tween(begin: minProgress, end: progress).animate(_animationController);
      _animationController.forward();
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void setProgress(double newProgress) {
    _animation = Tween(begin: progress, end: newProgress).animate(_animationController);
    progress = newProgress;
    _animationController.forward();
  }


}