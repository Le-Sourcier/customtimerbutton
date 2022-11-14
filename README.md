<!--
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/guides/libraries/writing-package-pages).

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-library-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/developing-packages).
-->

## Example
there are a number of properties that you can modify

- color
- disabledColor,
- buttonType
- activeTextStyle,
- disabledTextStyle
- borderRadius,
- textAlign,
- shape,
- elevation <!-- default elevation is 2 -->
- width,
- height,

<hr>

<table>
<tr>
<td>


```dart
class TimerButton extends StatelessWidget {
  const TimerButton({
    Key? key,
    required String label,
    required TextAlign textAlign,
    required String disabledLabel,
    required Color color,
    ShapeBorder? shape,
    double? width,
    required int height,
    required int timeOutInSeconds,
    required int elevation,
    BorderRadius? borderRadius,
    required void Function() onPressed,
    required TextStyle disabledTextStyle,
    required TextStyle activeTextStyle,
    required ButtonType buttonType,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Timer Button'),
      ),
      body: Center(
        child: ctmTimeButtom(
            text: 'Resend verification mail',
            disableText: 'Resend in',
            width: size(context).width * 0.53,
            onPressed: () {},
            time: 180,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    bottomLeft: Radius.circular(20))),
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20), bottomLeft: Radius.circular(20))),
      ),
    );
  }

  // custom Timeer button
  Widget ctmTimeButtom({
    required final String text,
    required final String disableText,
    final Color? color,
    required void Function() onPressed,
    final BorderRadius? borderRadius,
    final double? width,
    final ShapeBorder? shape,
    final double? elevation,
    int? time,
  }) {
    return TimerButton(
      label: text,
      textAlign: TextAlign.center,
      disabledLabel: disableText,
      color: color ?? Colors.red,
      shape: shape,
      width: width,
      height: 55,
      timeOutInSeconds: time ?? 5,
      elevation: 18,
      borderRadius: borderRadius,
      onPressed: onPressed,
      disabledTextStyle: const TextStyle(
        fontSize: 17,
        color: Colors.black38,
        fontWeight: FontWeight.bold,
      ),
      activeTextStyle: const TextStyle(
        color: Colors.white,
        fontSize: 17,
        fontWeight: FontWeight.bold,
      ),
      buttonType: ButtonType.CupertinoButton,
    );
  }
}

```
</td>
<td>
<img src="">
</td>
</tr>
</table>
