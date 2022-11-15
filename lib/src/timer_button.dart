// ignore_for_file: constant_identifier_names

import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum ButtonType {
  MaterialButton,
  CupertinoButton,
  ElevatedButton,
  TextButton,
  OutlinedButton
}

const int aSec = 1;

const String _secPostFix = 's';
const String labelSplitter = " |  ";

class CustomTimerButton extends StatefulWidget {
  /// Create a CustomTimerButton button.
  ///
  /// The [label], [onPressed], and [timeOutInSeconds]
  /// arguments must not be null.

  ///label
  final String label;

  ///disable label
  final String? disabledLabel;

  ///secPostFix
  final String secPostFix;

  ///[timeOutInSeconds] after which the button is enabled
  final int timeOutInSeconds;

  ///[onPressed] Called when the button is tapped or otherwise activated.
  final VoidCallback onPressed;

  /// Defines the button's base colors
  final Color? color;

  /// The color to use for this button's background/border when the button is disabled.
  final Color disabledColor;

  /// activeTextStyle
  final TextStyle? activeTextStyle;

  /// Button Style
  final ButtonStyle? btnStyle;

  /// text alignement
  final TextAlign? textAlign;

  ///disabledTextStyle
  final TextStyle disabledTextStyle;

  ///buttonType
  final ButtonType buttonType;

  ///If resetTimerOnPressed is true reset the timer when the button is pressed : default to true
  final bool resetTimerOnPressed;

  /// button radius
  final BorderRadius? borderRadius;

  ///shape button
  final ShapeBorder? shape;

  ///elevation
  final double? elevation;

  /// width
  final double? width;

  ///height
  final double? height;

  ///Button controller
  final MaterialStatesController? statesController;

  const CustomTimerButton({
    Key? key,
    required this.label,
    this.disabledLabel,
    required this.onPressed,
    required this.timeOutInSeconds,
    this.secPostFix = _secPostFix,
    this.color = Colors.blue,
    this.resetTimerOnPressed = true,
    this.disabledColor = Colors.grey,
    this.buttonType = ButtonType.MaterialButton,
    this.activeTextStyle,
    this.disabledTextStyle = const TextStyle(color: Colors.black45),
    this.borderRadius,
    this.textAlign,
    this.shape,
    this.elevation = 2,
    this.width,
    this.height,
    this.statesController,
    this.btnStyle,
  }) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _CustomTimerButtonState createState() => _CustomTimerButtonState();
}

class _CustomTimerButtonState extends State<CustomTimerButton> {
  bool timeUpFlag = false;
  int timeCounter = 0;

  String get _timerText => '$timeCounter${widget.secPostFix}';

  @override
  void initState() {
    super.initState();
    timeCounter = widget.timeOutInSeconds;
    _timerUpdate();
  }

  _timerUpdate() {
    Timer(const Duration(seconds: aSec), () async {
      setState(() {
        timeCounter--;
      });
      if (timeCounter != 0) {
        _timerUpdate();
      } else {
        timeUpFlag = true;
      }
    });
  }

  Widget _buildChild() {
    TextStyle? activeTextStyle;
    if (widget.activeTextStyle == null) {
      if (widget.buttonType == ButtonType.OutlinedButton ||
          widget.buttonType == ButtonType.OutlinedButton) {
        activeTextStyle = TextStyle(color: widget.color);
      } else {
        activeTextStyle = const TextStyle(color: Colors.white);
      }
    } else {
      activeTextStyle = widget.activeTextStyle;
    }
    return Container(
      child: timeUpFlag
          ? Center(
              child: Text(
                widget.label,
                style: activeTextStyle,
                textAlign: widget.textAlign,
              ),
            )
          : Center(
              child: Text(
                '${widget.disabledLabel ?? widget.label + labelSplitter} $_timerText',
                style: widget.disabledTextStyle,
                textAlign: widget.textAlign,
              ),
            ),
    );
  }

  _onPressed() {
    if (timeUpFlag) {
      setState(() {
        timeUpFlag = false;
      });
      timeCounter = widget.timeOutInSeconds;

      widget.onPressed();

      // reset the timer when the button is pressed
      if (widget.resetTimerOnPressed) {
        _timerUpdate();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    switch (widget.buttonType) {
      case ButtonType.MaterialButton:
        return Card(
          color:
              timeUpFlag ? widget.color : widget.disabledColor.withOpacity(0.2),
          shape: widget.shape,
          child: MaterialButton(
            elevation: timeUpFlag ? widget.elevation : 0,
            disabledColor: widget.disabledColor,
            color: timeUpFlag ? widget.color : widget.disabledColor,
            onPressed: timeUpFlag ? _onPressed : null,
            child: SizedBox(
              width: widget.width,
              height: widget.height,
              child: _buildChild(),
            ),
          ),
        );

      case ButtonType.CupertinoButton:
        return CupertinoButton(
            onPressed: timeUpFlag ? _onPressed : null,
            child: Card(
              color: timeUpFlag
                  ? widget.color
                  : widget.disabledColor.withOpacity(0.2),
              elevation: timeUpFlag ? widget.elevation : 0,
              shape: widget.shape,
              child: SizedBox(
                width: widget.width,
                height: widget.height,
                child: _buildChild(),
              ),
            ));
      case ButtonType.ElevatedButton:
        return ElevatedButton(
          onPressed: timeUpFlag ? _onPressed : null,
          statesController: widget.statesController,
          style: ElevatedButton.styleFrom(
            elevation: timeUpFlag ? widget.elevation : 0,
            backgroundColor: timeUpFlag ? widget.color : widget.disabledColor,
          ),
          child: SizedBox(
            width: widget.width,
            height: widget.height,
            child: _buildChild(),
          ),
        );
      case ButtonType.TextButton:
        return SizedBox(
          width: widget.width,
          height: widget.height,
          child: TextButton(
            statesController: widget.statesController,
            onPressed: _onPressed,
            style: TextButton.styleFrom(
              backgroundColor: timeUpFlag ? widget.color : widget.disabledColor,
            ),
            child: _buildChild(),
          ),
        );
      case ButtonType.OutlinedButton:
        return SizedBox(
          width: widget.width,
          height: widget.height,
          child: Card(
            elevation: timeUpFlag ? widget.elevation : 0,
            color: Colors.transparent,
            child: OutlinedButton(
              statesController: widget.statesController,
              onPressed: timeUpFlag ? _onPressed : null,
              style: widget.btnStyle,
              child: _buildChild(),
            ),
          ),
        );
      default:
        return Container();
    }
  }
}
