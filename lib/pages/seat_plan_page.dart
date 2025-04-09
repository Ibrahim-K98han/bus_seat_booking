import 'package:bus_reservation_flutter_starter/customwidgets/seat_plan_view.dart';
import 'package:bus_reservation_flutter_starter/models/bus_schedule.dart';
import 'package:bus_reservation_flutter_starter/providers/app_data_provider.dart';
import 'package:bus_reservation_flutter_starter/utils/colors.dart';
import 'package:bus_reservation_flutter_starter/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SeatPlanPage extends StatefulWidget {
  const SeatPlanPage({super.key});

  @override
  State<SeatPlanPage> createState() => _SeatPlanPageState();
}

class _SeatPlanPageState extends State<SeatPlanPage> {
  late BusSchedule schedule;
  late String departureDate;
  int totalSeatBooked = 0;
  String bookedSeatNumbers = '';
  List<String> selectedSeats = [];
  bool isFirst = true;
  bool isDataLoading = true;
  ValueNotifier<String> selectedSeatStringNotifier = ValueNotifier('');

  @override
  void didChangeDependencies() {
    final argList = ModalRoute.of(context)!.settings.arguments as List;
    schedule = argList[0];
    departureDate = argList[1];
    _getData();
    super.didChangeDependencies();
  }

  _getData() async {
    final resList = await Provider.of<AppDataProvider>(context, listen: false)
        .getReservationsByScheduleAndDepartureDate(
            schedule.scheduleId!, departureDate);
    List<String> seats = [];
    for (final res in resList) {
      totalSeatBooked += res.totalSeatBooked;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Seat Plan'),
      ),
      body: Center(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: Row(
                    children: [
                      Container(
                        width: 20,
                        height: 20,
                        decoration: const BoxDecoration(color: seatBookedColor),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      const Text(
                        'Booked',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: Row(
                    children: [
                      Container(
                        width: 20,
                        height: 20,
                        decoration: BoxDecoration(color: seatAvailableColor),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      const Text(
                        'Available',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            ValueListenableBuilder(
              valueListenable: selectedSeatStringNotifier,
              builder: (context, value, _) => Text(
                'Selected: $value',
                style: const TextStyle(fontSize: 16),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: SeatPlanView(
                  totalSeat: schedule.bus.totalSeat,
                  bookedSeatNumbers: bookedSeatNumbers,
                  totalSeatBooked: totalSeatBooked,
                  isBusinessClass: schedule.bus.busType == busTypeACBusiness,
                  onSeatSelected: (value, seat) {
                    if (value) {
                      selectedSeats.add(seat);
                    } else {
                      selectedSeats.remove(seat);
                    }
                    selectedSeatStringNotifier.value = selectedSeats.join(',');
                  },
                ),
              ),
            ),
            OutlinedButton(
              onPressed: () {},
              child: const Text('NEXT'),
            ),
          ],
        ),
      ),
    );
  }
}
