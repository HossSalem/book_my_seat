import 'package:book_my_seat/src/model/seat_layout_state_model.dart';
import 'package:book_my_seat/src/model/seat_model.dart';
import 'package:book_my_seat/src/utils/seat_state.dart';
import 'package:book_my_seat/src/widgets/seat_widget.dart';
import 'package:flutter/material.dart';

class SeatLayoutWidget extends StatelessWidget {
  final SeatLayoutStateModel stateModel;
  final void Function(int rowI, int colI,int selectedSeats,int passengers,  SeatState currentState)
      onSeatStateChanged;

  const SeatLayoutWidget({
    Key? key,
    required this.stateModel,
    required this.onSeatStateChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InteractiveViewer(
      maxScale: 5,
      minScale: 0.8,
      boundaryMargin: const EdgeInsets.all(8),
      constrained: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ...List<int>.generate(

              stateModel.rows, (rowI) => rowI)
              .map<Row>(
                (rowI) => Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ...List<int>.generate(stateModel.cols, (colI) => colI)
                        .map<SeatWidget>((colI) => SeatWidget(
                              model: SeatModel(
                                seatState: stateModel.currentSeatsState[rowI]
                                    [colI],
                                rowI: rowI,
                                colI: colI,
                                selectedSeats: stateModel.selectedSeats,
                                passengers: stateModel.passengers,
                                seatSvgSize: stateModel.seatSvgSize,
                                pathSelectedSeat: stateModel.pathSelectedSeat,
                                pathDisabledSeat: stateModel.pathDisabledSeat,
                                pathSoldSeat: stateModel.pathSoldSeat,
                                pathSoldSeatMale: stateModel.pathSoldSeatMale,
                                pathSoldSeatFemale: stateModel.pathSoldSeatFemale,
                                pathUnSelectedSeat:
                                    stateModel.pathUnSelectedSeat,
                              ),
                              onSeatStateChanged: onSeatStateChanged,
                            ))
                        .toList()
                  ],
                ),
              )
              .toList()
        ],
      ),
    );
  }
}
