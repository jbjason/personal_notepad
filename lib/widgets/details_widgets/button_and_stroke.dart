import 'package:flutter/material.dart';
import 'package:personal_notepad/widgets/common_widgets/buttonBlack.dart';

class ButtonAndStroke extends StatelessWidget {
  const ButtonAndStroke(
      {Key? key,
      required this.selectColor,
      required this.clearCanvas,
      required this.changeStrokeWidth,
      required this.selectedColor,
      required this.strokeWidth,
      required this.isPaint})
      : super(key: key);
  final Function selectColor, clearCanvas;
  final Function changeStrokeWidth;
  final Color selectedColor;
  final double strokeWidth;
  final bool isPaint;

  @override
  Widget build(BuildContext context) {
    return isPaint
        ? NeumorphismButtonBlack(
            boxShape: BoxShape.rectangle,
            padding: 3.0,
            widget: Row(
              children: [
                IconButton(
                    onPressed: () => selectColor(),
                    icon: Icon(Icons.color_lens, color: selectedColor)),
                Expanded(
                  child: Slider(
                    min: 3.0,
                    max: 10.0,
                    activeColor: selectedColor,
                    value: strokeWidth,
                    onChanged: (val) => changeStrokeWidth(val),
                  ),
                ),
                IconButton(
                  onPressed: () => clearCanvas(),
                  icon: Icon(Icons.layers_clear, color: selectedColor),
                ),
              ],
            ),
          )
        : Container();
  }
}
