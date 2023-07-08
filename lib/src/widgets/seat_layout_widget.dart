import 'package:book_my_seat/src/model/seat_layout_state_model.dart';
import 'package:book_my_seat/src/model/seat_model.dart';
import 'package:book_my_seat/src/utils/seat_state.dart';
import 'package:book_my_seat/src/widgets/seat_widget.dart';
import 'package:flutter/material.dart';

class SeatLayoutWidget extends StatelessWidget {
  final SeatLayoutStateModel stateModel;
  final void Function(int rowI, int colI,int SeatNo, SeatState currentState)
      onSeatStateChanged;

   SeatLayoutWidget({
    Key? key,
    required this.stateModel,
    required this.onSeatStateChanged,
  }) : super(key: key);
  int seatNo = 0;
  @override
  Widget build(BuildContext context) {

    return Column(


      children: [
        ...List<int>.generate(

            stateModel.rows, (rowI) => rowI)
            .map<Row>(
              (rowI) => Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ...List<int>.generate(stateModel.cols, (colI) => colI)
                      .map<SeatWidget>((colI) => SeatWidget(
                            model: SeatModel(
                              seatState: stateModel.currentSeatsState[rowI]
                                  [colI],
                              rowI: rowI,
                              colI: colI,
                              seatNum: seatNoFunc(stateModel.currentSeatsState[rowI]
                              [colI]) ,
                              seatSvgSize: stateModel.seatSvgSize,
                              pathSelectedSeat: stateModel.pathSelectedSeat,
                              pathDisabledSeat: stateModel.pathDisabledSeat,
                              pathSoldSeat: stateModel.pathSoldSeat,
                              pathSoldSeatMale: stateModel.pathSoldSeatMale,
                              pathSoldSeatFemale: stateModel.pathSoldSeatFemale,
                              pathUnSelectedSeat: stateModel.pathUnSelectedSeat,
                            ),
                            onSeatStateChanged: onSeatStateChanged,
                          ))
                      .toList()
                ],
              ),
            )
            .toList()
      ],
    );
  }

  int? seatNoFunc(SeatState state){
    if(state != SeatState.empty){
      seatNo = seatNo +1;
      return seatNo;

    }else{
      return null;
    }
  }
}
