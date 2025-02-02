import 'package:book_my_seat/src/model/seat_model.dart';
import 'package:book_my_seat/src/utils/seat_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SeatWidget extends StatefulWidget {
  final SeatModel model;
  final void Function(int rowI, int colI,int seatNo, SeatState currentState)
      onSeatStateChanged;

  const SeatWidget({
    Key? key,
    required this.model,
    required this.onSeatStateChanged,
  }) : super(key: key);

  @override
  State<SeatWidget> createState() => _SeatWidgetState();
}

class _SeatWidgetState extends State<SeatWidget> {
  SeatState? seatState;
  int rowI = 0;
  int colI = 0;
  int? maxSelected;
  int? selectedSeats;
  int? seatNo = 0;
  late SharedPreferences prefs;
  @override
  void initState() {
    super.initState();
    seatState = widget.model.seatState;
    rowI = widget.model.rowI;
    colI = widget.model.colI;
    seatNo = widget.model.seatNum;
    getSeatCount();
  }

  getSeatCount() async {
     prefs = await SharedPreferences.getInstance();
     maxSelected = prefs.getInt("maxSelected");
     selectedSeats = prefs.getInt("selectedSeats");
  }
  @override
  Widget build(BuildContext context) {
    final safeCheckedSeatState = seatState;
    if (safeCheckedSeatState != null) {
      return GestureDetector(
        onTapUp: (_) async {
          await getSeatCount();
          print('$maxSelected $selectedSeats llllllllllllllkk');

            switch (seatState) {
              case SeatState.selected:
                {
                  getSeatCount();
                  setState(()  {
                    seatState = SeatState.unselected;
                    widget.onSeatStateChanged(rowI, colI,seatNo!, SeatState.unselected);
                    prefs.setInt("selectedSeats", selectedSeats!-1);
                  });
                }
                break;
              case SeatState.unselected:
                {
                  if(selectedSeats! <=maxSelected!-1){
                    getSeatCount();
                    setState(()  {
                      seatState = SeatState.selected;
                      widget.onSeatStateChanged(rowI, colI,seatNo! ,SeatState.selected);

                      prefs.setInt("selectedSeats", selectedSeats!+1);
                    });
                  }else{
                    print('jjjjjjjjjjjjjjjjjj');
                }

                }
                break;
              case SeatState.disabled:
              case SeatState.sold:
              case SeatState.soldMale:
              case SeatState.soldFemale:
              case SeatState.empty:
              default:
                {}
                break;
            }


        },
        child: seatState != SeatState.empty
            ? Padding(
          padding: EdgeInsets.only(bottom: 6,left: 3,right: 3),
              child: SvgPicture.asset(
                  _getSvgPath(safeCheckedSeatState),
                  height: widget.model.seatSvgSize.toDouble(),
                  width: widget.model.seatSvgSize.toDouble(),
                  fit: BoxFit.cover,
                ),
            )
            : Padding(
          padding: EdgeInsets.only(bottom: 6,left: 3,right: 3),
              child: SizedBox(
                  height: widget.model.seatSvgSize.toDouble(),
                  width: widget.model.seatSvgSize.toDouble(),
                ),
            ),
      );
    }
    return const SizedBox();
  }



  String _getSvgPath(SeatState state) {
    switch (state) {
      case SeatState.unselected:
        {
          return widget.model.pathUnSelectedSeat;
        }
      case SeatState.selected:
        {
          return widget.model.pathSelectedSeat;
        }
      case SeatState.disabled:
        {
          return widget.model.pathDisabledSeat;
        }
      case SeatState.sold:
        {
          return widget.model.pathSoldSeat;
        }
      case SeatState.soldFemale:
        {
          return widget.model.pathSoldSeatFemale;
        }
      case SeatState.soldMale:
        {
          return widget.model.pathSoldSeatMale;
        }
      case SeatState.empty:
      default:
        {
          return widget.model.pathDisabledSeat;
        }
    }
  }
}
