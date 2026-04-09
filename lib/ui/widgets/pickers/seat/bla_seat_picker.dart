import 'package:flutter/material.dart';

import '../../../theme/theme.dart';
import '../../buttons/bla_circle_button.dart';
import '../../buttons/bla_icon_button.dart';

class BlaSeatPicker extends StatefulWidget {
  const BlaSeatPicker({super.key, this.initSeats, required this.maxSeat});

  final int? initSeats;
  final int maxSeat;

  @override
  State<BlaSeatPicker> createState() => _BlaSeatPickerState();
}

class _BlaSeatPickerState extends State<BlaSeatPicker> {
  int selectedSeat = 1;

  @override
  void initState() {
    super.initState();
    if (widget.initSeats != null) {
      selectedSeat = widget.initSeats!;
    }
  }

  void increaseSeat() {
    if (selectedSeat < widget.maxSeat) {
      setState(() {
        selectedSeat = selectedSeat + 1;
      });
    }
  }

  void decreaseSeat() {
    if (selectedSeat > 1) {
      setState(() {
        selectedSeat = selectedSeat - 1;
      });
    }
  }

  void goBack() {
    Navigator.pop(context);
  }

  void submit() {
    Navigator.pop(context, selectedSeat);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(BlaSpacings.l),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Back button
            BlaIconButton(onPressed: goBack, icon: Icons.close),

            SizedBox(height: BlaSpacings.m),

            // Title
            Text(
              "Number of seats to book",
              style: BlaTextStyles.title.copyWith(color: BlaColors.textNormal),
            ),

            // Seat controls
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                BlaCircleButton(
                  icon: Icons.remove,
                  type: CircleButtonType.secondary,
                  disabled: selectedSeat == 1,
                  onPressed: decreaseSeat,
                ),

                Text(
                  "$selectedSeat",
                  style: TextStyle(
                    fontSize: 60,
                    fontWeight: FontWeight.w500,
                    color: BlaColors.textNormal,
                  ),
                ),

                BlaCircleButton(
                  icon: Icons.add,
                  type: CircleButtonType.secondary,
                  disabled: selectedSeat == widget.maxSeat,
                  onPressed: increaseSeat,
                ),
              ],
            ),

            Spacer(),

            // Submit button
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                BlaCircleButton(icon: Icons.arrow_forward, onPressed: submit),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
