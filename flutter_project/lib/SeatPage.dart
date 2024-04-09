import 'package:flutter/material.dart';

class SeatPage extends StatefulWidget {
  @override
  _SeatPageState createState() => _SeatPageState();
}

class _SeatPageState extends State<SeatPage> {
  List<String> selectedSeats = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Seat Selection'),
      ),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 10, // Number of columns
          crossAxisSpacing: 60, // Spacing between columns
          mainAxisSpacing: 60, // Spacing between rows
        ),
        itemCount: 50, // Total number of seats
        itemBuilder: (context, index) {
          // Generate seat number based on index
          String seatNumber = 'Seat ${(index + 1)}';

          // Check if the seat is selected
          bool isSelected = selectedSeats.contains(seatNumber);

          return GestureDetector(
            onTap: () {
              setState(() {
                // Toggle seat selection
                if (isSelected) {
                  selectedSeats.remove(seatNumber);
                } else {
                  selectedSeats.add(seatNumber);
                }
              });
            },
            child: Container(
              decoration: BoxDecoration(
                color: isSelected ? Colors.blue : Colors.grey, // Change color based on selection
                borderRadius: BorderRadius.circular(5.0),
              ),
              alignment: Alignment.center,
              child: Text(
                seatNumber,
                style: TextStyle(color: Colors.white),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Perform booking or further action with selectedSeats list
          print('Selected Seats: $selectedSeats');
        },
        child: Icon(Icons.check),
      ),
    );
  }
}