
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../Hotelinfo/hotel_list_screen.dart';


class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  late TextEditingController locationTextController;
  late TextEditingController dateFromtextController;
  late TextEditingController dateToTextController;
  int roomQuantity = 1;
  int guestNumber = 1;

  @override
  void initState() {
    super.initState();
    locationTextController = TextEditingController();
    dateFromtextController = TextEditingController();
    dateToTextController = TextEditingController();
    final currentDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
    dateFromtextController.text = currentDate;
    dateToTextController.text =
        DateFormat('yyyy-MM-dd').format(DateTime.now().add(const Duration(days: 1)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    appBar: PreferredSize(
  preferredSize: const Size.fromHeight(80.0), // Adjust the height as needed
  child: AppBar(
    title: const Text(
       'Search',
      style: TextStyle(
        fontSize: 24.0, 
        fontWeight: FontWeight.w500, 
        color: Colors.white, 
        fontFamily: 'RaleWay',
      ),
    ),
    backgroundColor: const Color.fromARGB(255, 0, 62, 112), // Apply your preferred background color
    elevation: 0, // Remove the shadow
    centerTitle: true, // Center align the title
  ),
),
     body: ClipRRect(
        borderRadius: BorderRadius.circular(20.0),
        child: Container(
          padding: const EdgeInsets.all(20.0),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
              color: Colors.grey,
            ),
          ),
          child: Column(
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.location_city,
                    color: Colors.black,
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: TextField(
                      controller: locationTextController,
                      decoration: const InputDecoration(
                        labelText: 'Location',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  const Icon(
                    Icons.calendar_today,
                    color: Colors.black,
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: TextFormField(
                      controller: dateFromtextController,
                      decoration: const InputDecoration(
                        labelText: 'From',
                        border: InputBorder.none,
                      ),
                      readOnly: true,
                      onTap: () {
                        _selectDate(context, dateFromtextController);
                      },
                    ),
                  ),
                  Expanded(
                    child: TextFormField(
                      controller: dateToTextController,
                      decoration: const InputDecoration(
                        labelText: 'To',
                        border: InputBorder.none,
                      ),
                      readOnly: true,
                      onTap: () {
                        _selectDate(context, dateToTextController);
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  const Icon(
                    Icons.room_preferences,
                    color: Colors.black,
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: TextField(
                      decoration: const InputDecoration(
                        labelText: 'Rooms',
                        border: InputBorder.none,
                      ),
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        setState(() {
                          roomQuantity = int.tryParse(value) ?? 1;
                        });
                      },
                    ),
                  ),
                  Expanded(
                    child: TextField(
                      decoration: const InputDecoration(
                        labelText: 'Guests',
                        border: InputBorder.none,
                      ),
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        setState(() {
                          guestNumber = int.tryParse(value) ?? 1;
                        });
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              SizedBox(
  width: double.infinity, // Set the width to match the parent container
  height: 40.0, // Set the desired height for the button
  child: ElevatedButton(
  onPressed: () {
    if (locationTextController.text.isNotEmpty &&
        dateFromtextController.text.isNotEmpty &&
        dateToTextController.text.isNotEmpty) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => HotelListScreen(
            location: locationTextController.text,
            fromDate: dateFromtextController.text,
            toDate: dateToTextController.text,
            roomQuantity: roomQuantity,
            guestNumber: guestNumber,
          ),
        ),
      );
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Error'),
          content: const Text('Please fill in all fields.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  },
  child: const Text('Search'),
  style: ElevatedButton.styleFrom(
    backgroundColor: const Color.fromARGB(255, 1, 36, 65),
    textStyle: const TextStyle(fontSize: 20.0, color: Colors.white),
  ),
),




),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _selectDate(
      BuildContext context, TextEditingController controller) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(DateTime.now().year + 1),
    );
    if (picked != null) {
      final DateFormat formatter = DateFormat('yyyy-MM-dd');
      final String formattedDate = formatter.format(picked);
      setState(() {
        controller.text = formattedDate;
      });
    }
  }
}


class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.black),
        border: InputBorder.none,
      ),
      style: const TextStyle(fontWeight: FontWeight.w500),
    );
  }
}
