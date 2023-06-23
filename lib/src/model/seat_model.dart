import 'package:book_my_seat/src/utils/seat_state.dart';
import 'package:equatable/equatable.dart';

class SeatModel extends Equatable {
  final SeatState seatState;
  final int rowI;
  final int colI;
  final int seatSvgSize;
  final int selectedSeats;
  final int passengers;
  final String pathSelectedSeat;
  final String pathUnSelectedSeat;
  final String pathSoldSeat;
  final String pathSoldSeatMale;
  final String pathSoldSeatFemale;
  final String pathDisabledSeat;

  const SeatModel({
    required this.seatState,
    required this.rowI,
    required this.colI,
    required this.selectedSeats,
    required this.passengers,
    this.seatSvgSize = 50,
    required this.pathSelectedSeat,

    required this.pathDisabledSeat,
    required this.pathSoldSeat,
    required this.pathSoldSeatMale,
    required this.pathSoldSeatFemale,
    required this.pathUnSelectedSeat,
  });

  @override
  List<Object?> get props => [
        seatState,
        rowI,
        colI,
    selectedSeats,
    passengers,
        seatSvgSize,
        pathSelectedSeat,
        pathDisabledSeat,
    pathSoldSeatMale,
    pathSoldSeatFemale,
        pathSoldSeat,
        pathUnSelectedSeat,
      ];
}
