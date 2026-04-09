import '/ui/widgets/buttons/bla_button.dart';
import '/ui/widgets/display/bla_divider.dart';
import 'package:flutter/material.dart';

import '../../../../model/ride/locations.dart';
import '../../../../model/ride_pref/ride_pref.dart';
import '../../../../services/ride_prefs_service.dart';
import '../../../../utils/animations_util.dart';
import '../../../../utils/date_time_utils.dart';
import '../../../theme/theme.dart';
import '../../buttons/bla_icon_button.dart';
import '../location/bla_location_picker.dart';
import '../seat/bla_seat_picker.dart';

class BlaRidePreferencePicker extends StatefulWidget {
  final RidePreference? initRidePreference;

  const BlaRidePreferencePicker({
    super.key,
    this.initRidePreference,
    required this.onRidePreferenceSelected,
  });

  final ValueChanged<RidePreference> onRidePreferenceSelected;

  @override
  State<BlaRidePreferencePicker> createState() =>
      _BlaRidePreferencePickerState();
}

class _BlaRidePreferencePickerState extends State<BlaRidePreferencePicker> {
  Location? departure;
  Location? arrival;
  late DateTime departureDate;
  late int requestedSeats;

  @override
  void initState() {
    super.initState();
    final pref = widget.initRidePreference;

    departure = pref?.departure;
    arrival = pref?.arrival;
    departureDate = pref?.departureDate ?? DateTime.now();
    requestedSeats = pref?.requestedSeats ?? 1;
  }

  // -------------------------
  // Helpers
  // -------------------------
  Future openPicker(Widget page, Route route) {
    return Navigator.of(context).push(route);
  }

  void updateState(VoidCallback fn) => setState(fn);

  // -------------------------
  // Actions
  // -------------------------
  Future<void> onDeparturePressed() async {
    final result = await openPicker(
      BlaLocationPicker(initLocation: departure),
      AnimationUtils.createBottomToTopRoute(
        BlaLocationPicker(initLocation: departure),
      ),
    );

    if (result != null) updateState(() => departure = result);
  }

  Future<void> onArrivalPressed() async {
    final result = await openPicker(
      BlaLocationPicker(initLocation: arrival),
      AnimationUtils.createBottomToTopRoute(
        BlaLocationPicker(initLocation: arrival),
      ),
    );

    if (result != null) updateState(() => arrival = result);
  }

  Future<void> onSeatNumberPressed() async {
    final result = await openPicker(
      BlaSeatPicker(
        initSeats: requestedSeats,
        maxSeat: RidePrefsService.maxAllowedSeats,
      ),
      AnimationUtils.createRightToLeftRoute(
        BlaSeatPicker(
          initSeats: requestedSeats,
          maxSeat: RidePrefsService.maxAllowedSeats,
        ),
      ),
    );

    if (result != null && result != requestedSeats) {
      updateState(() => requestedSeats = result);
    }
  }

  void onSearch() {
    if (departure == null || arrival == null) return;

    widget.onRidePreferenceSelected(
      RidePreference(
        departure: departure!,
        departureDate: departureDate,
        arrival: arrival!,
        requestedSeats: requestedSeats,
      ),
    );
  }

  void onSwappingLocationPressed() {
    if (departure == null && arrival == null) return;

    updateState(() {
      final temp = departure;
      departure = arrival != null ? Location.copy(arrival!) : null;
      arrival = temp != null ? Location.copy(temp) : null;
    });
  }

  // -------------------------
  // Getters
  // -------------------------
  String get departureLabel => departure?.name ?? "Leaving from";
  String get arrivalLabel => arrival?.name ?? "Going to";
  String get dateLabel => DateTimeUtils.formatDateTime(departureDate);
  String get numberLabel => "$requestedSeats";

  bool get showDeparturePLaceHolder => departure == null;
  bool get showArrivalPLaceHolder => arrival == null;
  bool get switchVisible => departure != null || arrival != null;

  // -------------------------
  // UI
  // -------------------------
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: BlaSpacings.m),
          child: Column(
            children: [
              RidePrefInput(
                isPlaceHolder: showDeparturePLaceHolder,
                title: departureLabel,
                leftIcon: Icons.location_on,
                onPressed: onDeparturePressed,
                rightIcon: switchVisible ? Icons.swap_vert : null,
                onRightIconPressed: switchVisible
                    ? onSwappingLocationPressed
                    : null,
              ),
              const BlaDivider(),

              RidePrefInput(
                isPlaceHolder: showArrivalPLaceHolder,
                title: arrivalLabel,
                leftIcon: Icons.location_on,
                onPressed: onArrivalPressed,
              ),
              const BlaDivider(),

              RidePrefInput(
                title: dateLabel,
                leftIcon: Icons.calendar_month,
                onPressed: () {},
              ),
              const BlaDivider(),

              RidePrefInput(
                title: numberLabel,
                leftIcon: Icons.person_2_outlined,
                onPressed: onSeatNumberPressed,
              ),
            ],
          ),
        ),

        BlaButton(text: 'Search', onPressed: onSearch),
      ],
    );
  }
}

class RidePrefInput extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;
  final IconData leftIcon;
  final bool isPlaceHolder;
  final IconData? rightIcon;
  final VoidCallback? onRightIconPressed;

  const RidePrefInput({
    super.key,
    required this.title,
    required this.onPressed,
    required this.leftIcon,
    this.rightIcon,
    this.onRightIconPressed,
    this.isPlaceHolder = false,
  });

  @override
  Widget build(BuildContext context) {
    final color = isPlaceHolder ? BlaColors.textLight : BlaColors.textNormal;

    return ListTile(
      onTap: onPressed,
      title: Text(
        title,
        style: BlaTextStyles.button.copyWith(fontSize: 14, color: color),
      ),
      leading: Icon(leftIcon, size: BlaSize.icon, color: BlaColors.iconLight),
      trailing: rightIcon != null
          ? BlaIconButton(icon: rightIcon, onPressed: onRightIconPressed)
          : null,
    );
  }
}
